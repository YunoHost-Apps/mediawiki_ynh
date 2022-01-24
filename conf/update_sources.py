#!/usr/bin/env python3

from pathlib import Path
from tempfile import NamedTemporaryFile
from typing import List, Optional
import hashlib
import json
import urllib
from html.parser import HTMLParser
from packaging import version
import requests

# GENERIC CODE

# Don't edit this file manually, but {program} instead.
SOURCE_TEMPLATE = """SOURCE_URL={url}
SOURCE_SUM={sha256sum}
SOURCE_SUM_PRG=sha256sum
SOURCE_FORMAT=tar.gz
SOURCE_IN_SUBDIR={source_in_subdir}
SOURCE_EXTRACT={source_extract}
"""

def generate_source(url: str, output_name: str, source_extract=True, source_in_subdir=True) -> None:
    with NamedTemporaryFile() as tempfile:
        response = requests.get(url)
        response.raise_for_status()
        with open(tempfile.name, "wb") as datafile:
            for chunk in response.iter_content(chunk_size=1024):
                datafile.write(chunk)

        sha256_hash = hashlib.sha256()
        with open(tempfile.name, "rb") as datafile:
            # Read and update hash string value in blocks of 4K
            for byte_block in iter(lambda: datafile.read(4096),b""):
                sha256_hash.update(byte_block)
        sha256sum = sha256_hash.hexdigest()

    with open(Path(__file__).parent / output_name, "w", encoding="utf-8") as output:
        output.write(SOURCE_TEMPLATE.format(
            program=Path(__file__).name, url=url, sha256sum=sha256sum,
            source_in_subdir=("true" if source_in_subdir else "false"),
            source_extract=("true" if source_extract else "false")
        ))

# SPECIFIC TO MEDIAWIKI

VERSION = "1.37.1"
EXTENSION_VERSION = "_".join(VERSION.split(".")[0:2])
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

def find_valid_ext(all_exts: List[str], name: str, max_ver: str) -> Optional[str]:
    def version_of(ext):
        return version.parse(ext.split("-")[1].replace("_", ".").replace("REL", ""))

    found_exts = [ext for ext in all_exts if ext.startswith(name)]
    return max(found_exts, key=version_of) if found_exts else None

def main():
    print(f'Updating source file for Mediawiki...')
    version_dir = ".".join(VERSION.split(".")[0:2])
    generate_source(
        f"https://releases.wikimedia.org/mediawiki/{version_dir}/mediawiki-{VERSION}.tar.gz",
        "app.src"
    )

    all_extensions = get_all_extensions()
    for file, name in EXTENSIONS.items():
        print(f'Updating source file for {name}')
        ext = find_valid_ext(all_extensions, name, VERSION)
        if ext is None:
            print(f'ERROR: Could not find an upstream link for extension {name}')
        else:
            new_url = EXTENSIONS_HOST_URL + ext
            generate_source(new_url, file + ".src", source_in_subdir=False)



if __name__ == "__main__":
    main()
