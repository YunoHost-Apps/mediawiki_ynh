#!/usr/bin/env python3
"""
Download extensions for the current mediawiki version, and update the conf files.
"""

from typing import List, Optional, Any
import hashlib
import urllib
import datetime
from html.parser import HTMLParser
import tomlkit
from packaging import version
import requests

GITHUB_API_URL = "https://api.github.com/repos"

GITHUB_API_TOKEN = False

# Update this after updating mediawiki version.
ACCEPTABLE_BRANCHES = [
    "REL1_40",
    "REL1_39",
]


def github_get(path: str, *args, **kwargs) -> Any:
    headers = kwargs.get("headers", {})
    if GITHUB_API_TOKEN:
        headers["Authorization"] = f"Bearer {GITHUB_API_TOKEN}"

    kwargs["headers"] = headers
    result = requests.get(
        f"{GITHUB_API_URL}/{path}",
        timeout=10,
        *args,
        **kwargs
    )
    if result.status_code == requests.codes["forbidden"]:
        raise RuntimeError(result.json().get("message"), result.json().get("documentation_url"))

    return result.json()


def sha256sum_of_url(url: str) -> str:
    """Compute checksum without saving the file"""
    checksum = hashlib.sha256()
    for chunk in requests.get(url, stream=True, timeout=10).iter_content():
        checksum.update(chunk)
    return checksum.hexdigest()


def find_valid_version(all_versions: List[str], max_version: version.Version) -> Optional[str]:
    """Find the valid extensions for the current mediawiki version"""
    def version_of(ext):
        try:
            return version.parse(ext.replace("_", ".").replace("REL", ""))
        except version.InvalidVersion:
            # print(f"Invalid version (this might be normal): {ext}")
            return version.parse("0.0")

    def compatible(ext_version: str) -> bool:
        return version_of(ext_version) <= max_version

    compatible_versions = filter(compatible, all_versions)

    if compatible_versions:
        return max(compatible_versions, key=version_of)

    if "master" in all_versions:
        return "master"

    return None


def get_repo(url: str) -> str:
    return "/".join(url.split("://")[1].split("/")[1:3])


def get_branches(repo: str) -> List[str]:
    branches = github_get(f"{repo}/branches")
    names = [branch["name"] for branch in branches]
    return names


def get_last_commit_of(repo: str, branch: str) -> str:
    commit = github_get(f"{repo}/commits/{branch}")
    return commit["sha"]


def timestamp_of_commit(repo: str, sha: str) -> int:
    commit = github_get(f"{repo}/commits/{sha}")
    try:
        date = commit["commit"]["author"]["date"]
    except :
        print(date)
        raise
    return datetime.datetime.strptime(date, "%Y-%m-%dT%H:%M:%SZ")


def main():
    print('Updating extensions source files...')
    with open("manifest.toml", "r", encoding="utf-8") as file:
        manifest = tomlkit.loads(file.read())
    mediawiki_version = version.Version(manifest["version"].value.split("~")[0])

    for name, descr in manifest["resources"]["sources"].items():
        if "extension" not in descr["url"]:
            # not an extension
            continue
        print(f'Updating source file for {name}')
        repo = get_repo(descr["url"])
        branches = get_branches(repo)
        commits = [
            get_last_commit_of(repo, branch)
            for branch in branches
            if branch in ACCEPTABLE_BRANCHES
        ]

        if not commits:
            print("Could not find any valid branch")
            continue

        # Sort by commit date…
        commits = sorted(commits, key=lambda x, r=repo: timestamp_of_commit(r, x), reverse=True)

        commit = commits[0]
        url = f"https://github.com/{repo}/archive/{commit}.tar.gz"

        manifest["resources"]["sources"][name]["url"] = url
        manifest["resources"]["sources"][name]["sha256"] = sha256sum_of_url(url)

    with open("manifest.toml", "w", encoding="utf-8") as manifest_file:
        manifest_file.write(tomlkit.dumps(manifest))


if __name__ == "__main__":
    main()
