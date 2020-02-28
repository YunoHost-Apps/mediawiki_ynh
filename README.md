# MediaWiki

[![Integration level](https://dash.yunohost.org/integration/mediawiki.svg)](https://dash.yunohost.org/appci/app/mediawiki)
[![Install mediawiki with YunoHost](https://install-app.yunohost.org/install-with-yunohost.png)](https://install-app.yunohost.org/?app=mediawiki)

*[Lire ce readme en français.](./README_fr.md)*

> *This package allow you to install mediawiki quickly and simply on a YunoHost server.

If you don't have YunoHost, please see [here](https://yunohost.org/#/install) to know how to install and enjoy it.*

## Overview

![mediawiki_logo](sources/images/mediawiki_logo.png)

MediaWiki is a free and open source software wiki package written in PHP, originally for use on Wikipedia.

**Shipped version:** 1.32.0

**Shipped extension versions:**
  * [LDAPProvider](https://www.mediawiki.org/wiki/Extension:LDAPProvider): 1.33 Stable
  * [PluggableAuth](https://www.mediawiki.org/wiki/Extension:PluggableAuth): 1.33 Stable
  * [LDAPAuthentication2](https://www.mediawiki.org/wiki/Extension:LDAPAuthentication2): 1.33 Stable
  * [LDAPGroups](https://www.mediawiki.org/wiki/Extension:LDAPGroups): 1.31 Stable (**disabled and unused for now**)
  * [LDAPUserInfo](https://www.mediawiki.org/wiki/Extension:LDAPUserInfo): 1.33 Stable (**disabled and unused for now**)
  * [LDAPAuthorization](https://www.mediawiki.org/wiki/Extension:LDAPAuthorization): 1.33 Stable (**disabled and unused for now**)

Please note, there is no available 1.32.0 version of the LDAP* extensions but the installation portal assures that they work across various different version of MediaWiki. This is currently the case. We will be working towards a MediaWiki [1.33.0 upgrade shortly](https://github.com/YunoHost-Apps/mediawiki_ynh/issues/4). Some of the extensions are marked as "disabled and unused" because they are not immediately required but are part of the MediaWiki "LDAP Stack" which may be needed in future versions.

## Screenshots

![screenshot](sources/images/screenshot.png)

## Demo

* [Official demo](https://www.mediawiki.org/wiki/Project:Sandbox)

## Configuration

How to configure this app:

 * Through the admin panel : Log in then click on `Preferences`

## Documentation

 * Official documentation: https://www.mediawiki.org/
 * YunoHost documentation: https://yunohost.org/#/app_mediawiki

## YunoHost specific features

#### Multi-users support

* Is LDAP supported: yes
* Is HTTP auth supported? : no
* Can the app be used by multiple users? : yes

#### Supported architectures

* x86-64b - [![Build Status](https://ci-apps.yunohost.org/ci/logs/mediawiki%20%28Community%29.svg)](https://ci-apps.yunohost.org/ci/apps/mediawiki/)
* ARMv8-A - [![Build Status](https://ci-apps-arm.yunohost.org/ci/logs/mediawiki%20%28Community%29.svg)](https://ci-apps-arm.yunohost.org/ci/apps/mediawiki/)
* Jessie x86-64b - [![Build Status](https://ci-stretch.nohost.me/ci/logs/mediawiki%20%28Community%29.svg)](https://ci-stretch.nohost.me/ci/apps/mediawiki/)

## Limitations

* Any known limitations.

## Additional information

* The [Discourse forum topic](https://forum.yunohost.org/t/community-app-mediawiki-free-software-wiki-package-wikipedia/8588) tracking release schedule and feedback.

## Links

 * Report a bug: https://github.com/YunoHost-Apps/mediawiki_ynh/issues
 * App website: https://www.mediawiki.org/
 * YunoHost website: https://yunohost.org/

---

Developers info
----------------

Please make your change requests against the testing branch.

To try the testing branch, please try:

```
$ yunohost app install https://github.com/YunoHost-Apps/mediawiki_ynh/tree/testing --debug
$ yunohost app upgrade mediawiki -u https://github.com/YunoHost-Apps/mediawiki_ynh/tree/testing --debug
```

This should not be done on a production server!
