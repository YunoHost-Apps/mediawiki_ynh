#!/usr/bin/env python3
"""
Download extensions for the current mediawiki version, and update the conf files.
"""

import argparse
from typing import List, Optional
import hashlib
import json
import textwrap
import urllib
from html.parser import HTMLParser
from packaging import version
import requests

EXTENSIONS_HOST_URL = "https://extdist.wmflabs.org/dist/extensions/"

EXTENSIONS = {
    "ldap_authentication2": "LDAPAuthentication2",
    "ldap_authorization": "LDAPAuthorization",
    # "ldap_auth_remoteuser": "Auth_remoteuser",
    "ldap_groups": "LDAPGroups",
    "ldap_provider": "LDAPProvider",
    "ldap_userinfo": "LDAPUserInfo",
    "pluggable_auth": "PluggableAuth",
}

def sha256sum_of_url(url: str) -> str:
    """Compute checksum without saving the file"""
    checksum = hashlib.sha256()
    for chunk in requests.get(url, stream=True, timeout=10).iter_content():
        checksum.update(chunk)
    return checksum.hexdigest()


def generate_ext_source(asset_url: str, src_filename: str) -> None:
    """Generate the conf file"""
    with open(f"conf/{src_filename}", "w", encoding="utf-8") as output:
        output.write(textwrap.dedent(f"""\
            SOURCE_URL={asset_url}
            SOURCE_SUM={sha256sum_of_url(asset_url)}
            SOURCE_SUM_PRG=sha256sum
            SOURCE_FORMAT=tar.gz
            SOURCE_IN_SUBDIR=false
            SOURCE_FILENAME=
            SOURCE_EXTRACT=true
        """))


def get_all_extensions() -> List[str]:
    """Get all available extensions."""
    with urllib.request.urlopen(EXTENSIONS_HOST_URL) as page:
        webpage = page.read().decode("utf-8")

    class MyHTMLParser(HTMLParser):
        links = []

        def handle_starttag(self, tag, attrs):
            if tag == "a":
                for name, value in attrs:
                    if name == "href":
                        self.links.append(value)

    parser = MyHTMLParser()
    parser.feed(webpage)
    return parser.links

def find_valid_ext(all_exts: List[str], name: str, max_version: version.Version) -> Optional[str]:
    """Find the valid extensions for the current mediawiki version"""
    def version_of(ext):
        try:
            return version.parse(ext.split("-")[1].replace("_", ".").replace("REL", ""))
        except version.InvalidVersion:
            print(f"Invalid version (this might be normal): {ext}")
            return version.parse("0.0")

    found_exts = [
        ext for ext in all_exts
        if ext.startswith(name) and version_of(ext) <= max_version
    ]
    return max(found_exts, key=version_of) if found_exts else None


def main():
    print('Updating extensions source files...')
    with open("manifest.json", "r", encoding="utf-8") as file:
        manifest = json.load(file)
    mediawiki_version = version.Version(manifest["version"].split("~")[0])

    all_extensions = get_all_extensions()

    parser = argparse.ArgumentParser()
    parser.add_argument('extension_file', nargs='?')
    args = parser.parse_args()

    if args.extension_file:
        extensions = {args.extension_file: EXTENSIONS[args.extension_file]}
    else:
        extensions = EXTENSIONS

    for file, name in extensions.items():
        print(f'Updating source file for {name}')
        ext = find_valid_ext(all_extensions, name, mediawiki_version)
        if ext is None:
            print(f'ERROR: Could not find an upstream link for extension {name}')
        else:
            new_url = EXTENSIONS_HOST_URL + ext
            generate_ext_source(new_url, file + ".src")


if __name__ == "__main__":
    main()
