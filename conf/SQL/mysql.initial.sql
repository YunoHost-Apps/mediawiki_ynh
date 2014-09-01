SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

-- --------------------------------------------------------

--
-- Structure de la table `archive`
--

CREATE TABLE IF NOT EXISTS `archive` (
  `ar_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ar_namespace` int(11) NOT NULL DEFAULT '0',
  `ar_title` varbinary(255) NOT NULL DEFAULT '',
  `ar_text` mediumblob NOT NULL,
  `ar_comment` tinyblob NOT NULL,
  `ar_user` int(10) unsigned NOT NULL DEFAULT '0',
  `ar_user_text` varbinary(255) NOT NULL,
  `ar_timestamp` binary(14) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `ar_minor_edit` tinyint(4) NOT NULL DEFAULT '0',
  `ar_flags` tinyblob NOT NULL,
  `ar_rev_id` int(10) unsigned DEFAULT NULL,
  `ar_text_id` int(10) unsigned DEFAULT NULL,
  `ar_deleted` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `ar_len` int(10) unsigned DEFAULT NULL,
  `ar_page_id` int(10) unsigned DEFAULT NULL,
  `ar_parent_id` int(10) unsigned DEFAULT NULL,
  `ar_sha1` varbinary(32) NOT NULL DEFAULT '',
  `ar_content_model` varbinary(32) DEFAULT NULL,
  `ar_content_format` varbinary(64) DEFAULT NULL,
  PRIMARY KEY (`ar_id`),
  KEY `name_title_timestamp` (`ar_namespace`,`ar_title`,`ar_timestamp`),
  KEY `usertext_timestamp` (`ar_user_text`,`ar_timestamp`),
  KEY `ar_revid` (`ar_rev_id`)
) ENGINE=InnoDB DEFAULT CHARSET=binary AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `category`
--

CREATE TABLE IF NOT EXISTS `category` (
  `cat_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cat_title` varbinary(255) NOT NULL,
  `cat_pages` int(11) NOT NULL DEFAULT '0',
  `cat_subcats` int(11) NOT NULL DEFAULT '0',
  `cat_files` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`cat_id`),
  UNIQUE KEY `cat_title` (`cat_title`),
  KEY `cat_pages` (`cat_pages`)
) ENGINE=InnoDB DEFAULT CHARSET=binary AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `categorylinks`
--

CREATE TABLE IF NOT EXISTS `categorylinks` (
  `cl_from` int(10) unsigned NOT NULL DEFAULT '0',
  `cl_to` varbinary(255) NOT NULL DEFAULT '',
  `cl_sortkey` varbinary(230) NOT NULL DEFAULT '',
  `cl_sortkey_prefix` varbinary(255) NOT NULL DEFAULT '',
  `cl_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `cl_collation` varbinary(32) NOT NULL DEFAULT '',
  `cl_type` enum('page','subcat','file') NOT NULL DEFAULT 'page',
  UNIQUE KEY `cl_from` (`cl_from`,`cl_to`),
  KEY `cl_sortkey` (`cl_to`,`cl_type`,`cl_sortkey`,`cl_from`),
  KEY `cl_timestamp` (`cl_to`,`cl_timestamp`),
  KEY `cl_collation` (`cl_collation`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Structure de la table `change_tag`
--

CREATE TABLE IF NOT EXISTS `change_tag` (
  `ct_rc_id` int(11) DEFAULT NULL,
  `ct_log_id` int(11) DEFAULT NULL,
  `ct_rev_id` int(11) DEFAULT NULL,
  `ct_tag` varbinary(255) NOT NULL,
  `ct_params` blob,
  UNIQUE KEY `change_tag_rc_tag` (`ct_rc_id`,`ct_tag`),
  UNIQUE KEY `change_tag_log_tag` (`ct_log_id`,`ct_tag`),
  UNIQUE KEY `change_tag_rev_tag` (`ct_rev_id`,`ct_tag`),
  KEY `change_tag_tag_id` (`ct_tag`,`ct_rc_id`,`ct_rev_id`,`ct_log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Structure de la table `externallinks`
--

CREATE TABLE IF NOT EXISTS `externallinks` (
  `el_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `el_from` int(10) unsigned NOT NULL DEFAULT '0',
  `el_to` blob NOT NULL,
  `el_index` blob NOT NULL,
  PRIMARY KEY (`el_id`),
  KEY `el_from` (`el_from`,`el_to`(40)),
  KEY `el_to` (`el_to`(60),`el_from`),
  KEY `el_index` (`el_index`(60))
) ENGINE=InnoDB  DEFAULT CHARSET=binary AUTO_INCREMENT=10 ;

--
-- Contenu de la table `externallinks`
--

INSERT INTO `externallinks` (`el_id`, `el_from`, `el_to`, `el_index`) VALUES
(1, 1, 0x2f2f6d6574612e77696b696d656469612e6f72672f77696b692f48656c703a436f6e74656e7473, 0x687474703a2f2f6f72672e77696b696d656469612e6d6574612e2f77696b692f48656c703a436f6e74656e7473),
(2, 1, 0x2f2f6d6574612e77696b696d656469612e6f72672f77696b692f48656c703a436f6e74656e7473, 0x68747470733a2f2f6f72672e77696b696d656469612e6d6574612e2f77696b692f48656c703a436f6e74656e7473),
(3, 1, 0x2f2f7777772e6d6564696177696b692e6f72672f77696b692f4d616e75616c3a436f6e66696775726174696f6e5f73657474696e6773, 0x687474703a2f2f6f72672e6d6564696177696b692e7777772e2f77696b692f4d616e75616c3a436f6e66696775726174696f6e5f73657474696e6773),
(4, 1, 0x2f2f7777772e6d6564696177696b692e6f72672f77696b692f4d616e75616c3a436f6e66696775726174696f6e5f73657474696e6773, 0x68747470733a2f2f6f72672e6d6564696177696b692e7777772e2f77696b692f4d616e75616c3a436f6e66696775726174696f6e5f73657474696e6773),
(5, 1, 0x2f2f7777772e6d6564696177696b692e6f72672f77696b692f4d616e75616c3a464151, 0x687474703a2f2f6f72672e6d6564696177696b692e7777772e2f77696b692f4d616e75616c3a464151),
(6, 1, 0x2f2f7777772e6d6564696177696b692e6f72672f77696b692f4d616e75616c3a464151, 0x68747470733a2f2f6f72672e6d6564696177696b692e7777772e2f77696b692f4d616e75616c3a464151),
(7, 1, 0x68747470733a2f2f6c697374732e77696b696d656469612e6f72672f6d61696c6d616e2f6c697374696e666f2f6d6564696177696b692d616e6e6f756e6365, 0x68747470733a2f2f6f72672e77696b696d656469612e6c697374732e2f6d61696c6d616e2f6c697374696e666f2f6d6564696177696b692d616e6e6f756e6365),
(8, 1, 0x2f2f7777772e6d6564696177696b692e6f72672f77696b692f4c6f63616c69736174696f6e235472616e736c6174696f6e5f7265736f7572636573, 0x687474703a2f2f6f72672e6d6564696177696b692e7777772e2f77696b692f4c6f63616c69736174696f6e235472616e736c6174696f6e5f7265736f7572636573),
(9, 1, 0x2f2f7777772e6d6564696177696b692e6f72672f77696b692f4c6f63616c69736174696f6e235472616e736c6174696f6e5f7265736f7572636573, 0x68747470733a2f2f6f72672e6d6564696177696b692e7777772e2f77696b692f4c6f63616c69736174696f6e235472616e736c6174696f6e5f7265736f7572636573);

-- --------------------------------------------------------

--
-- Structure de la table `filearchive`
--

CREATE TABLE IF NOT EXISTS `filearchive` (
  `fa_id` int(11) NOT NULL AUTO_INCREMENT,
  `fa_name` varbinary(255) NOT NULL DEFAULT '',
  `fa_archive_name` varbinary(255) DEFAULT '',
  `fa_storage_group` varbinary(16) DEFAULT NULL,
  `fa_storage_key` varbinary(64) DEFAULT '',
  `fa_deleted_user` int(11) DEFAULT NULL,
  `fa_deleted_timestamp` binary(14) DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `fa_deleted_reason` blob,
  `fa_size` int(10) unsigned DEFAULT '0',
  `fa_width` int(11) DEFAULT '0',
  `fa_height` int(11) DEFAULT '0',
  `fa_metadata` mediumblob,
  `fa_bits` int(11) DEFAULT '0',
  `fa_media_type` enum('UNKNOWN','BITMAP','DRAWING','AUDIO','VIDEO','MULTIMEDIA','OFFICE','TEXT','EXECUTABLE','ARCHIVE') DEFAULT NULL,
  `fa_major_mime` enum('unknown','application','audio','image','text','video','message','model','multipart') DEFAULT 'unknown',
  `fa_minor_mime` varbinary(100) DEFAULT 'unknown',
  `fa_description` tinyblob,
  `fa_user` int(10) unsigned DEFAULT '0',
  `fa_user_text` varbinary(255) DEFAULT NULL,
  `fa_timestamp` binary(14) DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `fa_deleted` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `fa_sha1` varbinary(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`fa_id`),
  KEY `fa_name` (`fa_name`,`fa_timestamp`),
  KEY `fa_storage_group` (`fa_storage_group`,`fa_storage_key`),
  KEY `fa_deleted_timestamp` (`fa_deleted_timestamp`),
  KEY `fa_user_timestamp` (`fa_user_text`,`fa_timestamp`),
  KEY `fa_sha1` (`fa_sha1`(10))
) ENGINE=InnoDB DEFAULT CHARSET=binary AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `hitcounter`
--

CREATE TABLE IF NOT EXISTS `hitcounter` (
  `hc_id` int(10) unsigned NOT NULL
) ENGINE=MEMORY DEFAULT CHARSET=latin1 MAX_ROWS=25000;

-- --------------------------------------------------------

--
-- Structure de la table `image`
--

CREATE TABLE IF NOT EXISTS `image` (
  `img_name` varbinary(255) NOT NULL DEFAULT '',
  `img_size` int(10) unsigned NOT NULL DEFAULT '0',
  `img_width` int(11) NOT NULL DEFAULT '0',
  `img_height` int(11) NOT NULL DEFAULT '0',
  `img_metadata` mediumblob NOT NULL,
  `img_bits` int(11) NOT NULL DEFAULT '0',
  `img_media_type` enum('UNKNOWN','BITMAP','DRAWING','AUDIO','VIDEO','MULTIMEDIA','OFFICE','TEXT','EXECUTABLE','ARCHIVE') DEFAULT NULL,
  `img_major_mime` enum('unknown','application','audio','image','text','video','message','model','multipart') NOT NULL DEFAULT 'unknown',
  `img_minor_mime` varbinary(100) NOT NULL DEFAULT 'unknown',
  `img_description` tinyblob NOT NULL,
  `img_user` int(10) unsigned NOT NULL DEFAULT '0',
  `img_user_text` varbinary(255) NOT NULL,
  `img_timestamp` varbinary(14) NOT NULL DEFAULT '',
  `img_sha1` varbinary(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`img_name`),
  KEY `img_usertext_timestamp` (`img_user_text`,`img_timestamp`),
  KEY `img_size` (`img_size`),
  KEY `img_timestamp` (`img_timestamp`),
  KEY `img_sha1` (`img_sha1`(10)),
  KEY `img_media_mime` (`img_media_type`,`img_major_mime`,`img_minor_mime`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Structure de la table `imagelinks`
--

CREATE TABLE IF NOT EXISTS `imagelinks` (
  `il_from` int(10) unsigned NOT NULL DEFAULT '0',
  `il_to` varbinary(255) NOT NULL DEFAULT '',
  UNIQUE KEY `il_from` (`il_from`,`il_to`),
  UNIQUE KEY `il_to` (`il_to`,`il_from`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Structure de la table `interwiki`
--

CREATE TABLE IF NOT EXISTS `interwiki` (
  `iw_prefix` varbinary(32) NOT NULL,
  `iw_url` blob NOT NULL,
  `iw_api` blob NOT NULL,
  `iw_wikiid` varbinary(64) NOT NULL,
  `iw_local` tinyint(1) NOT NULL,
  `iw_trans` tinyint(4) NOT NULL DEFAULT '0',
  UNIQUE KEY `iw_prefix` (`iw_prefix`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

--
-- Contenu de la table `interwiki`
--

INSERT INTO `interwiki` (`iw_prefix`, `iw_url`, `iw_api`, `iw_wikiid`, `iw_local`, `iw_trans`) VALUES
('acronym', 0x687474703a2f2f7777772e6163726f6e796d66696e6465722e636f6d2f61662d71756572792e6173703f537472696e673d6578616374264163726f6e796d3d2431, '', '', 0, 0),
('advogato', 0x687474703a2f2f7777772e6164766f6761746f2e6f72672f2431, '', '', 0, 0),
('annotationwiki', 0x687474703a2f2f7777772e7365656477696b692e636f6d2f706167652e63666d3f77696b6969643d33363826646f633d2431, '', '', 0, 0),
('arxiv', 0x687474703a2f2f7777772e61727869762e6f72672f6162732f2431, '', '', 0, 0),
('c2find', 0x687474703a2f2f63322e636f6d2f6367692f77696b693f46696e64506167652676616c75653d2431, '', '', 0, 0),
('cache', 0x687474703a2f2f7777772e676f6f676c652e636f6d2f7365617263683f713d63616368653a2431, '', '', 0, 0),
('commons', 0x687474703a2f2f636f6d6d6f6e732e77696b696d656469612e6f72672f77696b692f2431, '', '', 0, 0),
('corpknowpedia', 0x687474703a2f2f636f72706b6e6f7770656469612e6f72672f77696b692f696e6465782e7068702f2431, '', '', 0, 0),
('dictionary', 0x687474703a2f2f7777772e646963742e6f72672f62696e2f446963743f44617461626173653d2a26466f726d3d44696374312653747261746567793d2a2651756572793d2431, '', '', 0, 0),
('disinfopedia', 0x687474703a2f2f7777772e646973696e666f70656469612e6f72672f77696b692e7068746d6c3f7469746c653d2431, '', '', 0, 0),
('docbook', 0x687474703a2f2f77696b692e646f63626f6f6b2e6f72672f746f7069632f2431, '', '', 0, 0),
('doi', 0x687474703a2f2f64782e646f692e6f72672f2431, '', '', 0, 0),
('drumcorpswiki', 0x687474703a2f2f7777772e6472756d636f72707377696b692e636f6d2f696e6465782e7068702f2431, '', '', 0, 0),
('dwjwiki', 0x687474703a2f2f7777772e737562657269632e6e65742f6367692d62696e2f64776a2f77696b692e6367693f2431, '', '', 0, 0),
('elibre', 0x687474703a2f2f656e6369636c6f70656469612e75732e65732f696e6465782e7068702f2431, '', '', 0, 0),
('emacswiki', 0x687474703a2f2f7777772e656d61637377696b692e6f72672f6367692d62696e2f77696b692e706c3f2431, '', '', 0, 0),
('foldoc', 0x687474703a2f2f666f6c646f632e6f72672f3f2431, '', '', 0, 0),
('foxwiki', 0x687474703a2f2f666f782e77696b69732e636f6d2f77632e646c6c3f57696b697e2431, '', '', 0, 0),
('freebsdman', 0x687474703a2f2f7777772e467265654253442e6f72672f6367692f6d616e2e6367693f6170726f706f733d312671756572793d2431, '', '', 0, 0),
('gej', 0x687474703a2f2f7777772e6573706572616e746f2e64652f6367692d62696e2f616b746976696b696f2f77696b692e706c3f2431, '', '', 0, 0),
('gentoo-wiki', 0x687474703a2f2f67656e746f6f2d77696b692e636f6d2f2431, '', '', 0, 0),
('google', 0x687474703a2f2f7777772e676f6f676c652e636f6d2f7365617263683f713d2431, '', '', 0, 0),
('googlegroups', 0x687474703a2f2f67726f7570732e676f6f676c652e636f6d2f67726f7570733f713d2431, '', '', 0, 0),
('hammondwiki', 0x687474703a2f2f7777772e64616972696b692e6f72672f48616d6d6f6e6457696b692f2431, '', '', 0, 0),
('hewikisource', 0x687474703a2f2f68652e77696b69736f757263652e6f72672f77696b692f2431, '', '', 1, 0),
('hrwiki', 0x687474703a2f2f7777772e687277696b692e6f72672f696e6465782e7068702f2431, '', '', 0, 0),
('imdb', 0x687474703a2f2f75732e696d64622e636f6d2f5469746c653f2431, '', '', 0, 0),
('jargonfile', 0x687474703a2f2f73756e69722e6f72672f617070732f6d6574612e706c3f77696b693d4a6172676f6e46696c652672656469726563743d2431, '', '', 0, 0),
('jspwiki', 0x687474703a2f2f7777772e6a737077696b692e6f72672f77696b692f2431, '', '', 0, 0),
('keiki', 0x687474703a2f2f6b65692e6b692f656e2f2431, '', '', 0, 0),
('kmwiki', 0x687474703a2f2f6b6d77696b692e77696b697370616365732e636f6d2f2431, '', '', 0, 0),
('linuxwiki', 0x687474703a2f2f6c696e757877696b692e64652f2431, '', '', 0, 0),
('lojban', 0x687474703a2f2f7777772e6c6f6a62616e2e6f72672f74696b692f74696b692d696e6465782e7068703f706167653d2431, '', '', 0, 0),
('lqwiki', 0x687474703a2f2f77696b692e6c696e75787175657374696f6e732e6f72672f77696b692f2431, '', '', 0, 0),
('lugkr', 0x687474703a2f2f6c75672d6b722e736f75726365666f7267652e6e65742f6367692d62696e2f6c756777696b692e706c3f2431, '', '', 0, 0),
('mathsongswiki', 0x687474703a2f2f5365656457696b692e636f6d2f706167652e63666d3f77696b6969643d32333726646f633d2431, '', '', 0, 0),
('meatball', 0x687474703a2f2f7777772e7573656d6f642e636f6d2f6367692d62696e2f6d622e706c3f2431, '', '', 0, 0),
('mediawikiwiki', 0x687474703a2f2f7777772e6d6564696177696b692e6f72672f77696b692f2431, '', '', 0, 0),
('mediazilla', 0x68747470733a2f2f6275677a696c6c612e77696b696d656469612e6f72672f2431, '', '', 1, 0),
('memoryalpha', 0x687474703a2f2f7777772e6d656d6f72792d616c7068612e6f72672f656e2f696e6465782e7068702f2431, '', '', 0, 0),
('metawiki', 0x687474703a2f2f73756e69722e6f72672f617070732f6d6574612e706c3f2431, '', '', 0, 0),
('metawikimedia', 0x687474703a2f2f6d6574612e77696b696d656469612e6f72672f77696b692f2431, '', '', 0, 0),
('moinmoin', 0x687474703a2f2f7075726c2e6e65742f77696b692f6d6f696e2f2431, '', '', 0, 0),
('mozillawiki', 0x687474703a2f2f77696b692e6d6f7a696c6c612e6f72672f696e6465782e7068702f2431, '', '', 0, 0),
('mw', 0x687474703a2f2f7777772e6d6564696177696b692e6f72672f77696b692f2431, '', '', 0, 0),
('oeis', 0x687474703a2f2f7777772e72657365617263682e6174742e636f6d2f6367692d62696e2f6163636573732e6367692f61732f6e6a61732f73657175656e6365732f656973412e6367693f416e756d3d2431, '', '', 0, 0),
('openfacts', 0x687474703a2f2f6f70656e66616374732e6265726c696f732e64652f696e6465782e7068746d6c3f7469746c653d2431, '', '', 0, 0),
('openwiki', 0x687474703a2f2f6f70656e77696b692e636f6d2f3f2431, '', '', 0, 0),
('pmeg', 0x687474703a2f2f7777772e62657274696c6f772e636f6d2f706d65672f24312e706870, '', '', 0, 0),
('ppr', 0x687474703a2f2f63322e636f6d2f6367692f77696b693f2431, '', '', 0, 0),
('pythoninfo', 0x687474703a2f2f77696b692e707974686f6e2e6f72672f6d6f696e2f2431, '', '', 0, 0),
('rfc', 0x687474703a2f2f7777772e7266632d656469746f722e6f72672f7266632f72666324312e747874, '', '', 0, 0),
('s23wiki', 0x687474703a2f2f69732d726f6f742e64652f77696b692f696e6465782e7068702f2431, '', '', 0, 0),
('seattlewiki', 0x687474703a2f2f73656174746c652e77696b69612e636f6d2f77696b692f2431, '', '', 0, 0),
('seattlewireless', 0x687474703a2f2f73656174746c65776972656c6573732e6e65742f3f2431, '', '', 0, 0),
('senseislibrary', 0x687474703a2f2f73656e736569732e786d702e6e65742f3f2431, '', '', 0, 0),
('sourceforge', 0x687474703a2f2f736f75726365666f7267652e6e65742f2431, '', '', 0, 0),
('squeak', 0x687474703a2f2f77696b692e73717565616b2e6f72672f73717565616b2f2431, '', '', 0, 0),
('susning', 0x687474703a2f2f7777772e7375736e696e672e6e752f2431, '', '', 0, 0),
('svgwiki', 0x687474703a2f2f77696b692e7376672e6f72672f2431, '', '', 0, 0),
('tavi', 0x687474703a2f2f746176692e736f75726365666f7267652e6e65742f2431, '', '', 0, 0),
('tejo', 0x687474703a2f2f7777772e74656a6f2e6f72672f76696b696f2f2431, '', '', 0, 0),
('theopedia', 0x687474703a2f2f7777772e7468656f70656469612e636f6d2f2431, '', '', 0, 0),
('tmbw', 0x687474703a2f2f7777772e746d62772e6e65742f77696b692f2431, '', '', 0, 0),
('tmnet', 0x687474703a2f2f7777772e746563686e6f6d616e69666573746f732e6e65742f3f2431, '', '', 0, 0),
('tmwiki', 0x687474703a2f2f7777772e45617379546f7069634d6170732e636f6d2f3f706167653d2431, '', '', 0, 0),
('twiki', 0x687474703a2f2f7477696b692e6f72672f6367692d62696e2f766965772f2431, '', '', 0, 0),
('uea', 0x687474703a2f2f7777772e74656a6f2e6f72672f7565612f2431, '', '', 0, 0),
('unreal', 0x687474703a2f2f77696b692e6265796f6e64756e7265616c2e636f6d2f77696b692f2431, '', '', 0, 0),
('usemod', 0x687474703a2f2f7777772e7573656d6f642e636f6d2f6367692d62696e2f77696b692e706c3f2431, '', '', 0, 0),
('vinismo', 0x687474703a2f2f76696e69736d6f2e636f6d2f656e2f2431, '', '', 0, 0),
('webseitzwiki', 0x687474703a2f2f776562736569747a2e666c7578656e742e636f6d2f77696b692f2431, '', '', 0, 0),
('why', 0x687474703a2f2f636c75626c65742e636f6d2f632f632f7768793f2431, '', '', 0, 0),
('wiki', 0x687474703a2f2f63322e636f6d2f6367692f77696b693f2431, '', '', 0, 0),
('wikia', 0x687474703a2f2f7777772e77696b69612e636f6d2f77696b692f2431, '', '', 0, 0),
('wikibooks', 0x687474703a2f2f656e2e77696b69626f6f6b732e6f72672f77696b692f2431, '', '', 1, 0),
('wikicities', 0x687474703a2f2f7777772e77696b69612e636f6d2f77696b692f2431, '', '', 0, 0),
('wikif1', 0x687474703a2f2f7777772e77696b6966312e6f72672f2431, '', '', 0, 0),
('wikihow', 0x687474703a2f2f7777772e77696b69686f772e636f6d2f2431, '', '', 0, 0),
('wikimedia', 0x687474703a2f2f77696b696d65646961666f756e646174696f6e2e6f72672f77696b692f2431, '', '', 0, 0),
('wikinews', 0x687474703a2f2f656e2e77696b696e6577732e6f72672f77696b692f2431, '', '', 1, 0),
('wikinfo', 0x687474703a2f2f7777772e77696b696e666f2e6f72672f696e6465782e7068702f2431, '', '', 0, 0),
('wikipedia', 0x687474703a2f2f656e2e77696b6970656469612e6f72672f77696b692f2431, '', '', 1, 0),
('wikiquote', 0x687474703a2f2f656e2e77696b6971756f74652e6f72672f77696b692f2431, '', '', 1, 0),
('wikisource', 0x687474703a2f2f77696b69736f757263652e6f72672f77696b692f2431, '', '', 1, 0),
('wikispecies', 0x687474703a2f2f737065636965732e77696b696d656469612e6f72672f77696b692f2431, '', '', 1, 0),
('wikitravel', 0x687474703a2f2f77696b6974726176656c2e6f72672f656e2f2431, '', '', 0, 0),
('wikiversity', 0x687474703a2f2f656e2e77696b69766572736974792e6f72672f77696b692f2431, '', '', 1, 0),
('wikt', 0x687474703a2f2f656e2e77696b74696f6e6172792e6f72672f77696b692f2431, '', '', 1, 0),
('wiktionary', 0x687474703a2f2f656e2e77696b74696f6e6172792e6f72672f77696b692f2431, '', '', 1, 0),
('wlug', 0x687474703a2f2f7777772e776c75672e6f72672e6e7a2f2431, '', '', 0, 0),
('zwiki', 0x687474703a2f2f7a77696b692e6f72672f2431, '', '', 0, 0),
('zzz wiki', 0x687474703a2f2f77696b692e7a7a7a2e65652f696e6465782e7068702f2431, '', '', 0, 0);

-- --------------------------------------------------------

--
-- Structure de la table `ipblocks`
--

CREATE TABLE IF NOT EXISTS `ipblocks` (
  `ipb_id` int(11) NOT NULL AUTO_INCREMENT,
  `ipb_address` tinyblob NOT NULL,
  `ipb_user` int(10) unsigned NOT NULL DEFAULT '0',
  `ipb_by` int(10) unsigned NOT NULL DEFAULT '0',
  `ipb_by_text` varbinary(255) NOT NULL DEFAULT '',
  `ipb_reason` tinyblob NOT NULL,
  `ipb_timestamp` binary(14) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `ipb_auto` tinyint(1) NOT NULL DEFAULT '0',
  `ipb_anon_only` tinyint(1) NOT NULL DEFAULT '0',
  `ipb_create_account` tinyint(1) NOT NULL DEFAULT '1',
  `ipb_enable_autoblock` tinyint(1) NOT NULL DEFAULT '1',
  `ipb_expiry` varbinary(14) NOT NULL DEFAULT '',
  `ipb_range_start` tinyblob NOT NULL,
  `ipb_range_end` tinyblob NOT NULL,
  `ipb_deleted` tinyint(1) NOT NULL DEFAULT '0',
  `ipb_block_email` tinyint(1) NOT NULL DEFAULT '0',
  `ipb_allow_usertalk` tinyint(1) NOT NULL DEFAULT '0',
  `ipb_parent_block_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`ipb_id`),
  UNIQUE KEY `ipb_address` (`ipb_address`(255),`ipb_user`,`ipb_auto`,`ipb_anon_only`),
  KEY `ipb_user` (`ipb_user`),
  KEY `ipb_range` (`ipb_range_start`(8),`ipb_range_end`(8)),
  KEY `ipb_timestamp` (`ipb_timestamp`),
  KEY `ipb_expiry` (`ipb_expiry`),
  KEY `ipb_parent_block_id` (`ipb_parent_block_id`)
) ENGINE=InnoDB DEFAULT CHARSET=binary AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `iwlinks`
--

CREATE TABLE IF NOT EXISTS `iwlinks` (
  `iwl_from` int(10) unsigned NOT NULL DEFAULT '0',
  `iwl_prefix` varbinary(20) NOT NULL DEFAULT '',
  `iwl_title` varbinary(255) NOT NULL DEFAULT '',
  UNIQUE KEY `iwl_from` (`iwl_from`,`iwl_prefix`,`iwl_title`),
  KEY `iwl_prefix_title_from` (`iwl_prefix`,`iwl_title`,`iwl_from`),
  KEY `iwl_prefix_from_title` (`iwl_prefix`,`iwl_from`,`iwl_title`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Structure de la table `job`
--

CREATE TABLE IF NOT EXISTS `job` (
  `job_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `job_cmd` varbinary(60) NOT NULL DEFAULT '',
  `job_namespace` int(11) NOT NULL,
  `job_title` varbinary(255) NOT NULL,
  `job_timestamp` varbinary(14) DEFAULT NULL,
  `job_params` blob NOT NULL,
  `job_random` int(10) unsigned NOT NULL DEFAULT '0',
  `job_attempts` int(10) unsigned NOT NULL DEFAULT '0',
  `job_token` varbinary(32) NOT NULL DEFAULT '',
  `job_token_timestamp` varbinary(14) DEFAULT NULL,
  `job_sha1` varbinary(32) NOT NULL DEFAULT '',
  PRIMARY KEY (`job_id`),
  KEY `job_sha1` (`job_sha1`),
  KEY `job_cmd_token` (`job_cmd`,`job_token`,`job_random`),
  KEY `job_cmd_token_id` (`job_cmd`,`job_token`,`job_id`),
  KEY `job_cmd` (`job_cmd`,`job_namespace`,`job_title`,`job_params`(128)),
  KEY `job_timestamp` (`job_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=binary AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `l10n_cache`
--

CREATE TABLE IF NOT EXISTS `l10n_cache` (
  `lc_lang` varbinary(32) NOT NULL,
  `lc_key` varbinary(255) NOT NULL,
  `lc_value` mediumblob NOT NULL,
  KEY `lc_lang_key` (`lc_lang`,`lc_key`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Structure de la table `langlinks`
--

CREATE TABLE IF NOT EXISTS `langlinks` (
  `ll_from` int(10) unsigned NOT NULL DEFAULT '0',
  `ll_lang` varbinary(20) NOT NULL DEFAULT '',
  `ll_title` varbinary(255) NOT NULL DEFAULT '',
  UNIQUE KEY `ll_from` (`ll_from`,`ll_lang`),
  KEY `ll_lang` (`ll_lang`,`ll_title`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Structure de la table `logging`
--

CREATE TABLE IF NOT EXISTS `logging` (
  `log_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `log_type` varbinary(32) NOT NULL DEFAULT '',
  `log_action` varbinary(32) NOT NULL DEFAULT '',
  `log_timestamp` binary(14) NOT NULL DEFAULT '19700101000000',
  `log_user` int(10) unsigned NOT NULL DEFAULT '0',
  `log_user_text` varbinary(255) NOT NULL DEFAULT '',
  `log_namespace` int(11) NOT NULL DEFAULT '0',
  `log_title` varbinary(255) NOT NULL DEFAULT '',
  `log_page` int(10) unsigned DEFAULT NULL,
  `log_comment` varbinary(255) NOT NULL DEFAULT '',
  `log_params` blob NOT NULL,
  `log_deleted` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`log_id`),
  KEY `type_time` (`log_type`,`log_timestamp`),
  KEY `user_time` (`log_user`,`log_timestamp`),
  KEY `page_time` (`log_namespace`,`log_title`,`log_timestamp`),
  KEY `times` (`log_timestamp`),
  KEY `log_user_type_time` (`log_user`,`log_type`,`log_timestamp`),
  KEY `log_page_id_time` (`log_page`,`log_timestamp`),
  KEY `type_action` (`log_type`,`log_action`,`log_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=binary AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `log_search`
--

CREATE TABLE IF NOT EXISTS `log_search` (
  `ls_field` varbinary(32) NOT NULL,
  `ls_value` varbinary(255) NOT NULL,
  `ls_log_id` int(10) unsigned NOT NULL DEFAULT '0',
  UNIQUE KEY `ls_field_val` (`ls_field`,`ls_value`,`ls_log_id`),
  KEY `ls_log_id` (`ls_log_id`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Structure de la table `module_deps`
--

CREATE TABLE IF NOT EXISTS `module_deps` (
  `md_module` varbinary(255) NOT NULL,
  `md_skin` varbinary(32) NOT NULL,
  `md_deps` mediumblob NOT NULL,
  UNIQUE KEY `md_module_skin` (`md_module`,`md_skin`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Structure de la table `msg_resource`
--

CREATE TABLE IF NOT EXISTS `msg_resource` (
  `mr_resource` varbinary(255) NOT NULL,
  `mr_lang` varbinary(32) NOT NULL,
  `mr_blob` mediumblob NOT NULL,
  `mr_timestamp` binary(14) NOT NULL,
  UNIQUE KEY `mr_resource_lang` (`mr_resource`,`mr_lang`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Structure de la table `msg_resource_links`
--

CREATE TABLE IF NOT EXISTS `msg_resource_links` (
  `mrl_resource` varbinary(255) NOT NULL,
  `mrl_message` varbinary(255) NOT NULL,
  UNIQUE KEY `mrl_message_resource` (`mrl_message`,`mrl_resource`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Structure de la table `objectcache`
--

CREATE TABLE IF NOT EXISTS `objectcache` (
  `keyname` varbinary(255) NOT NULL DEFAULT '',
  `value` mediumblob,
  `exptime` datetime DEFAULT NULL,
  PRIMARY KEY (`keyname`),
  KEY `exptime` (`exptime`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

--
-- Contenu de la table `objectcache`
--

INSERT INTO `objectcache` (`keyname`, `value`, `exptime`) VALUES
('mediawiki:pcache:idhash:1-0!*!*!*!*!*!*', 0xbd566d6f1a4710ce677ec5e6faa15225b8378ccd829122d7892dd9318d49f3d15aee0658f9deb4bb674cac48fd09fd8dfd259dd9bbc307386dd454c118b89d977d6676669ebde17ec09da9501ad44d698ad2383c3ce64f9a1f71279dc1a371469afbfd9313ee8c8bc9783eb986588a4ff25eb295d06c0e90315d461168bd289364c364a68d4812887b63773ee98c5db42a266779a6cbc430b30236164c4172ea64f9224f927ced3023d412cca973374f4476efb028115a9f3ab83ba84c24cc100eb652b038755c3705237a6b449012945eae962e3db91790141c37329019ed4c3e62483f6bf6ae94318c5d31618b5c213afc4c859179c6f05d6a992d2d28f2c074be306ba1a0676177c6ab6032d685c81a40e9babb021127320387c9f8d47907c6a0873b0c5919889d49bdc0ea85b14be69371bae688d56888ecce8558c2a9732d64c6a6f8d361b5e0d4f15f70b16b3c19bb08ab332e13fc48e4e4bbd3b95eaf7b36939482e76c5e8bac1409e5732197a5b229bbd31536cceece3a6bd65922b5a164630211db8f00f8f6cd6f4eab28f1f1ffdd7f654ca1b9eb52647aafec5221935464564695e56e61764596e56516411b1ba200a18191199df00f4cd6551e09dcce9ed64f3325329d5427aa40e7a5c2f67526b50eb067c4d4321b9433dc7a5962a9b6e1ba54829df1eb6e9775dec37a3ac5805269107f912bd3399b7e640693854d86869c793dcf3ba14acfb358773e0041ffaa788a4e544e5305113c482db1135896c7c0224cabe12c747dcfbe7655979001d6e49ef2c9b372aecd5f7ffc098fd896314e832829514dcbcf84c00dbce1b17f14b0f9c680eecc202d304bc0f000ca1487ca57f42ee47205da30eb54533bc45098156781dbf73ae78f05e0ea0360d7d394650b2c0bdb3435388fc075badd2697b7e201085aa31f89c8ce27b362f7b061dbc3e585957019e3205e71bfebbdfee5f98f517c945f1c2369c102cfef7b47dec00bfd7e38ec30daae9aec38e6afeac3bd92d9bd7646827bfce90bca7c949d610296b992d01678c40dd224d010c490b7a6193e0fc8eb9e376b54a7b4bd1eb4d62fe396e4180597297a6c6b230fa56f6502b72054b4ba2928936d39c5735eb7c616c111115a8820bf953c4692fb18c6519fffd701597b088ffedd034db05a7d10f2ef1e380df6e13fecfc0de3c0baa18cd245e012f3a2c8f2a512c1debfadb8c919cdb937aa6d2e90775f105119bccfdfd115416d76562f905a2f0da42dff74dad7795c26b07fc6d5ea6da46461dab2f0596636bb66475bd1350e8bbdbaa22aac2e401779de0e11d3987e122aab4eb5bd5a4766577dfe24311281889f2c6c9347093c40b23d0eeed4cfb8197702fac638ec55a2ced81ef1d77d9495e91c546de63b952b99c5f0d85e433c0b95a7869ab2d590774d435282695ae58b0596a8053508aa0d4416ad72b507627ba3197d69baee1cef2075c8b3fc1e28eeb90dcd16c154e50528b33327c86a76737631bbbe22f708a18182d3a39e4ccd10da1d504ee316cdcf33314f0849b55b80905fb52facafb03a311bd33c91d1a6b54fe81d28beb1f754880fc606b5e99eeead6522a136bf0a233e16f1eed40a4e0e0c68ead8f14f062dd78730ae88263f58966c746dd9f8432a0894550cda8d501bf3549fb92548fa1d78bb6a6beca517f506bb7a4551132951a38d25a8aa56f2d05629fe573439aa23dcb5de72eba1fdc9a17d18eed923f356b45bb32e91e98e13af7652b3ab7512ec3a31354f348cfc2d3ef6d3b0a569cbd23bd6416dddaf22e81f18564cde30b825f017b7f72907b4f7f0e0f0edd32d75d7cc9e99b5b6b380ced119c538c386c3b03ff08e87bd41d83f0e4ea898b983d540d2a0e71d0ffc60e835af7054b7daefa0b49db4b60cfcdea0d7dff6db195d156675917ca5df82460faf2c9266f37b5a2516265ec469a26f92f85a2c65548ded2f7f03, '2014-05-07 03:14:39'),
('mediawiki:pcache:idoptions:1', 0x458dc10e82301044ff653f806ca154d81e8d47d38b7aafd0e8265208cb4143f8775b13e26df2de4cc6514b70f4dd335c78084035ad420dc1700bb3f018c14a62a00a53e89c1526f7ef67a2094a541a6b3458295db53f5aeebdd37be2f90396a9311a31bb4376635c3c4771affeec1fdc81bd13eec3ab84de4d4bfa17b09e90d66dfb02, '2014-05-07 03:14:39');

-- --------------------------------------------------------

--
-- Structure de la table `oldimage`
--

CREATE TABLE IF NOT EXISTS `oldimage` (
  `oi_name` varbinary(255) NOT NULL DEFAULT '',
  `oi_archive_name` varbinary(255) NOT NULL DEFAULT '',
  `oi_size` int(10) unsigned NOT NULL DEFAULT '0',
  `oi_width` int(11) NOT NULL DEFAULT '0',
  `oi_height` int(11) NOT NULL DEFAULT '0',
  `oi_bits` int(11) NOT NULL DEFAULT '0',
  `oi_description` tinyblob NOT NULL,
  `oi_user` int(10) unsigned NOT NULL DEFAULT '0',
  `oi_user_text` varbinary(255) NOT NULL,
  `oi_timestamp` binary(14) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `oi_metadata` mediumblob NOT NULL,
  `oi_media_type` enum('UNKNOWN','BITMAP','DRAWING','AUDIO','VIDEO','MULTIMEDIA','OFFICE','TEXT','EXECUTABLE','ARCHIVE') DEFAULT NULL,
  `oi_major_mime` enum('unknown','application','audio','image','text','video','message','model','multipart') NOT NULL DEFAULT 'unknown',
  `oi_minor_mime` varbinary(100) NOT NULL DEFAULT 'unknown',
  `oi_deleted` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `oi_sha1` varbinary(32) NOT NULL DEFAULT '',
  KEY `oi_usertext_timestamp` (`oi_user_text`,`oi_timestamp`),
  KEY `oi_name_timestamp` (`oi_name`,`oi_timestamp`),
  KEY `oi_name_archive_name` (`oi_name`,`oi_archive_name`(14)),
  KEY `oi_sha1` (`oi_sha1`(10))
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Structure de la table `page`
--

CREATE TABLE IF NOT EXISTS `page` (
  `page_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `page_namespace` int(11) NOT NULL,
  `page_title` varbinary(255) NOT NULL,
  `page_restrictions` tinyblob NOT NULL,
  `page_counter` bigint(20) unsigned NOT NULL DEFAULT '0',
  `page_is_redirect` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `page_is_new` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `page_random` double unsigned NOT NULL,
  `page_touched` binary(14) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `page_latest` int(10) unsigned NOT NULL,
  `page_len` int(10) unsigned NOT NULL,
  `page_content_model` varbinary(32) DEFAULT NULL,
  PRIMARY KEY (`page_id`),
  UNIQUE KEY `name_title` (`page_namespace`,`page_title`),
  KEY `page_random` (`page_random`),
  KEY `page_len` (`page_len`),
  KEY `page_redirect_namespace_len` (`page_is_redirect`,`page_namespace`,`page_len`)
) ENGINE=InnoDB  DEFAULT CHARSET=binary AUTO_INCREMENT=2 ;

--
-- Contenu de la table `page`
--

INSERT INTO `page` (`page_id`, `page_namespace`, `page_title`, `page_restrictions`, `page_counter`, `page_is_redirect`, `page_is_new`, `page_random`, `page_touched`, `page_latest`, `page_len`, `page_content_model`) VALUES
(1, 0, 'Main_Page', '', 0, 0, 1, 0.231209644761, '20140506031439', 1, 524, 'wikitext');

-- --------------------------------------------------------

--
-- Structure de la table `pagelinks`
--

CREATE TABLE IF NOT EXISTS `pagelinks` (
  `pl_from` int(10) unsigned NOT NULL DEFAULT '0',
  `pl_namespace` int(11) NOT NULL DEFAULT '0',
  `pl_title` varbinary(255) NOT NULL DEFAULT '',
  UNIQUE KEY `pl_from` (`pl_from`,`pl_namespace`,`pl_title`),
  UNIQUE KEY `pl_namespace` (`pl_namespace`,`pl_title`,`pl_from`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Structure de la table `page_props`
--

CREATE TABLE IF NOT EXISTS `page_props` (
  `pp_page` int(11) NOT NULL,
  `pp_propname` varbinary(60) NOT NULL,
  `pp_value` blob NOT NULL,
  UNIQUE KEY `pp_page_propname` (`pp_page`,`pp_propname`),
  UNIQUE KEY `pp_propname_page` (`pp_propname`,`pp_page`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Structure de la table `page_restrictions`
--

CREATE TABLE IF NOT EXISTS `page_restrictions` (
  `pr_page` int(11) NOT NULL,
  `pr_type` varbinary(60) NOT NULL,
  `pr_level` varbinary(60) NOT NULL,
  `pr_cascade` tinyint(4) NOT NULL,
  `pr_user` int(11) DEFAULT NULL,
  `pr_expiry` varbinary(14) DEFAULT NULL,
  `pr_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`pr_id`),
  UNIQUE KEY `pr_pagetype` (`pr_page`,`pr_type`),
  KEY `pr_typelevel` (`pr_type`,`pr_level`),
  KEY `pr_level` (`pr_level`),
  KEY `pr_cascade` (`pr_cascade`)
) ENGINE=InnoDB DEFAULT CHARSET=binary AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `protected_titles`
--

CREATE TABLE IF NOT EXISTS `protected_titles` (
  `pt_namespace` int(11) NOT NULL,
  `pt_title` varbinary(255) NOT NULL,
  `pt_user` int(10) unsigned NOT NULL,
  `pt_reason` tinyblob,
  `pt_timestamp` binary(14) NOT NULL,
  `pt_expiry` varbinary(14) NOT NULL DEFAULT '',
  `pt_create_perm` varbinary(60) NOT NULL,
  UNIQUE KEY `pt_namespace_title` (`pt_namespace`,`pt_title`),
  KEY `pt_timestamp` (`pt_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Structure de la table `querycache`
--

CREATE TABLE IF NOT EXISTS `querycache` (
  `qc_type` varbinary(32) NOT NULL,
  `qc_value` int(10) unsigned NOT NULL DEFAULT '0',
  `qc_namespace` int(11) NOT NULL DEFAULT '0',
  `qc_title` varbinary(255) NOT NULL DEFAULT '',
  KEY `qc_type` (`qc_type`,`qc_value`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Structure de la table `querycachetwo`
--

CREATE TABLE IF NOT EXISTS `querycachetwo` (
  `qcc_type` varbinary(32) NOT NULL,
  `qcc_value` int(10) unsigned NOT NULL DEFAULT '0',
  `qcc_namespace` int(11) NOT NULL DEFAULT '0',
  `qcc_title` varbinary(255) NOT NULL DEFAULT '',
  `qcc_namespacetwo` int(11) NOT NULL DEFAULT '0',
  `qcc_titletwo` varbinary(255) NOT NULL DEFAULT '',
  KEY `qcc_type` (`qcc_type`,`qcc_value`),
  KEY `qcc_title` (`qcc_type`,`qcc_namespace`,`qcc_title`),
  KEY `qcc_titletwo` (`qcc_type`,`qcc_namespacetwo`,`qcc_titletwo`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Structure de la table `querycache_info`
--

CREATE TABLE IF NOT EXISTS `querycache_info` (
  `qci_type` varbinary(32) NOT NULL DEFAULT '',
  `qci_timestamp` binary(14) NOT NULL DEFAULT '19700101000000',
  UNIQUE KEY `qci_type` (`qci_type`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Structure de la table `recentchanges`
--

CREATE TABLE IF NOT EXISTS `recentchanges` (
  `rc_id` int(11) NOT NULL AUTO_INCREMENT,
  `rc_timestamp` varbinary(14) NOT NULL DEFAULT '',
  `rc_cur_time` varbinary(14) NOT NULL DEFAULT '',
  `rc_user` int(10) unsigned NOT NULL DEFAULT '0',
  `rc_user_text` varbinary(255) NOT NULL,
  `rc_namespace` int(11) NOT NULL DEFAULT '0',
  `rc_title` varbinary(255) NOT NULL DEFAULT '',
  `rc_comment` varbinary(255) NOT NULL DEFAULT '',
  `rc_minor` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `rc_bot` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `rc_new` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `rc_cur_id` int(10) unsigned NOT NULL DEFAULT '0',
  `rc_this_oldid` int(10) unsigned NOT NULL DEFAULT '0',
  `rc_last_oldid` int(10) unsigned NOT NULL DEFAULT '0',
  `rc_type` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `rc_patrolled` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `rc_ip` varbinary(40) NOT NULL DEFAULT '',
  `rc_old_len` int(11) DEFAULT NULL,
  `rc_new_len` int(11) DEFAULT NULL,
  `rc_deleted` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `rc_logid` int(10) unsigned NOT NULL DEFAULT '0',
  `rc_log_type` varbinary(255) DEFAULT NULL,
  `rc_log_action` varbinary(255) DEFAULT NULL,
  `rc_params` blob,
  PRIMARY KEY (`rc_id`),
  KEY `rc_timestamp` (`rc_timestamp`),
  KEY `rc_namespace_title` (`rc_namespace`,`rc_title`),
  KEY `rc_cur_id` (`rc_cur_id`),
  KEY `new_name_timestamp` (`rc_new`,`rc_namespace`,`rc_timestamp`),
  KEY `rc_ip` (`rc_ip`),
  KEY `rc_ns_usertext` (`rc_namespace`,`rc_user_text`),
  KEY `rc_user_text` (`rc_user_text`,`rc_timestamp`)
) ENGINE=InnoDB  DEFAULT CHARSET=binary AUTO_INCREMENT=2 ;

--
-- Contenu de la table `recentchanges`
--

INSERT INTO `recentchanges` (`rc_id`, `rc_timestamp`, `rc_cur_time`, `rc_user`, `rc_user_text`, `rc_namespace`, `rc_title`, `rc_comment`, `rc_minor`, `rc_bot`, `rc_new`, `rc_cur_id`, `rc_this_oldid`, `rc_last_oldid`, `rc_type`, `rc_patrolled`, `rc_ip`, `rc_old_len`, `rc_new_len`, `rc_deleted`, `rc_logid`, `rc_log_type`, `rc_log_action`, `rc_params`) VALUES
(1, '20140506031439', '20140506031439', 0, 'MediaWiki default', 0, 'Main_Page', '', 0, 0, 1, 1, 1, 0, 1, 0, '192.168.0.102', 0, 524, 0, 0, NULL, '', '');

-- --------------------------------------------------------

--
-- Structure de la table `redirect`
--

CREATE TABLE IF NOT EXISTS `redirect` (
  `rd_from` int(10) unsigned NOT NULL DEFAULT '0',
  `rd_namespace` int(11) NOT NULL DEFAULT '0',
  `rd_title` varbinary(255) NOT NULL DEFAULT '',
  `rd_interwiki` varbinary(32) DEFAULT NULL,
  `rd_fragment` varbinary(255) DEFAULT NULL,
  PRIMARY KEY (`rd_from`),
  KEY `rd_ns_title` (`rd_namespace`,`rd_title`,`rd_from`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Structure de la table `revision`
--

CREATE TABLE IF NOT EXISTS `revision` (
  `rev_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rev_page` int(10) unsigned NOT NULL,
  `rev_text_id` int(10) unsigned NOT NULL,
  `rev_comment` tinyblob NOT NULL,
  `rev_user` int(10) unsigned NOT NULL DEFAULT '0',
  `rev_user_text` varbinary(255) NOT NULL DEFAULT '',
  `rev_timestamp` binary(14) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `rev_minor_edit` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `rev_deleted` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `rev_len` int(10) unsigned DEFAULT NULL,
  `rev_parent_id` int(10) unsigned DEFAULT NULL,
  `rev_sha1` varbinary(32) NOT NULL DEFAULT '',
  `rev_content_model` varbinary(32) DEFAULT NULL,
  `rev_content_format` varbinary(64) DEFAULT NULL,
  PRIMARY KEY (`rev_id`),
  UNIQUE KEY `rev_page_id` (`rev_page`,`rev_id`),
  KEY `rev_timestamp` (`rev_timestamp`),
  KEY `page_timestamp` (`rev_page`,`rev_timestamp`),
  KEY `user_timestamp` (`rev_user`,`rev_timestamp`),
  KEY `usertext_timestamp` (`rev_user_text`,`rev_timestamp`),
  KEY `page_user_timestamp` (`rev_page`,`rev_user`,`rev_timestamp`)
) ENGINE=InnoDB  DEFAULT CHARSET=binary MAX_ROWS=10000000 AVG_ROW_LENGTH=1024 AUTO_INCREMENT=2 ;

--
-- Contenu de la table `revision`
--

INSERT INTO `revision` (`rev_id`, `rev_page`, `rev_text_id`, `rev_comment`, `rev_user`, `rev_user_text`, `rev_timestamp`, `rev_minor_edit`, `rev_deleted`, `rev_len`, `rev_parent_id`, `rev_sha1`, `rev_content_model`, `rev_content_format`) VALUES
(1, 1, 1, '', 0, 'MediaWiki default', '20140506031439', 0, 0, 524, 0, 'c3gchhvaaxh8pbro7ta0bvbj2slrbyl', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `searchindex`
--

CREATE TABLE IF NOT EXISTS `searchindex` (
  `si_page` int(10) unsigned NOT NULL,
  `si_title` varchar(255) NOT NULL DEFAULT '',
  `si_text` mediumtext NOT NULL,
  UNIQUE KEY `si_page` (`si_page`),
  FULLTEXT KEY `si_title` (`si_title`),
  FULLTEXT KEY `si_text` (`si_text`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Contenu de la table `searchindex`
--

INSERT INTO `searchindex` (`si_page`, `si_title`, `si_text`) VALUES
(1, 'main page', '  mediawiki hasu800 been successfully installed.  consult theu800 metau82ewikimediau82eorgu800 wiki help contents user user''su800 guide foru800 information onu800 using theu800 wiki software. getting started getting started getting started wwwu800u82emediawikiu82eorgu800 wiki manual configuration_settings configuration settings list wwwu800u82emediawikiu82eorgu800 wiki manual faqu800 mediawiki faqu800 mediawiki release mailing list wwwu800u82emediawikiu82eorgu800 wiki localisation#translation_resources localise mediawiki foru800 your language ');

-- --------------------------------------------------------

--
-- Structure de la table `sites`
--

CREATE TABLE IF NOT EXISTS `sites` (
  `site_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `site_global_key` varbinary(32) NOT NULL,
  `site_type` varbinary(32) NOT NULL,
  `site_group` varbinary(32) NOT NULL,
  `site_source` varbinary(32) NOT NULL,
  `site_language` varbinary(32) NOT NULL,
  `site_protocol` varbinary(32) NOT NULL,
  `site_domain` varbinary(255) NOT NULL,
  `site_data` blob NOT NULL,
  `site_forward` tinyint(1) NOT NULL,
  `site_config` blob NOT NULL,
  PRIMARY KEY (`site_id`),
  UNIQUE KEY `sites_global_key` (`site_global_key`),
  KEY `sites_type` (`site_type`),
  KEY `sites_group` (`site_group`),
  KEY `sites_source` (`site_source`),
  KEY `sites_language` (`site_language`),
  KEY `sites_protocol` (`site_protocol`),
  KEY `sites_domain` (`site_domain`),
  KEY `sites_forward` (`site_forward`)
) ENGINE=InnoDB DEFAULT CHARSET=binary AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `site_identifiers`
--

CREATE TABLE IF NOT EXISTS `site_identifiers` (
  `si_site` int(10) unsigned NOT NULL,
  `si_type` varbinary(32) NOT NULL,
  `si_key` varbinary(32) NOT NULL,
  UNIQUE KEY `site_ids_type` (`si_type`,`si_key`),
  KEY `site_ids_site` (`si_site`),
  KEY `site_ids_key` (`si_key`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Structure de la table `site_stats`
--

CREATE TABLE IF NOT EXISTS `site_stats` (
  `ss_row_id` int(10) unsigned NOT NULL,
  `ss_total_views` bigint(20) unsigned DEFAULT '0',
  `ss_total_edits` bigint(20) unsigned DEFAULT '0',
  `ss_good_articles` bigint(20) unsigned DEFAULT '0',
  `ss_total_pages` bigint(20) DEFAULT '-1',
  `ss_users` bigint(20) DEFAULT '-1',
  `ss_active_users` bigint(20) DEFAULT '-1',
  `ss_images` int(11) DEFAULT '0',
  UNIQUE KEY `ss_row_id` (`ss_row_id`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

--
-- Contenu de la table `site_stats`
--

INSERT INTO `site_stats` (`ss_row_id`, `ss_total_views`, `ss_total_edits`, `ss_good_articles`, `ss_total_pages`, `ss_users`, `ss_active_users`, `ss_images`) VALUES
(1, 0, 1, 0, 1, 1, -1, 0);

-- --------------------------------------------------------

--
-- Structure de la table `tag_summary`
--

CREATE TABLE IF NOT EXISTS `tag_summary` (
  `ts_rc_id` int(11) DEFAULT NULL,
  `ts_log_id` int(11) DEFAULT NULL,
  `ts_rev_id` int(11) DEFAULT NULL,
  `ts_tags` blob NOT NULL,
  UNIQUE KEY `tag_summary_rc_id` (`ts_rc_id`),
  UNIQUE KEY `tag_summary_log_id` (`ts_log_id`),
  UNIQUE KEY `tag_summary_rev_id` (`ts_rev_id`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Structure de la table `templatelinks`
--

CREATE TABLE IF NOT EXISTS `templatelinks` (
  `tl_from` int(10) unsigned NOT NULL DEFAULT '0',
  `tl_namespace` int(11) NOT NULL DEFAULT '0',
  `tl_title` varbinary(255) NOT NULL DEFAULT '',
  UNIQUE KEY `tl_from` (`tl_from`,`tl_namespace`,`tl_title`),
  UNIQUE KEY `tl_namespace` (`tl_namespace`,`tl_title`,`tl_from`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Structure de la table `text`
--

CREATE TABLE IF NOT EXISTS `text` (
  `old_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `old_text` mediumblob NOT NULL,
  `old_flags` tinyblob NOT NULL,
  PRIMARY KEY (`old_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=binary MAX_ROWS=10000000 AVG_ROW_LENGTH=10240 AUTO_INCREMENT=2 ;

--
-- Contenu de la table `text`
--

INSERT INTO `text` (`old_id`, `old_text`, `old_flags`) VALUES
(1, 0x2727274d6564696157696b6920686173206265656e207375636365737366756c6c7920696e7374616c6c65642e2727270a0a436f6e73756c7420746865205b2f2f6d6574612e77696b696d656469612e6f72672f77696b692f48656c703a436f6e74656e7473205573657227732047756964655d20666f7220696e666f726d6174696f6e206f6e207573696e67207468652077696b6920736f6674776172652e0a0a3d3d2047657474696e672073746172746564203d3d0a2a205b2f2f7777772e6d6564696177696b692e6f72672f77696b692f4d616e75616c3a436f6e66696775726174696f6e5f73657474696e677320436f6e66696775726174696f6e2073657474696e6773206c6973745d0a2a205b2f2f7777772e6d6564696177696b692e6f72672f77696b692f4d616e75616c3a464151204d6564696157696b69204641515d0a2a205b68747470733a2f2f6c697374732e77696b696d656469612e6f72672f6d61696c6d616e2f6c697374696e666f2f6d6564696177696b692d616e6e6f756e6365204d6564696157696b692072656c65617365206d61696c696e67206c6973745d0a2a205b2f2f7777772e6d6564696177696b692e6f72672f77696b692f4c6f63616c69736174696f6e235472616e736c6174696f6e5f7265736f7572636573204c6f63616c697365204d6564696157696b6920666f7220796f7572206c616e67756167655d, 0x7574662d38);

-- --------------------------------------------------------

--
-- Structure de la table `transcache`
--

CREATE TABLE IF NOT EXISTS `transcache` (
  `tc_url` varbinary(255) NOT NULL,
  `tc_contents` blob,
  `tc_time` binary(14) NOT NULL,
  UNIQUE KEY `tc_url_idx` (`tc_url`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Structure de la table `updatelog`
--

CREATE TABLE IF NOT EXISTS `updatelog` (
  `ul_key` varbinary(255) NOT NULL,
  `ul_value` blob,
  PRIMARY KEY (`ul_key`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Structure de la table `uploadstash`
--

CREATE TABLE IF NOT EXISTS `uploadstash` (
  `us_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `us_user` int(10) unsigned NOT NULL,
  `us_key` varbinary(255) NOT NULL,
  `us_orig_path` varbinary(255) NOT NULL,
  `us_path` varbinary(255) NOT NULL,
  `us_source_type` varbinary(50) DEFAULT NULL,
  `us_timestamp` varbinary(14) NOT NULL,
  `us_status` varbinary(50) NOT NULL,
  `us_chunk_inx` int(10) unsigned DEFAULT NULL,
  `us_props` blob,
  `us_size` int(10) unsigned NOT NULL,
  `us_sha1` varbinary(31) NOT NULL,
  `us_mime` varbinary(255) DEFAULT NULL,
  `us_media_type` enum('UNKNOWN','BITMAP','DRAWING','AUDIO','VIDEO','MULTIMEDIA','OFFICE','TEXT','EXECUTABLE','ARCHIVE') DEFAULT NULL,
  `us_image_width` int(10) unsigned DEFAULT NULL,
  `us_image_height` int(10) unsigned DEFAULT NULL,
  `us_image_bits` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`us_id`),
  UNIQUE KEY `us_key` (`us_key`),
  KEY `us_user` (`us_user`),
  KEY `us_timestamp` (`us_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=binary AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `user_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varbinary(255) NOT NULL DEFAULT '',
  `user_real_name` varbinary(255) NOT NULL DEFAULT '',
  `user_password` tinyblob NOT NULL,
  `user_newpassword` tinyblob NOT NULL,
  `user_newpass_time` binary(14) DEFAULT NULL,
  `user_email` tinyblob NOT NULL,
  `user_touched` binary(14) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `user_token` binary(32) NOT NULL DEFAULT '\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `user_email_authenticated` binary(14) DEFAULT NULL,
  `user_email_token` binary(32) DEFAULT NULL,
  `user_email_token_expires` binary(14) DEFAULT NULL,
  `user_registration` binary(14) DEFAULT NULL,
  `user_editcount` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_name` (`user_name`),
  KEY `user_email_token` (`user_email_token`),
  KEY `user_email` (`user_email`(50))
) ENGINE=InnoDB  DEFAULT CHARSET=binary AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Structure de la table `user_former_groups`
--

CREATE TABLE IF NOT EXISTS `user_former_groups` (
  `ufg_user` int(10) unsigned NOT NULL DEFAULT '0',
  `ufg_group` varbinary(255) NOT NULL DEFAULT '',
  UNIQUE KEY `ufg_user_group` (`ufg_user`,`ufg_group`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Structure de la table `user_groups`
--

CREATE TABLE IF NOT EXISTS `user_groups` (
  `ug_user` int(10) unsigned NOT NULL DEFAULT '0',
  `ug_group` varbinary(255) NOT NULL DEFAULT '',
  UNIQUE KEY `ug_user_group` (`ug_user`,`ug_group`),
  KEY `ug_group` (`ug_group`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;


-- --------------------------------------------------------

--
-- Structure de la table `user_newtalk`
--

CREATE TABLE IF NOT EXISTS `user_newtalk` (
  `user_id` int(11) NOT NULL DEFAULT '0',
  `user_ip` varbinary(40) NOT NULL DEFAULT '',
  `user_last_timestamp` varbinary(14) DEFAULT NULL,
  KEY `user_id` (`user_id`),
  KEY `user_ip` (`user_ip`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Structure de la table `user_properties`
--

CREATE TABLE IF NOT EXISTS `user_properties` (
  `up_user` int(11) NOT NULL,
  `up_property` varbinary(255) NOT NULL,
  `up_value` blob,
  UNIQUE KEY `user_properties_user_property` (`up_user`,`up_property`),
  KEY `user_properties_property` (`up_property`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Structure de la table `valid_tag`
--

CREATE TABLE IF NOT EXISTS `valid_tag` (
  `vt_tag` varbinary(255) NOT NULL,
  PRIMARY KEY (`vt_tag`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

-- --------------------------------------------------------

--
-- Structure de la table `watchlist`
--

CREATE TABLE IF NOT EXISTS `watchlist` (
  `wl_user` int(10) unsigned NOT NULL,
  `wl_namespace` int(11) NOT NULL DEFAULT '0',
  `wl_title` varbinary(255) NOT NULL DEFAULT '',
  `wl_notificationtimestamp` varbinary(14) DEFAULT NULL,
  UNIQUE KEY `wl_user` (`wl_user`,`wl_namespace`,`wl_title`),
  KEY `namespace_title` (`wl_namespace`,`wl_title`)
) ENGINE=InnoDB DEFAULT CHARSET=binary;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
