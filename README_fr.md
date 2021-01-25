# MediaWiki pour YunoHost

[![Niveau d'intégration](https://dash.yunohost.org/integration/mediawiki.svg)](https://dash.yunohost.org/appci/app/mediawiki) ![](https://ci-apps.yunohost.org/ci/badges/mediawiki.status.svg) ![](https://ci-apps.yunohost.org/ci/badges/mediawiki.maintain.svg)
[![Installer MediaWiki avec YunoHost](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=mediawiki)

*[Read this readme in english.](./README.md)*

> *Ce package vous permet d'installer MediaWiki rapidement et simplement sur un serveur YunoHost.
Si vous n'avez pas YunoHost, consultez [le guide](https://yunohost.org/#/install) pour apprendre comment l'installer.*

## Vue d'ensemble

MediaWiki est un moteur de wiki pour le Web. Il est utilisé par l’ensemble des projets de la Fondation Wikimedia.

**Version de Mediawiki:** 1.35.1

**Versions d'extension livrées:**
  * [LDAPAuthentication2](https://www.mediawiki.org/wiki/Extension:LDAPAuthentication2)
  * [LDAPAuthorization](https://www.mediawiki.org/wiki/Extension:LDAPAuthorization) (**désactivé et inutilisé pour le moment**)
  * [LDAPGroups](https://www.mediawiki.org/wiki/Extension:LDAPGroups) (**désactivé et inutilisé pour le moment**)
  * [LDAPUserInfo](https://www.mediawiki.org/wiki/Extension:LDAPUserInfo) (**désactivé et inutilisé pour le moment**)
  * [LDAPProvider](https://www.mediawiki.org/wiki/Extension:LDAPProvider)
  * [PluggableAuth](https://www.mediawiki.org/wiki/Extension:PluggableAuth)

Certaines extensions sont marquées comme "désactivées et inutilisées" car elles ne sont pas immédiatement requises mais font partie de la "pile LDAP" de MediaWiki qui pourrait être nécessaire dans les versions futures.

## Captures d'écran

![](sources/images/screenshot.png)

## Démo

 * [Démo officielle](https://www.mediawiki.org/wiki/Project:Sandbox)

## Configuration

Comment configurer cette application :

 * Via le panneau d'administration : Connectez-vous puis cliquez sur `Préférences`

## Documentation

 * Documentation officielle : https://www.mediawiki.org
 * Documentation YunoHost : https://yunohost.org/#/app_mediawiki

## Caractéristiques spécifiques YunoHost

#### Support multi-utilisateur

 * L'authentification LDAP est-elle prise en charge ? **Oui**
 * L'authentification HTTP est-elle prise en charge ? **Non**
 * L'application peut-elle être utilisée par plusieurs utilisateurs ? **Oui**

#### Architectures supportées

  * x86-64 - [![Build Status](https://ci-apps.yunohost.org/ci/logs/mediawiki%20%28Apps%29.svg)](https://ci-apps.yunohost.org/ci/apps/mediawiki/)
  * ARMv8-A - [![Build Status](https://ci-apps-arm.yunohost.org/ci/logs/mediawiki%20%28Apps%29.svg)](https://ci-apps-arm.yunohost.org/ci/apps/mediawiki/)

## Limitations

 * Limitations connues.

## Informations additionnelles

  * Le [forum Discourse](https://forum.yunohost.org/t/community-app-mediawiki-free-software-wiki-package-wikipedia/8588)

## Links

 * Signaler un bug : https://github.com/YunoHost-Apps/mediawiki_ynh/issues
 * Site de l'application : https://www.mediawiki.org
 * Dépôt de l'application principale : https://github.com/wikimedia/mediawiki
 * Site web YunoHost : https://yunohost.org

---

## Informations pour les développeurs

Merci de faire vos pull request sur la [branche testing](https://github.com/YunoHost-Apps/mediawiki_ynh/tree/testing).

Pour essayer la branche testing, procédez comme suit.
```
sudo yunohost app install https://github.com/YunoHost-Apps/mediawiki_ynh/tree/testing --debug
ou
sudo yunohost app upgrade mediawiki -u https://github.com/YunoHost-Apps/mediawiki_ynh/tree/testing --debug
```
