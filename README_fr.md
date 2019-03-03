# MediaWiki

[![Integration level](https://dash.yunohost.org/integration/mediawiki.svg)](https://dash.yunohost.org/appci/app/mediawiki)  
[![Install mediawiki with YunoHost](https://install-app.yunohost.org/install-with-yunohost.png)](https://install-app.yunohost.org/?app=mediawiki)

*[Read this readme in english.](./README.md)* 

> *Ce package vous permet d'installer mediawiki rapidement et simplement sur un serveur Yunohost.  
Si vous n'avez pas YunoHost, regardez [ici](https://yunohost.org/#/install) pour savoir comment l'installer et en profiter.*

## Vue d'ensemble

![mediawiki_logo](sources/images/mediawiki_logo.png)

MediaWiki est un ensemble wiki à base de logiciels libres Open source, développé à l’origine pour Wikipédia.

**Version incluse:** 1.32.0

## Captures d'écran

![screenshot](sources/images/screenshot.png)

## Démo

* [Démo officielle](https://www.mediawiki.org/wiki/Project:Sandbox)

## Configuration

Comment configurer cette application:  

 * par le panneau d'administration : Connectez vous puis cliquer on `Préférences`  
 * vous pouvez modifier le fichier Localsettings.php situé dans `/var/www/mediawiki`.  

## Documentation

 * Documentation officielle: https://www.mediawiki.org/  
 * Documentation YunoHost: https://yunohost.org/#/app_mediawiki

## Caractéristiques spécifiques YunoHost

#### Support multi-utilisateurs

L'authentification LDAP et HTTP est-elle prise en charge? : pas pour l'instant  
L'application peut-elle être utilisée par plusieurs utilisateurs? : oui  

#### Supported architectures

* x86-64b - [![Build Status](https://ci-apps.yunohost.org/ci/logs/mediawiki%20%28Community%29.svg)](https://ci-apps.yunohost.org/ci/apps/mediawiki/)
* ARMv8-A - [![Build Status](https://ci-apps-arm.yunohost.org/ci/logs/mediawiki%20%28Community%29.svg)](https://ci-apps-arm.yunohost.org/ci/apps/mediawiki/)
* Jessie x86-64b - [![Build Status](https://ci-stretch.nohost.me/ci/logs/mediawiki%20%28Community%29.svg)](https://ci-stretch.nohost.me/ci/apps/mediawiki/)

## Limitations

* Limitations connues.

## Informations additionnelles

* Autres informations à ajouter sur cette application

**Plus d'informations sur la page de documentation:**  
https://yunohost.org/packaging_apps

## Links

 * Signaler un bug: https://github.com/YunoHost-Apps/mediawiki_ynh/issues
 * Site de l'application: https://www.mediawiki.org/
 * Site web YunoHost: https://yunohost.org/

---

Informations pour les développeurs
----------------

**Seulement si vous voulez utiliser une branche de test pour le codage, au lieu de fusionner directement dans la banche principale.**
Merci de faire vos pull request sur la [branche testing](https://github.com/YunoHost-Apps/mediawiki_ynh/tree/testing).

Pour essayer la branche testing, procédez comme suit.
```
sudo yunohost app install https://github.com/YunoHost-Apps/mediawiki_ynh/tree/testing --debug
ou
sudo yunohost app upgrade mediawiki -u https://github.com/YunoHost-Apps/mediawiki_ynh/tree/testing --debug
```
