#!/usr/bin/env python3
"""
This tool updates conf/*.src according to the available extension version at wmflabs.org
"""

import sys
import json
import urllib.request
from html.parser import HTMLParser
import subprocess
import hashlib
import fileinput
from typing import List

EXTENSIONS_HOST_URL = 'https://extdist.wmflabs.org/dist/extensions/'


def get_all_extensions() -> List[str]:
    """Get all available extensions."""
    with urllib.request.urlopen(EXTENSIONS_HOST_URL) as page:
        webpage = page.read().decode('utf-8')

    class MyHTMLParser(HTMLParser):
        """Custom HTMLParser"""
        links = []

        def handle_starttag(self, tag, attrs):
            # Only parse the 'anchor' tag.
            if tag == 'a':
                # Check the list of defined attributes.
                for name, value in attrs:
                    # If href is defined, print it.
                    if name == "href":
                        self.links.append(value)

    parser = MyHTMLParser()
    parser.feed(webpage)
    return parser.links


def get_mediawiki_ext_version() -> str:
    """Returns the mediawiki version for extensions."""
    with open('manifest.json', encoding='utf-8') as manifest_json:
        manifest = json.load(manifest_json)
    mediawiki_version = manifest['version'].split('~')[0]
    mediawiki_ext_version = '_'.join(mediawiki_version.split('.')[0:2])
    return mediawiki_ext_version


def get_extensions_for_version(extensions: List[str], version: str) -> List[str]:
    """Returns available extensions compatible with mediawiki version."""
    exts = [ext for ext in extensions if version in ext]
    return exts


###############################################################################

def sha256sum(filename: str) -> str:
    """Calculate the sha256 of a file."""
    sha256_hash = hashlib.sha256()
    with open(filename, "rb") as file:
        # Read and update hash string value in blocks of 4K
        for byte_block in iter(lambda: file.read(4096), b""):
            sha256_hash.update(byte_block)
    return sha256_hash.hexdigest()


def replace_line_startingwith(file: str, startingwith: str, new_line: str):
    """"""
    for line in fileinput.input(file, inplace=1):
        if line.startswith(startingwith):
            line = new_line + '\n'
        sys.stdout.write(line)


def update_source_file(srcfile: str, url: str):
    filename = url.rsplit('/', 1)[1]
    urllib.request.urlretrieve(url, filename)
    hashsum = sha256sum(filename)

    replace_line_startingwith(srcfile, 'SOURCE_URL=', f'SOURCE_URL={url}')
    replace_line_startingwith(srcfile, 'SOURCE_SUM=', f'SOURCE_SUM={hashsum}')
    replace_line_startingwith(srcfile, 'SOURCE_SUM_PRG=', 'SOURCE_SUM_PRG=sha256sum')


def get_required_extensions(extensions: List[str]):
    ext_files = [
        {'name': 'LDAPAuthentication2', 'file': 'conf/ldap_authentication2.src', },
        {'name': 'LDAPAuthorization',   'file': 'conf/ldap_authorization.src', },
        # {'name': 'Auth_remoteuser',     'file': 'conf/ldap_auth_remoteuser.src', },
        {'name': 'LDAPGroups',          'file': 'conf/ldap_groups.src', },
        {'name': 'LDAPProvider',        'file': 'conf/ldap_provider.src', },
        {'name': 'LDAPUserInfo',        'file': 'conf/ldap_userinfo.src', },
        {'name': 'PluggableAuth',       'file': 'conf/pluggable_auth.src', },
    ]

    for ext in ext_files:
        file = ext['file']
        name = ext['name']

        echo_var = f'source {file} ; echo ${{}}'
        current_url = subprocess.check_output(
            echo_var.format('SOURCE_URL'), shell=True
        ).decode('utf-8').strip()

        # Search for corresponding in extensions
        matching_extension_urls = [url for url in extensions if name in url]

        if len(matching_extension_urls) != 1:
            print(f'ERROR: Could not find an upstream link for extension {name}')
            continue

        new_url = EXTENSIONS_HOST_URL + matching_extension_urls[0]

        if current_url == new_url:
            print(f'OK: url is up to date for {name}')
            continue

        print(f'Updating source file for {name}')
        update_source_file(file, new_url)


def main():
    """Main function."""
    mediawiki_ext_version = get_mediawiki_ext_version()
    extensions = get_all_extensions()
    extensions = get_extensions_for_version(extensions, mediawiki_ext_version)
    get_required_extensions(extensions)


if __name__ == '__main__':
    main()
