<?php
# This file was automatically generated by the MediaWiki 1.40.0
# installer. If you make manual changes, please keep track in case you
# need to recreate them later.
#
# See includes/MainConfigSchema.php for all configurable settings
# and their default values, but don't forget to make changes in _this_
# file, not there.
#
# Further documentation for configuration settings may be found at:
# https://www.mediawiki.org/wiki/Manual:Configuration_settings

# Protect against web entry
if ( !defined( 'MEDIAWIKI' ) ) {
	exit;
}


## Uncomment this to disable output compression
# $wgDisableOutputCompression = true;

$wgSitename = "__WIKI_NAME__";
$wgMetaNamespace = "__WIKI_NAME_UNDERSCORIFIED__";

## The URL base path to the directory containing the wiki;
## defaults for all runtime URL paths are based off of this.
## For more information on customizing the URLs
## (like /w/index.php/Page_title to /wiki/Page_title) please see:
## https://www.mediawiki.org/wiki/Manual:Short_URL
$wgScriptPath = "__MEDIAWIKI_PATH__";

## The protocol and server name to use in fully-qualified URLs
$wgServer = "https://__DOMAIN__";

## The URL path to static resources (images, scripts, etc.)
$wgResourceBasePath = $wgScriptPath;

## The URL paths to the logo.  Make sure you change this from the default,
## or else you'll overwrite your logo when you upgrade!
$wgLogos = [
  '1x' => "$wgResourceBasePath/resources/assets/wiki.png",
  'icon' => "$wgResourceBasePath/resources/assets/change-your-logo-icon.svg",
];

## UPO means: this is also a user preference option

$wgEnableEmail = true;
$wgEnableUserEmail = true; # UPO

$wgEmergencyContact = "__ADMIN__@__DOMAIN__";
$wgPasswordSender = "__ADMIN__@__DOMAIN__";

$wgEnotifUserTalk = false; # UPO
$wgEnotifWatchlist = false; # UPO
$wgEmailAuthentication = true;

## Database settings
$wgDBtype = "mysql";
$wgDBserver = "";
$wgDBname = "__DB_NAME__";
$wgDBuser = "__DB_USER__";
$wgDBpassword = "__DB_PWD__";

# MySQL specific settings
$wgDBprefix = "mdk_";

# MySQL table options to use during installation or update
$wgDBTableOptions = "ENGINE=InnoDB, DEFAULT CHARSET=binary";

# Shared database table
# This has no effect unless $wgSharedDB is also set.
$wgSharedTables[] = "actor";

## Shared memory settings
$wgMainCacheType = CACHE_NONE;
$wgMemCachedServers = [];

## To enable image uploads, make sure the 'images' directory
## is writable, then set this to true:
$wgEnableUploads = true;
$wgUseImageMagick = true;
$wgImageMagickConvertCommand = "/usr/bin/convert";

# InstantCommons allows wiki to use images from https://commons.wikimedia.org
$wgUseInstantCommons = false;

# Periodically send a pingback to https://www.mediawiki.org/ with basic data
# about this MediaWiki instance. The Wikimedia Foundation shares this data
# with MediaWiki developers to help guide future development efforts.
$wgPingback = false;

# Site language code, should be one of the list in ./includes/languages/data/Names.php
$wgLanguageCode = "__LANGUAGE__";

# Time zone
$wgLocaltimezone = "UTC";

## Set $wgCacheDirectory to a writable directory on the web server
## to make your wiki go slightly faster. The directory should not
## be publicly accessible from the web.
#$wgCacheDirectory = "$IP/cache";

$wgSecretKey = "__SECRET__";

# Changing this will log out all existing sessions.
$wgAuthenticationTokenVersion = "1";

# Site upgrade key. Must be set to a string (default provided) to turn on the
# web installer while LocalSettings.php is in place
$wgUpgradeKey = "5f274549882531d1";

## For attaching licensing metadata to pages, and displaying an
## appropriate copyright notice / icon. GNU Free Documentation
## License and Creative Commons licenses are supported so far.
$wgRightsPage = ""; # Set to the title of a wiki page that describes your license/copyright
$wgRightsUrl = "";
$wgRightsText = "";
$wgRightsIcon = "";

# Path to the GNU diff3 utility. Used for conflict resolution.
$wgDiff3 = "/usr/bin/diff3";

## Default skin: you can change the default skin. Use the internal symbolic
## names, e.g. 'vector' or 'monobook':
$wgDefaultSkin = "vector";

# Enabled skins.
# The following skins were automatically enabled:
wfLoadSkin( 'MinervaNeue' );
wfLoadSkin( 'MonoBook' );
wfLoadSkin( 'Timeless' );
wfLoadSkin( 'Vector' );


# End of automatically generated settings.
# Add more configuration options below.

# LDAP Settings
# See https://www.mediawiki.org/wiki/Manual:Active_Directory_Integration

# wfLoadExtension( 'LDAPAuthorization' );
wfLoadExtension( 'LDAPAuthentication2' );
wfLoadExtension( 'LDAPGroups' );
wfLoadExtension( 'LDAPProvider' );
wfLoadExtension( 'LDAPUserInfo' );
wfLoadExtension( 'PluggableAuth' );
wfLoadExtension( 'Auth_remoteuser' );

# Yunohost configuration values for config_panel
$public_wiki = __PUBLIC_WIKI__;
$local_accounts = __LOCAL_ACCOUNTS__;
$yunohost_accounts = __YUNOHOST_ACCOUNTS__;

# Configuration of the generic PluggableAuth extension
$wgPluggableAuth_EnableLocalLogin = $local_accounts;
$wgPluggableAuth_EnableLocalProperties = true;
$wgPluggableAuth_EnableFastLogout = true;
# $wgPluggableAuth_ButtonLabel = "Log In";

# Configuration of the Yunohost LDAP+SSO
if ($yunohost_accounts) {
  $LDAPProviderDomainConfigs = "$IP/ldapproviders.json";
  $LDAPProviderDefaultDomain = "yunohost.local";

  $wgPluggableAuth_Config["Log In with Yunohost"] = [
    "plugin" => "LDAPAuthentication2",
    "data" => [ "domain" => "yunohost.local" ]
  ];

  $wgAuthRemoteuserUserUrls = [
    'logout' => 'https://__DOMAIN__/yunohost/sso/?action=logout'
  ];
}

# Auth_remoteuser will read the REMOTE_USER http header (for Yunohost SSO)
$wgAuthRemoteuserUserName = [
  getenv('REMOTE_USER'),
];

# Allow users to login as other than SSO logged in user
$wgAuthRemoteuserAllowUserSwitch = true;

# $wgEmailConfirmToEdit = false;
$wgGroupPermissions['*']['edit'] = $public_wiki;
$wgGroupPermissions['*']['read'] = $public_wiki;
$wgGroupPermissions['*']['createaccount'] = $local_accounts;
$wgGroupPermissions['*']['autocreateaccount'] = true;
$wgBlockDisablesLogin = true;
