# MediaWiki pour YunoHost

[![Niveau d'intégration](https://dash.yunohost.org/integration/mediawiki.svg)](https://dash.yunohost.org/appci/app/mediawiki) ![](https://ci-apps.yunohost.org/ci/badges/mediawiki.status.svg) ![](https://ci-apps.yunohost.org/ci/badges/mediawiki.maintain.svg)
[![Installer MediaWiki avec YunoHost](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=mediawiki)

*[Read this readme in english.](./README.md)*
*[Lire ce readme en français.](./README_fr.md)*

> *Ce package vous permet d'installer MediaWiki rapidement et simplement sur un serveur YunoHost.
Si vous n'avez pas YunoHost, consultez [le guide](https://yunohost.org/#/install) pour apprendre comment l'installer.*

## Vue d'ensemble

Un wiki à base de logiciels libres Open source, développé à l’origine pour Wikipédia.

**Version incluse:** 1.35.2

**Démo:** https://www.wikipedia.org/, https://www.mediawiki.org/wiki/Project:Sandbox

## Captures d'écran

![](./doc/screenshots/screenshot.png)

## Avertissements / informations importantes

### Extensions livrées

* [LDAPAuthentication2](https://www.mediawiki.org/wiki/Extension:LDAPAuthentication2)
* [LDAPAuthorization](https://www.mediawiki.org/wiki/Extension:LDAPAuthorization) (**désactivée et inutilisée pour l'instant**)
* [LDAPGroups](https://www.mediawiki.org/wiki/Extension:LDAPGroups) (**désactivée et inutilisée pour l'instant**)
* [LDAPUserInfo](https://www.mediawiki.org/wiki/Extension:LDAPUserInfo) (**désactivée et inutilisée pour l'instant**)
* [LDAPProvider](https://www.mediawiki.org/wiki/Extension:LDAPProvider)
* [PluggableAuth](https://www.mediawiki.org/wiki/Extension:PluggableAuth)

Certaines extensions sont marquées comme "désactivées et inutilisées" car elles font partie de la "pile LDAP" de MediaWiki qui pourrait être nécessaire dans les versions futures.

#### Support multi-utilisateur

* L'authentification LDAP est-elle prise en charge ? **Oui**
* L'authentification HTTP est-elle prise en charge ? **Non**
* L'application peut-elle être utilisée par plusieurs utilisateurs ? **Oui**


#### Architectures supportées

* x86-64 - [![Build Status](https://ci-apps.yunohost.org/ci/logs/mediawiki.svg)](https://ci-apps.yunohost.org/ci/apps/mediawiki/)
* ARMv8-A - [![Build Status](https://ci-apps-arm.yunohost.org/ci/logs/mediawiki.svg)](https://ci-apps-arm.yunohost.org/ci/apps/mediawiki/)

### Comment configurer cette application :

* Via le panneau d'administration : Connectez-vous puis cliquez sur `Préférences`

## Documentations et ressources

* Site officiel de l'app : https://www.mediawiki.org
* Documentation officielle utilisateur: https://www.mediawiki.org/wiki/Project:Help
* Documentation officielle de l'admin: https://www.mediawiki.org/wiki/Documentation
* Dépôt de code officiel de l'app:  https://github.com/wikimedia/mediawiki
* Documentation YunoHost pour cette app: https://yunohost.org/app_mediawiki
* Signaler un bug: https://github.com/YunoHost-Apps/mediawiki_ynh/issues

## Informations pour les développeurs

Merci de faire vos pull request sur la [branche testing](https://github.com/YunoHost-Apps/mediawiki_ynh/tree/testing).

Pour essayer la branche testing, procédez comme suit.
```
sudo yunohost app install https://github.com/YunoHost-Apps/mediawiki_ynh/tree/testing --debug
or
sudo yunohost app upgrade mediawiki -u https://github.com/YunoHost-Apps/mediawiki_ynh/tree/testing --debug
```

**Plus d'infos sur le packaging d'applications:** https://yunohost.org/packaging_apps