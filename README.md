# MediaWiki for YunoHost

[
![](https://dash.yunohost.org/integration/mediawiki.svg)
![](https://ci-apps.yunohost.org/ci/badges/mediawiki.status.svg)
![](https://ci-apps.yunohost.org/ci/badges/mediawiki.maintain.svg)
](https://dash.yunohost.org/appci/app/mediawiki)

[![Install WediaWiki with YunoHost](https://install-app.yunohost.org/install-with-yunohost.png)](https://install-app.yunohost.org/?app=mediawiki)

*[Lire ce readme en français.](./README_fr.md)*

> *This package allow you to install MediaWiki quickly and simply on a YunoHost server.
> If you don't have YunoHost, please see [here](https://yunohost.org/#/install) to know how to install and enjoy it.*

## Overview

MediaWiki is a free and open source software wiki package written in PHP, originally for use on Wikipedia.

**Shipped version:** 1.32.0

**Shipped extension versions:**
  * [LDAPProvider](https://www.mediawiki.org/wiki/Extension:LDAPProvider): 1.31 Stable
  * [PluggableAuth](https://www.mediawiki.org/wiki/Extension:PluggableAuth): 1.31 Stable
  * [LDAPAuthentication2](https://www.mediawiki.org/wiki/Extension:LDAPAuthentication2): 1.31 Stable
  * [LDAPGroups](https://www.mediawiki.org/wiki/Extension:LDAPGroups): 1.31 Stable (**disabled and unused for now**)
  * [LDAPUserInfo](https://www.mediawiki.org/wiki/Extension:LDAPUserInfo): 1.31 Stable (**disabled and unused for now**)
  * [LDAPAuthorization](https://www.mediawiki.org/wiki/Extension:LDAPAuthorization): 1.31 Stable (**disabled and unused for now**)

Some of the extensions are marked as "disabled and unused" because they are not immediately required but are part of the MediaWiki "LDAP Stack" which may be needed in future versions.

## Screenshots

![screenshot](sources/images/screenshot.png)

## Demo

  * [Official demo](https://www.mediawiki.org/wiki/Project:Sandbox)

## Configuration

How to configure this app:

  * Through the admin panel: Log in then click on `Preferences`

## Documentation

  * Official documentation: https://www.mediawiki.org
  * YunoHost documentation: https://yunohost.org/#/app_mediawiki

## YunoHost specific features

#### Multi-users support

  * Is LDAP supported?: **yes**
  * Is HTTP auth supported?: **no**
  * Can the app be used by multiple users?: **yes**

#### Supported architectures

  * x86-64 - [![Build Status](https://ci-apps.yunohost.org/ci/logs/mediawiki%20%28Apps%29.svg)](https://ci-apps.yunohost.org/ci/apps/mediawiki/)
  * ARMv8-A - [![Build Status](https://ci-apps-arm.yunohost.org/ci/logs/mediawiki%20%28Apps%29.svg)](https://ci-apps-arm.yunohost.org/ci/apps/mediawiki/)
  * Buster x86-64b - [![Build Status](https://ci-buster.nohost.me/ci/logs/mediawiki%20%28Apps%29.svg)](https://ci-buster.nohost.me/ci/apps/mediawiki/)

## Limitations

  * Any known limitations.

## Additional information

  * The [Discourse forum topic](https://forum.yunohost.org/t/community-app-mediawiki-free-software-wiki-package-wikipedia/8588) tracking release schedule and feedback.

## Links

  * Report a bug: https://github.com/YunoHost-Apps/mediawiki_ynh/issues
  * App website: https://www.mediawiki.org
  * Upstream app repository: https://github.com/wikimedia/mediawiki
  * YunoHost website: https://yunohost.org

---

Developers info
----------------

Please do your pull request to the [testing branch](https://github.com/YunoHost-Apps/mediawiki_ynh/tree/testing).

To try the testing branch, please proceed like that.
```
sudo yunohost app install https://github.com/YunoHost-Apps/mediawiki_ynh/tree/testing --debug
or
sudo yunohost app upgrade mediawiki -u https://github.com/YunoHost-Apps/mediawiki_ynh/tree/testing --debug
```
