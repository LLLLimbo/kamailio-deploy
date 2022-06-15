CREATE DATABASE `kamailio` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `kamailio`;
CREATE TABLE `acc` (
                       `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                       `method` varchar(16) NOT NULL DEFAULT '',
                       `from_tag` varchar(128) NOT NULL DEFAULT '',
                       `to_tag` varchar(128) NOT NULL DEFAULT '',
                       `callid` varchar(255) NOT NULL DEFAULT '',
                       `sip_code` varchar(3) NOT NULL DEFAULT '',
                       `sip_reason` varchar(128) NOT NULL DEFAULT '',
                       `time` datetime NOT NULL,
                       PRIMARY KEY (`id`),
                       KEY `callid_idx` (`callid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `acc_cdrs` (
                            `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                            `start_time` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
                            `end_time` datetime NOT NULL DEFAULT '2000-01-01 00:00:00',
                            `duration` float(10,3) NOT NULL DEFAULT '0.000',
  PRIMARY KEY (`id`),
  KEY `start_time_idx` (`start_time`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `active_watchers` (
                                   `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                                   `presentity_uri` varchar(255) NOT NULL,
                                   `watcher_username` varchar(64) NOT NULL,
                                   `watcher_domain` varchar(64) NOT NULL,
                                   `to_user` varchar(64) NOT NULL,
                                   `to_domain` varchar(64) NOT NULL,
                                   `event` varchar(64) NOT NULL DEFAULT 'presence',
                                   `event_id` varchar(64) DEFAULT NULL,
                                   `to_tag` varchar(128) NOT NULL,
                                   `from_tag` varchar(128) NOT NULL,
                                   `callid` varchar(255) NOT NULL,
                                   `local_cseq` int(11) NOT NULL,
                                   `remote_cseq` int(11) NOT NULL,
                                   `contact` varchar(255) NOT NULL,
                                   `record_route` text,
                                   `expires` int(11) NOT NULL,
                                   `status` int(11) NOT NULL DEFAULT '2',
                                   `reason` varchar(64) DEFAULT NULL,
                                   `version` int(11) NOT NULL DEFAULT '0',
                                   `socket_info` varchar(64) NOT NULL,
                                   `local_contact` varchar(255) NOT NULL,
                                   `from_user` varchar(64) NOT NULL,
                                   `from_domain` varchar(64) NOT NULL,
                                   `updated` int(11) NOT NULL,
                                   `updated_winfo` int(11) NOT NULL,
                                   `flags` int(11) NOT NULL DEFAULT '0',
                                   `user_agent` varchar(255) DEFAULT '',
                                   PRIMARY KEY (`id`),
                                   UNIQUE KEY `active_watchers_idx` (`callid`,`to_tag`,`from_tag`),
                                   KEY `active_watchers_expires` (`expires`),
                                   KEY `active_watchers_pres` (`presentity_uri`,`event`),
                                   KEY `updated_idx` (`updated`),
                                   KEY `updated_winfo_idx` (`updated_winfo`,`presentity_uri`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `address` (
                           `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                           `grp` int(11) unsigned NOT NULL DEFAULT '1',
                           `ip_addr` varchar(50) NOT NULL,
                           `mask` int(11) NOT NULL DEFAULT '32',
                           `port` smallint(5) unsigned NOT NULL DEFAULT '0',
                           `tag` varchar(64) DEFAULT NULL,
                           PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `aliases` (
                           `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                           `ruid` varchar(64) NOT NULL DEFAULT '',
                           `username` varchar(64) NOT NULL DEFAULT '',
                           `domain` varchar(64) DEFAULT NULL,
                           `contact` varchar(255) NOT NULL DEFAULT '',
                           `received` varchar(255) DEFAULT NULL,
                           `path` varchar(512) DEFAULT NULL,
                           `expires` datetime NOT NULL DEFAULT '2030-05-28 21:32:15',
                           `q` float(10,2) NOT NULL DEFAULT '1.00',
  `callid` varchar(255) NOT NULL DEFAULT 'Default-Call-ID',
  `cseq` int(11) NOT NULL DEFAULT '1',
  `last_modified` datetime NOT NULL DEFAULT '2000-01-01 00:00:01',
  `flags` int(11) NOT NULL DEFAULT '0',
  `cflags` int(11) NOT NULL DEFAULT '0',
  `user_agent` varchar(255) NOT NULL DEFAULT '',
  `socket` varchar(64) DEFAULT NULL,
  `methods` int(11) DEFAULT NULL,
  `instance` varchar(255) DEFAULT NULL,
  `reg_id` int(11) NOT NULL DEFAULT '0',
  `server_id` int(11) NOT NULL DEFAULT '0',
  `connection_id` int(11) NOT NULL DEFAULT '0',
  `keepalive` int(11) NOT NULL DEFAULT '0',
  `partition` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ruid_idx` (`ruid`),
  KEY `account_contact_idx` (`username`,`domain`,`contact`),
  KEY `expires_idx` (`expires`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `carrier_name` (
                                `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                                `carrier` varchar(64) DEFAULT NULL,
                                PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `carrierfailureroute` (
                                       `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                                       `carrier` int(10) unsigned NOT NULL DEFAULT '0',
                                       `domain` int(10) unsigned NOT NULL DEFAULT '0',
                                       `scan_prefix` varchar(64) NOT NULL DEFAULT '',
                                       `host_name` varchar(255) NOT NULL DEFAULT '',
                                       `reply_code` varchar(3) NOT NULL DEFAULT '',
                                       `flags` int(11) unsigned NOT NULL DEFAULT '0',
                                       `mask` int(11) unsigned NOT NULL DEFAULT '0',
                                       `next_domain` int(10) unsigned NOT NULL DEFAULT '0',
                                       `description` varchar(255) DEFAULT NULL,
                                       PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `carrierroute` (
                                `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                                `carrier` int(10) unsigned NOT NULL DEFAULT '0',
                                `domain` int(10) unsigned NOT NULL DEFAULT '0',
                                `scan_prefix` varchar(64) NOT NULL DEFAULT '',
                                `flags` int(11) unsigned NOT NULL DEFAULT '0',
                                `mask` int(11) unsigned NOT NULL DEFAULT '0',
                                `prob` float NOT NULL DEFAULT '0',
                                `strip` int(11) unsigned NOT NULL DEFAULT '0',
                                `rewrite_host` varchar(255) NOT NULL DEFAULT '',
                                `rewrite_prefix` varchar(64) NOT NULL DEFAULT '',
                                `rewrite_suffix` varchar(64) NOT NULL DEFAULT '',
                                `description` varchar(255) DEFAULT NULL,
                                PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `cpl` (
                       `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                       `username` varchar(64) NOT NULL,
                       `domain` varchar(64) NOT NULL DEFAULT '',
                       `cpl_xml` text,
                       `cpl_bin` text,
                       PRIMARY KEY (`id`),
                       UNIQUE KEY `account_idx` (`username`,`domain`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `dbaliases` (
                             `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                             `alias_username` varchar(64) NOT NULL DEFAULT '',
                             `alias_domain` varchar(64) NOT NULL DEFAULT '',
                             `username` varchar(64) NOT NULL DEFAULT '',
                             `domain` varchar(64) NOT NULL DEFAULT '',
                             PRIMARY KEY (`id`),
                             KEY `alias_user_idx` (`alias_username`),
                             KEY `alias_idx` (`alias_username`,`alias_domain`),
                             KEY `target_idx` (`username`,`domain`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `dialog` (
                          `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                          `hash_entry` int(10) unsigned NOT NULL,
                          `hash_id` int(10) unsigned NOT NULL,
                          `callid` varchar(255) NOT NULL,
                          `from_uri` varchar(255) NOT NULL,
                          `from_tag` varchar(128) NOT NULL,
                          `to_uri` varchar(255) NOT NULL,
                          `to_tag` varchar(128) NOT NULL,
                          `caller_cseq` varchar(20) NOT NULL,
                          `callee_cseq` varchar(20) NOT NULL,
                          `caller_route_set` varchar(512) DEFAULT NULL,
                          `callee_route_set` varchar(512) DEFAULT NULL,
                          `caller_contact` varchar(255) NOT NULL,
                          `callee_contact` varchar(255) NOT NULL,
                          `caller_sock` varchar(64) NOT NULL,
                          `callee_sock` varchar(64) NOT NULL,
                          `state` int(10) unsigned NOT NULL,
                          `start_time` int(10) unsigned NOT NULL,
                          `timeout` int(10) unsigned NOT NULL DEFAULT '0',
                          `sflags` int(10) unsigned NOT NULL DEFAULT '0',
                          `iflags` int(10) unsigned NOT NULL DEFAULT '0',
                          `toroute_name` varchar(32) DEFAULT NULL,
                          `req_uri` varchar(255) NOT NULL,
                          `xdata` varchar(512) DEFAULT NULL,
                          PRIMARY KEY (`id`),
                          KEY `hash_idx` (`hash_entry`,`hash_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `dialog_vars` (
                               `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                               `hash_entry` int(10) unsigned NOT NULL,
                               `hash_id` int(10) unsigned NOT NULL,
                               `dialog_key` varchar(128) NOT NULL,
                               `dialog_value` varchar(512) NOT NULL,
                               PRIMARY KEY (`id`),
                               KEY `hash_idx` (`hash_entry`,`hash_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `dialplan` (
                            `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                            `dpid` int(11) NOT NULL,
                            `pr` int(11) NOT NULL,
                            `match_op` int(11) NOT NULL,
                            `match_exp` varchar(64) NOT NULL,
                            `match_len` int(11) NOT NULL,
                            `subst_exp` varchar(64) NOT NULL,
                            `repl_exp` varchar(256) NOT NULL,
                            `attrs` varchar(64) NOT NULL,
                            PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `dispatcher` (
                              `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                              `setid` int(11) NOT NULL DEFAULT '0',
                              `destination` varchar(192) NOT NULL DEFAULT '',
                              `flags` int(11) NOT NULL DEFAULT '0',
                              `priority` int(11) NOT NULL DEFAULT '0',
                              `attrs` varchar(128) NOT NULL DEFAULT '',
                              `description` varchar(64) NOT NULL DEFAULT '',
                              PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `domain` (
                          `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                          `domain` varchar(64) NOT NULL,
                          `did` varchar(64) DEFAULT NULL,
                          `last_modified` datetime NOT NULL DEFAULT '2000-01-01 00:00:01',
                          PRIMARY KEY (`id`),
                          UNIQUE KEY `domain_idx` (`domain`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `domain_attrs` (
                                `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                                `did` varchar(64) NOT NULL,
                                `name` varchar(32) NOT NULL,
                                `type` int(10) unsigned NOT NULL,
                                `value` varchar(255) NOT NULL,
                                `last_modified` datetime NOT NULL DEFAULT '2000-01-01 00:00:01',
                                PRIMARY KEY (`id`),
                                KEY `domain_attrs_idx` (`did`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `domain_name` (
                               `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                               `domain` varchar(64) DEFAULT NULL,
                               PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `domainpolicy` (
                                `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                                `rule` varchar(255) NOT NULL,
                                `type` varchar(255) NOT NULL,
                                `att` varchar(255) DEFAULT NULL,
                                `val` varchar(128) DEFAULT NULL,
                                `description` varchar(255) NOT NULL,
                                PRIMARY KEY (`id`),
                                UNIQUE KEY `rav_idx` (`rule`,`att`,`val`),
                                KEY `rule_idx` (`rule`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `dr_gateways` (
                               `gwid` int(10) unsigned NOT NULL AUTO_INCREMENT,
                               `type` int(11) unsigned NOT NULL DEFAULT '0',
                               `address` varchar(128) NOT NULL,
                               `strip` int(11) unsigned NOT NULL DEFAULT '0',
                               `pri_prefix` varchar(64) DEFAULT NULL,
                               `attrs` varchar(255) DEFAULT NULL,
                               `description` varchar(128) NOT NULL DEFAULT '',
                               PRIMARY KEY (`gwid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `dr_groups` (
                             `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                             `username` varchar(64) NOT NULL,
                             `domain` varchar(128) NOT NULL DEFAULT '',
                             `groupid` int(11) unsigned NOT NULL DEFAULT '0',
                             `description` varchar(128) NOT NULL DEFAULT '',
                             PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `dr_gw_lists` (
                               `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                               `gwlist` varchar(255) NOT NULL,
                               `description` varchar(128) NOT NULL DEFAULT '',
                               PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `dr_rules` (
                            `ruleid` int(10) unsigned NOT NULL AUTO_INCREMENT,
                            `groupid` varchar(255) NOT NULL,
                            `prefix` varchar(64) NOT NULL,
                            `timerec` varchar(255) NOT NULL,
                            `priority` int(11) NOT NULL DEFAULT '0',
                            `routeid` varchar(64) NOT NULL,
                            `gwlist` varchar(255) NOT NULL,
                            `description` varchar(128) NOT NULL DEFAULT '',
                            PRIMARY KEY (`ruleid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `globalblocklist` (
                                   `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                                   `prefix` varchar(64) NOT NULL DEFAULT '',
                                   `allowlist` tinyint(1) NOT NULL DEFAULT '0',
                                   `description` varchar(255) DEFAULT NULL,
                                   PRIMARY KEY (`id`),
                                   KEY `globalblocklist_idx` (`prefix`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `grp` (
                       `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                       `username` varchar(64) NOT NULL DEFAULT '',
                       `domain` varchar(64) NOT NULL DEFAULT '',
                       `grp` varchar(64) NOT NULL DEFAULT '',
                       `last_modified` datetime NOT NULL DEFAULT '2000-01-01 00:00:01',
                       PRIMARY KEY (`id`),
                       UNIQUE KEY `account_group_idx` (`username`,`domain`,`grp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `htable` (
                          `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                          `key_name` varchar(64) NOT NULL DEFAULT '',
                          `key_type` int(11) NOT NULL DEFAULT '0',
                          `value_type` int(11) NOT NULL DEFAULT '0',
                          `key_value` varchar(128) NOT NULL DEFAULT '',
                          `expires` int(11) NOT NULL DEFAULT '0',
                          PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `imc_members` (
                               `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                               `username` varchar(64) NOT NULL,
                               `domain` varchar(64) NOT NULL,
                               `room` varchar(64) NOT NULL,
                               `flag` int(11) NOT NULL,
                               PRIMARY KEY (`id`),
                               UNIQUE KEY `account_room_idx` (`username`,`domain`,`room`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `imc_rooms` (
                             `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                             `name` varchar(64) NOT NULL,
                             `domain` varchar(64) NOT NULL,
                             `flag` int(11) NOT NULL,
                             PRIMARY KEY (`id`),
                             UNIQUE KEY `name_domain_idx` (`name`,`domain`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `lcr_gw` (
                          `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                          `lcr_id` smallint(5) unsigned NOT NULL,
                          `gw_name` varchar(128) DEFAULT NULL,
                          `ip_addr` varchar(50) DEFAULT NULL,
                          `hostname` varchar(64) DEFAULT NULL,
                          `port` smallint(5) unsigned DEFAULT NULL,
                          `params` varchar(64) DEFAULT NULL,
                          `uri_scheme` tinyint(3) unsigned DEFAULT NULL,
                          `transport` tinyint(3) unsigned DEFAULT NULL,
                          `strip` tinyint(3) unsigned DEFAULT NULL,
                          `prefix` varchar(16) DEFAULT NULL,
                          `tag` varchar(64) DEFAULT NULL,
                          `flags` int(10) unsigned NOT NULL DEFAULT '0',
                          `defunct` int(10) unsigned DEFAULT NULL,
                          PRIMARY KEY (`id`),
                          KEY `lcr_id_idx` (`lcr_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `lcr_rule` (
                            `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                            `lcr_id` smallint(5) unsigned NOT NULL,
                            `prefix` varchar(16) DEFAULT NULL,
                            `from_uri` varchar(64) DEFAULT NULL,
                            `request_uri` varchar(64) DEFAULT NULL,
                            `mt_tvalue` varchar(128) DEFAULT NULL,
                            `stopper` int(10) unsigned NOT NULL DEFAULT '0',
                            `enabled` int(10) unsigned NOT NULL DEFAULT '1',
                            PRIMARY KEY (`id`),
                            UNIQUE KEY `lcr_id_prefix_from_uri_idx` (`lcr_id`,`prefix`,`from_uri`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `lcr_rule_target` (
                                   `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                                   `lcr_id` smallint(5) unsigned NOT NULL,
                                   `rule_id` int(10) unsigned NOT NULL,
                                   `gw_id` int(10) unsigned NOT NULL,
                                   `priority` tinyint(3) unsigned NOT NULL,
                                   `weight` int(10) unsigned NOT NULL DEFAULT '1',
                                   PRIMARY KEY (`id`),
                                   UNIQUE KEY `rule_id_gw_id_idx` (`rule_id`,`gw_id`),
                                   KEY `lcr_id_idx` (`lcr_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `location` (
                            `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                            `ruid` varchar(64) NOT NULL DEFAULT '',
                            `username` varchar(64) NOT NULL DEFAULT '',
                            `domain` varchar(64) DEFAULT NULL,
                            `contact` varchar(512) NOT NULL DEFAULT '',
                            `received` varchar(128) DEFAULT NULL,
                            `path` varchar(512) DEFAULT NULL,
                            `expires` datetime NOT NULL DEFAULT '2030-05-28 21:32:15',
                            `q` float(10,2) NOT NULL DEFAULT '1.00',
  `callid` varchar(255) NOT NULL DEFAULT 'Default-Call-ID',
  `cseq` int(11) NOT NULL DEFAULT '1',
  `last_modified` datetime NOT NULL DEFAULT '2000-01-01 00:00:01',
  `flags` int(11) NOT NULL DEFAULT '0',
  `cflags` int(11) NOT NULL DEFAULT '0',
  `user_agent` varchar(255) NOT NULL DEFAULT '',
  `socket` varchar(64) DEFAULT NULL,
  `methods` int(11) DEFAULT NULL,
  `instance` varchar(255) DEFAULT NULL,
  `reg_id` int(11) NOT NULL DEFAULT '0',
  `server_id` int(11) NOT NULL DEFAULT '0',
  `connection_id` int(11) NOT NULL DEFAULT '0',
  `keepalive` int(11) NOT NULL DEFAULT '0',
  `partition` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `ruid_idx` (`ruid`),
  KEY `account_contact_idx` (`username`,`domain`,`contact`),
  KEY `expires_idx` (`expires`),
  KEY `connection_idx` (`server_id`,`connection_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `location_attrs` (
                                  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                                  `ruid` varchar(64) NOT NULL DEFAULT '',
                                  `username` varchar(64) NOT NULL DEFAULT '',
                                  `domain` varchar(64) DEFAULT NULL,
                                  `aname` varchar(64) NOT NULL DEFAULT '',
                                  `atype` int(11) NOT NULL DEFAULT '0',
                                  `avalue` varchar(512) NOT NULL DEFAULT '',
                                  `last_modified` datetime NOT NULL DEFAULT '2000-01-01 00:00:01',
                                  PRIMARY KEY (`id`),
                                  KEY `account_record_idx` (`username`,`domain`,`ruid`),
                                  KEY `last_modified_idx` (`last_modified`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `missed_calls` (
                                `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                                `method` varchar(16) NOT NULL DEFAULT '',
                                `from_tag` varchar(128) NOT NULL DEFAULT '',
                                `to_tag` varchar(128) NOT NULL DEFAULT '',
                                `callid` varchar(255) NOT NULL DEFAULT '',
                                `sip_code` varchar(3) NOT NULL DEFAULT '',
                                `sip_reason` varchar(128) NOT NULL DEFAULT '',
                                `time` datetime NOT NULL,
                                PRIMARY KEY (`id`),
                                KEY `callid_idx` (`callid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `mohqcalls` (
                             `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                             `mohq_id` int(10) unsigned NOT NULL,
                             `call_id` varchar(100) NOT NULL,
                             `call_status` int(10) unsigned NOT NULL,
                             `call_from` varchar(100) NOT NULL,
                             `call_contact` varchar(100) DEFAULT NULL,
                             `call_time` datetime NOT NULL,
                             PRIMARY KEY (`id`),
                             UNIQUE KEY `mohqcalls_idx` (`call_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `mohqueues` (
                             `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                             `name` varchar(25) NOT NULL,
                             `uri` varchar(100) NOT NULL,
                             `mohdir` varchar(100) DEFAULT NULL,
                             `mohfile` varchar(100) NOT NULL,
                             `debug` int(11) NOT NULL,
                             PRIMARY KEY (`id`),
                             UNIQUE KEY `mohqueue_uri_idx` (`uri`),
                             UNIQUE KEY `mohqueue_name_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `mtree` (
                         `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                         `tprefix` varchar(32) NOT NULL DEFAULT '',
                         `tvalue` varchar(128) NOT NULL DEFAULT '',
                         PRIMARY KEY (`id`),
                         UNIQUE KEY `tprefix_idx` (`tprefix`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `mtrees` (
                          `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                          `tname` varchar(128) NOT NULL DEFAULT '',
                          `tprefix` varchar(32) NOT NULL DEFAULT '',
                          `tvalue` varchar(128) NOT NULL DEFAULT '',
                          PRIMARY KEY (`id`),
                          UNIQUE KEY `tname_tprefix_tvalue_idx` (`tname`,`tprefix`,`tvalue`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `pdt` (
                       `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                       `sdomain` varchar(255) NOT NULL,
                       `prefix` varchar(32) NOT NULL,
                       `domain` varchar(255) NOT NULL DEFAULT '',
                       PRIMARY KEY (`id`),
                       UNIQUE KEY `sdomain_prefix_idx` (`sdomain`,`prefix`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `pl_pipes` (
                            `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                            `pipeid` varchar(64) NOT NULL DEFAULT '',
                            `algorithm` varchar(32) NOT NULL DEFAULT '',
                            `plimit` int(11) NOT NULL DEFAULT '0',
                            PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `presentity` (
                              `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                              `username` varchar(64) NOT NULL,
                              `domain` varchar(64) NOT NULL,
                              `event` varchar(64) NOT NULL,
                              `etag` varchar(128) NOT NULL,
                              `expires` int(11) NOT NULL,
                              `received_time` int(11) NOT NULL,
                              `body` blob NOT NULL,
                              `sender` varchar(255) NOT NULL,
                              `priority` int(11) NOT NULL DEFAULT '0',
                              `ruid` varchar(64) DEFAULT NULL,
                              PRIMARY KEY (`id`),
                              UNIQUE KEY `presentity_idx` (`username`,`domain`,`event`,`etag`),
                              UNIQUE KEY `ruid_idx` (`ruid`),
                              KEY `presentity_expires` (`expires`),
                              KEY `account_idx` (`username`,`domain`,`event`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `pua` (
                       `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                       `pres_uri` varchar(255) NOT NULL,
                       `pres_id` varchar(255) NOT NULL,
                       `event` int(11) NOT NULL,
                       `expires` int(11) NOT NULL,
                       `desired_expires` int(11) NOT NULL,
                       `flag` int(11) NOT NULL,
                       `etag` varchar(128) NOT NULL,
                       `tuple_id` varchar(64) DEFAULT NULL,
                       `watcher_uri` varchar(255) NOT NULL,
                       `call_id` varchar(255) NOT NULL,
                       `to_tag` varchar(128) NOT NULL,
                       `from_tag` varchar(128) NOT NULL,
                       `cseq` int(11) NOT NULL,
                       `record_route` text,
                       `contact` varchar(255) NOT NULL,
                       `remote_contact` varchar(255) NOT NULL,
                       `version` int(11) NOT NULL,
                       `extra_headers` text NOT NULL,
                       PRIMARY KEY (`id`),
                       UNIQUE KEY `pua_idx` (`etag`,`tuple_id`,`call_id`,`from_tag`),
                       KEY `expires_idx` (`expires`),
                       KEY `dialog1_idx` (`pres_id`,`pres_uri`),
                       KEY `dialog2_idx` (`call_id`,`from_tag`),
                       KEY `record_idx` (`pres_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `purplemap` (
                             `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                             `sip_user` varchar(255) NOT NULL,
                             `ext_user` varchar(255) NOT NULL,
                             `ext_prot` varchar(16) NOT NULL,
                             `ext_pass` varchar(64) DEFAULT NULL,
                             PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `re_grp` (
                          `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                          `reg_exp` varchar(128) NOT NULL DEFAULT '',
                          `group_id` int(11) NOT NULL DEFAULT '0',
                          PRIMARY KEY (`id`),
                          KEY `group_idx` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `rls_presentity` (
                                  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                                  `rlsubs_did` varchar(255) NOT NULL,
                                  `resource_uri` varchar(255) NOT NULL,
                                  `content_type` varchar(255) NOT NULL,
                                  `presence_state` blob NOT NULL,
                                  `expires` int(11) NOT NULL,
                                  `updated` int(11) NOT NULL,
                                  `auth_state` int(11) NOT NULL,
                                  `reason` varchar(64) NOT NULL,
                                  PRIMARY KEY (`id`),
                                  UNIQUE KEY `rls_presentity_idx` (`rlsubs_did`,`resource_uri`),
                                  KEY `rlsubs_idx` (`rlsubs_did`),
                                  KEY `updated_idx` (`updated`),
                                  KEY `expires_idx` (`expires`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `rls_watchers` (
                                `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                                `presentity_uri` varchar(255) NOT NULL,
                                `to_user` varchar(64) NOT NULL,
                                `to_domain` varchar(64) NOT NULL,
                                `watcher_username` varchar(64) NOT NULL,
                                `watcher_domain` varchar(64) NOT NULL,
                                `event` varchar(64) NOT NULL DEFAULT 'presence',
                                `event_id` varchar(64) DEFAULT NULL,
                                `to_tag` varchar(128) NOT NULL,
                                `from_tag` varchar(128) NOT NULL,
                                `callid` varchar(255) NOT NULL,
                                `local_cseq` int(11) NOT NULL,
                                `remote_cseq` int(11) NOT NULL,
                                `contact` varchar(255) NOT NULL,
                                `record_route` text,
                                `expires` int(11) NOT NULL,
                                `status` int(11) NOT NULL DEFAULT '2',
                                `reason` varchar(64) NOT NULL,
                                `version` int(11) NOT NULL DEFAULT '0',
                                `socket_info` varchar(64) NOT NULL,
                                `local_contact` varchar(255) NOT NULL,
                                `from_user` varchar(64) NOT NULL,
                                `from_domain` varchar(64) NOT NULL,
                                `updated` int(11) NOT NULL,
                                PRIMARY KEY (`id`),
                                UNIQUE KEY `rls_watcher_idx` (`callid`,`to_tag`,`from_tag`),
                                KEY `rls_watchers_update` (`watcher_username`,`watcher_domain`,`event`),
                                KEY `rls_watchers_expires` (`expires`),
                                KEY `updated_idx` (`updated`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `rtpengine` (
                             `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                             `setid` int(10) unsigned NOT NULL DEFAULT '0',
                             `url` varchar(64) NOT NULL,
                             `weight` int(10) unsigned NOT NULL DEFAULT '1',
                             `disabled` int(1) NOT NULL DEFAULT '0',
                             `stamp` datetime NOT NULL DEFAULT '1900-01-01 00:00:01',
                             PRIMARY KEY (`id`),
                             UNIQUE KEY `rtpengine_nodes` (`setid`,`url`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `rtpproxy` (
                            `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                            `setid` varchar(32) NOT NULL DEFAULT '0',
                            `url` varchar(64) NOT NULL DEFAULT '',
                            `flags` int(11) NOT NULL DEFAULT '0',
                            `weight` int(11) NOT NULL DEFAULT '1',
                            `description` varchar(64) NOT NULL DEFAULT '',
                            PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `sca_subscriptions` (
                                     `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                                     `subscriber` varchar(255) NOT NULL,
                                     `aor` varchar(255) NOT NULL,
                                     `event` int(11) NOT NULL DEFAULT '0',
                                     `expires` int(11) NOT NULL DEFAULT '0',
                                     `state` int(11) NOT NULL DEFAULT '0',
                                     `app_idx` int(11) NOT NULL DEFAULT '0',
                                     `call_id` varchar(255) NOT NULL,
                                     `from_tag` varchar(128) NOT NULL,
                                     `to_tag` varchar(128) NOT NULL,
                                     `record_route` text,
                                     `notify_cseq` int(11) NOT NULL,
                                     `subscribe_cseq` int(11) NOT NULL,
                                     `server_id` int(11) NOT NULL DEFAULT '0',
                                     PRIMARY KEY (`id`),
                                     UNIQUE KEY `sca_subscriptions_idx` (`subscriber`,`call_id`,`from_tag`,`to_tag`),
                                     KEY `sca_expires_idx` (`server_id`,`expires`),
                                     KEY `sca_subscribers_idx` (`subscriber`,`event`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `secfilter` (
                             `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                             `action` smallint(6) NOT NULL DEFAULT '0',
                             `type` smallint(6) NOT NULL DEFAULT '0',
                             `data` varchar(64) NOT NULL DEFAULT '',
                             PRIMARY KEY (`id`),
                             KEY `secfilter_idx` (`action`,`type`,`data`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `silo` (
                        `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                        `src_addr` varchar(255) NOT NULL DEFAULT '',
                        `dst_addr` varchar(255) NOT NULL DEFAULT '',
                        `username` varchar(64) NOT NULL DEFAULT '',
                        `domain` varchar(64) NOT NULL DEFAULT '',
                        `inc_time` int(11) NOT NULL DEFAULT '0',
                        `exp_time` int(11) NOT NULL DEFAULT '0',
                        `snd_time` int(11) NOT NULL DEFAULT '0',
                        `ctype` varchar(32) NOT NULL DEFAULT 'text/plain',
                        `body` blob,
                        `extra_hdrs` text,
                        `callid` varchar(128) NOT NULL DEFAULT '',
                        `status` int(11) NOT NULL DEFAULT '0',
                        PRIMARY KEY (`id`),
                        KEY `account_idx` (`username`,`domain`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `sip_trace` (
                             `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                             `time_stamp` datetime NOT NULL DEFAULT '2000-01-01 00:00:01',
                             `time_us` int(10) unsigned NOT NULL DEFAULT '0',
                             `callid` varchar(255) NOT NULL DEFAULT '',
                             `traced_user` varchar(255) NOT NULL DEFAULT '',
                             `msg` mediumtext NOT NULL,
                             `method` varchar(50) NOT NULL DEFAULT '',
                             `status` varchar(255) NOT NULL DEFAULT '',
                             `fromip` varchar(64) NOT NULL DEFAULT '',
                             `toip` varchar(64) NOT NULL DEFAULT '',
                             `fromtag` varchar(128) NOT NULL DEFAULT '',
                             `totag` varchar(128) NOT NULL DEFAULT '',
                             `direction` varchar(4) NOT NULL DEFAULT '',
                             PRIMARY KEY (`id`),
                             KEY `traced_user_idx` (`traced_user`),
                             KEY `date_idx` (`time_stamp`),
                             KEY `fromip_idx` (`fromip`),
                             KEY `callid_idx` (`callid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `speed_dial` (
                              `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                              `username` varchar(64) NOT NULL DEFAULT '',
                              `domain` varchar(64) NOT NULL DEFAULT '',
                              `sd_username` varchar(64) NOT NULL DEFAULT '',
                              `sd_domain` varchar(64) NOT NULL DEFAULT '',
                              `new_uri` varchar(255) NOT NULL DEFAULT '',
                              `fname` varchar(64) NOT NULL DEFAULT '',
                              `lname` varchar(64) NOT NULL DEFAULT '',
                              `description` varchar(64) NOT NULL DEFAULT '',
                              PRIMARY KEY (`id`),
                              UNIQUE KEY `speed_dial_idx` (`username`,`domain`,`sd_domain`,`sd_username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `subscriber` (
                              `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                              `username` varchar(64) NOT NULL DEFAULT '',
                              `domain` varchar(64) NOT NULL DEFAULT '',
                              `password` varchar(64) NOT NULL DEFAULT '',
                              `ha1` varchar(128) NOT NULL DEFAULT '',
                              `ha1b` varchar(128) NOT NULL DEFAULT '',
                              PRIMARY KEY (`id`),
                              UNIQUE KEY `account_idx` (`username`,`domain`),
                              KEY `username_idx` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `topos_d` (
                           `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                           `rectime` datetime NOT NULL,
                           `x_context` varchar(64) NOT NULL DEFAULT '',
                           `s_method` varchar(64) NOT NULL DEFAULT '',
                           `s_cseq` varchar(64) NOT NULL DEFAULT '',
                           `a_callid` varchar(255) NOT NULL DEFAULT '',
                           `a_uuid` varchar(255) NOT NULL DEFAULT '',
                           `b_uuid` varchar(255) NOT NULL DEFAULT '',
                           `a_contact` varchar(512) NOT NULL DEFAULT '',
                           `b_contact` varchar(512) NOT NULL DEFAULT '',
                           `as_contact` varchar(512) NOT NULL DEFAULT '',
                           `bs_contact` varchar(512) NOT NULL DEFAULT '',
                           `a_tag` varchar(255) NOT NULL DEFAULT '',
                           `b_tag` varchar(255) NOT NULL DEFAULT '',
                           `a_rr` mediumtext,
                           `b_rr` mediumtext,
                           `s_rr` mediumtext,
                           `iflags` int(10) unsigned NOT NULL DEFAULT '0',
                           `a_uri` varchar(255) NOT NULL DEFAULT '',
                           `b_uri` varchar(255) NOT NULL DEFAULT '',
                           `r_uri` varchar(255) NOT NULL DEFAULT '',
                           `a_srcaddr` varchar(128) NOT NULL DEFAULT '',
                           `b_srcaddr` varchar(128) NOT NULL DEFAULT '',
                           `a_socket` varchar(128) NOT NULL DEFAULT '',
                           `b_socket` varchar(128) NOT NULL DEFAULT '',
                           PRIMARY KEY (`id`),
                           KEY `rectime_idx` (`rectime`),
                           KEY `a_callid_idx` (`a_callid`),
                           KEY `a_uuid_idx` (`a_uuid`),
                           KEY `b_uuid_idx` (`b_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `topos_t` (
                           `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                           `rectime` datetime NOT NULL,
                           `x_context` varchar(64) NOT NULL DEFAULT '',
                           `s_method` varchar(64) NOT NULL DEFAULT '',
                           `s_cseq` varchar(64) NOT NULL DEFAULT '',
                           `a_callid` varchar(255) NOT NULL DEFAULT '',
                           `a_uuid` varchar(255) NOT NULL DEFAULT '',
                           `b_uuid` varchar(255) NOT NULL DEFAULT '',
                           `direction` int(11) NOT NULL DEFAULT '0',
                           `x_via` mediumtext,
                           `x_vbranch` varchar(255) NOT NULL DEFAULT '',
                           `x_rr` mediumtext,
                           `y_rr` mediumtext,
                           `s_rr` mediumtext,
                           `x_uri` varchar(255) NOT NULL DEFAULT '',
                           `a_contact` varchar(512) NOT NULL DEFAULT '',
                           `b_contact` varchar(512) NOT NULL DEFAULT '',
                           `as_contact` varchar(512) NOT NULL DEFAULT '',
                           `bs_contact` varchar(512) NOT NULL DEFAULT '',
                           `x_tag` varchar(255) NOT NULL DEFAULT '',
                           `a_tag` varchar(255) NOT NULL DEFAULT '',
                           `b_tag` varchar(255) NOT NULL DEFAULT '',
                           `a_srcaddr` varchar(255) NOT NULL DEFAULT '',
                           `b_srcaddr` varchar(255) NOT NULL DEFAULT '',
                           `a_socket` varchar(128) NOT NULL DEFAULT '',
                           `b_socket` varchar(128) NOT NULL DEFAULT '',
                           PRIMARY KEY (`id`),
                           KEY `rectime_idx` (`rectime`),
                           KEY `a_callid_idx` (`a_callid`),
                           KEY `x_vbranch_idx` (`x_vbranch`),
                           KEY `a_uuid_idx` (`a_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `trusted` (
                           `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                           `src_ip` varchar(50) NOT NULL,
                           `proto` varchar(4) NOT NULL,
                           `from_pattern` varchar(64) DEFAULT NULL,
                           `ruri_pattern` varchar(64) DEFAULT NULL,
                           `tag` varchar(64) DEFAULT NULL,
                           `priority` int(11) NOT NULL DEFAULT '0',
                           PRIMARY KEY (`id`),
                           KEY `peer_idx` (`src_ip`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `uacreg` (
                          `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                          `l_uuid` varchar(64) NOT NULL DEFAULT '',
                          `l_username` varchar(64) NOT NULL DEFAULT '',
                          `l_domain` varchar(64) NOT NULL DEFAULT '',
                          `r_username` varchar(64) NOT NULL DEFAULT '',
                          `r_domain` varchar(64) NOT NULL DEFAULT '',
                          `realm` varchar(64) NOT NULL DEFAULT '',
                          `auth_username` varchar(64) NOT NULL DEFAULT '',
                          `auth_password` varchar(64) NOT NULL DEFAULT '',
                          `auth_ha1` varchar(128) NOT NULL DEFAULT '',
                          `auth_proxy` varchar(255) NOT NULL DEFAULT '',
                          `expires` int(11) NOT NULL DEFAULT '0',
                          `flags` int(11) NOT NULL DEFAULT '0',
                          `reg_delay` int(11) NOT NULL DEFAULT '0',
                          `contact_addr` varchar(255) NOT NULL DEFAULT '',
                          `socket` varchar(128) NOT NULL DEFAULT '',
                          PRIMARY KEY (`id`),
                          UNIQUE KEY `l_uuid_idx` (`l_uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `uid_credentials` (
                                   `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                                   `auth_username` varchar(64) NOT NULL,
                                   `did` varchar(64) NOT NULL DEFAULT '_default',
                                   `realm` varchar(64) NOT NULL,
                                   `password` varchar(28) NOT NULL DEFAULT '',
                                   `flags` int(11) NOT NULL DEFAULT '0',
                                   `ha1` varchar(32) NOT NULL,
                                   `ha1b` varchar(32) NOT NULL DEFAULT '',
                                   `uid` varchar(64) NOT NULL,
                                   PRIMARY KEY (`id`),
                                   KEY `cred_idx` (`auth_username`,`did`),
                                   KEY `uid` (`uid`),
                                   KEY `did_idx` (`did`),
                                   KEY `realm_idx` (`realm`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `uid_domain` (
                              `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                              `did` varchar(64) NOT NULL,
                              `domain` varchar(64) NOT NULL,
                              `flags` int(10) unsigned NOT NULL DEFAULT '0',
                              PRIMARY KEY (`id`),
                              UNIQUE KEY `domain_idx` (`domain`),
                              KEY `did_idx` (`did`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `uid_domain_attrs` (
                                    `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                                    `did` varchar(64) DEFAULT NULL,
                                    `name` varchar(32) NOT NULL,
                                    `type` int(11) NOT NULL DEFAULT '0',
                                    `value` varchar(128) DEFAULT NULL,
                                    `flags` int(10) unsigned NOT NULL DEFAULT '0',
                                    PRIMARY KEY (`id`),
                                    UNIQUE KEY `domain_attr_idx` (`did`,`name`,`value`),
                                    KEY `domain_did` (`did`,`flags`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `uid_global_attrs` (
                                    `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                                    `name` varchar(32) NOT NULL,
                                    `type` int(11) NOT NULL DEFAULT '0',
                                    `value` varchar(128) DEFAULT NULL,
                                    `flags` int(10) unsigned NOT NULL DEFAULT '0',
                                    PRIMARY KEY (`id`),
                                    UNIQUE KEY `global_attrs_idx` (`name`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `uid_uri` (
                           `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                           `uid` varchar(64) NOT NULL,
                           `did` varchar(64) NOT NULL,
                           `username` varchar(64) NOT NULL,
                           `flags` int(10) unsigned NOT NULL DEFAULT '0',
                           `scheme` varchar(8) NOT NULL DEFAULT 'sip',
                           PRIMARY KEY (`id`),
                           KEY `uri_idx1` (`username`,`did`,`scheme`),
                           KEY `uri_uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `uid_uri_attrs` (
                                 `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                                 `username` varchar(64) NOT NULL,
                                 `did` varchar(64) NOT NULL,
                                 `name` varchar(32) NOT NULL,
                                 `value` varchar(128) DEFAULT NULL,
                                 `type` int(11) NOT NULL DEFAULT '0',
                                 `flags` int(10) unsigned NOT NULL DEFAULT '0',
                                 `scheme` varchar(8) NOT NULL DEFAULT 'sip',
                                 PRIMARY KEY (`id`),
                                 UNIQUE KEY `uriattrs_idx` (`username`,`did`,`name`,`value`,`scheme`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `uid_user_attrs` (
                                  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                                  `uid` varchar(64) NOT NULL,
                                  `name` varchar(32) NOT NULL,
                                  `value` varchar(128) DEFAULT NULL,
                                  `type` int(11) NOT NULL DEFAULT '0',
                                  `flags` int(10) unsigned NOT NULL DEFAULT '0',
                                  PRIMARY KEY (`id`),
                                  UNIQUE KEY `userattrs_idx` (`uid`,`name`,`value`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `uri` (
                       `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                       `username` varchar(64) NOT NULL DEFAULT '',
                       `domain` varchar(64) NOT NULL DEFAULT '',
                       `uri_user` varchar(64) NOT NULL DEFAULT '',
                       `last_modified` datetime NOT NULL DEFAULT '2000-01-01 00:00:01',
                       PRIMARY KEY (`id`),
                       UNIQUE KEY `account_idx` (`username`,`domain`,`uri_user`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `userblocklist` (
                                 `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                                 `username` varchar(64) NOT NULL DEFAULT '',
                                 `domain` varchar(64) NOT NULL DEFAULT '',
                                 `prefix` varchar(64) NOT NULL DEFAULT '',
                                 `allowlist` tinyint(1) NOT NULL DEFAULT '0',
                                 PRIMARY KEY (`id`),
                                 KEY `userblocklist_idx` (`username`,`domain`,`prefix`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `usr_preferences` (
                                   `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                                   `uuid` varchar(64) NOT NULL DEFAULT '',
                                   `username` varchar(255) NOT NULL DEFAULT '0',
                                   `domain` varchar(64) NOT NULL DEFAULT '',
                                   `attribute` varchar(32) NOT NULL DEFAULT '',
                                   `type` int(11) NOT NULL DEFAULT '0',
                                   `value` varchar(128) NOT NULL DEFAULT '',
                                   `last_modified` datetime NOT NULL DEFAULT '2000-01-01 00:00:01',
                                   PRIMARY KEY (`id`),
                                   KEY `ua_idx` (`uuid`,`attribute`),
                                   KEY `uda_idx` (`username`,`domain`,`attribute`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `version` (
                           `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                           `table_name` varchar(32) NOT NULL,
                           `table_version` int(10) unsigned NOT NULL DEFAULT '0',
                           PRIMARY KEY (`id`),
                           UNIQUE KEY `table_name_idx` (`table_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `watchers` (
                            `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                            `presentity_uri` varchar(255) NOT NULL,
                            `watcher_username` varchar(64) NOT NULL,
                            `watcher_domain` varchar(64) NOT NULL,
                            `event` varchar(64) NOT NULL DEFAULT 'presence',
                            `status` int(11) NOT NULL,
                            `reason` varchar(64) DEFAULT NULL,
                            `inserted_time` int(11) NOT NULL,
                            PRIMARY KEY (`id`),
                            UNIQUE KEY `watcher_idx` (`presentity_uri`,`watcher_username`,`watcher_domain`,`event`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `xcap` (
                        `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
                        `username` varchar(64) NOT NULL,
                        `domain` varchar(64) NOT NULL,
                        `doc` mediumblob NOT NULL,
                        `doc_type` int(11) NOT NULL,
                        `etag` varchar(128) NOT NULL,
                        `source` int(11) NOT NULL,
                        `doc_uri` varchar(255) NOT NULL,
                        `port` int(11) NOT NULL,
                        PRIMARY KEY (`id`),
                        UNIQUE KEY `doc_uri_idx` (`doc_uri`),
                        KEY `account_doc_type_idx` (`username`,`domain`,`doc_type`),
                        KEY `account_doc_type_uri_idx` (`username`,`domain`,`doc_type`,`doc_uri`),
                        KEY `account_doc_uri_idx` (`username`,`domain`,`doc_uri`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

