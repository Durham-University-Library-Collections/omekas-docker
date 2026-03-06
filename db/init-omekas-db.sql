-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Generation Time: Mar 06, 2026 at 04:19 PM
-- Server version: 8.0.45
-- PHP Version: 8.0.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `omekas`
--

-- --------------------------------------------------------

--
-- Table structure for table `api_key`
--

CREATE TABLE `api_key` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner_id` int NOT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `credential_hash` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_ip` varbinary(16) DEFAULT NULL COMMENT '(DC2Type:ip_address)',
  `last_accessed` datetime DEFAULT NULL,
  `created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `api_key`
--

INSERT INTO `api_key` (`id`, `owner_id`, `label`, `credential_hash`, `last_ip`, `last_accessed`, `created`) VALUES
('0XhKkvsEtxdoJpbrBd3wj6baaxZ31giS', 1, 'admin-key-411', '$2y$10$ALWAd22X1u.1PhhaI33oIeV04vrXcwO6QdE34hBbd5tY/bFLMDxxG', NULL, NULL, '2025-08-11 10:49:40');

-- --------------------------------------------------------

--
-- Table structure for table `asset`
--

CREATE TABLE `asset` (
  `id` int NOT NULL,
  `owner_id` int DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `media_type` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `storage_id` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `extension` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alt_text` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bulk_export`
--

CREATE TABLE `bulk_export` (
  `id` int NOT NULL,
  `exporter_id` int DEFAULT NULL,
  `owner_id` int DEFAULT NULL,
  `job_id` int DEFAULT NULL,
  `comment` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `params` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json)',
  `filename` varchar(760) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bulk_exporter`
--

CREATE TABLE `bulk_exporter` (
  `id` int NOT NULL,
  `owner_id` int DEFAULT NULL,
  `label` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `writer` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `config` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bulk_exporter`
--

INSERT INTO `bulk_exporter` (`id`, `owner_id`, `label`, `writer`, `config`) VALUES
(1, 1, 'TSV (tab-separated values)', 'BulkExport\\Writer\\TsvWriter', '{\"writer\":{\"separator\":\" | \",\"resource_types\":[\"o:Item\"],\"metadata\":null,\"query\":\"\"}}'),
(2, 1, 'OpenDocument text (odt)', 'BulkExport\\Writer\\OpenDocumentTextWriter', '{\"writer\":{\"format_fields\":\"label\",\"resource_types\":[\"o:Item\"],\"metadata\":null,\"query\":\"\"}}'),
(3, 1, 'OpenDocument spreadsheet (ods)', 'BulkExport\\Writer\\OpenDocumentSpreadsheetWriter', '{\"writer\":{\"separator\":\" | \",\"resource_types\":[\"o:Item\"],\"metadata\":null,\"query\":\"\"}}'),
(4, 1, 'CSV', 'BulkExport\\Writer\\CsvWriter', '{\"writer\":{\"delimiter\":\",\",\"enclosure\":\"\\\"\",\"escape\":\"\\\\\",\"separator\":\" | \",\"resource_types\":[\"o:Item\"],\"metadata\":null,\"query\":\"\"}}'),
(5, 1, 'Text', 'BulkExport\\Writer\\TextWriter', '{\"writer\":{\"format_fields\":\"label\",\"resource_types\":[\"o:Item\"],\"metadata\":null,\"query\":\"\"}}');

-- --------------------------------------------------------

--
-- Table structure for table `csvimport_entity`
--

CREATE TABLE `csvimport_entity` (
  `id` int NOT NULL,
  `job_id` int NOT NULL,
  `entity_id` int NOT NULL,
  `resource_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `csvimport_import`
--

CREATE TABLE `csvimport_import` (
  `id` int NOT NULL,
  `job_id` int NOT NULL,
  `undo_job_id` int DEFAULT NULL,
  `comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `resource_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `has_err` tinyint(1) NOT NULL,
  `stats` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `custom_vocab`
--

CREATE TABLE `custom_vocab` (
  `id` int NOT NULL,
  `item_set_id` int DEFAULT NULL,
  `owner_id` int DEFAULT NULL,
  `label` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `lang` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `terms` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:json)',
  `uris` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:json)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `custom_vocab`
--

INSERT INTO `custom_vocab` (`id`, `item_set_id`, `owner_id`, `label`, `lang`, `terms`, `uris`) VALUES
(1, NULL, 1, 'Languages', NULL, '[\"Dutch\",\"English\",\"French\",\"German\",\"Latin\"]', NULL),
(2, 2, 1, 'CC-Licenses', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `fulltext_search`
--

CREATE TABLE `fulltext_search` (
  `id` int NOT NULL,
  `resource` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner_id` int DEFAULT NULL,
  `is_public` tinyint(1) NOT NULL,
  `title` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `text` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `fulltext_search`
--

INSERT INTO `fulltext_search` (`id`, `resource`, `owner_id`, `is_public`, `title`, `text`) VALUES
(1, 'items', 1, 1, 'First item', 'First item\nThis is the first item in this Omeka instance. It was created during the Docker bootstrap phase.\nIt contains metadata, but no associated media files.\nark:/99999/a1apZs2'),
(2, 'item_sets', 1, 1, 'CC-Licenses Collection', 'CC-Licenses Collection\nark:/99999/a12vpho'),
(3, 'items', 1, 1, 'Creative Common license - CC-BY-NC', 'CC-BY-NC\nCreative Common license - CC-BY-NC\nhttps://creativecommons.org/licenses/by-nc/4.0/ Creative Commons website\nYou are free to:\nShare — copy and redistribute the material in any medium or format\nAdapt — remix, transform, and build upon the material\nThe licensor cannot revoke these freedoms as long as you follow the license terms.\nAttribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.\n\nNonCommercial — You may not use the material for commercial purposes.\n\nNo additional restrictions — You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.\nark:/99999/a1UAQRM'),
(4, 'items', 1, 1, 'Creative Common license - CC-BY', 'CC-BY\nCreative Common license - CC-BY\nhttps://creativecommons.org/licenses/by/4.0/ Creative Commons website\nYou are free to:\nShare — copy and redistribute the material in any medium or format\nAdapt — remix, transform, and build upon the material\nfor any purpose, even commercially.\nUnder the following terms:\nAttribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.\n\nNo additional restrictions — You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.\nark:/99999/a1MGfH7');

-- --------------------------------------------------------

--
-- Table structure for table `hit`
--

CREATE TABLE `hit` (
  `id` int NOT NULL,
  `url` varchar(1024) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `entity_id` int NOT NULL DEFAULT '0',
  `entity_name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `site_id` int NOT NULL DEFAULT '0',
  `user_id` int NOT NULL DEFAULT '0',
  `ip` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `language` varchar(2) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `query` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:json)',
  `referrer` varchar(1024) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL DEFAULT '',
  `user_agent` varchar(1024) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `accept_language` varchar(190) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `hit`
--

INSERT INTO `hit` (`id`, `url`, `entity_id`, `entity_name`, `site_id`, `user_id`, `ip`, `language`, `query`, `referrer`, `user_agent`, `accept_language`, `created`) VALUES
(1, '/', 0, '', 0, 0, '::', 'en', NULL, '', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:124.0) Gecko/20100101 Firefox/124.0', 'en-US,en;q=0.5', '2024-03-26 13:43:37'),
(2, '/', 0, '', 0, 0, '::', 'en', NULL, '', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:124.0) Gecko/20100101 Firefox/124.0', 'en-US,en;q=0.5', '2024-04-15 09:39:14'),
(3, '/s/default/item', 0, '', 1, 1, '::', 'en', NULL, 'http://omeka.local/s/default/item', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:125.0) Gecko/20100101 Firefox/125.0', 'en-US,en;q=0.5', '2024-04-15 12:33:56'),
(4, '/s/default/item', 0, '', 1, 1, '::', 'en', NULL, 'http://omeka.local/s/default/item', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:125.0) Gecko/20100101 Firefox/125.0', 'en-US,en;q=0.5', '2024-04-15 12:34:16'),
(5, '/s/default/item/1', 1, 'items', 1, 1, '::', 'en', NULL, 'http://omeka.local/s/default/item', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:125.0) Gecko/20100101 Firefox/125.0', 'en-US,en;q=0.5', '2024-04-15 12:34:18'),
(6, '/s/default/item', 0, '', 1, 1, '::', 'en', NULL, 'http://omeka.local/s/default/item', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:125.0) Gecko/20100101 Firefox/125.0', 'en-US,en;q=0.5', '2024-04-15 12:34:19'),
(7, '/', 0, '', 0, 0, '::', 'en', NULL, '', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:125.0) Gecko/20100101 Firefox/125.0', 'en-US,en;q=0.5', '2024-04-16 12:07:36'),
(8, '/', 0, '', 0, 0, '::', 'en', NULL, '', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:131.0) Gecko/20100101 Firefox/131.0', 'en-US,en;q=0.5', '2024-10-08 13:35:21'),
(9, '/', 0, '', 0, 1, '::', 'en', NULL, '', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:131.0) Gecko/20100101 Firefox/131.0', 'en-US,en;q=0.5', '2024-10-08 13:36:02'),
(10, '/s/default', 0, '', 1, 1, '::', 'en', NULL, 'http://omeka.local/', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:131.0) Gecko/20100101 Firefox/131.0', 'en-US,en;q=0.5', '2024-10-08 13:36:04'),
(11, '/s/default/page/welcome', 1, 'site_pages', 1, 1, '::', 'en', NULL, 'http://omeka.local/', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:131.0) Gecko/20100101 Firefox/131.0', 'en-US,en;q=0.5', '2024-10-08 13:36:04'),
(12, '/s/default/sitemap.xml', 0, '', 1, 1, '::', 'en', NULL, '', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:131.0) Gecko/20100101 Firefox/131.0', 'en-US,en;q=0.5', '2024-10-08 13:36:11'),
(13, '/', 0, '', 0, 1, '::', 'en', NULL, '', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:131.0) Gecko/20100101 Firefox/131.0', 'en-US,en;q=0.5', '2024-10-08 13:37:24'),
(14, '/', 0, '', 0, 1, '::', 'en', NULL, '', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:131.0) Gecko/20100101 Firefox/131.0', 'en-US,en;q=0.5', '2024-10-08 13:38:45'),
(15, '/s/default', 0, '', 1, 1, '::', 'en', NULL, 'http://omeka.local/', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:131.0) Gecko/20100101 Firefox/131.0', 'en-US,en;q=0.5', '2024-10-08 13:38:46'),
(16, '/s/default/page/welcome', 1, 'site_pages', 1, 1, '::', 'en', NULL, 'http://omeka.local/', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:131.0) Gecko/20100101 Firefox/131.0', 'en-US,en;q=0.5', '2024-10-08 13:38:46'),
(17, '/s/default/sitemap.xml', 0, '', 1, 1, '::', 'en', NULL, '', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:131.0) Gecko/20100101 Firefox/131.0', 'en-US,en;q=0.5', '2024-10-08 13:38:53'),
(18, '/s/default/sitemapindex.xml', 0, '', 1, 1, '::', 'en', NULL, '', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:131.0) Gecko/20100101 Firefox/131.0', 'en-US,en;q=0.5', '2024-10-08 13:38:53'),
(19, '/s/default/sitemap.xml', 0, '', 1, 1, '::', 'en', NULL, '', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:131.0) Gecko/20100101 Firefox/131.0', 'en-US,en;q=0.5', '2024-10-08 13:39:28'),
(20, '/s/default/sitemapindex.xml', 0, '', 1, 1, '::', 'en', NULL, '', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:131.0) Gecko/20100101 Firefox/131.0', 'en-US,en;q=0.5', '2024-10-08 13:39:29'),
(21, '/s/default/sitemapindex.xml', 0, '', 1, 1, '::', 'en', NULL, '', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:131.0) Gecko/20100101 Firefox/131.0', 'en-US,en;q=0.5', '2024-10-08 13:41:32'),
(22, '/s/default/sitemap.xml', 0, '', 1, 1, '::', 'en', NULL, '', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:131.0) Gecko/20100101 Firefox/131.0', 'en-US,en;q=0.5', '2024-10-08 13:41:32'),
(23, '/', 0, '', 0, 0, '::', 'en', NULL, '', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/135.0.0.0 Safari/537.36', 'en-US,en;q=0.9', '2025-04-30 07:57:12'),
(24, '/s/default', 0, '', 1, 1, '::', 'en', NULL, 'http://omeka.local/admin/site', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'en-US,en;q=0.9', '2025-07-10 14:52:21'),
(25, '/s/default/page/welcome', 1, 'site_pages', 1, 1, '::', 'en', NULL, 'http://omeka.local/admin/site', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'en-US,en;q=0.9', '2025-07-10 14:52:21'),
(26, '/s/default/page/welcome', 1, 'site_pages', 1, 1, '::', 'en', NULL, 'http://omeka.local/admin/site', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'en-US,en;q=0.9', '2025-07-10 14:52:39'),
(27, '/s/default/find', 0, '', 1, 1, '::', 'en', NULL, 'http://omeka.local/s/default/page/welcome', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'en-US,en;q=0.9', '2025-07-10 14:52:40'),
(28, '/s/default/find', 0, '', 1, 1, '::', 'en', NULL, 'http://omeka.local/s/default/page/welcome', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'en-US,en;q=0.9', '2025-07-10 14:52:48'),
(29, '/s/index', 0, '', 1, 1, '::', 'en', NULL, 'http://omeka.local/admin/site/s/index', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'en-US,en;q=0.9', '2025-07-10 14:56:35'),
(30, '/s/index/page/welcome', 1, 'site_pages', 1, 1, '::', 'en', NULL, 'http://omeka.local/admin/site/s/index', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'en-US,en;q=0.9', '2025-07-10 14:56:35'),
(31, '/s/index/page/welcome', 1, 'site_pages', 1, 1, '::', 'en', NULL, 'http://omeka.local/admin/site/s/index', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'en-US,en;q=0.9', '2025-07-10 14:56:38'),
(32, '/s/index/find', 0, '', 1, 1, '::', 'en', NULL, 'http://omeka.local/s/index/page/welcome', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'en-US,en;q=0.9', '2025-07-10 14:56:39'),
(33, '/s/index/item/1', 1, 'items', 1, 1, '::', 'en', NULL, 'http://omeka.local/s/index/find', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'en-US,en;q=0.9', '2025-07-10 14:56:41'),
(34, '/s/index', 0, '', 1, 1, '::', 'en', NULL, 'http://omeka.local/s/index/find', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'en-US,en;q=0.9', '2025-09-29 13:38:56'),
(35, '/s/index/page/welcome', 1, 'site_pages', 1, 1, '::', 'en', NULL, 'http://omeka.local/s/index/find', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'en-US,en;q=0.9', '2025-09-29 13:38:56'),
(36, '/s/index/find', 0, '', 1, 1, '::', 'en', NULL, 'http://omeka.local/s/index/page/welcome', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'en-US,en;q=0.9', '2025-09-29 13:38:58'),
(37, '/s/index/item', 0, '', 1, 1, '::', 'en', NULL, 'http://omeka.local/s/index/find', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'en-US,en;q=0.9', '2025-09-29 13:38:59'),
(38, '/s/index/item/1', 1, 'items', 1, 1, '::', 'en', NULL, 'http://omeka.local/s/index/item', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'en-US,en;q=0.9', '2025-09-29 13:39:01'),
(39, '/s/index/item', 0, '', 1, 1, '::', 'en', NULL, 'http://omeka.local/s/index/item/1', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'en-US,en;q=0.9', '2025-09-29 13:39:03'),
(40, '/s/index/find', 0, '', 1, 1, '::', 'en', NULL, 'http://omeka.local/s/index/item', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'en-US,en;q=0.9', '2025-09-29 13:49:10'),
(41, '/s/index/find', 0, '', 1, 1, '::', 'en', NULL, 'http://omeka.local/s/index/item', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'en-US,en;q=0.9', '2025-09-29 13:49:32'),
(42, '/', 0, '', 0, 0, '::', 'en', NULL, '', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36', 'en-US,en;q=0.9', '2025-11-12 13:24:49'),
(43, '/s/index/find', 0, '', 1, 1, '::', 'nl', NULL, 'http://omeka.local/s/index/page/welcome', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:145.0) Gecko/20100101 Firefox/145.0', 'nl,en-US;q=0.7,en;q=0.3', '2025-12-09 10:50:44'),
(44, '/', 0, '', 0, 0, '::', 'en', NULL, '', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'en-US,en;q=0.9', '2026-02-19 13:51:26'),
(45, '/', 0, '', 0, 0, '::', 'en', NULL, '', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:147.0) Gecko/20100101 Firefox/147.0', 'en-GB,en;q=0.9', '2026-03-06 11:22:48'),
(46, '/s/index', 0, '', 1, 0, '::', 'en', NULL, 'http://omeka.local/', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:147.0) Gecko/20100101 Firefox/147.0', 'en-GB,en;q=0.9', '2026-03-06 11:23:00'),
(47, '/s/index/page/welcome', 1, 'site_pages', 1, 0, '::', 'en', NULL, 'http://omeka.local/', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:147.0) Gecko/20100101 Firefox/147.0', 'en-GB,en;q=0.9', '2026-03-06 11:23:00'),
(48, '/', 0, '', 0, 0, '::', 'en', NULL, '', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:147.0) Gecko/20100101 Firefox/147.0', 'en-GB,en;q=0.9', '2026-03-06 11:23:02'),
(49, '/', 0, '', 0, 0, '::', 'en', NULL, '', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:147.0) Gecko/20100101 Firefox/147.0', 'en-GB,en;q=0.9', '2026-03-06 11:23:32'),
(50, '/', 0, '', 0, 0, '::', 'en', NULL, '', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:147.0) Gecko/20100101 Firefox/147.0', 'en-GB,en;q=0.9', '2026-03-06 11:23:45'),
(51, '/', 0, '', 0, 1, '::', 'en', NULL, '', 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:147.0) Gecko/20100101 Firefox/147.0', 'en-GB,en;q=0.9', '2026-03-06 16:13:55');

-- --------------------------------------------------------

--
-- Table structure for table `item`
--

CREATE TABLE `item` (
  `id` int NOT NULL,
  `primary_media_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `item`
--

INSERT INTO `item` (`id`, `primary_media_id`) VALUES
(1, NULL),
(3, NULL),
(4, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `item_item_set`
--

CREATE TABLE `item_item_set` (
  `item_id` int NOT NULL,
  `item_set_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `item_item_set`
--

INSERT INTO `item_item_set` (`item_id`, `item_set_id`) VALUES
(3, 2),
(4, 2);

-- --------------------------------------------------------

--
-- Table structure for table `item_set`
--

CREATE TABLE `item_set` (
  `id` int NOT NULL,
  `is_open` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `item_set`
--

INSERT INTO `item_set` (`id`, `is_open`) VALUES
(2, 0);

-- --------------------------------------------------------

--
-- Table structure for table `item_site`
--

CREATE TABLE `item_site` (
  `item_id` int NOT NULL,
  `site_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `item_site`
--

INSERT INTO `item_site` (`item_id`, `site_id`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `job`
--

CREATE TABLE `job` (
  `id` int NOT NULL,
  `owner_id` int DEFAULT NULL,
  `pid` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `class` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `args` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:json_array)',
  `log` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `started` datetime NOT NULL,
  `ended` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `job`
--

INSERT INTO `job` (`id`, `owner_id`, `pid`, `status`, `class`, `args`, `log`, `started`, `ended`) VALUES
(1, 1, '49', 'completed', 'Ark\\Job\\CreateArks', NULL, NULL, '2023-02-16 07:52:23', '2023-02-16 07:52:23'),
(2, 1, '41', 'completed', 'AdvancedSearch\\Job\\IndexSearch', '{\"search_engine_id\":2,\"start_resource_id\":1,\"resource_names\":[\"items\"],\"force\":false}', '2023-02-28T14:44:24+00:00 NOTICE (5): Search index #2 (\"Solr\"): start of indexing\n2023-02-28T14:44:24+00:00 INFO (6): Search index is not cleared: reindexing starts at resource #1.\n2023-02-28T14:44:24+00:00 INFO (6): Indexing in Solr core \"Default\": item #1\n2023-02-28T14:44:24+00:00 INFO (6): Search index #2 (\"Solr\"): end of indexing. items: 1 indexed. Execution time: 0 seconds. Failed indexed resources should be checked manually.\n', '2023-02-28 14:44:23', '2023-02-28 14:44:24'),
(3, 1, '165', 'completed', 'AdvancedSearch\\Job\\IndexSearch', '{\"search_engine_ids\":[2],\"clear_index\":false,\"start_resource_id\":1,\"resources_by_batch\":500,\"sleep_after_loop\":0,\"resource_types\":[\"items\"],\"resources_limit\":0,\"resources_offset\":0,\"visibility\":null,\"force\":false}', NULL, '2025-07-10 14:52:46', '2025-07-10 14:52:47'),
(4, 1, '181', 'completed', 'Omeka\\Job\\BatchDelete', '{\"resource\":\"logs\",\"query\":{\"sort_by_default\":\"\",\"sort_order_default\":\"\",\"message\":[]}}', NULL, '2025-07-10 14:57:58', '2025-07-10 14:57:58'),
(5, 1, '163', 'completed', 'AdvancedSearch\\Job\\IndexSearch', '{\"search_engine_ids\":[2],\"clear_index\":false,\"start_resource_id\":1,\"resources_by_batch\":500,\"sleep_after_loop\":0,\"resource_types\":[\"items\"],\"resources_limit\":0,\"resources_offset\":0,\"visibility\":null,\"force\":false}', NULL, '2025-09-29 13:43:46', '2025-09-29 13:43:46'),
(6, 1, '163', 'completed', 'Log\\Job\\ArchiveLogsJob', '{\"seconds\":7776000,\"severity\":0,\"references\":[],\"store\":false,\"format\":\"tsv\",\"compress\":true,\"include_id\":false,\"translate\":true,\"delete\":true}', NULL, '2025-12-09 10:50:33', '2025-12-09 10:50:33'),
(7, NULL, '162', 'completed', 'Log\\Job\\ArchiveLogsJob', '{\"seconds\":7776000,\"severity\":0,\"references\":[],\"store\":false,\"format\":\"tsv\",\"compress\":true,\"include_id\":false,\"translate\":true,\"delete\":true}', NULL, '2026-01-06 11:50:35', '2026-01-06 11:50:35'),
(8, NULL, '162', 'completed', 'Log\\Job\\ArchiveLogsJob', '{\"seconds\":7776000,\"severity\":0,\"references\":[],\"store\":false,\"format\":\"tsv\",\"compress\":true,\"include_id\":false,\"translate\":true,\"delete\":true}', NULL, '2026-02-19 13:51:26', '2026-02-19 13:51:26'),
(9, NULL, '162', 'completed', 'Log\\Job\\ArchiveLogsJob', '{\"seconds\":7776000,\"severity\":0,\"references\":[],\"store\":false,\"format\":\"tsv\",\"compress\":true,\"include_id\":false,\"translate\":true,\"delete\":true}', NULL, '2026-03-06 11:22:48', '2026-03-06 11:22:49');

-- --------------------------------------------------------

--
-- Table structure for table `log`
--

CREATE TABLE `log` (
  `id` int NOT NULL,
  `owner_id` int DEFAULT NULL,
  `job_id` int DEFAULT NULL,
  `reference` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `severity` int NOT NULL DEFAULT '0',
  `message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `context` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json)',
  `created` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `log`
--

INSERT INTO `log` (`id`, `owner_id`, `job_id`, `reference`, `severity`, `message`, `context`, `created`) VALUES
(23, 1, 6, 'easy-admin/check/job_6', 5, 'Delete specified logs older than {date_time} with params: severity = {severity}; reference = {references}.', '{\"date_time\":\"2025-09-10 10:50:33\",\"severity\":\"-\",\"references\":\"-\"}', '2025-12-09 10:50:33'),
(24, 1, 6, 'easy-admin/check/job_6', 5, 'No logs found matching criteria.', '[]', '2025-12-09 10:50:33'),
(25, NULL, 7, 'easy-admin/check/job_7', 5, 'Delete specified logs older than {date_time} with params: severity = {severity}; reference = {references}.', '{\"date_time\":\"2025-10-08 11:50:35\",\"severity\":\"-\",\"references\":\"-\"}', '2026-01-06 11:50:35'),
(26, NULL, 7, 'easy-admin/check/job_7', 5, 'Found {count} logs to process.', '{\"count\":5}', '2026-01-06 11:50:35'),
(27, NULL, 7, 'easy-admin/check/job_7', 5, 'Deleted {count} logs from database.', '{\"count\":5}', '2026-01-06 11:50:35'),
(28, NULL, 8, 'easy-admin/check/job_8', 5, 'Delete specified logs older than {date_time} with params: severity = {severity}; reference = {references}.', '{\"date_time\":\"2025-11-21 13:51:26\",\"severity\":\"-\",\"references\":\"-\"}', '2026-02-19 13:51:26'),
(29, NULL, 8, 'easy-admin/check/job_8', 5, 'Found {count} logs to process.', '{\"count\":1}', '2026-02-19 13:51:26'),
(30, NULL, 8, 'easy-admin/check/job_8', 5, 'Deleted {count} logs from database.', '{\"count\":1}', '2026-02-19 13:51:26'),
(31, NULL, 9, 'easy-admin/check/job_9', 5, 'Delete specified logs older than {date_time} with params: severity = {severity}; reference = {references}.', '{\"date_time\":\"2025-12-06 11:22:49\",\"severity\":\"-\",\"references\":\"-\"}', '2026-03-06 11:22:49'),
(32, NULL, 9, 'easy-admin/check/job_9', 5, 'No logs found matching criteria.', '[]', '2026-03-06 11:22:49');

-- --------------------------------------------------------

--
-- Table structure for table `media`
--

CREATE TABLE `media` (
  `id` int NOT NULL,
  `item_id` int NOT NULL,
  `ingester` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `renderer` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:json_array)',
  `source` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `media_type` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `storage_id` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `extension` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sha256` char(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `size` bigint DEFAULT NULL,
  `has_original` tinyint(1) NOT NULL,
  `has_thumbnails` tinyint(1) NOT NULL,
  `position` int DEFAULT NULL,
  `lang` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alt_text` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migration`
--

CREATE TABLE `migration` (
  `version` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migration`
--

INSERT INTO `migration` (`version`) VALUES
('20171128053327'),
('20180412035023'),
('20180919072656'),
('20180924033501'),
('20181002015551'),
('20181004043735'),
('20181106060421'),
('20190307043537'),
('20190319020708'),
('20190412090532'),
('20190423040354'),
('20190423071228'),
('20190514061351'),
('20190515055359'),
('20190729023728'),
('20190809092609'),
('20190815062003'),
('20200224022356'),
('20200226064602'),
('20200325091157'),
('20200326091310'),
('20200803000000'),
('20200831000000'),
('20210205101827'),
('20210225095734'),
('20210810083804'),
('20220718090449'),
('20220824103916'),
('20230124033031'),
('20230410074846'),
('20230523085358'),
('20230601060113'),
('20230713101012'),
('20231016000000'),
('20240103030617');

-- --------------------------------------------------------

--
-- Table structure for table `module`
--

CREATE TABLE `module` (
  `id` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `version` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `module`
--

INSERT INTO `module` (`id`, `is_active`, `version`) VALUES
('AdvancedSearch', 1, '3.4.53'),
('ArchiveRepertory', 1, '3.15.17'),
('Ark', 1, '3.5.15'),
('BlockPlus', 1, '3.4.42'),
('BlocksDisposition', 1, '3.4.5'),
('BulkEdit', 1, '3.4.37'),
('BulkExport', 1, '3.4.37'),
('Common', 1, '3.4.74'),
('CreateMissingThumbnails', 1, '0.3.0'),
('CSVImport', 1, '2.6.2'),
('CustomVocab', 1, '2.0.2'),
('EasyAdmin', 1, '3.4.37'),
('EUCookieBar', 1, '3.4.5'),
('ExtractText', 1, '2.1.0'),
('FileSideload', 1, '1.7.1'),
('HideProperties', 1, '1.3.1'),
('IiifSearch', 1, '3.4.8'),
('IiifServer', 1, '3.6.26'),
('ImageServer', 1, '3.6.20'),
('Log', 1, '3.4.33'),
('Mirador', 1, '3.4.10'),
('ModelViewer', 1, '3.3.0.7-132'),
('NdeTermennetwerk', 1, '1.4.0'),
('NumericDataTypes', 1, '1.13.0'),
('PdfViewer', 1, '3.4.4'),
('ResourceMeta', 1, '1.1.0'),
('SearchSolr', 1, '3.5.60'),
('Sitemaps', 1, '1.1'),
('Statistics', 1, '3.4.11'),
('UniversalViewer', 1, '3.6.11-4.2.1'),
('ValueSuggest', 1, '1.19.0');

-- --------------------------------------------------------

--
-- Table structure for table `numeric_data_types_duration`
--

CREATE TABLE `numeric_data_types_duration` (
  `id` int NOT NULL,
  `resource_id` int NOT NULL,
  `property_id` int NOT NULL,
  `value` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `numeric_data_types_integer`
--

CREATE TABLE `numeric_data_types_integer` (
  `id` int NOT NULL,
  `resource_id` int NOT NULL,
  `property_id` int NOT NULL,
  `value` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `numeric_data_types_interval`
--

CREATE TABLE `numeric_data_types_interval` (
  `id` int NOT NULL,
  `resource_id` int NOT NULL,
  `property_id` int NOT NULL,
  `value` bigint NOT NULL,
  `value2` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `numeric_data_types_timestamp`
--

CREATE TABLE `numeric_data_types_timestamp` (
  `id` int NOT NULL,
  `resource_id` int NOT NULL,
  `property_id` int NOT NULL,
  `value` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_creation`
--

CREATE TABLE `password_creation` (
  `id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `user_id` int NOT NULL,
  `created` datetime NOT NULL,
  `activate` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `property`
--

CREATE TABLE `property` (
  `id` int NOT NULL,
  `owner_id` int DEFAULT NULL,
  `vocabulary_id` int NOT NULL,
  `local_name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `property`
--

INSERT INTO `property` (`id`, `owner_id`, `vocabulary_id`, `local_name`, `label`, `comment`) VALUES
(1, NULL, 1, 'title', 'Title', 'A name given to the resource.'),
(2, NULL, 1, 'creator', 'Creator', 'An entity primarily responsible for making the resource.'),
(3, NULL, 1, 'subject', 'Subject', 'The topic of the resource.'),
(4, NULL, 1, 'description', 'Description', 'An account of the resource.'),
(5, NULL, 1, 'publisher', 'Publisher', 'An entity responsible for making the resource available.'),
(6, NULL, 1, 'contributor', 'Contributor', 'An entity responsible for making contributions to the resource.'),
(7, NULL, 1, 'date', 'Date', 'A point or period of time associated with an event in the lifecycle of the resource.'),
(8, NULL, 1, 'type', 'Type', 'The nature or genre of the resource.'),
(9, NULL, 1, 'format', 'Format', 'The file format, physical medium, or dimensions of the resource.'),
(10, NULL, 1, 'identifier', 'Identifier', 'An unambiguous reference to the resource within a given context.'),
(11, NULL, 1, 'source', 'Source', 'A related resource from which the described resource is derived.'),
(12, NULL, 1, 'language', 'Language', 'A language of the resource.'),
(13, NULL, 1, 'relation', 'Relation', 'A related resource.'),
(14, NULL, 1, 'coverage', 'Coverage', 'The spatial or temporal topic of the resource, the spatial applicability of the resource, or the jurisdiction under which the resource is relevant.'),
(15, NULL, 1, 'rights', 'Rights', 'Information about rights held in and over the resource.'),
(16, NULL, 1, 'audience', 'Audience', 'A class of entity for whom the resource is intended or useful.'),
(17, NULL, 1, 'alternative', 'Alternative Title', 'An alternative name for the resource.'),
(18, NULL, 1, 'tableOfContents', 'Table Of Contents', 'A list of subunits of the resource.'),
(19, NULL, 1, 'abstract', 'Abstract', 'A summary of the resource.'),
(20, NULL, 1, 'created', 'Date Created', 'Date of creation of the resource.'),
(21, NULL, 1, 'valid', 'Date Valid', 'Date (often a range) of validity of a resource.'),
(22, NULL, 1, 'available', 'Date Available', 'Date (often a range) that the resource became or will become available.'),
(23, NULL, 1, 'issued', 'Date Issued', 'Date of formal issuance (e.g., publication) of the resource.'),
(24, NULL, 1, 'modified', 'Date Modified', 'Date on which the resource was changed.'),
(25, NULL, 1, 'extent', 'Extent', 'The size or duration of the resource.'),
(26, NULL, 1, 'medium', 'Medium', 'The material or physical carrier of the resource.'),
(27, NULL, 1, 'isVersionOf', 'Is Version Of', 'A related resource of which the described resource is a version, edition, or adaptation.'),
(28, NULL, 1, 'hasVersion', 'Has Version', 'A related resource that is a version, edition, or adaptation of the described resource.'),
(29, NULL, 1, 'isReplacedBy', 'Is Replaced By', 'A related resource that supplants, displaces, or supersedes the described resource.'),
(30, NULL, 1, 'replaces', 'Replaces', 'A related resource that is supplanted, displaced, or superseded by the described resource.'),
(31, NULL, 1, 'isRequiredBy', 'Is Required By', 'A related resource that requires the described resource to support its function, delivery, or coherence.'),
(32, NULL, 1, 'requires', 'Requires', 'A related resource that is required by the described resource to support its function, delivery, or coherence.'),
(33, NULL, 1, 'isPartOf', 'Is Part Of', 'A related resource in which the described resource is physically or logically included.'),
(34, NULL, 1, 'hasPart', 'Has Part', 'A related resource that is included either physically or logically in the described resource.'),
(35, NULL, 1, 'isReferencedBy', 'Is Referenced By', 'A related resource that references, cites, or otherwise points to the described resource.'),
(36, NULL, 1, 'references', 'References', 'A related resource that is referenced, cited, or otherwise pointed to by the described resource.'),
(37, NULL, 1, 'isFormatOf', 'Is Format Of', 'A related resource that is substantially the same as the described resource, but in another format.'),
(38, NULL, 1, 'hasFormat', 'Has Format', 'A related resource that is substantially the same as the pre-existing described resource, but in another format.'),
(39, NULL, 1, 'conformsTo', 'Conforms To', 'An established standard to which the described resource conforms.'),
(40, NULL, 1, 'spatial', 'Spatial Coverage', 'Spatial characteristics of the resource.'),
(41, NULL, 1, 'temporal', 'Temporal Coverage', 'Temporal characteristics of the resource.'),
(42, NULL, 1, 'mediator', 'Mediator', 'An entity that mediates access to the resource and for whom the resource is intended or useful.'),
(43, NULL, 1, 'dateAccepted', 'Date Accepted', 'Date of acceptance of the resource.'),
(44, NULL, 1, 'dateCopyrighted', 'Date Copyrighted', 'Date of copyright.'),
(45, NULL, 1, 'dateSubmitted', 'Date Submitted', 'Date of submission of the resource.'),
(46, NULL, 1, 'educationLevel', 'Audience Education Level', 'A class of entity, defined in terms of progression through an educational or training context, for which the described resource is intended.'),
(47, NULL, 1, 'accessRights', 'Access Rights', 'Information about who can access the resource or an indication of its security status.'),
(48, NULL, 1, 'bibliographicCitation', 'Bibliographic Citation', 'A bibliographic reference for the resource.'),
(49, NULL, 1, 'license', 'License', 'A legal document giving official permission to do something with the resource.'),
(50, NULL, 1, 'rightsHolder', 'Rights Holder', 'A person or organization owning or managing rights over the resource.'),
(51, NULL, 1, 'provenance', 'Provenance', 'A statement of any changes in ownership and custody of the resource since its creation that are significant for its authenticity, integrity, and interpretation.'),
(52, NULL, 1, 'instructionalMethod', 'Instructional Method', 'A process, used to engender knowledge, attitudes and skills, that the described resource is designed to support.'),
(53, NULL, 1, 'accrualMethod', 'Accrual Method', 'The method by which items are added to a collection.'),
(54, NULL, 1, 'accrualPeriodicity', 'Accrual Periodicity', 'The frequency with which items are added to a collection.'),
(55, NULL, 1, 'accrualPolicy', 'Accrual Policy', 'The policy governing the addition of items to a collection.'),
(56, NULL, 3, 'affirmedBy', 'affirmedBy', 'A legal decision that affirms a ruling.'),
(57, NULL, 3, 'annotates', 'annotates', 'Critical or explanatory note for a Document.'),
(58, NULL, 3, 'authorList', 'list of authors', 'An ordered list of authors. Normally, this list is seen as a priority list that order authors by importance.'),
(59, NULL, 3, 'citedBy', 'cited by', 'Relates a document to another document that cites the\nfirst document.'),
(60, NULL, 3, 'cites', 'cites', 'Relates a document to another document that is cited\nby the first document as reference, comment, review, quotation or for\nanother purpose.'),
(61, NULL, 3, 'contributorList', 'list of contributors', 'An ordered list of contributors. Normally, this list is seen as a priority list that order contributors by importance.'),
(62, NULL, 3, 'court', 'court', 'A court associated with a legal document; for example, that which issues a decision.'),
(63, NULL, 3, 'degree', 'degree', 'The thesis degree.'),
(64, NULL, 3, 'director', 'director', 'A Film director.'),
(65, NULL, 3, 'distributor', 'distributor', 'Distributor of a document or a collection of documents.'),
(66, NULL, 3, 'editor', 'editor', 'A person having managerial and sometimes policy-making responsibility for the editorial part of a publishing firm or of a newspaper, magazine, or other publication.'),
(67, NULL, 3, 'editorList', 'list of editors', 'An ordered list of editors. Normally, this list is seen as a priority list that order editors by importance.'),
(68, NULL, 3, 'interviewee', 'interviewee', 'An agent that is interviewed by another agent.'),
(69, NULL, 3, 'interviewer', 'interviewer', 'An agent that interview another agent.'),
(70, NULL, 3, 'issuer', 'issuer', 'An entity responsible for issuing often informally published documents such as press releases, reports, etc.'),
(71, NULL, 3, 'organizer', 'organizer', 'The organizer of an event; includes conference organizers, but also government agencies or other bodies that are responsible for conducting hearings.'),
(72, NULL, 3, 'owner', 'owner', 'Owner of a document or a collection of documents.'),
(73, NULL, 3, 'performer', 'performer', NULL),
(74, NULL, 3, 'presentedAt', 'presented at', 'Relates a document to an event; for example, a paper to a conference.'),
(75, NULL, 3, 'presents', 'presents', 'Relates an event to associated documents; for example, conference to a paper.'),
(76, NULL, 3, 'producer', 'producer', 'Producer of a document or a collection of documents.'),
(77, NULL, 3, 'recipient', 'recipient', 'An agent that receives a communication document.'),
(78, NULL, 3, 'reproducedIn', 'reproducedIn', 'The resource in which another resource is reproduced.'),
(79, NULL, 3, 'reversedBy', 'reversedBy', 'A legal decision that reverses a ruling.'),
(80, NULL, 3, 'reviewOf', 'review of', 'Relates a review document to a reviewed thing (resource, item, etc.).'),
(81, NULL, 3, 'status', 'status', 'The publication status of (typically academic) content.'),
(82, NULL, 3, 'subsequentLegalDecision', 'subsequentLegalDecision', 'A legal decision on appeal that takes action on a case (affirming it, reversing it, etc.).'),
(83, NULL, 3, 'transcriptOf', 'transcript of', 'Relates a document to some transcribed original.'),
(84, NULL, 3, 'translationOf', 'translation of', 'Relates a translated document to the original document.'),
(85, NULL, 3, 'translator', 'translator', 'A person who translates written document from one language to another.'),
(86, NULL, 3, 'abstract', 'abstract', 'A summary of the resource.'),
(87, NULL, 3, 'argued', 'date argued', 'The date on which a legal case is argued before a court. Date is of format xsd:date'),
(88, NULL, 3, 'asin', 'asin', NULL),
(89, NULL, 3, 'chapter', 'chapter', 'An chapter number'),
(90, NULL, 3, 'coden', 'coden', NULL),
(91, NULL, 3, 'content', 'content', 'This property is for a plain-text rendering of the content of a Document. While the plain-text content of an entire document could be described by this property.'),
(92, NULL, 3, 'doi', 'doi', NULL),
(93, NULL, 3, 'eanucc13', 'eanucc13', NULL),
(94, NULL, 3, 'edition', 'edition', 'The name defining a special edition of a document. Normally its a literal value composed of a version number and words.'),
(95, NULL, 3, 'eissn', 'eissn', NULL),
(96, NULL, 3, 'gtin14', 'gtin14', NULL),
(97, NULL, 3, 'handle', 'handle', NULL),
(98, NULL, 3, 'identifier', 'identifier', NULL),
(99, NULL, 3, 'isbn', 'isbn', NULL),
(100, NULL, 3, 'isbn10', 'isbn10', NULL),
(101, NULL, 3, 'isbn13', 'isbn13', NULL),
(102, NULL, 3, 'issn', 'issn', NULL),
(103, NULL, 3, 'issue', 'issue', 'An issue number'),
(104, NULL, 3, 'lccn', 'lccn', NULL),
(105, NULL, 3, 'locator', 'locator', 'A description (often numeric) that locates an item within a containing document or collection.'),
(106, NULL, 3, 'numPages', 'number of pages', 'The number of pages contained in a document'),
(107, NULL, 3, 'numVolumes', 'number of volumes', 'The number of volumes contained in a collection of documents (usually a series, periodical, etc.).'),
(108, NULL, 3, 'number', 'number', 'A generic item or document number. Not to be confused with issue number.'),
(109, NULL, 3, 'oclcnum', 'oclcnum', NULL),
(110, NULL, 3, 'pageEnd', 'page end', 'Ending page number within a continuous page range.'),
(111, NULL, 3, 'pageStart', 'page start', 'Starting page number within a continuous page range.'),
(112, NULL, 3, 'pages', 'pages', 'A string of non-contiguous page spans that locate a Document within a Collection. Example: 23-25, 34, 54-56. For continuous page ranges, use the pageStart and pageEnd properties.'),
(113, NULL, 3, 'pmid', 'pmid', NULL),
(114, NULL, 3, 'prefixName', 'prefix name', 'The prefix of a name'),
(115, NULL, 3, 'section', 'section', 'A section number'),
(116, NULL, 3, 'shortDescription', 'shortDescription', NULL),
(117, NULL, 3, 'shortTitle', 'short title', 'The abbreviation of a title.'),
(118, NULL, 3, 'sici', 'sici', NULL),
(119, NULL, 3, 'suffixName', 'suffix name', 'The suffix of a name'),
(120, NULL, 3, 'upc', 'upc', NULL),
(121, NULL, 3, 'uri', 'uri', 'Universal Resource Identifier of a document'),
(122, NULL, 3, 'volume', 'volume', 'A volume number'),
(123, NULL, 4, 'mbox', 'personal mailbox', 'A  personal mailbox, ie. an Internet mailbox associated with exactly one owner, the first owner of this mailbox. This is a \'static inverse functional property\', in that  there is (across time and change) at most one individual that ever has any particular value for foaf:mbox.'),
(124, NULL, 4, 'mbox_sha1sum', 'sha1sum of a personal mailbox URI name', 'The sha1sum of the URI of an Internet mailbox associated with exactly one owner, the  first owner of the mailbox.'),
(125, NULL, 4, 'gender', 'gender', 'The gender of this Agent (typically but not necessarily \'male\' or \'female\').'),
(126, NULL, 4, 'geekcode', 'geekcode', 'A textual geekcode for this person, see http://www.geekcode.com/geek.html'),
(127, NULL, 4, 'dnaChecksum', 'DNA checksum', 'A checksum for the DNA of some thing. Joke.'),
(128, NULL, 4, 'sha1', 'sha1sum (hex)', 'A sha1sum hash, in hex.'),
(129, NULL, 4, 'based_near', 'based near', 'A location that something is based near, for some broadly human notion of near.'),
(130, NULL, 4, 'title', 'title', 'Title (Mr, Mrs, Ms, Dr. etc)'),
(131, NULL, 4, 'nick', 'nickname', 'A short informal nickname characterising an agent (includes login identifiers, IRC and other chat nicknames).'),
(132, NULL, 4, 'jabberID', 'jabber ID', 'A jabber ID for something.'),
(133, NULL, 4, 'aimChatID', 'AIM chat ID', 'An AIM chat ID'),
(134, NULL, 4, 'skypeID', 'Skype ID', 'A Skype ID'),
(135, NULL, 4, 'icqChatID', 'ICQ chat ID', 'An ICQ chat ID'),
(136, NULL, 4, 'yahooChatID', 'Yahoo chat ID', 'A Yahoo chat ID'),
(137, NULL, 4, 'msnChatID', 'MSN chat ID', 'An MSN chat ID'),
(138, NULL, 4, 'name', 'name', 'A name for some thing.'),
(139, NULL, 4, 'firstName', 'firstName', 'The first name of a person.'),
(140, NULL, 4, 'lastName', 'lastName', 'The last name of a person.'),
(141, NULL, 4, 'givenName', 'Given name', 'The given name of some person.'),
(142, NULL, 4, 'givenname', 'Given name', 'The given name of some person.'),
(143, NULL, 4, 'surname', 'Surname', 'The surname of some person.'),
(144, NULL, 4, 'family_name', 'family_name', 'The family name of some person.'),
(145, NULL, 4, 'familyName', 'familyName', 'The family name of some person.'),
(146, NULL, 4, 'phone', 'phone', 'A phone,  specified using fully qualified tel: URI scheme (refs: http://www.w3.org/Addressing/schemes.html#tel).'),
(147, NULL, 4, 'homepage', 'homepage', 'A homepage for some thing.'),
(148, NULL, 4, 'weblog', 'weblog', 'A weblog of some thing (whether person, group, company etc.).'),
(149, NULL, 4, 'openid', 'openid', 'An OpenID for an Agent.'),
(150, NULL, 4, 'tipjar', 'tipjar', 'A tipjar document for this agent, describing means for payment and reward.'),
(151, NULL, 4, 'plan', 'plan', 'A .plan comment, in the tradition of finger and \'.plan\' files.'),
(152, NULL, 4, 'made', 'made', 'Something that was made by this agent.'),
(153, NULL, 4, 'maker', 'maker', 'An agent that  made this thing.'),
(154, NULL, 4, 'img', 'image', 'An image that can be used to represent some thing (ie. those depictions which are particularly representative of something, eg. one\'s photo on a homepage).'),
(155, NULL, 4, 'depiction', 'depiction', 'A depiction of some thing.'),
(156, NULL, 4, 'depicts', 'depicts', 'A thing depicted in this representation.'),
(157, NULL, 4, 'thumbnail', 'thumbnail', 'A derived thumbnail image.'),
(158, NULL, 4, 'myersBriggs', 'myersBriggs', 'A Myers Briggs (MBTI) personality classification.'),
(159, NULL, 4, 'workplaceHomepage', 'workplace homepage', 'A workplace homepage of some person; the homepage of an organization they work for.'),
(160, NULL, 4, 'workInfoHomepage', 'work info homepage', 'A work info homepage of some person; a page about their work for some organization.'),
(161, NULL, 4, 'schoolHomepage', 'schoolHomepage', 'A homepage of a school attended by the person.'),
(162, NULL, 4, 'knows', 'knows', 'A person known by this person (indicating some level of reciprocated interaction between the parties).'),
(163, NULL, 4, 'interest', 'interest', 'A page about a topic of interest to this person.'),
(164, NULL, 4, 'topic_interest', 'topic_interest', 'A thing of interest to this person.'),
(165, NULL, 4, 'publications', 'publications', 'A link to the publications of this person.'),
(166, NULL, 4, 'currentProject', 'current project', 'A current project this person works on.'),
(167, NULL, 4, 'pastProject', 'past project', 'A project this person has previously worked on.'),
(168, NULL, 4, 'fundedBy', 'funded by', 'An organization funding a project or person.'),
(169, NULL, 4, 'logo', 'logo', 'A logo representing some thing.'),
(170, NULL, 4, 'topic', 'topic', 'A topic of some page or document.'),
(171, NULL, 4, 'primaryTopic', 'primary topic', 'The primary topic of some page or document.'),
(172, NULL, 4, 'focus', 'focus', 'The underlying or \'focal\' entity associated with some SKOS-described concept.'),
(173, NULL, 4, 'isPrimaryTopicOf', 'is primary topic of', 'A document that this thing is the primary topic of.'),
(174, NULL, 4, 'page', 'page', 'A page or document about this thing.'),
(175, NULL, 4, 'theme', 'theme', 'A theme.'),
(176, NULL, 4, 'account', 'account', 'Indicates an account held by this agent.'),
(177, NULL, 4, 'holdsAccount', 'account', 'Indicates an account held by this agent.'),
(178, NULL, 4, 'accountServiceHomepage', 'account service homepage', 'Indicates a homepage of the service provide for this online account.'),
(179, NULL, 4, 'accountName', 'account name', 'Indicates the name (identifier) associated with this online account.'),
(180, NULL, 4, 'member', 'member', 'Indicates a member of a Group'),
(181, NULL, 4, 'membershipClass', 'membershipClass', 'Indicates the class of individuals that are a member of a Group'),
(182, NULL, 4, 'birthday', 'birthday', 'The birthday of this Agent, represented in mm-dd string form, eg. \'12-31\'.'),
(183, NULL, 4, 'age', 'age', 'The age in years of some agent.'),
(184, NULL, 4, 'status', 'status', 'A string expressing what the user is happy for the general public (normally) to know about their current activity.'),
(185, 1, 5, 'extracted_text', 'extracted text', 'Text extracted from a resource.'),
(1638, 1, 7, 'attributionName', 'attributionName', NULL),
(1639, 1, 7, 'attributionURL', 'attributionURL', NULL),
(1640, 1, 7, 'deprecatedOn', 'deprecated on', NULL),
(1641, 1, 7, 'jurisdiction', 'jurisdiction', NULL),
(1642, 1, 7, 'legalcode', 'legalcode', NULL),
(1643, 1, 7, 'license', 'has license', NULL),
(1644, 1, 7, 'morePermissions', 'morePermissions', NULL),
(1645, 1, 7, 'permits', 'permits', NULL),
(1646, 1, 7, 'prohibits', 'prohibits', NULL),
(1647, 1, 7, 'requires', 'requires', NULL),
(1648, 1, 7, 'useGuidelines', 'useGuidelines', NULL),
(2129, 1, 10, 'access', 'Access', 'Define an access to the resource.'),
(2130, 1, 10, 'featured', 'Featured', 'Mark the resource as a featured one as soon as a value is set, whatever it is.'),
(2131, 1, 10, 'new', 'New', 'Mark the resource as a new one as soon as a value is set, whatever it is.'),
(2132, 1, 10, 'reserved', 'Reserved', 'Define the resource as a restricted access one as soon a value is set, whatever it is.'),
(2133, 1, 10, 'selected', 'Selected', 'Mark the resource as a selected one as soon as a value is set, whatever it is.'),
(2134, 1, 10, 'category', 'Category', 'A topic that can be used for some purposes.'),
(2135, 1, 10, 'collection', 'Collection', 'A way to group resources.'),
(2136, 1, 10, 'set', 'Set', 'A set to group resources together.'),
(2137, 1, 10, 'subject', 'Subject', 'A subject to describe the resource.'),
(2138, 1, 10, 'tag', 'Tag', 'Tag that can be used for some purposes or for upgrade from Omeka Classic.'),
(2139, 1, 10, 'theme', 'Theme', 'A domain that can be used for some purposes.'),
(2140, 1, 10, 'type', 'Type', 'A type that can be used for some purposes.'),
(2141, 1, 10, 'coordinates', 'Coordinates', 'Numerical coordinates related to the resource, generaly the geographic position.'),
(2142, 1, 10, 'data', 'Data', 'Any data that can be used for any purpose.'),
(2143, 1, 10, 'start', 'Start', 'A start related to the resource, for example the start of an embargo.'),
(2144, 1, 10, 'end', 'End', 'A end related to the resource, for example the end of an embargo.'),
(2145, 1, 10, 'location', 'Location', 'A location related to the resource, for example the place of publication.'),
(2146, 1, 10, 'note', 'Note', 'A specific or generic information on a resource, generally for internal purposes.'),
(2147, 1, 10, 'number', 'Number', 'A number related to the resource.'),
(2148, 1, 10, 'rank', 'Rank', 'A rank or a position related to the resource.'),
(2149, 1, 10, 'status', 'Status', 'The status of the resource, generally for internal purposes.');

-- --------------------------------------------------------

--
-- Table structure for table `resource`
--

CREATE TABLE `resource` (
  `id` int NOT NULL,
  `owner_id` int DEFAULT NULL,
  `resource_class_id` int DEFAULT NULL,
  `resource_template_id` int DEFAULT NULL,
  `thumbnail_id` int DEFAULT NULL,
  `title` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `is_public` tinyint(1) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  `resource_type` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `resource`
--

INSERT INTO `resource` (`id`, `owner_id`, `resource_class_id`, `resource_template_id`, `thumbnail_id`, `title`, `is_public`, `created`, `modified`, `resource_type`) VALUES
(1, 1, 40, NULL, NULL, 'First item', 1, '2023-02-15 16:05:58', '2023-02-28 14:46:08', 'Omeka\\Entity\\Item'),
(2, 1, NULL, NULL, NULL, 'CC-Licenses Collection', 1, '2023-11-30 18:54:06', '2023-11-30 18:54:06', 'Omeka\\Entity\\ItemSet'),
(3, 1, 1000, 2, NULL, 'Creative Common license - CC-BY-NC', 1, '2023-11-30 18:57:24', '2023-11-30 19:00:07', 'Omeka\\Entity\\Item'),
(4, 1, 1000, 2, NULL, 'Creative Common license - CC-BY', 1, '2023-11-30 18:58:55', '2023-11-30 18:59:56', 'Omeka\\Entity\\Item');

-- --------------------------------------------------------

--
-- Table structure for table `resource_class`
--

CREATE TABLE `resource_class` (
  `id` int NOT NULL,
  `owner_id` int DEFAULT NULL,
  `vocabulary_id` int NOT NULL,
  `local_name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `resource_class`
--

INSERT INTO `resource_class` (`id`, `owner_id`, `vocabulary_id`, `local_name`, `label`, `comment`) VALUES
(1, NULL, 1, 'Agent', 'Agent', 'A resource that acts or has the power to act.'),
(2, NULL, 1, 'AgentClass', 'Agent Class', 'A group of agents.'),
(3, NULL, 1, 'BibliographicResource', 'Bibliographic Resource', 'A book, article, or other documentary resource.'),
(4, NULL, 1, 'FileFormat', 'File Format', 'A digital resource format.'),
(5, NULL, 1, 'Frequency', 'Frequency', 'A rate at which something recurs.'),
(6, NULL, 1, 'Jurisdiction', 'Jurisdiction', 'The extent or range of judicial, law enforcement, or other authority.'),
(7, NULL, 1, 'LicenseDocument', 'License Document', 'A legal document giving official permission to do something with a Resource.'),
(8, NULL, 1, 'LinguisticSystem', 'Linguistic System', 'A system of signs, symbols, sounds, gestures, or rules used in communication.'),
(9, NULL, 1, 'Location', 'Location', 'A spatial region or named place.'),
(10, NULL, 1, 'LocationPeriodOrJurisdiction', 'Location, Period, or Jurisdiction', 'A location, period of time, or jurisdiction.'),
(11, NULL, 1, 'MediaType', 'Media Type', 'A file format or physical medium.'),
(12, NULL, 1, 'MediaTypeOrExtent', 'Media Type or Extent', 'A media type or extent.'),
(13, NULL, 1, 'MethodOfInstruction', 'Method of Instruction', 'A process that is used to engender knowledge, attitudes, and skills.'),
(14, NULL, 1, 'MethodOfAccrual', 'Method of Accrual', 'A method by which resources are added to a collection.'),
(15, NULL, 1, 'PeriodOfTime', 'Period of Time', 'An interval of time that is named or defined by its start and end dates.'),
(16, NULL, 1, 'PhysicalMedium', 'Physical Medium', 'A physical material or carrier.'),
(17, NULL, 1, 'PhysicalResource', 'Physical Resource', 'A material thing.'),
(18, NULL, 1, 'Policy', 'Policy', 'A plan or course of action by an authority, intended to influence and determine decisions, actions, and other matters.'),
(19, NULL, 1, 'ProvenanceStatement', 'Provenance Statement', 'A statement of any changes in ownership and custody of a resource since its creation that are significant for its authenticity, integrity, and interpretation.'),
(20, NULL, 1, 'RightsStatement', 'Rights Statement', 'A statement about the intellectual property rights (IPR) held in or over a Resource, a legal document giving official permission to do something with a resource, or a statement about access rights.'),
(21, NULL, 1, 'SizeOrDuration', 'Size or Duration', 'A dimension or extent, or a time taken to play or execute.'),
(22, NULL, 1, 'Standard', 'Standard', 'A basis for comparison; a reference point against which other things can be evaluated.'),
(23, NULL, 2, 'Collection', 'Collection', 'An aggregation of resources.'),
(24, NULL, 2, 'Dataset', 'Dataset', 'Data encoded in a defined structure.'),
(25, NULL, 2, 'Event', 'Event', 'A non-persistent, time-based occurrence.'),
(26, NULL, 2, 'Image', 'Image', 'A visual representation other than text.'),
(27, NULL, 2, 'InteractiveResource', 'Interactive Resource', 'A resource requiring interaction from the user to be understood, executed, or experienced.'),
(28, NULL, 2, 'Service', 'Service', 'A system that provides one or more functions.'),
(29, NULL, 2, 'Software', 'Software', 'A computer program in source or compiled form.'),
(30, NULL, 2, 'Sound', 'Sound', 'A resource primarily intended to be heard.'),
(31, NULL, 2, 'Text', 'Text', 'A resource consisting primarily of words for reading.'),
(32, NULL, 2, 'PhysicalObject', 'Physical Object', 'An inanimate, three-dimensional object or substance.'),
(33, NULL, 2, 'StillImage', 'Still Image', 'A static visual representation.'),
(34, NULL, 2, 'MovingImage', 'Moving Image', 'A series of visual representations imparting an impression of motion when shown in succession.'),
(35, NULL, 3, 'AcademicArticle', 'Academic Article', 'A scholarly academic article, typically published in a journal.'),
(36, NULL, 3, 'Article', 'Article', 'A written composition in prose, usually nonfiction, on a specific topic, forming an independent part of a book or other publication, as a newspaper or magazine.'),
(37, NULL, 3, 'AudioDocument', 'audio document', 'An audio document; aka record.'),
(38, NULL, 3, 'AudioVisualDocument', 'audio-visual document', 'An audio-visual document; film, video, and so forth.'),
(39, NULL, 3, 'Bill', 'Bill', 'Draft legislation presented for discussion to a legal body.'),
(40, NULL, 3, 'Book', 'Book', 'A written or printed work of fiction or nonfiction, usually on sheets of paper fastened or bound together within covers.'),
(41, NULL, 3, 'BookSection', 'Book Section', 'A section of a book.'),
(42, NULL, 3, 'Brief', 'Brief', 'A written argument submitted to a court.'),
(43, NULL, 3, 'Chapter', 'Chapter', 'A chapter of a book.'),
(44, NULL, 3, 'Code', 'Code', 'A collection of statutes.'),
(45, NULL, 3, 'CollectedDocument', 'Collected Document', 'A document that simultaneously contains other documents.'),
(46, NULL, 3, 'Collection', 'Collection', 'A collection of Documents or Collections'),
(47, NULL, 3, 'Conference', 'Conference', 'A meeting for consultation or discussion.'),
(48, NULL, 3, 'CourtReporter', 'Court Reporter', 'A collection of legal cases.'),
(49, NULL, 3, 'Document', 'Document', 'A document (noun) is a bounded physical representation of body of information designed with the capacity (and usually intent) to communicate. A document may manifest symbolic, diagrammatic or sensory-representational information.'),
(50, NULL, 3, 'DocumentPart', 'document part', 'a distinct part of a larger document or collected document.'),
(51, NULL, 3, 'DocumentStatus', 'Document Status', 'The status of the publication of a document.'),
(52, NULL, 3, 'EditedBook', 'Edited Book', 'An edited book.'),
(53, NULL, 3, 'Email', 'EMail', 'A written communication addressed to a person or organization and transmitted electronically.'),
(54, NULL, 3, 'Event', 'Event', NULL),
(55, NULL, 3, 'Excerpt', 'Excerpt', 'A passage selected from a larger work.'),
(56, NULL, 3, 'Film', 'Film', 'aka movie.'),
(57, NULL, 3, 'Hearing', 'Hearing', 'An instance or a session in which testimony and arguments are presented, esp. before an official, as a judge in a lawsuit.'),
(58, NULL, 3, 'Image', 'Image', 'A document that presents visual or diagrammatic information.'),
(59, NULL, 3, 'Interview', 'Interview', 'A formalized discussion between two or more people.'),
(60, NULL, 3, 'Issue', 'Issue', 'something that is printed or published and distributed, esp. a given number of a periodical'),
(61, NULL, 3, 'Journal', 'Journal', 'A periodical of scholarly journal Articles.'),
(62, NULL, 3, 'LegalCaseDocument', 'Legal Case Document', 'A document accompanying a legal case.'),
(63, NULL, 3, 'LegalDecision', 'Decision', 'A document containing an authoritative determination (as a decree or judgment) made after consideration of facts or law.'),
(64, NULL, 3, 'LegalDocument', 'Legal Document', 'A legal document; for example, a court decision, a brief, and so forth.'),
(65, NULL, 3, 'Legislation', 'Legislation', 'A legal document proposing or enacting a law or a group of laws.'),
(66, NULL, 3, 'Letter', 'Letter', 'A written or printed communication addressed to a person or organization and usually transmitted by mail.'),
(67, NULL, 3, 'Magazine', 'Magazine', 'A periodical of magazine Articles. A magazine is a publication that is issued periodically, usually bound in a paper cover, and typically contains essays, stories, poems, etc., by many writers, and often photographs and drawings, frequently specializing in a particular subject or area, as hobbies, news, or sports.'),
(68, NULL, 3, 'Manual', 'Manual', 'A small reference book, especially one giving instructions.'),
(69, NULL, 3, 'Manuscript', 'Manuscript', 'An unpublished Document, which may also be submitted to a publisher for publication.'),
(70, NULL, 3, 'Map', 'Map', 'A graphical depiction of geographic features.'),
(71, NULL, 3, 'MultiVolumeBook', 'Multivolume Book', 'A loose, thematic, collection of Documents, often Books.'),
(72, NULL, 3, 'Newspaper', 'Newspaper', 'A periodical of documents, usually issued daily or weekly, containing current news, editorials, feature articles, and usually advertising.'),
(73, NULL, 3, 'Note', 'Note', 'Notes or annotations about a resource.'),
(74, NULL, 3, 'Patent', 'Patent', 'A document describing the exclusive right granted by a government to an inventor to manufacture, use, or sell an invention for a certain number of years.'),
(75, NULL, 3, 'Performance', 'Performance', 'A public performance.'),
(76, NULL, 3, 'Periodical', 'Periodical', 'A group of related documents issued at regular intervals.'),
(77, NULL, 3, 'PersonalCommunication', 'Personal Communication', 'A communication between an agent and one or more specific recipients.'),
(78, NULL, 3, 'PersonalCommunicationDocument', 'Personal Communication Document', 'A personal communication manifested in some document.'),
(79, NULL, 3, 'Proceedings', 'Proceedings', 'A compilation of documents published from an event, such as a conference.'),
(80, NULL, 3, 'Quote', 'Quote', 'An excerpted collection of words.'),
(81, NULL, 3, 'ReferenceSource', 'Reference Source', 'A document that presents authoritative reference information, such as a dictionary or encylopedia .'),
(82, NULL, 3, 'Report', 'Report', 'A document describing an account or statement describing in detail an event, situation, or the like, usually as the result of observation, inquiry, etc..'),
(83, NULL, 3, 'Series', 'Series', 'A loose, thematic, collection of Documents, often Books.'),
(84, NULL, 3, 'Slide', 'Slide', 'A slide in a slideshow'),
(85, NULL, 3, 'Slideshow', 'Slideshow', 'A presentation of a series of slides, usually presented in front of an audience with written text and images.'),
(86, NULL, 3, 'Standard', 'Standard', 'A document describing a standard'),
(87, NULL, 3, 'Statute', 'Statute', 'A bill enacted into law.'),
(88, NULL, 3, 'Thesis', 'Thesis', 'A document created to summarize research findings associated with the completion of an academic degree.'),
(89, NULL, 3, 'ThesisDegree', 'Thesis degree', 'The academic degree of a Thesis'),
(90, NULL, 3, 'Webpage', 'Webpage', 'A web page is an online document available (at least initially) on the world wide web. A web page is written first and foremost to appear on the web, as distinct from other online resources such as books, manuscripts or audio documents which use the web primarily as a distribution mechanism alongside other more traditional methods such as print.'),
(91, NULL, 3, 'Website', 'Website', 'A group of Webpages accessible on the Web.'),
(92, NULL, 3, 'Workshop', 'Workshop', 'A seminar, discussion group, or the like, that emphasizes zxchange of ideas and the demonstration and application of techniques, skills, etc.'),
(93, NULL, 4, 'LabelProperty', 'Label Property', 'A foaf:LabelProperty is any RDF property with texual values that serve as labels.'),
(94, NULL, 4, 'Person', 'Person', 'A person.'),
(95, NULL, 4, 'Document', 'Document', 'A document.'),
(96, NULL, 4, 'Organization', 'Organization', 'An organization.'),
(97, NULL, 4, 'Group', 'Group', 'A class of Agents.'),
(98, NULL, 4, 'Agent', 'Agent', 'An agent (eg. person, group, software or physical artifact).'),
(99, NULL, 4, 'Project', 'Project', 'A project (a collective endeavour of some kind).'),
(100, NULL, 4, 'Image', 'Image', 'An image.'),
(101, NULL, 4, 'PersonalProfileDocument', 'PersonalProfileDocument', 'A personal profile RDF document.'),
(102, NULL, 4, 'OnlineAccount', 'Online Account', 'An online account.'),
(103, NULL, 4, 'OnlineGamingAccount', 'Online Gaming Account', 'An online gaming account.'),
(104, NULL, 4, 'OnlineEcommerceAccount', 'Online E-commerce Account', 'An online e-commerce account.'),
(105, NULL, 4, 'OnlineChatAccount', 'Online Chat Account', 'An online chat account.'),
(999, 1, 7, 'Jurisdiction', 'Jurisdiction', 'the legal jurisdiction of a license'),
(1000, 1, 7, 'License', 'License', 'a set of requests/permissions to users of a Work, e.g. a copyright license, the public domain, information for distributors'),
(1001, 1, 7, 'Permission', 'Permission', 'an action that may or may not be allowed or desired'),
(1002, 1, 7, 'Prohibition', 'Prohibition', 'something you may be asked not to do'),
(1003, 1, 7, 'Requirement', 'Requirement', 'an action that may or may not be requested of you'),
(1004, 1, 7, 'Work', 'Work', 'a potentially copyrightable work');

-- --------------------------------------------------------

--
-- Table structure for table `resource_meta_resource_template_meta_names`
--

CREATE TABLE `resource_meta_resource_template_meta_names` (
  `id` int UNSIGNED NOT NULL,
  `resource_template_id` int NOT NULL,
  `resource_template_property_id` int NOT NULL,
  `meta_names` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `resource_template`
--

CREATE TABLE `resource_template` (
  `id` int NOT NULL,
  `owner_id` int DEFAULT NULL,
  `resource_class_id` int DEFAULT NULL,
  `title_property_id` int DEFAULT NULL,
  `description_property_id` int DEFAULT NULL,
  `label` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `resource_template`
--

INSERT INTO `resource_template` (`id`, `owner_id`, `resource_class_id`, `title_property_id`, `description_property_id`, `label`) VALUES
(1, NULL, NULL, NULL, NULL, 'Base Resource'),
(2, 1, 1000, 1, 4, 'CC-License'),
(3, 1, NULL, NULL, NULL, '3-D models'),
(4, 1, NULL, NULL, NULL, 'Audio'),
(5, 1, NULL, NULL, NULL, 'Book'),
(6, 1, NULL, NULL, NULL, 'General Collection'),
(7, 1, NULL, NULL, NULL, 'Journal Collection'),
(8, 1, NULL, NULL, NULL, 'Journal Issue'),
(9, 1, NULL, NULL, NULL, 'Journal Volume'),
(10, 1, NULL, NULL, NULL, 'Letters'),
(11, 1, NULL, NULL, NULL, 'Manuscript'),
(12, 1, NULL, NULL, NULL, 'Plakkaten'),
(13, 1, NULL, NULL, NULL, 'Visual Art Works');

-- --------------------------------------------------------

--
-- Table structure for table `resource_template_property`
--

CREATE TABLE `resource_template_property` (
  `id` int NOT NULL,
  `resource_template_id` int NOT NULL,
  `property_id` int NOT NULL,
  `alternate_label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alternate_comment` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `position` int DEFAULT NULL,
  `data_type` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:json_array)',
  `is_required` tinyint(1) NOT NULL,
  `is_private` tinyint(1) NOT NULL,
  `default_lang` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `resource_template_property`
--

INSERT INTO `resource_template_property` (`id`, `resource_template_id`, `property_id`, `alternate_label`, `alternate_comment`, `position`, `data_type`, `is_required`, `is_private`, `default_lang`) VALUES
(1, 1, 1, NULL, NULL, 1, NULL, 0, 0, NULL),
(2, 1, 15, NULL, NULL, 2, NULL, 0, 0, NULL),
(3, 1, 8, NULL, NULL, 3, NULL, 0, 0, NULL),
(4, 1, 2, NULL, NULL, 4, NULL, 0, 0, NULL),
(5, 1, 7, NULL, NULL, 5, NULL, 0, 0, NULL),
(6, 1, 4, NULL, NULL, 6, NULL, 0, 0, NULL),
(7, 1, 9, NULL, NULL, 7, NULL, 0, 0, NULL),
(8, 1, 12, NULL, NULL, 8, NULL, 0, 0, NULL),
(9, 1, 40, 'Place', NULL, 9, NULL, 0, 0, NULL),
(10, 1, 5, NULL, NULL, 10, NULL, 0, 0, NULL),
(11, 1, 17, NULL, NULL, 11, NULL, 0, 0, NULL),
(12, 1, 6, NULL, NULL, 12, NULL, 0, 0, NULL),
(13, 1, 25, NULL, NULL, 13, NULL, 0, 0, NULL),
(14, 1, 10, NULL, NULL, 14, NULL, 0, 0, NULL),
(15, 1, 13, NULL, NULL, 15, NULL, 0, 0, NULL),
(16, 1, 29, NULL, NULL, 16, NULL, 0, 0, NULL),
(17, 1, 30, NULL, NULL, 17, NULL, 0, 0, NULL),
(18, 1, 50, NULL, NULL, 18, NULL, 0, 0, NULL),
(19, 1, 3, NULL, NULL, 19, NULL, 0, 0, NULL),
(20, 1, 41, NULL, NULL, 20, NULL, 0, 0, NULL),
(21, 2, 48, 'Short Title / Abbreviation', NULL, 1, '[\"literal\"]', 0, 0, NULL),
(22, 2, 1, NULL, NULL, 2, '[\"literal\"]', 0, 0, NULL),
(23, 2, 4, NULL, NULL, 3, '[\"literal\"]', 0, 0, NULL),
(24, 2, 1639, NULL, NULL, 4, '[\"uri\"]', 0, 0, NULL),
(25, 2, 1645, NULL, NULL, 5, NULL, 0, 0, NULL),
(26, 2, 1646, NULL, NULL, 6, NULL, 0, 0, NULL),
(68, 5, 116, 'Physical Description', NULL, 13, NULL, 0, 0, NULL),
(147, 12, 11, 'Vindplaats', NULL, 3, '[\"literal\"]', 0, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `search_config`
--

CREATE TABLE `search_config` (
  `id` int NOT NULL,
  `engine_id` int NOT NULL,
  `name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `form_adapter` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `settings` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:json)',
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `search_config`
--

INSERT INTO `search_config` (`id`, `engine_id`, `name`, `slug`, `form_adapter`, `settings`, `created`, `modified`) VALUES
(1, 2, 'Default', 'find', 'main', '{\"request\":{\"default_results\":\"default\",\"default_query_post\":\"&resource_name_s=items\",\"validate_form\":\"0\"},\"index\":{\"aliases\":{\"full_text\":{\"name\":\"full_text\",\"label\":\"Full text\",\"fields\":[\"bibo:content\",\"extracttext:extracted_text\"]}}},\"q\":{\"label\":\"Search\",\"suggester\":\"1\",\"suggest_fill_input\":\"0\",\"remove_diacritics\":\"0\"},\"form\":{\"button_submit\":\"1\",\"label_submit\":\"Search\",\"button_reset\":\"0\",\"label_reset\":\"Reset fields\",\"attribute_form\":\"0\",\"advanced\":{\"default_number\":0,\"max_number\":10,\"field_joiner\":true,\"field_joiner_not\":true,\"field_operator\":true,\"field_operators\":{\"eq\":\"is exactly\",\"neq\":\"is not exactly\",\"in\":\"contains\",\"nin\":\"does not contain\",\"sw\":\"starts with\",\"nsw\":\"does not start with\",\"ew\":\"ends with\",\"new\":\"does not end with\",\"ex\":\"has any value\",\"nex\":\"has no values\",\"res\":\"is resource with ID\",\"nres\":\"is not resource with ID\",\"lex\":\"is a linked resource\",\"nlex\":\"is not a linked resource\",\"lres\":\"is linked with resource with ID\",\"nlres\":\"is not linked with resource with ID\"},\"fields\":[]},\"filters\":[]},\"results\":{\"label_default\":\"Search\",\"label_results\":\"Search results\",\"label_no_results\":\"No results\",\"by_resource_type\":\"1\",\"breadcrumbs\":\"0\",\"search_filters\":\"header\",\"active_facets\":\"none\",\"total_results\":\"header\",\"search_form_simple\":\"none\",\"search_form_quick\":\"none\",\"paginator\":\"both\",\"per_page\":\"header\",\"sort\":\"header\",\"grid_list\":\"header\",\"grid_list_mode\":\"auto\",\"thumbnail_mode\":\"default\",\"thumbnail_type\":\"medium\",\"allow_html\":\"0\",\"facets\":\"after\",\"pagination_per_page\":\"0\",\"per_page_list\":{\"10\":\"Results by 10\",\"25\":\"Results by 25\",\"50\":\"Results by 50\",\"100\":\"Results by 100\"},\"label_sort\":\"Sort by\",\"sort_list\":{\"dcterms_date_s asc\":{\"name\":\"dcterms_date_s asc\",\"label\":\"Date (asc)\"},\"dcterms_date_s desc\":{\"name\":\"dcterms_date_s desc\",\"label\":\"Date (desc)\"},\"name_s asc\":{\"name\":\"name_s asc\",\"label\":\"Name (asc)\"},\"name_s desc\":{\"name\":\"name_s desc\",\"label\":\"Name (desc)\"}}},\"facet\":{\"label\":\"Facets\",\"label_no_facets\":\"No facets\",\"mode\":\"button\",\"list\":\"all\",\"display_active\":\"1\",\"label_active_facets\":\"Active facets\",\"display_submit\":\"below\",\"label_submit\":\"Apply facets\",\"display_reset\":\"none\",\"label_reset\":\"Reset facets\",\"display_refine\":\"1\",\"label_refine\":\"Refine results\",\"facets\":{\"resource_template_s\":{\"field\":\"resource_template_s\",\"order\":\"total desc\",\"limit\":100,\"label\":\"Resource Type\",\"type\":\"Checkbox\",\"state\":\"collapse\",\"more\":10,\"display_count\":true,\"mode\":\"button\"},\"dcterms_creator_s\":{\"field\":\"dcterms_creator_s\",\"order\":\"total desc\",\"limit\":100,\"label\":\"Creator\",\"type\":\"Checkbox\",\"state\":\"collapse\",\"more\":100,\"display_count\":true,\"mode\":\"button\"}}}}', '2023-02-15 16:01:30', '2023-02-28 14:50:30');

-- --------------------------------------------------------

--
-- Table structure for table `search_engine`
--

CREATE TABLE `search_engine` (
  `id` int NOT NULL,
  `name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `adapter` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `settings` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:json)',
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `search_engine`
--

INSERT INTO `search_engine` (`id`, `name`, `adapter`, `settings`, `created`, `modified`) VALUES
(1, 'Internal (sql)', 'internal', '{\"resource_types\":[\"item_sets\",\"items\"],\"engine_adapter\":{\"default_search_partial_word\":false,\"multifields\":{\"title\":{\"name\":\"title\",\"label\":\"Title\",\"fields\":[\"dcterms:title\",\"dcterms:alternative\",\"bibo:shortTitle\"]},\"author\":{\"name\":\"author\",\"label\":\"Author\",\"fields\":[\"dcterms:creator\",\"dcterms:contributor\",\"bibo:authorList\",\"bibo:contributorList\",\"bibo:director\",\"bibo:editor\",\"bibo:editorList\",\"bibo:interviewee\",\"bibo:interviewer\",\"bibo:organizer\",\"bibo:performer\",\"bibo:producer\",\"bibo:recipient\",\"bibo:translator\"]},\"creator\":{\"name\":\"creator\",\"label\":\"Creator\",\"fields\":[\"dcterms:creator\"]},\"contributor\":{\"name\":\"contributor\",\"label\":\"Contributor\",\"fields\":[\"dcterms:contributor\",\"bibo:authorList\",\"bibo:contributorList\",\"bibo:director\",\"bibo:editor\",\"bibo:editorList\",\"bibo:interviewee\",\"bibo:interviewer\",\"bibo:organizer\",\"bibo:performer\",\"bibo:producer\",\"bibo:recipient\",\"bibo:translator\"]},\"subject\":{\"name\":\"subject\",\"label\":\"Subject\",\"fields\":[\"dcterms:subject\"]},\"description\":{\"name\":\"description\",\"label\":\"Description\",\"fields\":[\"dcterms:description\",\"dcterms:abstract\",\"dcterms:tableOfContents\",\"bibo:abstract\",\"bibo:shortDescription\"]},\"publisher\":{\"name\":\"publisher\",\"label\":\"Publisher\",\"fields\":[\"dcterms:publisher\",\"bibo:distributor\",\"bibo:issuer\"]},\"date\":{\"name\":\"date\",\"label\":\"Date\",\"fields\":[\"dcterms:date\",\"dcterms:available\",\"dcterms:created\",\"dcterms:issued\",\"dcterms:modified\",\"dcterms:valid\",\"dcterms:dateAccepted\",\"dcterms:dateCopyrighted\",\"dcterms:dateSubmitted\",\"bibo:argued\"]},\"type\":{\"name\":\"type\",\"label\":\"Type\",\"fields\":[\"dcterms:type\"]},\"format\":{\"name\":\"format\",\"label\":\"Format\",\"fields\":[\"dcterms:format\",\"dcterms:extent\",\"dcterms:medium\"]},\"identifier\":{\"name\":\"identifier\",\"label\":\"Identifier\",\"fields\":[\"dcterms:identifier\",\"dcterms:bibliographicCitation\",\"bibo:asin\",\"bibo:coden\",\"bibo:doi\",\"bibo:eanucc13\",\"bibo:eissn\",\"bibo:gtin14\",\"bibo:handle\",\"bibo:identifier\",\"bibo:isbn\",\"bibo:isbn10\",\"bibo:isbn13\",\"bibo:issn\",\"bibo:oclcnum\",\"bibo:pmid\",\"bibo:sici\",\"bibo:upc\",\"bibo:uri\"]},\"source\":{\"name\":\"source\",\"label\":\"Source\",\"fields\":[\"dcterms:source\"]},\"provenance\":{\"name\":\"provenance\",\"label\":\"Provenance\",\"fields\":[\"dcterms:provenance\"]},\"language\":{\"name\":\"language\",\"label\":\"Language\",\"fields\":[\"dcterms:language\"]},\"relation\":{\"name\":\"relation\",\"label\":\"Relation\",\"fields\":[\"dcterms:relation\",\"dcterms:isVersionOf\",\"dcterms:hasVersion\",\"dcterms:isReplacedBy\",\"dcterms:replaces\",\"dcterms:isRequiredBy\",\"dcterms:requires\",\"dcterms:isPartOf\",\"dcterms:hasPart\",\"dcterms:isReferencedBy\",\"dcterms:references\",\"dcterms:isFormatOf\",\"dcterms:hasFormat\",\"dcterms:conformsTo\",\"bibo:annotates\",\"bibo:citedBy\",\"bibo:cites\",\"bibo:reproducedIn\",\"bibo:reviewOf\",\"bibo:transcriptOf\",\"bibo:translationOf\"]},\"coverage\":{\"name\":\"coverage\",\"label\":\"Coverage\",\"fields\":[\"dcterms:coverage\",\"dcterms:spatial\",\"dcterms:temporal\"]},\"rights\":{\"name\":\"rights\",\"label\":\"Rights\",\"fields\":[\"dcterms:rights\",\"dcterms:accessRights\",\"dcterms:license\"]},\"audience\":{\"name\":\"audience\",\"label\":\"Audience\",\"fields\":[\"dcterms:audience\",\"dcterms:mediator\",\"dcterms:educationLevel\"]},\"rightsHolder\":{\"name\":\"rightsHolder\",\"label\":\"Rights holder\",\"fields\":[\"dcterms:rightsHolder\",\"bibo:owner\"]},\"accrualAndInstructional\":{\"name\":\"accrualAndInstructional\",\"label\":\"Accrual and instructional metadata\",\"fields\":[\"dcterms:accrualMethod\",\"dcterms:accrualPeriodicity\",\"dcterms:accrualPolicy\",\"dcterms:instructionalMethod\"]},\"bibliographicData\":{\"name\":\"bibliographicData\",\"label\":\"Bibliographic data\",\"fields\":[\"bibo:chapter\",\"bibo:edition\",\"bibo:issue\",\"bibo:locator\",\"bibo:numPages\",\"bibo:numVolumes\",\"bibo:number\",\"bibo:pageEnd\",\"bibo:pageStart\",\"bibo:pages\",\"bibo:section\",\"bibo:volume\"]}}}}', '2023-02-15 16:01:30', NULL),
(2, 'Solr', 'solarium', '{\"resource_types\":[\"items\"],\"engine_adapter\":{\"solr_core_id\":\"1\",\"index_name\":\"\"}}', '2023-02-28 14:42:10', '2023-02-28 14:42:12');

-- --------------------------------------------------------

--
-- Table structure for table `search_suggester`
--

CREATE TABLE `search_suggester` (
  `id` int NOT NULL,
  `engine_id` int NOT NULL,
  `name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `settings` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:json)',
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modified` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `search_suggester`
--

INSERT INTO `search_suggester` (`id`, `engine_id`, `name`, `settings`, `created`, `modified`) VALUES
(1, 1, 'Main index', '{\"direct\":false,\"mode_index\":\"start\",\"mode_search\":\"start\",\"limit\":25,\"length\":50,\"fields\":[],\"excluded_fields\":[]}', '2023-02-15 16:01:30', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `search_suggestion`
--

CREATE TABLE `search_suggestion` (
  `id` int NOT NULL,
  `suggester_id` int NOT NULL,
  `text` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_all` int NOT NULL,
  `total_public` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `session`
--

CREATE TABLE `session` (
  `id` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` longblob NOT NULL,
  `modified` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `session`
--

INSERT INTO `session` (`id`, `data`, `modified`) VALUES
('3dc6fa0c49230d8389d3d40845c8dab3', 0x5f5f4c616d696e61737c613a323a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313737323739363232352e3934373036353b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a33323a223364633666613063343932333064383338396433643430383435633864616233223b7d7d, 1772796225),
('88647b8b7f0530f4986668fd5e1802fa', 0x5f5f4c616d696e61737c613a323a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313737323739363231332e3032373436373b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a33323a223838363437623862376630353330663439383636363866643565313830326661223b7d7d, 1772796213),
('e785162a3905235b99578fb30cb62dd5', 0x5f5f4c616d696e61737c613a363a7b733a32303a225f524551554553545f4143434553535f54494d45223b643a313737323831333935352e38373736373b733a363a225f56414c4944223b613a313a7b733a32383a224c616d696e61735c53657373696f6e5c56616c696461746f725c4964223b733a33323a223261303462336465616630316331653636376464623531643032616433313437223b7d733a34323a224c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313737323833393433313b7d733a34343a224c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313737323835373032373b7d733a33323a224c616d696e61735f56616c696461746f725f437372665f73616c745f63737266223b613a313a7b733a363a22455850495245223b693a313737323835373135353b7d733a35333a224c616d696e61735f56616c696461746f725f437372665f73616c745f7265736f7572636574656d706c617465666f726d5f63737266223b613a313a7b733a363a22455850495245223b693a313737323835373032373b7d7d72656469726563745f75726c7c733a32343a22687474703a2f2f6f6d656b612e6c6f63616c2f61646d696e223b4c616d696e61735f56616c696461746f725f437372665f73616c745f6c6f67696e666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223131363439373338633133393632393538366566356130316638346361303236223b733a33323a223938386665643965343735303365633165356439653661393834346362666465223b7d733a343a2268617368223b733a36353a2239383866656439653437353033656331653564396536613938343463626664652d3131363439373338633133393632393538366566356130316638346361303236223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f417574687c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a313a7b733a373a2273746f72616765223b693a313b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4f6d656b614d657373656e6765727c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a303a7b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4561737941646d696e7c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a31343a226c61737442726f77736550616765223b613a313a7b733a353a2261646d696e223b613a313a7b733a353a226974656d73223b733a31313a222f61646d696e2f6974656d223b7d7d733a393a226c6173745175657279223b613a313a7b733a353a2261646d696e223b613a313a7b733a353a226974656d73223b613a353a7b733a31353a22736f72745f62795f64656661756c74223b733a303a22223b733a31383a22736f72745f6f726465725f64656661756c74223b733a303a22223b733a373a22736f72745f6279223b733a373a2263726561746564223b733a31303a22736f72745f6f72646572223b733a343a2264657363223b733a343a2270616765223b693a313b7d7d7d7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f636f6e6669726d666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a32313a7b733a33323a226465316463373434333165666635656163626136313562373331316234386232223b733a33323a226633626463333832333132633365343631646261663530663333333163633863223b733a33323a223361303763396331343961336633666664366639626463666436613236363536223b733a33323a226261306237303232616339643336346637623037323731303661376630376631223b733a33323a226238396536323637653966323831616537373562383137333739616661313764223b733a33323a223165613532613766633864623639386432653233366365666664333431326236223b733a33323a223464383835326263623163623636396634373534313831646537363238333639223b733a33323a223133343064346334393934333036316137643562363134636234666433386338223b733a33323a226362663364386333323132663666633661353637633536646562626432636438223b733a33323a226234653032636337656565613234383630306262373462393966613061623832223b733a33323a226430393838633430366631383138616530623030386566343233633934626639223b733a33323a223661646130313335323936633236316464613235353833626565623963616264223b733a33323a223061396630363861323336383139333832376636363463306565656461613332223b733a33323a226135333538313566653165353665643663336433386166303066333461343032223b733a33323a223937333931653432366335316237636137396130643239346235313166623738223b733a33323a226461346436346637353433626431326135303530643133313936653433663063223b733a33323a223561303364353362363432333864313265363739393033313031376430333432223b733a33323a223830376431313533356563356135343862316130633732656537636636393638223b733a33323a223239663563393962663838373937306539626535376533373262646162623239223b733a33323a226237633466613534653766633830353562633230313533383733646235666334223b733a33323a223632616334383230643638643932616531643036373235313763643735393337223b733a33323a223033383139633864663336363837303161383534623530323665666563353832223b733a33323a226663616262383065653432363435653131316161393337366436623231326461223b733a33323a223235616161343137316635356364353732663162613839626534663833333063223b733a33323a223438623938356562383430633237626335373764373563633733663463303838223b733a33323a226166643136616235366161656139393563613962346630343739313561303334223b733a33323a223833303830633636623739376138626339646132636437666437343762306165223b733a33323a223165636265313438323836363730316462393731636166626563326161653333223b733a33323a223165393535303561303331653065623537646432303163386130663039383231223b733a33323a226362396564646636356439383439316138383132393339653732373165306362223b733a33323a223332306336393733643532323965616565653432323835336337613762383838223b733a33323a226661326337656430623534623938613735623263666137363039343266363463223b733a33323a226163613533656139656663303231616239326436393762626464343230616534223b733a33323a226637386665643462323039666562336230353936333962653437333239353363223b733a33323a226237386135393465326464363162633361663336363531646638386336666330223b733a33323a226638646531613765373335323130663463336662356237623334656464633461223b733a33323a223532643239666662333431666164366331343565303736643435313864366565223b733a33323a226131313738643937633932653732393736323432643031313862316462363737223b733a33323a223665356237363331633739623737343431383435346130383531333765316533223b733a33323a223336346537383830386538383434326264616166343466333935303830653263223b733a33323a223837646165303130326330346536623531666435326635396237656135623535223b733a33323a226333656630346665633563343630623964653337653638623438373566346265223b7d733a343a2268617368223b733a36353a2263336566303466656335633436306239646533376536386234383735663462652d3837646165303130326330346536623531666435326635396237656135623535223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a39383a7b733a33323a226136333961646361666633626539306338366339356464323130376338653330223b733a33323a223735623839326132336665313962663331323132353636353330333536636632223b733a33323a226436353035363763376337366563633734653961663736653862656630616135223b733a33323a223162363231656136643737613463323834343762636333393062656365363439223b733a33323a223138663233376536333562343635343930663638353561373363353966346339223b733a33323a223530353930666135313832333439373139643636353164393165643462393134223b733a33323a223066323830326638366336643639303161303765613730633031646637306135223b733a33323a226433383162636435363131663136653263396534366664653637633730643263223b733a33323a223531363834376163376364366533353463616166303961626130336562646262223b733a33323a226138363930626265303030626261383936623032306239303361393039633737223b733a33323a223137643537663862303665376138346335386331626466663266306431356364223b733a33323a223139363136346362336536383964653035386435366463623935613235643136223b733a33323a223630323533393039343330323761636364353337656462653531333265636338223b733a33323a223961306262393862316337626239336339383065306266313032663366616339223b733a33323a226361353636323834636133363733396465396538323133356336653531636236223b733a33323a226633303466363633666339393939313631306665343261303666316235376364223b733a33323a223539363661336333613331303065393239393639663561396332326263326162223b733a33323a223133623365633361353933633332356436376533306264333037653562353136223b733a33323a223935326366343632353162353036393164343364633563383932353534633038223b733a33323a223265326261326433306133336238653930363332336262623536306330333830223b733a33323a226161333838373261643963346530616139306235626430303164386536666131223b733a33323a223166333962366132303736626261303162383631343838356135653263396330223b733a33323a223930383164623138323936386566373335303761653565333865633463356335223b733a33323a223966643235306334633735623738333935636538353136343761396438373530223b733a33323a226665373964663931643438303036616461346631303539656439386265313264223b733a33323a223639663335633166356532343065326235653732363537643232623333633536223b733a33323a223532653863636532616135626263633561383333306363623335636661623635223b733a33323a226239303139646430656337343335313834346531616436313365633635336437223b733a33323a223765666230643665626431386332323362636662666135333165316462616530223b733a33323a223766623332613365373638663839386336636266376237363332383363363836223b733a33323a223464633766613265643533343964326365393132636564616330303137656134223b733a33323a223964303061383566623764363136383131626561663039306231633962633237223b733a33323a226332633735636639376363303139376638393765636361313062386436643031223b733a33323a223231613338393738323261616230306336343531653036393766616662356430223b733a33323a226261376137303864363435316364333266623263363237666562643837313939223b733a33323a223731393966636139333833643964396538303937323966656563626631636138223b733a33323a223532353362393661323662323838643932626664323233373864323564303762223b733a33323a223466636231653036646634333337666432613932376130346135623365613537223b733a33323a223330663164626465656466383330316538623835633930616563386337353066223b733a33323a226434663162333731373161303539363634346363623765316231643064633330223b733a33323a223534396635626565623835646133636165646163373066366265356166373061223b733a33323a226239346365383839646538383431336464313436653434643431646238663061223b733a33323a226535393166363439636661323134313731623364636364383964396165373561223b733a33323a223938366438643964313263643237646137663636323662313831666534383934223b733a33323a226330343061353630656439376236393338366665626264333234346265643539223b733a33323a223664633637366538343133623430346639343431636566663830333831383261223b733a33323a223234356166326331633266313365353739313238366433326165633062363639223b733a33323a223931623663353036653162623966323538366663376665306435623963323262223b733a33323a226633366563626463343364396530646335353533316362623333353762383265223b733a33323a223537613636363461343266373866346366333334323866333139333266626237223b733a33323a223637363133363866356132336235393031646534313763303637386166306236223b733a33323a223431336332623239323230653462393463663663383530633732356562383238223b733a33323a223835313836623738353161343039633038616566636566316339636335383566223b733a33323a223338326635303937306134616535316230333539633564373966636465633534223b733a33323a223738333366643631303134656565316266653830623761313264373036626339223b733a33323a223134646264366565666164343234656264616232623361393433383632303132223b733a33323a223833366665353238626238313232633161643538393637383164613436383362223b733a33323a223039383439356563376331616461623137386434356432613739303938643734223b733a33323a226533666437656634326530626138373834653330353932643838346135303936223b733a33323a226137333433383635353139316430363962313832373661623566316132653962223b733a33323a223133386136333435333433313630326566386633616663376433363164383030223b733a33323a223835653665303834653462343135353531646365363635623031666463376139223b733a33323a223936616363376163323864393466333133373630633262616264366433666538223b733a33323a226130336463623463653736663162323035663562373266383630386537386631223b733a33323a223462346637653134633461396364623962633130613766393965306463363237223b733a33323a223666653737333663383539643465323662303834376535653636626535616637223b733a33323a226438633830346163376633616432353938333438386137323465353134636535223b733a33323a226366303038383161643764326631613433336136616632633865656138626633223b733a33323a226632356637313463323135373962623237613936653366346133636539343239223b733a33323a226335633939646266396231336134353637386437363037383463303435653239223b733a33323a226339326332376166303965313630666462303139396532636261323930386439223b733a33323a226365386532326561363261316335656232303236616166393735613735373630223b733a33323a223336393738306563393666643332376137326530303032623336646165373836223b733a33323a226331376437373866336361646462366637393262333563303439333133643766223b733a33323a223032323435353163323165663331313930656433316336633533306530633831223b733a33323a226465613236623039626333333132373965323132366539663039316461333464223b733a33323a226531366133313931336636666164313461396464323334626438323930653466223b733a33323a226634336462356130636664303562663763643338616566343435643036386332223b733a33323a226161613764653138356434656166643932376336373465643934663661383731223b733a33323a223463363735653335333135373836363834353235373062666561623665326536223b733a33323a223137663236333461656430363334336334343138613263366231373639353761223b733a33323a223432343664646366396232663766656364306366396466616236623435646661223b733a33323a223362363831373538363033633531366632363336343032653233363061383933223b733a33323a226638346563363932383035353165616338613265326635663032376666373134223b733a33323a223061643135393634646666613465336435396339393438623566336638373438223b733a33323a226138356635623238666537623136393233343039363861336433653831303363223b733a33323a226630653461386134666464363932373665373965376135363663343361626539223b733a33323a223634313338333937373232613835363563336566656462646661376235653164223b733a33323a223337383661326630626161323964306363346132353439383261373361383665223b733a33323a223334633761323432343935646564613632636438633064393234653765323233223b733a33323a223362326339643933326439313565363364653537613266343137383030356361223b733a33323a226563366339626662363062396532366162333334373862633036643337336635223b733a33323a223039663662633833653331646565393031663330373936393931346639366538223b733a33323a226339326464613563323238323738303461373065616137663133653439646465223b733a33323a223034346163366566326466613566353164303635633336656466646366396239223b733a33323a223435643463666162353962633936366331636335656532313439353135346631223b733a33323a223137376636613765323439656162656439626135313632613033336666373236223b733a33323a223237363533333963653735656536626163313762393731653164643366333032223b733a33323a223564633830633636613035393535643330386432643062326538323838393632223b733a33323a226536323930616261346230373838623838333461396433643936353137313733223b733a33323a223865386138383830396533303432376432323037613038363562646230346538223b733a33323a223231386239343038363235386165333064346634316130636134373635356330223b733a33323a223363633834393133623336623735633038333532633939393632653230306364223b733a33323a226435613533633831363438303934656631663635373137346666373732346663223b733a33323a223834643961626138663562363138356339646138313662653837613435656230223b733a33323a226431393935356665653938353039666366373939633238336461633735336133223b733a33323a226437363634633762653861383839323365343432353637346262323837396263223b733a33323a226261323930633535343133393262313836363465363539393436333066633031223b733a33323a226637666238303364313630626132333435313831623639663031663332633132223b733a33323a223162383062323261656531653662663733623662373565313733666566326430223b733a33323a226631343537376663366439396132323865356233303132646664303366363835223b733a33323a226233613135393761353733653633386539663237636564356466353462643937223b733a33323a223665326235306133373764653239363063353962343630336630306463303731223b733a33323a223931326161323862633264343038643130316162316535376261636230373131223b733a33323a226364393765316230353730393362303062366563383837656433343061343262223b733a33323a223832663763613434383665353532643464616164366134393661386138323730223b733a33323a223935366336303532346336653030393138633730663763623066313734376130223b733a33323a223435623661363935343161646433646266326365643632333262383038333539223b733a33323a226361316130643765346138313039613835313335663633346133623138633130223b733a33323a226461623534643430666662656333616666633739626463376264353766386562223b733a33323a223766303866613438363933666637376266306535653662393564353063336132223b733a33323a226330353664656438663162366365616431333561656232623066343934636135223b733a33323a223934323866653166333064613935336263383164353737356136383964363735223b733a33323a223934396231303538326531653239653137643835373136643265616239396165223b733a33323a223933363930316531636530376137316237303931326434393064633931663233223b733a33323a223130336638653265616332613834643838646362363933393936643862343830223b733a33323a223363316465623838363937623264326638363462666362653239656434383032223b733a33323a226630383365643837336632623330346539363165323563326665643633636133223b733a33323a226463633334303064636535633234303732376237313936323439306266653436223b733a33323a223565633636383432623731326538323232333364613463316462336366383038223b733a33323a226165326633626531626162303063376462303133336533363233613334666239223b733a33323a226436303035306533363735636134366565646332313130383730616532373465223b733a33323a223139386336303966616265623333303838336638653265663134656138656562223b733a33323a223964383361396533336363356466666136626133306164346131356232646130223b733a33323a226135633035313336363964623231353331656438326563396462353863313161223b733a33323a223861633561343233303666616130653838323161626166313963633130373065223b733a33323a223430636435616635303938666465393130653936393064396536393661613436223b733a33323a226439356532613532643936643039366465313763386531306630376237383336223b733a33323a223037663735656562393961396163613139613635373665316239343862356433223b733a33323a226662336566616434363636633430616535363162663233653631373332613861223b733a33323a223663313538336538303038363436346132333439646632323265653237666565223b733a33323a226466663936646665633033653130623665653963356362326164653739636538223b733a33323a223363666562313537653066633232343232656662383336633737613166383236223b733a33323a226132356637643836363966363431356539393166323436306134306665333735223b733a33323a223164626232663230396438313061303463373231363764636364323037386233223b733a33323a223339646238653538613233653961383039363938366539636533333833646136223b733a33323a223161383064303637356637316430313233303364363366323961393936396662223b733a33323a223839663966326562616434623536323266383662336264343936313232636339223b733a33323a226262373863616462656334633835336533316536333731353731336466306134223b733a33323a223230633831396239653165633064336537306365363361393336656132303438223b733a33323a226533653739333533623531666334613739343865636661303565306538643339223b733a33323a223262333733363530653561303737363533326233323461353336623065363236223b733a33323a223132663161616562343933626333663836666230336430633635326235396365223b733a33323a226261663635666339306230326462383633643031653263653331636233343437223b733a33323a226532653839616362613665353836646430626639303066633239633138653461223b733a33323a226436316366366633326664343866663635303664326564653463343538633234223b733a33323a223032613535643131616632396137373462393539336136663236326366663936223b733a33323a223330323261366131323261333039313034303437333037393337316333643566223b733a33323a226462663439313235646239626231343066326563663439313266383238623338223b733a33323a223563643134333632363038363330396664393430313666646161623432633666223b733a33323a223065353139383062306266653930656534636462316537613464393938363337223b733a33323a226561333030636530386530663063363363356562333433343737616436313036223b733a33323a226438323864653236386161306266333234376137653565323862626339643165223b733a33323a223062643931303131626139346366363430336566613931393338646633336531223b733a33323a223636333063643133636339303238393331646465636531636235383632613130223b733a33323a226339643337333932616163663237633061353336333566333132306135666661223b733a33323a226538626232643464313265323434636230353133363664313238323562393265223b733a33323a223764636166336239643334323633373230396263376234653934373064393635223b733a33323a226337313135623761643433356163656464306232613132306663396339653735223b733a33323a223039643237333165343931366539336564346334396237323030663863343564223b733a33323a223137373235636237646134303064333335323564366661346337383732663730223b733a33323a223130363161653361626138626435323363373566386533303831356336386639223b733a33323a223838356362313863343533623739663032616232616364396131663463636530223b733a33323a223434653535353437363530333735663361376538303661343563633366663134223b733a33323a223762663138616234396562343239376435376663396166393362663866353339223b733a33323a226531353231336236626362626534636638623364323735396134666539653537223b733a33323a226632626664666566353961313463326637646564636365343861376639323335223b733a33323a223465366134343435613438386462333234376138346437336339623234383431223b733a33323a223731666466633832343433633235303063643462353261616632326339623665223b733a33323a226462643339343661313934663832316530363635626530393433356530383930223b733a33323a226136663366616264643661326266613839323637663536663338396530663432223b733a33323a223632353362653761656632623532666631653863336164373666636532363336223b733a33323a223534636264393230646261663335336564396364366431636435613162396564223b733a33323a226233343433373833343063663363343935666463326636646335323337376637223b733a33323a223166343463303433626237663264303138626461623164353938626664343965223b733a33323a223833663433386562663832633639373035633335373963306430323131376537223b733a33323a223433393931663133393439376231656539616536613536303766376131666665223b733a33323a223964343664326539313233383535366530663735623231376232356336366161223b733a33323a226338363633313439306564653866303735633966613036376665613238326530223b733a33323a226538353031666139346465626464646435353766666232303163363533383736223b733a33323a223333376632633234656361393933626534626532346636363939663765383539223b733a33323a223461383963643435396362346464613533303534336663306534373134666136223b733a33323a223963393063653331393664396139336135316433346366623765306532653461223b733a33323a223537386362653936393061636263343939373565616365666363363161363662223b733a33323a226335633630373034343264313537333632643564363330383066336232656333223b733a33323a226237303866616231386266336565643832306161393730343964613932333739223b7d733a343a2268617368223b733a36353a2262373038666162313862663365656438323061613937303439646139323337392d6335633630373034343264313537333632643564363330383066336232656333223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d4c616d696e61735f56616c696461746f725f437372665f73616c745f7265736f7572636574656d706c617465666f726d5f637372667c4f3a32363a224c616d696e61735c5374646c69625c41727261794f626a656374223a343a7b733a373a2273746f72616765223b613a323a7b733a393a22746f6b656e4c697374223b613a313a7b733a33323a223735663430343836633363336130656438633565303035366162316562316661223b733a33323a223564376634633537386233336231356133356238653062343937383234386239223b7d733a343a2268617368223b733a36353a2235643766346335373862333362313561333562386530623439373832343862392d3735663430343836633363336130656438633565303035366162316562316661223b7d733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b733a31333a2241727261794974657261746f72223b733a31393a2270726f74656374656450726f70657274696573223b613a343a7b693a303b733a373a2273746f72616765223b693a313b733a343a22666c6167223b693a323b733a31333a226974657261746f72436c617373223b693a333b733a31393a2270726f74656374656450726f70657274696573223b7d7d, 1772813955);

-- --------------------------------------------------------

--
-- Table structure for table `setting`
--

CREATE TABLE `setting` (
  `id` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `setting`
--

INSERT INTO `setting` (`id`, `value`) VALUES
('administrator_email', '\"admin@example.org\"'),
('advancedsearch_all_configs', '{\"1\":\"find\"}'),
('advancedsearch_api_config', '\"\"'),
('advancedsearch_batch_size', '\"100\"'),
('advancedsearch_fulltextsearch_alto', '\"0\"'),
('advancedsearch_main_config', '\"1\"'),
('advancedsearch_metadata_improved', 'true'),
('advancedsearch_search_fields', '[\"common\\/advanced-search\\/sort\",\"common\\/advanced-search\\/fulltext\",\"common\\/advanced-search\\/properties\",\"common\\/advanced-search\\/filters\",\"common\\/advanced-search\\/resource-class\",\"common\\/advanced-search\\/resource-template\",\"common\\/advanced-search\\/item-sets\",\"common\\/advanced-search\\/item-sets-improved\",\"common\\/advanced-search\\/site\",\"common\\/advanced-search\\/has-media-radio\",\"common\\/advanced-search\\/media-types\",\"common\\/advanced-search\\/media-type\",\"common\\/advanced-search\\/owner\",\"common\\/advanced-search\\/visibility-radio\",\"common\\/advanced-search\\/ids\",\"common\\/advanced-search\\/date-time\",\"common\\/advanced-search\\/has-original\",\"common\\/advanced-search\\/has-thumbnails\",\"common\\/advanced-search\\/has-asset\",\"common\\/advanced-search\\/asset\",\"common\\/advanced-search\\/data-type-geography\",\"common\\/advanced-search\\/item-set-is-dynamic\",\"common\\/numeric-data-types-advanced-search\",\"common\\/advanced-search\\/harvests\"]'),
('archiverepertory_item_convert', '\"full\"'),
('archiverepertory_item_folder', '\"id\"'),
('archiverepertory_item_prefix', '\"\"'),
('archiverepertory_item_set_convert', '\"full\"'),
('archiverepertory_item_set_folder', '\"\"'),
('archiverepertory_item_set_prefix', '\"\"'),
('archiverepertory_media_convert', '\"full\"'),
('ark_naa', '\"example.org\"'),
('ark_naan', '\"99999\"'),
('ark_name', '\"noid\"'),
('ark_name_noid_template', '\"a1.rllllk\"'),
('ark_note', '\"\"'),
('ark_policy_main', '\"Our institution assigns identifiers within the ARK domain under the NAAN 99999 and according to the following principles:\\r\\n\\r\\n* No ARK shall be re-assigned; that is, once an ARK-to-object association has been made public, that association shall be considered unique into the indefinite future.\\r\\n* To help them age and travel well, the Name part of our institution-assigned ARKs shall contain no widely recognizable semantic information (to the extent possible).\\r\\n* Our institution-assigned ARKs shall be generated with a terminal check character that guarantees them against single character errors and transposition errors.\"'),
('ark_policy_statement', '\"erc-support:\\r\\nwho: Our Institution\\r\\nwhat: Permanent: Stable Content:\\r\\nwhen: 20160101\\r\\nwhere: http:\\/\\/example.com\\/ark:\\/99999\\/\"'),
('ark_property', '\"dcterms:identifier\"'),
('ark_qualifier', '\"internal\"'),
('ark_qualifier_position_format', '\"\"'),
('ark_qualifier_static', '\"0\"'),
('ark_subnaa', '\"sub\"'),
('blockplus_html_config_page', '\"default\"'),
('blockplus_html_mode_page', '\"inline\"'),
('blockplus_page_models', '[]'),
('blockplus_property_itemset', '\"\"'),
('blocksdisposition_modules', '[]'),
('bulkedit_deduplicate_on_save', '\"1\"'),
('bulkexport_format_fields', '\"name\"'),
('bulkexport_format_generic', '\"string\"'),
('bulkexport_format_resource', '\"id\"'),
('bulkexport_format_resource_property', '\"dcterms:identifier\"'),
('bulkexport_format_uri', '\"uri_label\"'),
('bulkexport_formatters', '[\"csv\",\"json-ld\",\"ods\",\"tsv\",\"txt\"]'),
('bulkexport_language', '\"\"'),
('bulkexport_limit', '\"1000\"'),
('bulkexport_metadata', '[\"o:id\",\"o:resource_template\",\"o:resource_class\",\"o:owner\",\"o:is_public\"]'),
('bulkexport_metadata_exclude', '[\"extracttext:extracted_text\"]'),
('bulkexport_template', '\"\"'),
('cleanurl_admin_reserved', '[]'),
('cleanurl_admin_use', '\"0\"'),
('cleanurl_item', '{\"default\":\"ark:\\/99999\\/{item_identifier_short}\",\"short\":\"\",\"paths\":[],\"pattern\":\"[a-zA-Z0-9][a-zA-Z0-9_-]*\",\"pattern_short\":\"\",\"property\":10,\"prefix\":\"ark:\\/99999\\/\",\"prefix_part_of\":false,\"keep_slash\":false,\"case_sensitive\":true}'),
('cleanurl_item_set', '{\"default\":\"collection\\/{item_set_id}\",\"short\":\"\",\"paths\":[],\"pattern\":\"[a-zA-Z0-9][a-zA-Z0-9_-]*\",\"pattern_short\":\"\",\"property\":10,\"prefix\":\"\",\"prefix_part_of\":false,\"keep_slash\":false,\"case_sensitive\":false}'),
('cleanurl_media', '{\"default\":\"document\\/{item_identifier}\\/{media_id}\",\"short\":\"\",\"paths\":[],\"pattern\":\"\",\"pattern_short\":\"\",\"property\":10,\"prefix\":\"\",\"prefix_part_of\":false,\"keep_slash\":false,\"case_sensitive\":false}'),
('cleanurl_page_slug', '\"page\\/\"'),
('cleanurl_settings', '{\"routes\":[],\"route_aliases\":[]}'),
('cleanurl_site_skip_main', '\"0\"'),
('cleanurl_site_slug', '\"s\\/\"'),
('default_site', '\"\"'),
('default_to_private', '\"0\"'),
('disable_file_validation', '\"0\"'),
('disable_jsonld_embed', '\"0\"'),
('disable_jsonld_reverse', '\"0\"'),
('easyadmin_addon_notify_version_dev', '\"0\"'),
('easyadmin_addon_notify_version_inactive', '\"1\"'),
('easyadmin_administrator_name', '\"\"'),
('easyadmin_allow_empty_files', '\"0\"'),
('easyadmin_cron_last', '1772813635'),
('easyadmin_cron_tasks', '[\"session_8d\"]'),
('easyadmin_disable_csrf', '\"0\"'),
('easyadmin_display_exception', '\"0\"'),
('easyadmin_interface', '[\"resource_public_view\"]'),
('easyadmin_local_path', '\"\\/var\\/www\\/html\\/files\\/import\"'),
('easyadmin_local_path_any', 'false'),
('easyadmin_local_path_any_files', '\"0\"'),
('easyadmin_local_paths', '[]'),
('easyadmin_maintenance_mode', '\"\"'),
('easyadmin_maintenance_text', '\"<p>This site is down for maintenance. Please contact the site administrator for more information.<\\/p>\\r\\n\"'),
('easyadmin_no_reply_email', '\"\"'),
('easyadmin_no_reply_name', '\"\"'),
('easyadmin_rights_reviewer_delete_all', '\"0\"'),
('extension_whitelist', '[\"aac\",\"aif\",\"aiff\",\"asf\",\"asx\",\"avi\",\"bmp\",\"c\",\"cc\",\"class\",\"css\",\"divx\",\"doc\",\"docx\",\"exe\",\"gif\",\"gz\",\"gzip\",\"h\",\"ico\",\"j2k\",\"jp2\",\"jpe\",\"jpeg\",\"jpg\",\"m4a\",\"m4v\",\"mdb\",\"mid\",\"midi\",\"mov\",\"mp2\",\"mp3\",\"mp4\",\"mpa\",\"mpe\",\"mpeg\",\"mpg\",\"mpp\",\"odb\",\"odc\",\"odf\",\"odg\",\"odp\",\"ods\",\"odt\",\"ogg\",\"opus\",\"pdf\",\"png\",\"pot\",\"pps\",\"ppt\",\"pptx\",\"qt\",\"ra\",\"ram\",\"rtf\",\"rtx\",\"swf\",\"tar\",\"tif\",\"tiff\",\"txt\",\"wav\",\"wax\",\"webm\",\"wma\",\"wmv\",\"wmx\",\"wri\",\"xla\",\"xls\",\"xlsx\",\"xlt\",\"xlw\",\"zip\",\"bin\",\"dae\",\"fbx\",\"glb\",\"gltf\",\"json\",\"ktx2\",\"mtl\",\"obj\",\"xml\"]'),
('favicon', '\"\"'),
('file_sideload_delete_file', '\"no\"'),
('file_sideload_directory', '\"\\/data\\/sftp\\/omeka-sideload\\/\"'),
('file_sideload_max_directories', '1000'),
('file_sideload_max_files', '1000'),
('hidden_properties_admin_show_all', 'false'),
('hidden_properties_properties', '[\"extracttext:extracted_text\"]'),
('iiifsearch_minimum_query_length', '3'),
('iiifsearch_xml_fix_mode', '\"no\"'),
('iiifsearch_xml_image_match', '\"order\"'),
('iiifserver_access_ocr_skip', '\"0\"'),
('iiifserver_access_resource_skip', '\"0\"'),
('iiifserver_identifier_clean', '\"1\"'),
('iiifserver_identifier_prefix', '\"\"'),
('iiifserver_identifier_raw', '\"0\"'),
('iiifserver_manifest_append_cors_headers', '\"0\"'),
('iiifserver_manifest_attribution_default', '\"Provided by Example Organization\"'),
('iiifserver_manifest_attribution_property', '\"\"'),
('iiifserver_manifest_behavior_default', '[\"none\"]'),
('iiifserver_manifest_behavior_property', '\"\"'),
('iiifserver_manifest_cache', '\"0\"'),
('iiifserver_manifest_canvas_label', '\"template\"'),
('iiifserver_manifest_canvas_label_property', '\"\"'),
('iiifserver_manifest_collection_properties', '[]'),
('iiifserver_manifest_default_version', '\"2\"'),
('iiifserver_manifest_external_property', '\"dcterms:hasFormat\"'),
('iiifserver_manifest_homepage', '[\"resource\"]'),
('iiifserver_manifest_homepage_property', '\"\"'),
('iiifserver_manifest_html_descriptive', '\"1\"'),
('iiifserver_manifest_item_properties', '[]'),
('iiifserver_manifest_logo_default', '\"\"'),
('iiifserver_manifest_media_properties', '[]'),
('iiifserver_manifest_placeholder_canvas_default', '\"\"'),
('iiifserver_manifest_placeholder_canvas_property', '\"\"'),
('iiifserver_manifest_placeholder_canvas_value', '\"Informed public\"'),
('iiifserver_manifest_pretty_json', '\"0\"'),
('iiifserver_manifest_properties_collection_blacklist', '[\"dcterms:tableOfContents\",\"bibo:content\",\"extracttext:extracted_text\"]'),
('iiifserver_manifest_properties_item_blacklist', '[\"dcterms:tableOfContents\",\"bibo:content\",\"extracttext:extracted_text\"]'),
('iiifserver_manifest_properties_media_blacklist', '[\"dcterms:tableOfContents\",\"bibo:content\",\"extracttext:extracted_text\"]'),
('iiifserver_manifest_provider', '[\"simple\"]'),
('iiifserver_manifest_provider_agent', '\"\"'),
('iiifserver_manifest_provider_property', '\"\"'),
('iiifserver_manifest_rights', '\"property_or_url\"'),
('iiifserver_manifest_rights_property', '\"dcterms:license\"'),
('iiifserver_manifest_rights_text', '\"\"'),
('iiifserver_manifest_rights_uri', '\"https:\\/\\/rightsstatements.org\\/vocab\\/CNE\\/1.0\\/\"'),
('iiifserver_manifest_rights_url', '\"\"'),
('iiifserver_manifest_seealso_property', '\"\"'),
('iiifserver_manifest_start_primary_media', '\"0\"'),
('iiifserver_manifest_start_property', '\"\"'),
('iiifserver_manifest_structures_property', '\"\"'),
('iiifserver_manifest_structures_skip_flat', '\"0\"'),
('iiifserver_manifest_summary_property', '\"dcterms:bibliographicCitation\"'),
('iiifserver_manifest_viewing_direction_default', '\"left-to-right\"'),
('iiifserver_manifest_viewing_direction_property', '\"\"'),
('iiifserver_media_api_default_supported_version', '{\"service\":\"2\",\"level\":\"2\"}'),
('iiifserver_media_api_default_version', '\"2\"'),
('iiifserver_media_api_fix_uv_mp3', '\"0\"'),
('iiifserver_media_api_identifier', '\"media_id\"'),
('iiifserver_media_api_identifier_infojson', '\"0\"'),
('iiifserver_media_api_prefix', '\"\"'),
('iiifserver_media_api_support_non_image', '\"0\"'),
('iiifserver_media_api_supported_versions', '[\"2\\/2\",\"3\\/2\"]'),
('iiifserver_media_api_url', '\"\"'),
('iiifserver_media_api_version_append', '\"0\"'),
('iiifserver_url_force_from', '\"\"'),
('iiifserver_url_force_to', '\"\"'),
('iiifserver_url_version_add', '\"0\"'),
('iiifserver_xml_fix_mode', '\"no\"'),
('iiifserver_xml_image_match', '\"order\"'),
('imageserver_base_url', '\"http:\\/\\/omeka.local\\/\"'),
('imageserver_default_thumbnail_type', '\"tile\"'),
('imageserver_image_max_size', '\"10000000\"'),
('imageserver_image_tile_dir', '\"tile\"'),
('imageserver_image_tile_type', '\"tiled_tiff\"'),
('imageserver_imager', '\"Auto\"'),
('imageserver_info_rights', '\"property_or_url\"'),
('imageserver_info_rights_property', '\"dcterms:license\"'),
('imageserver_info_rights_text', '\"\"'),
('imageserver_info_rights_uri', '\"https:\\/\\/rightsstatements.org\\/vocab\\/CNE\\/1.0\\/\"'),
('imageserver_info_rights_url', '\"\"'),
('imageserver_tile_fallback', '\"tile_large\"'),
('imageserver_tile_mode', '\"manual\"'),
('installation_title', '\"OmekaS Docker\"'),
('locale', '\"en_US\"'),
('log_archive_compress', '\"1\"'),
('log_archive_days', '\"90\"'),
('log_archive_delete', '\"1\"'),
('log_archive_format', '\"tsv\"'),
('log_archive_include_id', '\"0\"'),
('log_archive_references', '[]'),
('log_archive_severity_max', '\"\"'),
('log_archive_store', '\"0\"'),
('log_archive_translate', '\"1\"'),
('log_cron_days', '\"7\"'),
('log_cron_last', '1772796168'),
('media_alt_text_property', '\"\"'),
('media_type_whitelist', '[\"application\\/msword\",\"application\\/ogg\",\"application\\/pdf\",\"application\\/rtf\",\"application\\/vnd.ms-access\",\"application\\/vnd.ms-excel\",\"application\\/vnd.ms-powerpoint\",\"application\\/vnd.ms-project\",\"application\\/vnd.ms-write\",\"application\\/vnd.oasis.opendocument.chart\",\"application\\/vnd.oasis.opendocument.database\",\"application\\/vnd.oasis.opendocument.formula\",\"application\\/vnd.oasis.opendocument.graphics\",\"application\\/vnd.oasis.opendocument.presentation\",\"application\\/vnd.oasis.opendocument.spreadsheet\",\"application\\/vnd.oasis.opendocument.text\",\"application\\/vnd.openxmlformats-officedocument.wordprocessingml.document\",\"application\\/vnd.openxmlformats-officedocument.presentationml.presentation\",\"application\\/vnd.openxmlformats-officedocument.spreadsheetml.sheet\",\"application\\/x-gzip\",\"application\\/x-ms-wmp\",\"application\\/x-msdownload\",\"application\\/x-shockwave-flash\",\"application\\/x-tar\",\"application\\/zip\",\"audio\\/midi\",\"audio\\/mp4\",\"audio\\/mpeg\",\"audio\\/ogg\",\"audio\\/x-aac\",\"audio\\/x-aiff\",\"audio\\/x-ms-wma\",\"audio\\/x-ms-wax\",\"audio\\/x-realaudio\",\"audio\\/x-wav\",\"image\\/bmp\",\"image\\/gif\",\"image\\/jp2\",\"image\\/jpeg\",\"image\\/pjpeg\",\"image\\/png\",\"image\\/tiff\",\"image\\/x-icon\",\"text\\/css\",\"text\\/plain\",\"text\\/richtext\",\"video\\/divx\",\"video\\/mp4\",\"video\\/mpeg\",\"video\\/ogg\",\"video\\/quicktime\",\"video\\/webm\",\"video\\/x-ms-asf\",\"video\\/x-msvideo\",\"video\\/x-ms-wmv\",\"application\\/octet-stream\",\"application\\/vnd.threejs+json\",\"model\\/gltf-binary\",\"model\\/gltf+json\",\"model\\/obj\",\"model\\/vnd.collada+xml\",\"model\\/vnd.filmbox\",\"image\\/ktx2\",\"model\\/mtl\",\"model\\/vnd.threejs+json\",\"application\\/alto+xml\"]'),
('mirador_annotation_endpoint', '\"\"'),
('mirador_config_collection', '\"\"'),
('mirador_config_collection_2', '\"\"'),
('mirador_config_item', '\"\"'),
('mirador_config_item_2', '\"\"'),
('mirador_plugins', '[]'),
('mirador_plugins_2', '[]'),
('mirador_preselected_items', '\"0\"'),
('mirador_version', '\"3\"'),
('modelviewer', '{\"modelviewer_config_property\":\"dcterms:abstract\",\"modelviewer_config_default\":\"\"}'),
('modelviewer_config_default', '\"\"'),
('modelviewer_config_property', '\"dcterms:abstract\"'),
('pagination_per_page', '\"25\"'),
('property_label_information', '\"none\"'),
('recaptcha_secret_key', '\"\"'),
('recaptcha_site_key', '\"\"'),
('searchsolr_server_id', '\"1ik8m4\"'),
('searchsolr_solarium_adapter', '\"auto\"'),
('searchsolr_solarium_timeout', '5'),
('statistics_default_user_status_admin', '\"hits\"'),
('statistics_default_user_status_public', '\"anonymous\"'),
('statistics_disable_dashboard', '\"1\"'),
('statistics_include_bots', '\"0\"'),
('statistics_per_page_admin', '\"100\"'),
('statistics_per_page_public', '\"10\"'),
('statistics_privacy', '\"anonymous\"'),
('statistics_public_allow_browse', '\"0\"'),
('statistics_public_allow_statistics', '\"0\"'),
('statistics_public_allow_summary', '\"0\"'),
('time_zone', '\"Europe\\/London\"'),
('universalviewer_config', '\"{}\"'),
('universalviewer_version', '\"4\"'),
('use_htmlpurifier', '\"0\"'),
('value_languages', '[]'),
('version', '\"4.1.1\"'),
('version_notifications', '\"1\"');

-- --------------------------------------------------------

--
-- Table structure for table `site`
--

CREATE TABLE `site` (
  `id` int NOT NULL,
  `thumbnail_id` int DEFAULT NULL,
  `homepage_id` int DEFAULT NULL,
  `owner_id` int DEFAULT NULL,
  `slug` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `theme` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `summary` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `navigation` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)',
  `item_pool` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)',
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  `is_public` tinyint(1) NOT NULL,
  `assign_new_items` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `site`
--

INSERT INTO `site` (`id`, `thumbnail_id`, `homepage_id`, `owner_id`, `slug`, `theme`, `title`, `summary`, `navigation`, `item_pool`, `created`, `modified`, `is_public`, `assign_new_items`) VALUES
(1, NULL, 1, 1, 'index', 'default', 'Default site', 'Default site created at Docker bootstrap phase', '[{\"type\":\"browse\",\"data\":{\"label\":\"Browse\",\"query\":\"\"},\"links\":[]},{\"type\":\"searchingPage\",\"data\":{\"label\":\"Search\",\"advancedsearch_config_id\":\"1\"},\"links\":[]}]', '[]', '2023-02-15 16:04:55', '2025-07-10 14:56:31', 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `site_block_attachment`
--

CREATE TABLE `site_block_attachment` (
  `id` int NOT NULL,
  `block_id` int NOT NULL,
  `item_id` int DEFAULT NULL,
  `media_id` int DEFAULT NULL,
  `caption` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `position` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `site_item_set`
--

CREATE TABLE `site_item_set` (
  `id` int NOT NULL,
  `site_id` int NOT NULL,
  `item_set_id` int NOT NULL,
  `position` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `site_page`
--

CREATE TABLE `site_page` (
  `id` int NOT NULL,
  `site_id` int NOT NULL,
  `slug` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_public` tinyint(1) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  `layout` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `layout_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:json)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `site_page`
--

INSERT INTO `site_page` (`id`, `site_id`, `slug`, `title`, `is_public`, `created`, `modified`, `layout`, `layout_data`) VALUES
(1, 1, 'welcome', 'Welcome', 1, '2023-02-15 16:04:55', '2023-02-15 16:04:55', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `site_page_block`
--

CREATE TABLE `site_page_block` (
  `id` int NOT NULL,
  `page_id` int NOT NULL,
  `layout` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)',
  `position` int NOT NULL,
  `layout_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '(DC2Type:json)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `site_page_block`
--

INSERT INTO `site_page_block` (`id`, `page_id`, `layout`, `data`, `position`, `layout_data`) VALUES
(1, 1, 'html', '{\"html\":\"Welcome to your new site. This is an example page.\"}', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `site_permission`
--

CREATE TABLE `site_permission` (
  `id` int NOT NULL,
  `site_id` int NOT NULL,
  `user_id` int NOT NULL,
  `role` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `site_permission`
--

INSERT INTO `site_permission` (`id`, `site_id`, `user_id`, `role`) VALUES
(1, 1, 1, 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `site_setting`
--

CREATE TABLE `site_setting` (
  `id` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `site_id` int NOT NULL,
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `site_setting`
--

INSERT INTO `site_setting` (`id`, `site_id`, `value`) VALUES
('advancedsearch_configs', 1, '[\"1\"]'),
('advancedsearch_item_sets_config', 1, '\"1\"'),
('advancedsearch_item_sets_redirect_page_url', 1, '[]'),
('advancedsearch_item_sets_redirect_search_first', 1, '[\"all\"]'),
('advancedsearch_item_sets_redirects', 1, '{\"default\":\"first\"}'),
('advancedsearch_item_sets_scope', 1, '\"0\"'),
('advancedsearch_item_sets_template_form', 1, '\"\"'),
('advancedsearch_items_config', 1, '\"1\"'),
('advancedsearch_items_template_form', 1, '\"\"'),
('advancedsearch_main_config', 1, '\"1\"'),
('advancedsearch_media_config', 1, '\"1\"'),
('advancedsearch_media_template_form', 1, '\"\"'),
('advancedsearch_metadata_improved', 1, 'true'),
('advancedsearch_redirect_itemset', 1, '\"first\"'),
('advancedsearch_redirect_itemsets', 1, '{\"default\":\"first\"}'),
('advancedsearch_search_fields', 1, '[\"common\\/advanced-search\\/sort\",\"common\\/advanced-search\\/fulltext\",\"common\\/advanced-search\\/properties\",\"common\\/advanced-search\\/filters\",\"common\\/advanced-search\\/resource-class\",\"common\\/advanced-search\\/item-sets\",\"common\\/advanced-search\\/has-media-radio\",\"common\\/advanced-search\\/media-types\",\"common\\/advanced-search\\/media-type\",\"common\\/advanced-search\\/ids\",\"common\\/advanced-search\\/data-type-geography\",\"common\\/numeric-data-types-advanced-search\"]'),
('attachment_link_type', 1, '\"item\"'),
('blockplus_breadcrumbs_collections_url', 1, '\"\"'),
('blockplus_breadcrumbs_crumbs', 1, '[\"home\",\"collections\",\"itemset\",\"itemsetstree\",\"current\"]'),
('blockplus_breadcrumbs_homepage', 1, '\"0\"'),
('blockplus_breadcrumbs_prepend', 1, '[]'),
('blockplus_breadcrumbs_separator', 1, '\"\"'),
('blockplus_items_order_for_itemsets', 1, '[]'),
('blockplus_page_model_rights', 1, '\"0\"'),
('blockplus_page_model_skip_blockplus', 1, '\"0\"'),
('blockplus_page_models', 1, '[]'),
('blockplus_page_types', 1, '{\"home\":\"Home\",\"exhibit\":\"Exhibit\",\"exhibit_page\":\"Exhibit page\",\"simple\":\"Simple page\"}'),
('blockplus_prevnext_item_sets_query', 1, '\"\"'),
('blockplus_prevnext_items_query', 1, '\"\"'),
('browse_attached_items', 1, '\"0\"'),
('browse_body_property_term', 1, '\"\"'),
('browse_defaults_public_items', 1, '{\"sort_by\":\"created\",\"sort_order\":\"desc\"}'),
('browse_heading_property_term', 1, '\"\"'),
('bulkexport_format_fields', 1, '\"label\"'),
('bulkexport_format_generic', 1, '\"string\"'),
('bulkexport_format_resource', 1, '\"id\"'),
('bulkexport_format_resource_property', 1, '\"dcterms:identifier\"'),
('bulkexport_format_uri', 1, '\"uri_label\"'),
('bulkexport_formatters', 1, '[\"csv\",\"json-ld\",\"ods\",\"tsv\",\"txt\"]'),
('bulkexport_language', 1, '\"\"'),
('bulkexport_limit', 1, '\"1000\"'),
('bulkexport_metadata', 1, '[\"url\",\"o:resource_class\"]'),
('bulkexport_metadata_exclude', 1, '[\"extracttext:extracted_text\"]'),
('bulkexport_template', 1, '\"\"'),
('bulkexport_views', 1, '[\"item_browse\"]'),
('disable_jsonld_embed', 1, '\"0\"'),
('eucookiebar_message', 1, '\"<p>Warning: this site uses cookies or other means to steal your personal data and to allow Google or Facebook to fetch them. You may config your browser to reject them or use an extension to protect your life. See terms and conditions. By visiting this site, you accept them.<\\/p>\\r\\n\"'),
('eucookiebar_options', 1, '\"{\\r\\n    \\\"acceptButton\\\": true,\\r\\n    \\\"acceptText\\\": \\\"OK\\\",\\r\\n    \\\"declineButton\\\": false,\\r\\n    \\\"declineText\\\": \\\"Disable Cookies\\\",\\r\\n    \\\"policyButton\\\": false,\\r\\n    \\\"policyText\\\": \\\"Privacy Policy\\\",\\r\\n    \\\"policyURL\\\": \\\"\\/\\\",\\r\\n    \\\"bottom\\\": true,\\r\\n    \\\"fixed\\\": true,\\r\\n    \\\"zindex\\\": \\\"99999\\\"\\r\\n}\"'),
('exclude_resources_not_in_site', 1, '\"0\"'),
('favicon', 1, '\"\"'),
('filter_locale_values', 1, '\"0\"'),
('imageserver_default_thumbnail_type', 1, '\"large\"'),
('imageserver_tile_fallback', 1, '\"tile_large\"'),
('item_media_embed', 1, '\"0\"'),
('locale', 1, '\"\"'),
('mirador_annotation_endpoint', 1, '\"\"'),
('mirador_config_collection', 1, '\"\"'),
('mirador_config_collection_2', 1, '\"\"'),
('mirador_config_item', 1, '\"{\\r\\n    \\\"window\\\": {\\r\\n\\t    \\\"imageToolsEnabled\\\": true,\\r\\n\\t\\t\\\"imageToolsOpen\\\": true\\r\\n    },\\r\\n    \\\"thumbnailNavigation\\\": {\\r\\n        \\\"defaultPosition\\\": \\\"far-bottom\\\",\\r\\n        \\\"displaySettings\\\": true\\r\\n    },\\r\\n}\"'),
('mirador_config_item_2', 1, '\"\"'),
('mirador_plugins', 1, '[\"annotations\",\"dl\",\"image-tools\",\"ocr-helper\",\"share\"]'),
('mirador_plugins_2', 1, '[]'),
('mirador_preselected_items', 1, '\"0\"'),
('mirador_skip_default_css', 1, '\"0\"'),
('mirador_version', 1, '\"3\"'),
('pdfviewer', 1, '{\"pdfviewer_template\":\"common\\/pdf-viewer\"}'),
('pdfviewer_template', 1, '\"common\\/pdf-viewer\"'),
('property_label_information', 1, '\"none\"'),
('search_resource_names', 1, '[\"site_pages\",\"items\"]'),
('search_restrict_templates', 1, '\"0\"'),
('search_type', 1, '\"sitewide\"'),
('show_attached_pages', 1, '\"1\"'),
('show_locale_label', 1, '\"1\"'),
('show_page_pagination', 1, '\"1\"'),
('show_user_bar', 1, '\"0\"'),
('show_value_annotations', 1, '\"\"'),
('sitemaps_enableindex', 1, '\"0\"'),
('sitemaps_enablesitemap', 1, '\"1\"'),
('sitemaps_maxentries', 1, '\"500\"'),
('subnav_display', 1, '\"\"'),
('theme_settings_omekas-theme-um', 1, '{\"siteMainColor\":\"#920b0b\",\"UMLogoLink\":\"home\",\"logoRight\":\"\",\"logoFooter\":\"\",\"mainText\":\"Main text here.\",\"footer\":\"Powered by Omeka S\",\"footerBar\":\"Text for footerbar\",\"searchController\":\"find\",\"CustomFieldList\":\"modsrdf:name, modsrdf:subject, schema:dateIssued, schema:contributor, modsrdf:namePrincipal\",\"IiifViewer\":\"mirador\",\"cover_vh\":\"30\",\"highlight_Image_1\":\"\",\"highlight_Link_1\":\"\",\"highlight_Link_Text_1\":\"\",\"highlight_Image_2\":\"\",\"highlight_Link_2\":\"\",\"highlight_Link_Text_2\":\"\",\"highlight_Image_3\":\"\",\"highlight_Link_3\":\"\",\"highlight_Link_Text_3\":\"\",\"highlight_Image_4\":\"\",\"highlight_Link_4\":\"\",\"highlight_Link_Text_4\":\"\"}'),
('universalviewer_config', 1, '\"{}\"'),
('universalviewer_config_theme', 1, '\"0\"'),
('universalviewer_version', 1, '\"4\"'),
('vocabulary_scope', 1, '\"\"');

-- --------------------------------------------------------

--
-- Table structure for table `solr_core`
--

CREATE TABLE `solr_core` (
  `id` int NOT NULL,
  `name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `settings` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `solr_core`
--

INSERT INTO `solr_core` (`id`, `name`, `settings`) VALUES
(1, 'Default', '{\"support\":\"\",\"server_id\":\"\",\"resource_languages\":\"\",\"client\":{\"scheme\":\"http\",\"host\":\"omekas_solr\",\"port\":\"8983\",\"core\":\"omekas\",\"secure\":false,\"username\":\"\",\"password\":\"\",\"bypass_certificate_check\":\"0\",\"http_request_type\":\"post\"},\"query\":{\"minimum_match\":\"\",\"tie_breaker\":\"\"}}');

-- --------------------------------------------------------

--
-- Table structure for table `solr_map`
--

CREATE TABLE `solr_map` (
  `id` int NOT NULL,
  `solr_core_id` int NOT NULL,
  `resource_name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `field_name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `source` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `alias` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `pool` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json)',
  `settings` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `solr_map`
--

INSERT INTO `solr_map` (`id`, `solr_core_id`, `resource_name`, `field_name`, `source`, `alias`, `pool`, `settings`) VALUES
(1, 1, 'generic', 'resource_name_s', 'resource_name', 'resource_name', '[]', '{\"formatter\":\"text\",\"label\":\"Resource type\",\"parts\":{\"1\":\"main\"}}'),
(2, 1, 'generic', 'is_public_b', 'is_public', 'is_public', '[]', '{\"formatter\":\"text\",\"label\":\"Public\",\"parts\":{\"1\":\"main\"}}'),
(3, 1, 'generic', 'owner_id_i', 'owner/o:id', 'owner_id', '[]', '{\"formatter\":\"text\",\"parts\":{\"1\":\"main\"}}'),
(4, 1, 'generic', 'site_id_is', 'site/o:id', 'site_id', '[]', '{\"formatter\":\"text\",\"parts\":{\"1\":\"main\"}}'),
(5, 1, 'resources', 'resource_class_s', 'resource_class/o:term', 'resource_class_term', '[]', '{\"formatter\":\"text\",\"label\":\"Resource class\",\"parts\":{\"1\":\"main\"}}'),
(6, 1, 'resources', 'resource_template_s', 'resource_template/o:label', 'resource_template_label', '[]', '{\"formatter\":\"text\",\"label\":\"Resource template\",\"parts\":{\"1\":\"main\"}}'),
(7, 1, 'resources', 'title_s', 'o:title', 'title', '[]', '{\"formatter\":\"text\",\"label\":\"Title\",\"parts\":{\"1\":\"main\"}}'),
(8, 1, 'resources', 'dcterms_title_txt', 'dcterms:title', NULL, '[]', '{\"formatter\":\"text\",\"label\":\"Title\",\"parts\":{\"1\":\"main\"}}'),
(9, 1, 'resources', 'dcterms_creator_txt', 'dcterms:creator', NULL, '[]', '{\"formatter\":\"text\",\"label\":\"Creator\",\"parts\":{\"1\":\"main\"}}'),
(10, 1, 'resources', 'dcterms_subject_txt', 'dcterms:subject', NULL, '[]', '{\"formatter\":\"text\",\"label\":\"Subject\",\"parts\":{\"1\":\"main\"}}'),
(11, 1, 'resources', 'dcterms_description_txt', 'dcterms:description', NULL, '[]', '{\"formatter\":\"text\",\"label\":\"Description\",\"parts\":{\"1\":\"main\"}}'),
(12, 1, 'resources', 'dcterms_publisher_txt', 'dcterms:publisher', NULL, '[]', '{\"formatter\":\"text\",\"label\":\"Publisher\",\"parts\":{\"1\":\"main\"}}'),
(13, 1, 'items', 'dcterms_contributor_txt', 'dcterms:contributor', NULL, '[]', '{\"formatter\":\"text\",\"label\":\"Contributor\",\"parts\":{\"1\":\"main\"}}'),
(14, 1, 'resources', 'dcterms_date_txt', 'dcterms:date', NULL, '[]', '{\"formatter\":\"text\",\"label\":\"Date\",\"parts\":{\"1\":\"main\"}}'),
(15, 1, 'resources', 'dcterms_type_txt', 'dcterms:type', NULL, '[]', '{\"formatter\":\"text\",\"label\":\"Type\",\"parts\":{\"1\":\"main\"}}'),
(16, 1, 'resources', 'dcterms_format_txt', 'dcterms:format', NULL, '[]', '{\"formatter\":\"text\",\"label\":\"Format\",\"parts\":{\"1\":\"main\"}}'),
(17, 1, 'resources', 'dcterms_identifier_txt', 'dcterms:identifier', NULL, '[]', '{\"formatter\":\"text\",\"label\":\"Identifier\",\"parts\":{\"1\":\"main\"}}'),
(18, 1, 'resources', 'dcterms_source_txt', 'dcterms:source', NULL, '[]', '{\"formatter\":\"text\",\"label\":\"Source\",\"parts\":{\"1\":\"main\"}}'),
(19, 1, 'resources', 'dcterms_language_txt', 'dcterms:language', NULL, '[]', '{\"formatter\":\"text\",\"label\":\"Language\",\"parts\":{\"1\":\"main\"}}'),
(20, 1, 'resources', 'dcterms_relation_txt', 'dcterms:relation', NULL, '[]', '{\"formatter\":\"text\",\"label\":\"Relation\",\"parts\":{\"1\":\"main\"}}'),
(21, 1, 'resources', 'dcterms_coverage_txt', 'dcterms:coverage', NULL, '[]', '{\"formatter\":\"text\",\"label\":\"Coverage\",\"parts\":{\"1\":\"main\"}}'),
(22, 1, 'resources', 'dcterms_rights_txt', 'dcterms:rights', NULL, '[]', '{\"formatter\":\"text\",\"label\":\"Rights\",\"parts\":{\"1\":\"main\"}}'),
(23, 1, 'resources', 'dcterms_spatial_txt', 'dcterms:spatial', NULL, '[]', '{\"formatter\":\"text\",\"label\":\"Spatial coverage\",\"parts\":{\"1\":\"main\"}}'),
(24, 1, 'resources', 'dcterms_temporal_txt', 'dcterms:temporal', NULL, '[]', '{\"formatter\":\"text\",\"label\":\"Temporal coverage\",\"parts\":{\"1\":\"main\"}}'),
(25, 1, 'resources', 'dcterms_spatial_ss', 'dcterms:spatial', NULL, '[]', '{\"formatter\":\"text\",\"label\":\"Spatial coverage\",\"parts\":{\"1\":\"main\"}}'),
(26, 1, 'resources', 'dcterms_temporal_dr', 'dcterms:temporal', NULL, '[]', '{\"formatter\":\"date_range\",\"label\":\"Temporal coverage\",\"normalization\":[],\"parts\":[\"main\"]}'),
(27, 1, 'resources', 'dcterms_type_ss', 'dcterms:type', NULL, '[]', '{\"formatter\":\"text\",\"label\":\"Type\",\"parts\":{\"1\":\"main\"}}'),
(28, 1, 'resources', 'dcterms_subject_ss', 'dcterms:subject', NULL, '[]', '{\"formatter\":\"text\",\"label\":\"Subject\",\"parts\":{\"1\":\"main\"}}'),
(29, 1, 'resources', 'dcterms_creator_ss', 'dcterms:creator', NULL, '[]', '{\"formatter\":\"text\",\"label\":\"Creator\",\"parts\":{\"1\":\"main\"}}'),
(30, 1, 'resources', 'dcterms_publisher_ss', 'dcterms:publisher', NULL, '[]', '{\"formatter\":\"text\",\"label\":\"Publisher\",\"parts\":{\"1\":\"main\"}}'),
(31, 1, 'resources', 'dcterms_language_ss', 'dcterms:language', NULL, '[]', '{\"formatter\":\"text\",\"label\":\"Language\",\"parts\":{\"1\":\"main\"}}'),
(32, 1, 'resources', 'dcterms_rights_ss', 'dcterms:rights', NULL, '[]', '{\"formatter\":\"text\",\"label\":\"Rights\",\"parts\":{\"1\":\"main\"}}'),
(33, 1, 'resources', 'item_set_dcterms_title_ss', 'item_set/dcterms:title', NULL, '[]', '{\"formatter\":\"text\",\"label\":\"Item Set\",\"parts\":{\"1\":\"main\"}}'),
(34, 1, 'resources', 'dcterms_title_s', 'dcterms:title', NULL, '[]', '{\"formatter\":\"text\",\"label\":\"Title\",\"parts\":{\"1\":\"main\"}}'),
(35, 1, 'resources', 'dcterms_date_s', 'dcterms:date', NULL, '[]', '{\"formatter\":\"text\",\"label\":\"Date\",\"parts\":{\"1\":\"main\"}}'),
(36, 1, 'resources', 'dcterms_creator_s', 'dcterms:creator', NULL, '[]', '{\"formatter\":\"text\",\"label\":\"Creator\",\"parts\":{\"1\":\"main\"}}'),
(37, 1, 'items', 'item_set_id_is', 'item_set/o:id', 'item_set_id', '[]', '{\"formatter\":\"text\",\"label\":\"Item set id\",\"parts\":{\"1\":\"main\"}}'),
(38, 1, 'generic', 'id_i', 'o:id', 'id', '[]', '{\"formatter\":\"text\",\"parts\":{\"1\":\"main\"}}'),
(39, 1, 'generic', 'name_s', 'o:title', 'name', '[]', '{\"formatter\":\"text\",\"parts\":{\"1\":\"main\"}}');

-- --------------------------------------------------------

--
-- Table structure for table `stat`
--

CREATE TABLE `stat` (
  `id` int NOT NULL,
  `type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(1024) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `entity_id` int NOT NULL,
  `entity_name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `hits` int NOT NULL,
  `hits_anonymous` int NOT NULL,
  `hits_identified` int NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `stat`
--

INSERT INTO `stat` (`id`, `type`, `url`, `entity_id`, `entity_name`, `hits`, `hits_anonymous`, `hits_identified`, `created`, `modified`) VALUES
(1, 'page', '/', 0, '', 15, 11, 4, '2024-03-26 13:43:37', '2026-03-06 16:13:55'),
(2, 'page', '/s/default/item', 0, '', 3, 0, 3, '2024-04-15 12:33:56', '2024-04-15 12:34:19'),
(3, 'page', '/s/default/item/1', 1, 'items', 1, 0, 1, '2024-04-15 12:34:18', '2024-04-15 12:34:18'),
(4, 'resource', '/s/default/item/1', 1, 'items', 1, 0, 1, '2024-04-15 12:34:18', '2024-04-15 12:34:18'),
(5, 'page', '/s/default', 0, '', 3, 0, 3, '2024-10-08 13:36:04', '2025-07-10 14:52:21'),
(6, 'page', '/s/default/page/welcome', 1, 'site_pages', 4, 0, 4, '2024-10-08 13:36:04', '2025-07-10 14:52:39'),
(7, 'resource', '/s/default/page/welcome', 1, 'site_pages', 4, 0, 4, '2024-10-08 13:36:04', '2025-07-10 14:52:39'),
(8, 'page', '/s/default/sitemap.xml', 0, '', 4, 0, 4, '2024-10-08 13:36:11', '2024-10-08 13:41:32'),
(9, 'page', '/s/default/sitemapindex.xml', 0, '', 3, 0, 3, '2024-10-08 13:38:53', '2024-10-08 13:41:32'),
(10, 'page', '/s/default/find', 0, '', 2, 0, 2, '2025-07-10 14:52:40', '2025-07-10 14:52:48'),
(11, 'page', '/s/index', 0, '', 3, 1, 2, '2025-07-10 14:56:35', '2026-03-06 11:23:00'),
(12, 'page', '/s/index/page/welcome', 1, 'site_pages', 4, 1, 3, '2025-07-10 14:56:35', '2026-03-06 11:23:00'),
(13, 'resource', '/s/index/page/welcome', 1, 'site_pages', 4, 1, 3, '2025-07-10 14:56:35', '2026-03-06 11:23:00'),
(14, 'page', '/s/index/find', 0, '', 5, 0, 5, '2025-07-10 14:56:39', '2025-12-09 10:50:44'),
(15, 'page', '/s/index/item/1', 1, 'items', 2, 0, 2, '2025-07-10 14:56:41', '2025-09-29 13:39:01'),
(16, 'resource', '/s/index/item/1', 1, 'items', 2, 0, 2, '2025-07-10 14:56:41', '2025-09-29 13:39:01'),
(17, 'page', '/s/index/item', 0, '', 2, 0, 2, '2025-09-29 13:38:59', '2025-09-29 13:39:03');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int NOT NULL,
  `email` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  `password_hash` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `role` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `email`, `name`, `created`, `modified`, `password_hash`, `role`, `is_active`) VALUES
(1, 'admin@example.org', 'Admin', '2023-02-15 15:44:23', '2023-02-23 19:08:52', '$2y$10$F6zoM/4CQP80t6rglGrpRuBNeuXEYRxUwz7ehD38Q9bCzlO4H1WcK', 'global_admin', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_setting`
--

CREATE TABLE `user_setting` (
  `id` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int NOT NULL,
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json_array)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_setting`
--

INSERT INTO `user_setting` (`id`, `user_id`, `value`) VALUES
('browse_defaults_admin_item_sets', 1, '{\"sort_by\":\"created\",\"sort_order\":\"desc\"}'),
('browse_defaults_admin_items', 1, '{\"sort_by\":\"created\",\"sort_order\":\"desc\"}'),
('browse_defaults_admin_media', 1, '{\"sort_by\":\"created\",\"sort_order\":\"desc\"}'),
('browse_defaults_admin_sites', 1, '{\"sort_by\":\"title\",\"sort_order\":\"asc\"}'),
('columns_admin_item_sets', 1, '[{\"type\":\"resource_class\",\"default\":null,\"header\":null},{\"type\":\"owner\",\"default\":null,\"header\":null},{\"type\":\"created\",\"default\":null,\"header\":null}]'),
('columns_admin_items', 1, '[{\"type\":\"resource_class\",\"default\":null,\"header\":null},{\"type\":\"owner\",\"default\":null,\"header\":null},{\"type\":\"created\",\"default\":null,\"header\":null}]'),
('columns_admin_media', 1, '[{\"type\":\"resource_class\",\"default\":null,\"header\":null},{\"type\":\"owner\",\"default\":null,\"header\":null},{\"type\":\"created\",\"default\":null,\"header\":null}]'),
('columns_admin_sites', 1, '[{\"type\":\"slug\",\"default\":null,\"header\":null},{\"type\":\"owner\",\"default\":null,\"header\":null},{\"type\":\"created\",\"default\":null,\"header\":null}]'),
('default_resource_template', 1, '\"\"'),
('locale', 1, '\"\"');

-- --------------------------------------------------------

--
-- Table structure for table `value`
--

CREATE TABLE `value` (
  `id` int NOT NULL,
  `resource_id` int NOT NULL,
  `property_id` int NOT NULL,
  `value_resource_id` int DEFAULT NULL,
  `type` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `lang` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value_annotation_id` int DEFAULT NULL,
  `value` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `uri` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `is_public` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `value`
--

INSERT INTO `value` (`id`, `resource_id`, `property_id`, `value_resource_id`, `type`, `lang`, `value_annotation_id`, `value`, `uri`, `is_public`) VALUES
(1, 1, 1, NULL, 'literal', NULL, NULL, 'First item', NULL, 1),
(2, 1, 4, NULL, 'literal', NULL, NULL, 'This is the first item in this Omeka instance. It was created during the Docker bootstrap phase.\nIt contains metadata, but no associated media files.', NULL, 1),
(4, 1, 10, NULL, 'literal', NULL, NULL, 'ark:/99999/a1apZs2', NULL, 1),
(5, 2, 1, NULL, 'literal', NULL, NULL, 'CC-Licenses Collection', NULL, 1),
(6, 2, 10, NULL, 'literal', NULL, NULL, 'ark:/99999/a12vpho', NULL, 1),
(7, 3, 48, NULL, 'literal', NULL, NULL, 'CC-BY-NC', NULL, 1),
(8, 3, 1, NULL, 'literal', NULL, NULL, 'Creative Common license - CC-BY-NC', NULL, 1),
(9, 3, 1639, NULL, 'uri', '', NULL, 'Creative Commons website', 'https://creativecommons.org/licenses/by-nc/4.0/', 1),
(10, 3, 1645, NULL, 'literal', NULL, NULL, 'You are free to:\nShare — copy and redistribute the material in any medium or format\nAdapt — remix, transform, and build upon the material\nThe licensor cannot revoke these freedoms as long as you follow the license terms.', NULL, 1),
(11, 3, 1646, NULL, 'literal', NULL, NULL, 'Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.\n\nNonCommercial — You may not use the material for commercial purposes.\n\nNo additional restrictions — You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.', NULL, 1),
(12, 3, 10, NULL, 'literal', NULL, NULL, 'ark:/99999/a1UAQRM', NULL, 1),
(13, 4, 48, NULL, 'literal', NULL, NULL, 'CC-BY', NULL, 1),
(14, 4, 1, NULL, 'literal', NULL, NULL, 'Creative Common license - CC-BY', NULL, 1),
(15, 4, 1639, NULL, 'uri', '', NULL, 'Creative Commons website', 'https://creativecommons.org/licenses/by/4.0/', 1),
(16, 4, 1645, NULL, 'literal', NULL, NULL, 'You are free to:\nShare — copy and redistribute the material in any medium or format\nAdapt — remix, transform, and build upon the material\nfor any purpose, even commercially.', NULL, 1),
(17, 4, 1646, NULL, 'literal', NULL, NULL, 'Under the following terms:\nAttribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.\n\nNo additional restrictions — You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.', NULL, 1),
(18, 4, 10, NULL, 'literal', NULL, NULL, 'ark:/99999/a1MGfH7', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `value_annotation`
--

CREATE TABLE `value_annotation` (
  `id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vocabulary`
--

CREATE TABLE `vocabulary` (
  `id` int NOT NULL,
  `owner_id` int DEFAULT NULL,
  `namespace_uri` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `prefix` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `vocabulary`
--

INSERT INTO `vocabulary` (`id`, `owner_id`, `namespace_uri`, `prefix`, `label`, `comment`) VALUES
(1, NULL, 'http://purl.org/dc/terms/', 'dcterms', 'Dublin Core', 'Basic resource metadata (DCMI Metadata Terms)'),
(2, NULL, 'http://purl.org/dc/dcmitype/', 'dctype', 'Dublin Core Type', 'Basic resource types (DCMI Type Vocabulary)'),
(3, NULL, 'http://purl.org/ontology/bibo/', 'bibo', 'Bibliographic Ontology', 'Bibliographic metadata (BIBO)'),
(4, NULL, 'http://xmlns.com/foaf/0.1/', 'foaf', 'Friend of a Friend', 'Relationships between people and organizations (FOAF)'),
(5, 1, 'http://omeka.org/s/vocabs/o-module-extracttext#', 'extracttext', 'Extract Text', NULL),
(7, 1, 'http://creativecommons.org/ns#', 'cc', 'Creative Commons', 'Downloaded from https://creativecommons.org/ns# -> and click on \'RDF Schema\'. Or use this direct URL https://creativecommons.org/schema.rdf'),
(10, 1, 'https://omeka.org/s/vocabs/curation/', 'curation', 'Curation', 'Generic and common properties that are useful in Omeka for the curation of resources. The use of more common or more precise ontologies is recommended when it is possible.');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `api_key`
--
ALTER TABLE `api_key`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_C912ED9D7E3C61F9` (`owner_id`);

--
-- Indexes for table `asset`
--
ALTER TABLE `asset`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_2AF5A5C5CC5DB90` (`storage_id`),
  ADD KEY `IDX_2AF5A5C7E3C61F9` (`owner_id`);

--
-- Indexes for table `bulk_export`
--
ALTER TABLE `bulk_export`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_625A30FDBE04EA9` (`job_id`),
  ADD KEY `IDX_625A30FDB4523DE5` (`exporter_id`),
  ADD KEY `IDX_625A30FD7E3C61F9` (`owner_id`);

--
-- Indexes for table `bulk_exporter`
--
ALTER TABLE `bulk_exporter`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_6093500B7E3C61F9` (`owner_id`);

--
-- Indexes for table `csvimport_entity`
--
ALTER TABLE `csvimport_entity`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_84D382F4BE04EA9` (`job_id`);

--
-- Indexes for table `csvimport_import`
--
ALTER TABLE `csvimport_import`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_17B50881BE04EA9` (`job_id`),
  ADD UNIQUE KEY `UNIQ_17B508814C276F75` (`undo_job_id`);

--
-- Indexes for table `custom_vocab`
--
ALTER TABLE `custom_vocab`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_8533D2A5EA750E8` (`label`),
  ADD KEY `IDX_8533D2A5960278D7` (`item_set_id`),
  ADD KEY `IDX_8533D2A57E3C61F9` (`owner_id`);

--
-- Indexes for table `fulltext_search`
--
ALTER TABLE `fulltext_search`
  ADD PRIMARY KEY (`id`,`resource`),
  ADD KEY `IDX_AA31FE4A7E3C61F9` (`owner_id`),
  ADD KEY `is_public` (`is_public`);
ALTER TABLE `fulltext_search` ADD FULLTEXT KEY `IDX_AA31FE4A2B36786B3B8BA7C7` (`title`,`text`);

--
-- Indexes for table `hit`
--
ALTER TABLE `hit`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_5AD22641F47645AE` (`url`),
  ADD KEY `IDX_5AD2264181257D5D` (`entity_id`),
  ADD KEY `IDX_5AD2264116EFC72D` (`entity_name`),
  ADD KEY `IDX_5AD2264181257D5D16EFC72D` (`entity_id`,`entity_name`),
  ADD KEY `IDX_5AD22641F6BD1646` (`site_id`),
  ADD KEY `IDX_5AD22641A76ED395` (`user_id`),
  ADD KEY `IDX_5AD22641A5E3B32D` (`ip`),
  ADD KEY `IDX_5AD22641ED646567` (`referrer`),
  ADD KEY `IDX_5AD22641C44967C5` (`user_agent`),
  ADD KEY `IDX_5AD22641C2F0CDFC` (`accept_language`),
  ADD KEY `IDX_5AD22641B23DB7B8` (`created`),
  ADD KEY `IDX_5AD22641D4DB71B5` (`language`);

--
-- Indexes for table `item`
--
ALTER TABLE `item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_1F1B251ECBE0B084` (`primary_media_id`);

--
-- Indexes for table `item_item_set`
--
ALTER TABLE `item_item_set`
  ADD PRIMARY KEY (`item_id`,`item_set_id`),
  ADD KEY `IDX_6D0C9625126F525E` (`item_id`),
  ADD KEY `IDX_6D0C9625960278D7` (`item_set_id`);

--
-- Indexes for table `item_set`
--
ALTER TABLE `item_set`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `item_site`
--
ALTER TABLE `item_site`
  ADD PRIMARY KEY (`item_id`,`site_id`),
  ADD KEY `IDX_A1734D1F126F525E` (`item_id`),
  ADD KEY `IDX_A1734D1FF6BD1646` (`site_id`);

--
-- Indexes for table `job`
--
ALTER TABLE `job`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_FBD8E0F87E3C61F9` (`owner_id`);

--
-- Indexes for table `log`
--
ALTER TABLE `log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_8F3F68C57E3C61F9` (`owner_id`),
  ADD KEY `IDX_8F3F68C5BE04EA9` (`job_id`),
  ADD KEY `IDX_8F3F68C5AEA34913` (`reference`),
  ADD KEY `IDX_8F3F68C5F660D16B` (`severity`),
  ADD KEY `IDX_8F3F68C5B23DB7B8` (`created`);

--
-- Indexes for table `media`
--
ALTER TABLE `media`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_6A2CA10C5CC5DB90` (`storage_id`),
  ADD KEY `IDX_6A2CA10C126F525E` (`item_id`),
  ADD KEY `item_position` (`item_id`,`position`),
  ADD KEY `ingester` (`ingester`),
  ADD KEY `renderer` (`renderer`),
  ADD KEY `media_type` (`media_type`),
  ADD KEY `extension` (`extension`);

--
-- Indexes for table `migration`
--
ALTER TABLE `migration`
  ADD PRIMARY KEY (`version`);

--
-- Indexes for table `module`
--
ALTER TABLE `module`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `numeric_data_types_duration`
--
ALTER TABLE `numeric_data_types_duration`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_E1B5FC6089329D25` (`resource_id`),
  ADD KEY `IDX_E1B5FC60549213EC` (`property_id`),
  ADD KEY `property_value` (`property_id`,`value`),
  ADD KEY `value` (`value`);

--
-- Indexes for table `numeric_data_types_integer`
--
ALTER TABLE `numeric_data_types_integer`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_6D39C79089329D25` (`resource_id`),
  ADD KEY `IDX_6D39C790549213EC` (`property_id`),
  ADD KEY `property_value` (`property_id`,`value`),
  ADD KEY `value` (`value`);

--
-- Indexes for table `numeric_data_types_interval`
--
ALTER TABLE `numeric_data_types_interval`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_7E2C936B89329D25` (`resource_id`),
  ADD KEY `IDX_7E2C936B549213EC` (`property_id`),
  ADD KEY `property_value` (`property_id`,`value`),
  ADD KEY `value` (`value`);

--
-- Indexes for table `numeric_data_types_timestamp`
--
ALTER TABLE `numeric_data_types_timestamp`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_7367AFAA89329D25` (`resource_id`),
  ADD KEY `IDX_7367AFAA549213EC` (`property_id`),
  ADD KEY `property_value` (`property_id`,`value`),
  ADD KEY `value` (`value`);

--
-- Indexes for table `password_creation`
--
ALTER TABLE `password_creation`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_C77917B4A76ED395` (`user_id`);

--
-- Indexes for table `property`
--
ALTER TABLE `property`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_8BF21CDEAD0E05F6623C14D5` (`vocabulary_id`,`local_name`),
  ADD KEY `IDX_8BF21CDE7E3C61F9` (`owner_id`),
  ADD KEY `IDX_8BF21CDEAD0E05F6` (`vocabulary_id`);

--
-- Indexes for table `resource`
--
ALTER TABLE `resource`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_BC91F4167E3C61F9` (`owner_id`),
  ADD KEY `IDX_BC91F416448CC1BD` (`resource_class_id`),
  ADD KEY `IDX_BC91F41616131EA` (`resource_template_id`),
  ADD KEY `IDX_BC91F416FDFF2E92` (`thumbnail_id`),
  ADD KEY `title` (`title`(190)),
  ADD KEY `idx_public_type_id_title` (`is_public`,`resource_type`,`id`,`title`(190)),
  ADD KEY `is_public` (`is_public`);

--
-- Indexes for table `resource_class`
--
ALTER TABLE `resource_class`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_C6F063ADAD0E05F6623C14D5` (`vocabulary_id`,`local_name`),
  ADD KEY `IDX_C6F063AD7E3C61F9` (`owner_id`),
  ADD KEY `IDX_C6F063ADAD0E05F6` (`vocabulary_id`);

--
-- Indexes for table `resource_meta_resource_template_meta_names`
--
ALTER TABLE `resource_meta_resource_template_meta_names`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_E4071E6A16131EA2A6B767B` (`resource_template_id`,`resource_template_property_id`),
  ADD KEY `IDX_E4071E6A16131EA` (`resource_template_id`),
  ADD KEY `IDX_E4071E6A2A6B767B` (`resource_template_property_id`);

--
-- Indexes for table `resource_template`
--
ALTER TABLE `resource_template`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_39ECD52EEA750E8` (`label`),
  ADD KEY `IDX_39ECD52E7E3C61F9` (`owner_id`),
  ADD KEY `IDX_39ECD52E448CC1BD` (`resource_class_id`),
  ADD KEY `IDX_39ECD52E724734A3` (`title_property_id`),
  ADD KEY `IDX_39ECD52EB84E0D1D` (`description_property_id`);

--
-- Indexes for table `resource_template_property`
--
ALTER TABLE `resource_template_property`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_4689E2F116131EA549213EC` (`resource_template_id`,`property_id`),
  ADD KEY `IDX_4689E2F116131EA` (`resource_template_id`),
  ADD KEY `IDX_4689E2F1549213EC` (`property_id`);

--
-- Indexes for table `search_config`
--
ALTER TABLE `search_config`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_D684063E78C9C0A` (`engine_id`);

--
-- Indexes for table `search_engine`
--
ALTER TABLE `search_engine`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `search_suggester`
--
ALTER TABLE `search_suggester`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_F64D915AE78C9C0A` (`engine_id`);

--
-- Indexes for table `search_suggestion`
--
ALTER TABLE `search_suggestion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_536C3D170913F08` (`suggester_id`),
  ADD KEY `search_text_idx` (`text`,`suggester_id`);
ALTER TABLE `search_suggestion` ADD FULLTEXT KEY `IDX_536C3D13B8BA7C7` (`text`);

--
-- Indexes for table `session`
--
ALTER TABLE `session`
  ADD PRIMARY KEY (`id`),
  ADD KEY `modified` (`modified`);

--
-- Indexes for table `setting`
--
ALTER TABLE `setting`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `site`
--
ALTER TABLE `site`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_694309E4989D9B62` (`slug`),
  ADD UNIQUE KEY `UNIQ_694309E4571EDDA` (`homepage_id`),
  ADD KEY `IDX_694309E4FDFF2E92` (`thumbnail_id`),
  ADD KEY `IDX_694309E47E3C61F9` (`owner_id`);

--
-- Indexes for table `site_block_attachment`
--
ALTER TABLE `site_block_attachment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_236473FEE9ED820C` (`block_id`),
  ADD KEY `IDX_236473FE126F525E` (`item_id`),
  ADD KEY `IDX_236473FEEA9FDD75` (`media_id`),
  ADD KEY `block_position` (`block_id`,`position`);

--
-- Indexes for table `site_item_set`
--
ALTER TABLE `site_item_set`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_D4CE134F6BD1646960278D7` (`site_id`,`item_set_id`),
  ADD KEY `IDX_D4CE134F6BD1646` (`site_id`),
  ADD KEY `IDX_D4CE134960278D7` (`item_set_id`),
  ADD KEY `position` (`position`);

--
-- Indexes for table `site_page`
--
ALTER TABLE `site_page`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_2F900BD9F6BD1646989D9B62` (`site_id`,`slug`),
  ADD KEY `IDX_2F900BD9F6BD1646` (`site_id`),
  ADD KEY `is_public` (`is_public`);

--
-- Indexes for table `site_page_block`
--
ALTER TABLE `site_page_block`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_C593E731C4663E4` (`page_id`),
  ADD KEY `page_position` (`page_id`,`position`);

--
-- Indexes for table `site_permission`
--
ALTER TABLE `site_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_C0401D6FF6BD1646A76ED395` (`site_id`,`user_id`),
  ADD KEY `IDX_C0401D6FF6BD1646` (`site_id`),
  ADD KEY `IDX_C0401D6FA76ED395` (`user_id`);

--
-- Indexes for table `site_setting`
--
ALTER TABLE `site_setting`
  ADD PRIMARY KEY (`id`,`site_id`),
  ADD KEY `IDX_64D05A53F6BD1646` (`site_id`);

--
-- Indexes for table `solr_core`
--
ALTER TABLE `solr_core`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `solr_map`
--
ALTER TABLE `solr_map`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_39A565C527B35A19` (`solr_core_id`),
  ADD KEY `IDX_39A565C527B35A195103DEBC` (`solr_core_id`,`resource_name`),
  ADD KEY `IDX_39A565C527B35A194DEF17BC` (`solr_core_id`,`field_name`),
  ADD KEY `IDX_39A565C527B35A195F8A7F73` (`solr_core_id`,`source`);

--
-- Indexes for table `stat`
--
ALTER TABLE `stat`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_20B8FF218CDE5729F47645AE` (`type`,`url`(759)),
  ADD KEY `IDX_20B8FF218CDE5729` (`type`),
  ADD KEY `IDX_20B8FF21F47645AE` (`url`),
  ADD KEY `IDX_20B8FF2181257D5D` (`entity_id`),
  ADD KEY `IDX_20B8FF2116EFC72D` (`entity_name`),
  ADD KEY `IDX_20B8FF2181257D5D16EFC72D` (`entity_id`,`entity_name`),
  ADD KEY `IDX_20B8FF21B23DB7B8` (`created`),
  ADD KEY `IDX_20B8FF215F6B6CAC` (`modified`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_8D93D649E7927C74` (`email`);

--
-- Indexes for table `user_setting`
--
ALTER TABLE `user_setting`
  ADD PRIMARY KEY (`id`,`user_id`),
  ADD KEY `IDX_C779A692A76ED395` (`user_id`);

--
-- Indexes for table `value`
--
ALTER TABLE `value`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_1D7758349B66727E` (`value_annotation_id`),
  ADD KEY `IDX_1D77583489329D25` (`resource_id`),
  ADD KEY `IDX_1D775834549213EC` (`property_id`),
  ADD KEY `IDX_1D7758344BC72506` (`value_resource_id`),
  ADD KEY `value` (`value`(190)),
  ADD KEY `uri` (`uri`(190)),
  ADD KEY `idx_public_resource_property` (`is_public`,`resource_id`,`property_id`),
  ADD KEY `is_public` (`is_public`),
  ADD KEY `type` (`type`),
  ADD KEY `lang` (`lang`);

--
-- Indexes for table `value_annotation`
--
ALTER TABLE `value_annotation`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vocabulary`
--
ALTER TABLE `vocabulary`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_9099C97B9B267FDF` (`namespace_uri`),
  ADD UNIQUE KEY `UNIQ_9099C97B93B1868E` (`prefix`),
  ADD KEY `IDX_9099C97B7E3C61F9` (`owner_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `asset`
--
ALTER TABLE `asset`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bulk_export`
--
ALTER TABLE `bulk_export`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bulk_exporter`
--
ALTER TABLE `bulk_exporter`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `csvimport_entity`
--
ALTER TABLE `csvimport_entity`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `csvimport_import`
--
ALTER TABLE `csvimport_import`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `custom_vocab`
--
ALTER TABLE `custom_vocab`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `hit`
--
ALTER TABLE `hit`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `job`
--
ALTER TABLE `job`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `log`
--
ALTER TABLE `log`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `numeric_data_types_duration`
--
ALTER TABLE `numeric_data_types_duration`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `numeric_data_types_integer`
--
ALTER TABLE `numeric_data_types_integer`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `numeric_data_types_interval`
--
ALTER TABLE `numeric_data_types_interval`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `numeric_data_types_timestamp`
--
ALTER TABLE `numeric_data_types_timestamp`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `property`
--
ALTER TABLE `property`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2150;

--
-- AUTO_INCREMENT for table `resource`
--
ALTER TABLE `resource`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `resource_class`
--
ALTER TABLE `resource_class`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1281;

--
-- AUTO_INCREMENT for table `resource_meta_resource_template_meta_names`
--
ALTER TABLE `resource_meta_resource_template_meta_names`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `resource_template`
--
ALTER TABLE `resource_template`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `resource_template_property`
--
ALTER TABLE `resource_template_property`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=189;

--
-- AUTO_INCREMENT for table `search_config`
--
ALTER TABLE `search_config`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `search_engine`
--
ALTER TABLE `search_engine`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `search_suggester`
--
ALTER TABLE `search_suggester`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `search_suggestion`
--
ALTER TABLE `search_suggestion`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `site`
--
ALTER TABLE `site`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `site_block_attachment`
--
ALTER TABLE `site_block_attachment`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `site_item_set`
--
ALTER TABLE `site_item_set`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `site_page`
--
ALTER TABLE `site_page`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `site_page_block`
--
ALTER TABLE `site_page_block`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `site_permission`
--
ALTER TABLE `site_permission`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `solr_core`
--
ALTER TABLE `solr_core`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `solr_map`
--
ALTER TABLE `solr_map`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `stat`
--
ALTER TABLE `stat`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `value`
--
ALTER TABLE `value`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `vocabulary`
--
ALTER TABLE `vocabulary`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `api_key`
--
ALTER TABLE `api_key`
  ADD CONSTRAINT `FK_C912ED9D7E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`);

--
-- Constraints for table `asset`
--
ALTER TABLE `asset`
  ADD CONSTRAINT `FK_2AF5A5C7E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `bulk_export`
--
ALTER TABLE `bulk_export`
  ADD CONSTRAINT `FK_625A30FD7E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_625A30FDB4523DE5` FOREIGN KEY (`exporter_id`) REFERENCES `bulk_exporter` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_625A30FDBE04EA9` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `bulk_exporter`
--
ALTER TABLE `bulk_exporter`
  ADD CONSTRAINT `FK_6093500B7E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `csvimport_entity`
--
ALTER TABLE `csvimport_entity`
  ADD CONSTRAINT `FK_84D382F4BE04EA9` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`);

--
-- Constraints for table `csvimport_import`
--
ALTER TABLE `csvimport_import`
  ADD CONSTRAINT `FK_17B508814C276F75` FOREIGN KEY (`undo_job_id`) REFERENCES `job` (`id`),
  ADD CONSTRAINT `FK_17B50881BE04EA9` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`);

--
-- Constraints for table `custom_vocab`
--
ALTER TABLE `custom_vocab`
  ADD CONSTRAINT `FK_8533D2A57E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_8533D2A5960278D7` FOREIGN KEY (`item_set_id`) REFERENCES `item_set` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `fulltext_search`
--
ALTER TABLE `fulltext_search`
  ADD CONSTRAINT `FK_AA31FE4A7E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `item`
--
ALTER TABLE `item`
  ADD CONSTRAINT `FK_1F1B251EBF396750` FOREIGN KEY (`id`) REFERENCES `resource` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_1F1B251ECBE0B084` FOREIGN KEY (`primary_media_id`) REFERENCES `media` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `item_item_set`
--
ALTER TABLE `item_item_set`
  ADD CONSTRAINT `FK_6D0C9625126F525E` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_6D0C9625960278D7` FOREIGN KEY (`item_set_id`) REFERENCES `item_set` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `item_set`
--
ALTER TABLE `item_set`
  ADD CONSTRAINT `FK_1015EEEBF396750` FOREIGN KEY (`id`) REFERENCES `resource` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `item_site`
--
ALTER TABLE `item_site`
  ADD CONSTRAINT `FK_A1734D1F126F525E` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_A1734D1FF6BD1646` FOREIGN KEY (`site_id`) REFERENCES `site` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `job`
--
ALTER TABLE `job`
  ADD CONSTRAINT `FK_FBD8E0F87E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `log`
--
ALTER TABLE `log`
  ADD CONSTRAINT `FK_8F3F68C57E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_8F3F68C5BE04EA9` FOREIGN KEY (`job_id`) REFERENCES `job` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `media`
--
ALTER TABLE `media`
  ADD CONSTRAINT `FK_6A2CA10C126F525E` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`),
  ADD CONSTRAINT `FK_6A2CA10CBF396750` FOREIGN KEY (`id`) REFERENCES `resource` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `numeric_data_types_duration`
--
ALTER TABLE `numeric_data_types_duration`
  ADD CONSTRAINT `FK_E1B5FC60549213EC` FOREIGN KEY (`property_id`) REFERENCES `property` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_E1B5FC6089329D25` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `numeric_data_types_integer`
--
ALTER TABLE `numeric_data_types_integer`
  ADD CONSTRAINT `FK_6D39C790549213EC` FOREIGN KEY (`property_id`) REFERENCES `property` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_6D39C79089329D25` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `numeric_data_types_interval`
--
ALTER TABLE `numeric_data_types_interval`
  ADD CONSTRAINT `FK_7E2C936B549213EC` FOREIGN KEY (`property_id`) REFERENCES `property` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_7E2C936B89329D25` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `numeric_data_types_timestamp`
--
ALTER TABLE `numeric_data_types_timestamp`
  ADD CONSTRAINT `FK_7367AFAA549213EC` FOREIGN KEY (`property_id`) REFERENCES `property` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_7367AFAA89329D25` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `password_creation`
--
ALTER TABLE `password_creation`
  ADD CONSTRAINT `FK_C77917B4A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `property`
--
ALTER TABLE `property`
  ADD CONSTRAINT `FK_8BF21CDE7E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_8BF21CDEAD0E05F6` FOREIGN KEY (`vocabulary_id`) REFERENCES `vocabulary` (`id`);

--
-- Constraints for table `resource`
--
ALTER TABLE `resource`
  ADD CONSTRAINT `FK_BC91F41616131EA` FOREIGN KEY (`resource_template_id`) REFERENCES `resource_template` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_BC91F416448CC1BD` FOREIGN KEY (`resource_class_id`) REFERENCES `resource_class` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_BC91F4167E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_BC91F416FDFF2E92` FOREIGN KEY (`thumbnail_id`) REFERENCES `asset` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `resource_class`
--
ALTER TABLE `resource_class`
  ADD CONSTRAINT `FK_C6F063AD7E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_C6F063ADAD0E05F6` FOREIGN KEY (`vocabulary_id`) REFERENCES `vocabulary` (`id`);

--
-- Constraints for table `resource_meta_resource_template_meta_names`
--
ALTER TABLE `resource_meta_resource_template_meta_names`
  ADD CONSTRAINT `FK_E4071E6A16131EA` FOREIGN KEY (`resource_template_id`) REFERENCES `resource_template` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_E4071E6A2A6B767B` FOREIGN KEY (`resource_template_property_id`) REFERENCES `resource_template_property` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `resource_template`
--
ALTER TABLE `resource_template`
  ADD CONSTRAINT `FK_39ECD52E448CC1BD` FOREIGN KEY (`resource_class_id`) REFERENCES `resource_class` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_39ECD52E724734A3` FOREIGN KEY (`title_property_id`) REFERENCES `property` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_39ECD52E7E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_39ECD52EB84E0D1D` FOREIGN KEY (`description_property_id`) REFERENCES `property` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `resource_template_property`
--
ALTER TABLE `resource_template_property`
  ADD CONSTRAINT `FK_4689E2F116131EA` FOREIGN KEY (`resource_template_id`) REFERENCES `resource_template` (`id`),
  ADD CONSTRAINT `FK_4689E2F1549213EC` FOREIGN KEY (`property_id`) REFERENCES `property` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `search_config`
--
ALTER TABLE `search_config`
  ADD CONSTRAINT `FK_D684063E78C9C0A` FOREIGN KEY (`engine_id`) REFERENCES `search_engine` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `search_suggester`
--
ALTER TABLE `search_suggester`
  ADD CONSTRAINT `FK_F64D915AE78C9C0A` FOREIGN KEY (`engine_id`) REFERENCES `search_engine` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `search_suggestion`
--
ALTER TABLE `search_suggestion`
  ADD CONSTRAINT `FK_536C3D170913F08` FOREIGN KEY (`suggester_id`) REFERENCES `search_suggester` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `site`
--
ALTER TABLE `site`
  ADD CONSTRAINT `FK_694309E4571EDDA` FOREIGN KEY (`homepage_id`) REFERENCES `site_page` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_694309E47E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_694309E4FDFF2E92` FOREIGN KEY (`thumbnail_id`) REFERENCES `asset` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `site_block_attachment`
--
ALTER TABLE `site_block_attachment`
  ADD CONSTRAINT `FK_236473FE126F525E` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `FK_236473FEE9ED820C` FOREIGN KEY (`block_id`) REFERENCES `site_page_block` (`id`),
  ADD CONSTRAINT `FK_236473FEEA9FDD75` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `site_item_set`
--
ALTER TABLE `site_item_set`
  ADD CONSTRAINT `FK_D4CE134960278D7` FOREIGN KEY (`item_set_id`) REFERENCES `item_set` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_D4CE134F6BD1646` FOREIGN KEY (`site_id`) REFERENCES `site` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `site_page`
--
ALTER TABLE `site_page`
  ADD CONSTRAINT `FK_2F900BD9F6BD1646` FOREIGN KEY (`site_id`) REFERENCES `site` (`id`);

--
-- Constraints for table `site_page_block`
--
ALTER TABLE `site_page_block`
  ADD CONSTRAINT `FK_C593E731C4663E4` FOREIGN KEY (`page_id`) REFERENCES `site_page` (`id`);

--
-- Constraints for table `site_permission`
--
ALTER TABLE `site_permission`
  ADD CONSTRAINT `FK_C0401D6FA76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_C0401D6FF6BD1646` FOREIGN KEY (`site_id`) REFERENCES `site` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `site_setting`
--
ALTER TABLE `site_setting`
  ADD CONSTRAINT `FK_64D05A53F6BD1646` FOREIGN KEY (`site_id`) REFERENCES `site` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `solr_map`
--
ALTER TABLE `solr_map`
  ADD CONSTRAINT `FK_39A565C527B35A19` FOREIGN KEY (`solr_core_id`) REFERENCES `solr_core` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_setting`
--
ALTER TABLE `user_setting`
  ADD CONSTRAINT `FK_C779A692A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `value`
--
ALTER TABLE `value`
  ADD CONSTRAINT `FK_1D7758344BC72506` FOREIGN KEY (`value_resource_id`) REFERENCES `resource` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_1D775834549213EC` FOREIGN KEY (`property_id`) REFERENCES `property` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_1D77583489329D25` FOREIGN KEY (`resource_id`) REFERENCES `resource` (`id`),
  ADD CONSTRAINT `FK_1D7758349B66727E` FOREIGN KEY (`value_annotation_id`) REFERENCES `value_annotation` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `value_annotation`
--
ALTER TABLE `value_annotation`
  ADD CONSTRAINT `FK_C03BA4EBF396750` FOREIGN KEY (`id`) REFERENCES `resource` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `vocabulary`
--
ALTER TABLE `vocabulary`
  ADD CONSTRAINT `FK_9099C97B7E3C61F9` FOREIGN KEY (`owner_id`) REFERENCES `user` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
