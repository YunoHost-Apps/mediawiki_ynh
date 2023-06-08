#!/usr/bin/env python3
"""
This script is meant to be run by GitHub Actions.
It comes with a Github Action updater.yml to run this script periodically.

Since each app is different, maintainers can adapt its contents to perform
automatic actions when a new upstream release is detected.

You need to enable the action by removing `if ${{ false }}` in updater.yml!
"""

import hashlib
import logging
import os
from subprocess import run, PIPE
import textwrap
from typing import List, Tuple, Any, Optional
import requests
from packaging import version

import tomlkit


logging.getLogger().setLevel(logging.INFO)

# ========================================================================== #
# Functions customizable by app maintainer


def get_latest_version(repo: str) -> Tuple[version.Version, Any]:
    """May be customized by maintainers for other forges than Github"""
    api_url = repo.replace("github.com", "api.github.com/repos")
    # May use {api_url}/tags and release["name"] for tag-based upstream
    releases = requests.get(f"{api_url}/tags").json()
    release_info = next(
        release for release in releases
        if "-rc" not in release["name"] and "REL" not in release["name"]
    )
    return version.Version(release_info["name"]), release_info


def get_asset_urls_of_release(repo: str, release: Any) -> List[str]:
    """May be customized by maintainers for custom urls"""
    rel = release['name']
    short_rel = '.'.join(rel.split('.')[:2])
    return [
        f"https://releases.wikimedia.org/mediawiki/{short_rel}/mediawiki-{rel}.tar.gz"
    ]


def handle_asset(asset_url: str) -> Optional[str]:
    """This should be customized by the maintainer according to upstream"""
    logging.info("Handling asset at %s", asset_url)
    if asset_url.endswith(".tar.gz"):
        return "main"
    logging.info("Asset ignored")
    return None

# ========================================================================== #
# Core generic code of the script


def sha256sum_of_url(url: str) -> str:
    """Compute checksum without saving the file"""
    checksum = hashlib.sha256()
    for chunk in requests.get(url, stream=True, timeout=100).iter_content(chunk_size=4096):
        checksum.update(chunk)
    return checksum.hexdigest()


def write_github_env(proceed: bool, new_version: str, branch: str):
    """Those values will be used later in the workflow"""
    if "GITHUB_ENV" not in os.environ:
        logging.warning("GITHUB_ENV is not in the envvars, assuming not in CI")
        return
    with open(os.environ["GITHUB_ENV"], "w", encoding="utf-8") as github_env:
        github_env.write(textwrap.dedent(f"""\
            VERSION={new_version}
            BRANCH={branch}
            PROCEED={str(proceed).lower()}
        """))


def main():
    with open("manifest.toml", "r", encoding="utf-8") as manifest_file:
        manifest = tomlkit.loads(manifest_file.read())
    repo = manifest["upstream"]["code"]

    current_version = version.Version(manifest["version"].value.split("~")[0])
    latest_version, release_info = get_latest_version(repo)
    logging.info("Current version: %s", current_version)
    logging.info("Latest upstream version: %s", latest_version)

    # Proceed only if the retrieved version is greater than the current one
    if latest_version <= current_version:
        logging.warning("No new version available")
        write_github_env(False, "", "")
        return

    # Proceed only if a PR for this new version does not already exist
    branch = f"ci-auto-update-v{latest_version}"
    command = ["git", "ls-remote", "--exit-code", "-h", repo, branch]
    if run(command, stderr=PIPE, stdout=PIPE, check=False).returncode == 0:
        logging.warning("A branch already exists for this update")
        write_github_env(False, "", "")
        return

    assets = get_asset_urls_of_release(repo, release_info)

    logging.info("%d available asset(s)", len(assets))
    for asset in assets:
        name = handle_asset(asset)
        if name:
            manifest["resources"]["sources"][name]["url"] = asset
            manifest["resources"]["sources"][name]["sha256"] = sha256sum_of_url(asset)

    manifest["version"] = f"{latest_version}~ynh1"
    with open("manifest.toml", "w", encoding="utf-8") as manifest_file:
        manifest_file.write(tomlkit.dumps(manifest))

    write_github_env(True, latest_version, branch)


if __name__ == "__main__":
    main()
