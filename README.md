# Usage of this package (REMOVE THIS SECTION BEFORE RELEASE)
- Copy this app before working on it.
- Edit `conf/nginx.conf` file to match application prerequisites.
- Edit `manifest.json` with application specific information.
- Edit the `install`, `upgrade`, `remove`, `backup`, and `restore` scripts.
- Add a `LICENSE` file for the package.
- Edit `README.md` and README_fr.md.

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

## Screenshots

![screenshot](sources/images/screenshot.png)

## Demo

* [Official demo](https://www.mediawiki.org/wiki/Project:Sandbox)

## Configuration

How to configure this app: 
 * by the admin panel : Log in then click on `Preferences`
 * you can edit the file Localsettings.php located in `/var/www/mediawiki`.

## Documentation

 * Official documentation: https://www.mediawiki.org/
 * YunoHost documentation: https://yunohost.org/#/app_mediawiki

## YunoHost specific features

#### Multi-users support

Are LDAP and HTTP auth supported? : not yet
Can the app be used by multiple users? : yes

#### Supported architectures

* x86-64b - [![Build Status](https://ci-apps.yunohost.org/ci/logs/mediawiki%20%28Community%29.svg)](https://ci-apps.yunohost.org/ci/apps/mediawiki/)
* ARMv8-A - [![Build Status](https://ci-apps-arm.yunohost.org/ci/logs/mediawiki%20%28Community%29.svg)](https://ci-apps-arm.yunohost.org/ci/apps/mediawiki/)
* Jessie x86-64b - [![Build Status](https://ci-stretch.nohost.me/ci/logs/mediawiki%20%28Community%29.svg)](https://ci-stretch.nohost.me/ci/apps/mediawiki/)

## Limitations

* Any known limitations.

## Additional information

* Other information you would add about this application

**More information on the documentation page:**  
https://yunohost.org/packaging_apps

## Links

 * Report a bug: https://github.com/YunoHost-Apps/mediawiki_ynh/issues
 * App website: https://www.mediawiki.org/
 * YunoHost website: https://yunohost.org/

---

Developers info
----------------

**Only if you want to use a testing branch for coding, instead of merging directly into master.**
Please do your pull request to the [testing branch](https://github.com/YunoHost-Apps/mediawiki_ynh/tree/testing).

To try the testing branch, please proceed like that.
```
sudo yunohost app install https://github.com/YunoHost-Apps/mediawiki_ynh/tree/testing --debug
or
sudo yunohost app upgrade mediawiki -u https://github.com/YunoHost-Apps/mediawiki_ynh/tree/testing --debug
```
