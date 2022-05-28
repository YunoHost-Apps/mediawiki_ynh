#!/usr/bin/env python3

import hashlib
import json
import logging
import os
import subprocess
import textwrap
from pathlib import Path
from typing import List, Tuple, Any
import requests
from packaging import version

logging.getLogger().setLevel(logging.INFO)

# This script is meant to be run by GitHub Actions
# The YunoHost-Apps organisation offers a template Action to run this script periodically
# Since each app is different, maintainers can adapt its contents so as to perform
# automatic actions when a new upstream release is detected.

# Remove this exit command when you are ready to run this Action
# exit(1)

#=================================================
# Fetching information

def get_latest_version(repo: str) -> Tuple[version.Version, Any]:
    api_url = repo.replace("https://github.com/", "https://api.github.com/repos/")
    releases = requests.get(f"{api_url}/tags").json()
    release_info = [
        release for release in releases
        if "-rc" not in release["name"] and "REL" not in release["name"]
    ][0]
    return version.Version(release_info["name"]), release_info

def get_assets_of_release(repo: str, rel_info: Any) -> List[str]:
    """May be customized by maintainers for custom urls"""
    rel = rel_info['name']
    short_rel = '.'.join(rel.split('.')[:2])
    assets = [
        f"https://releases.wikimedia.org/mediawiki/{short_rel}/mediawiki-{rel}.tar.gz"
    ]
    return assets

#=================================================
# Download assets and compute filename / sha256sum

def sha256sum_of_url(url: str) -> str:
    """Compute checksum without saving the file"""
    checksum = hashlib.sha256()
    for chunk in requests.get(url, stream=True).iter_content():
        checksum.update(chunk)
    return checksum.hexdigest()

# It has to be adapted in accordance with how the upstream releases look like.
def handle_asset(asset_url: str):
    """This should be customized by the maintainer"""
    logging.info("Handling asset at %s", asset_url)
    if asset_url.endswith(".tar.gz"):
        src = "app.src"
        extract = "true"
    else:
        logging.info("Asset ignored")
        return
    logging.info("Asset is for %s", src)

    # Rewrite source file
    extension = "tar.gz" if asset_url.endswith(".tar.gz") else Path(asset_url).suffix[1:]
    with open(f"conf/{src}", "w", encoding="utf-8") as conf_file:
        conf_file.write(textwrap.dedent(f"""\
            SOURCE_URL={asset_url}
            SOURCE_SUM={sha256sum_of_url(asset_url)}
            SOURCE_SUM_PRG=sha256sum
            SOURCE_FORMAT={extension}
            SOURCE_IN_SUBDIR=true
            SOURCE_EXTRACT={extract}
        """))


def main():
    with open(os.environ["GITHUB_ENV"], "w", encoding="utf-8") as github_env:
        github_env.write("PROCEED=false\n")

    with open("manifest.json", "r", encoding="utf-8") as file:
        manifest = json.load(file)
    repo = manifest["upstream"]["code"]

    current_version = version.Version(manifest["version"].split("~")[0])
    logging.info("Current version: %s", current_version)
    latest_version, release_info = get_latest_version(repo)
    logging.info("Latest upstream version: %s", latest_version)

    # Proceed only if the retrieved version is greater than the current one
    if latest_version <= current_version:
        logging.warning("No new version available")
        return

    # Proceed only if a PR for this new version does not already exist
    command = ["git", "ls-remote", "--exit-code", "-h", repo, f"ci-auto-update-v${latest_version}"]
    if subprocess.run(command, stderr=subprocess.DEVNULL, check=False).returncode == 0:
        logging.warning("A branch already exists for this update")
        return

    assets = get_assets_of_release(repo, release_info)
    logging.info("%d available asset(s)", len(assets))
    for asset in assets:
        handle_asset(asset)

    manifest["version"] = f"{latest_version}~ynh1"
    with open("manifest.json", "w", encoding="utf-8") as manifest_file:
        json.dump(manifest, manifest_file, indent=4, ensure_ascii=False)
        manifest_file.write("\n")

    with open(os.environ["GITHUB_ENV"], "w", encoding="utf-8") as github_env:
        github_env.write(textwrap.dedent(f"""\
            VERSION={latest_version}
            REPO={repo}
            PROCEED=true
        """))


if __name__ == "__main__":
    main()
