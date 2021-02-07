#!/usr/bin/env python3

import json
from os import replace
import urllib.request
from html.parser import HTMLParser
import subprocess
import hashlib
import sys, fileinput

extensions_host_url = 'https://extdist.wmflabs.org/dist/extensions/'

def get_all_extensions():
    webpage = urllib.request.urlopen(extensions_host_url).read().decode('utf-8')

    class MyHTMLParser(HTMLParser):
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

def get_mediawiki_ext_version():
    with open('manifest.json') as manifest_json:
        manifest = json.load(manifest_json)
    mediawiki_version = manifest['version'].split('~')[0]
    mediawiki_ext_version = '_'.join(mediawiki_version.split('.')[0:2])
    return mediawiki_ext_version


def get_extensions_for_version(extensions, version):
    exts = [ ext for ext in extensions if version in ext ]
    return exts



###############################################################################

def sha256sum(filename):
    sha256_hash = hashlib.sha256()
    with open(filename,"rb") as f:
        # Read and update hash string value in blocks of 4K
        for byte_block in iter(lambda: f.read(4096),b""):
            sha256_hash.update(byte_block)
    return sha256_hash.hexdigest()


def replace_line_startingwith(file, startingwith, new_line):
    for line in fileinput.input(file, inplace=1):
        if line.startswith(startingwith):
            line = new_line + '\n'
        sys.stdout.write(line)
    pass

def update_source_file(srcfile, url, shasum):
    filename = url.rsplit('/', 1)[1]
    urllib.request.urlretrieve(url, filename)
    hash = sha256sum(filename)

    replace_line_startingwith(srcfile, 'SOURCE_URL=', 'SOURCE_URL={}'.format(url))
    replace_line_startingwith(srcfile, 'SOURCE_SUM=', 'SOURCE_SUM={}'.format(hash))
    replace_line_startingwith(srcfile, 'SOURCE_SUM_PRG=', 'SOURCE_SUM_PRG=sha256sum')





def get_required_extensions(extensions):
    ext_files = [
        { 'name': 'LDAPAuthentication2',    'file': 'conf/ldap_authentication2.src', },
        { 'name': 'LDAPAuthorization',      'file': 'conf/ldap_authorization.src', },
        { 'name': 'Auth_remoteuser',        'file': 'conf/ldap_auth_remoteuser.src', },
        { 'name': 'LDAPGroups',             'file': 'conf/ldap_groups.src', },
        { 'name': 'LDAPProvider',           'file': 'conf/ldap_provider.src', },
        { 'name': 'LDAPUserInfo',           'file': 'conf/ldap_userinfo.src', },
        { 'name': 'PluggableAuth',          'file': 'conf/pluggable_auth.src', },
    ]

    for ext in ext_files:
        file = ext['file']
        name = ext['name']

        echo_var = 'source {} ; echo ${}'.format(file, '{}')
        current_url = subprocess.check_output(echo_var.format('SOURCE_URL'), shell=True).decode('utf-8').strip()

        # Search for corresponding in extensions
        matching_extension_urls = [ url for url in extensions if name in url ]

        if len(matching_extension_urls) != 1:
            print('ERROR: Could not find an upstream link for extension {}'.format(name))
            continue

        new_url = extensions_host_url + matching_extension_urls[0]

        if current_url == new_url:
            print('OK: url is up to date for {}'.format(name))
            continue

        print('Updating source file for {}'.format(name))
        update_source_file(file, new_url, '000')



if __name__ == '__main__':
    mediawiki_ext_version = get_mediawiki_ext_version()
    extensions = get_all_extensions()
    extensions = get_extensions_for_version(extensions, mediawiki_ext_version)
    get_required_extensions(extensions)
