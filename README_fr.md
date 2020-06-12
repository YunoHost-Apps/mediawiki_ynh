# MediaWiki pour YunoHost

[
![](https://dash.yunohost.org/integration/mediawiki.svg)
![](https://ci-apps.yunohost.org/ci/badges/mediawiki.status.svg)
![](https://ci-apps.yunohost.org/ci/badges/mediawiki.maintain.svg)
](https://dash.yunohost.org/appci/app/mediawiki)

[![Installer WediaWiki avec YunoHost](https://install-app.yunohost.org/install-with-yunohost.png)](https://install-app.yunohost.org/?app=mediawiki)

*[Read this readme in english.](./README.md)* 

> *Ce package vous permet d'installer MediaWiki rapidement et simplement sur un serveur YunoHost.  
Si vous n'avez pas YunoHost, regardez [ici](https://yunohost.org/#/install) pour savoir comment l'installer et en profiter.*

## Vue d'ensemble

MediaWiki est un logiciel wiki gratuit et open source écrit en PHP, à l'origine pour une utilisation sur Wikipedia.

**Version incluse :**  1.32.0

**Versions des extensions installées :**
  * [LDAPProvider](https://www.mediawiki.org/wiki/Extension:LDAPProvider) : 1.33 Stable
  * [PluggableAuth](https://www.mediawiki.org/wiki/Extension:PluggableAuth) : 1.33 Stable
  * [LDAPAuthentication2](https://www.mediawiki.org/wiki/Extension:LDAPAuthentication2) : 1.33 Stable
  * [LDAPGroups](https://www.mediawiki.org/wiki/Extension:LDAPGroups) : 1.31 Stable (**désactivée et inutilisée**)
  * [LDAPUserInfo](https://www.mediawiki.org/wiki/Extension:LDAPUserInfo) : 1.33 Stable (**désactivée et inutilisée**)
  * [LDAPAuthorization](https://www.mediawiki.org/wiki/Extension:LDAPAuthorization) : 1.33 Stable (**désactivée et inutilisée**)

Certaines des extensions sont marquées comme "désactivées et inutilisées" car elles ne sont pas immédiatement requises mais font partie de la "pile LDAP" de MediaWiki qui pourrait être nécessaire dans les futures versions.

## Captures d'écran

![capture d'écran](sources/images/screenshot.png)

## Démo

  * [Démo officielle](https://www.mediawiki.org/wiki/Project:Sandbox)

## Configuration

Comment configurer cette application :

  * Via le panneau d'administration : connectez-vous puis cliquez sur `Preferences`

## Documentation

  * Documentation officielle : https://www.mediawiki.org
  * Documentation YunoHost : https://yunohost.org/#/app_mediawiki_fr

## Caractéristiques spécifiques YunoHost

#### Support multi-utilisateurs

 * L'authentification LDAP est-elle prise en charge ? **Oui**
 * L'authentification HTTP est-elle prise en charge ? **Non**
 * L'application peut-elle être utilisée par plusieurs utilisateurs ? **Oui**

#### Architectures supportées

  * x86-64 - [![Build Status](https://ci-apps.yunohost.org/ci/logs/mediawiki%20%28Apps%29.svg)](https://ci-apps.yunohost.org/ci/apps/mediawiki/)
  * ARMv8-A - [![Build Status](https://ci-apps-arm.yunohost.org/ci/logs/mediawiki%20%28Apps%29.svg)](https://ci-apps-arm.yunohost.org/ci/apps/mediawiki/)
  * Buster x86-64 - [![Build Status](https://ci-buster.nohost.me/ci/logs/mediawiki%20%28Apps%29.svg)](https://ci-buster.nohost.me/ci/apps/mediawiki/)

## Limitations

  * Limitations connues.

## Informations additionnelles

  * Le [forum](https://forum.yunohost.org/t/community-app-mediawiki-free-software-wiki-package-wikipedia/8588) pour le suivi de la publication de nouvelles versions et commentaires.

## Liens

  * Signaler un bug : https://github.com/YunoHost-Apps/mediawiki_ynh/issues
  * Site de l'application : https://www.mediawiki.org
  * Dépôt de l'application principale : https://github.com/wikimedia/mediawiki
  * Site web YunoHost : https://yunohost.org

---

Informations pour les développeurs
----------------

Merci de faire vos pull request sur la [branche testing](https://github.com/YunoHost-Apps/mediawiki_ynh/tree/testing).

Pour essayer la branche testing, procédez comme suit.
```
sudo yunohost app install https://github.com/YunoHost-Apps/mediawiki_ynh/tree/testing --debug
ou
sudo yunohost app upgrade mediawiki -u https://github.com/YunoHost-Apps/mediawiki_ynh/tree/testing --debug
```
