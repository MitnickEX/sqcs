/*
SQLyog Ultimate v11.24 (32 bit)
MySQL - 5.6.19 : Database - sqcs
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`sqcs` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `sqcs`;

/*Table structure for table `attachment` */

DROP TABLE IF EXISTS `attachment`;

CREATE TABLE `attachment` (
  `file_id` int(10) NOT NULL AUTO_INCREMENT,
  `file_name` varchar(200) DEFAULT NULL,
  `oper_seq` decimal(25,0) NOT NULL,
  `store_path` varchar(100) NOT NULL,
  `upload_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `modify_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
  PRIMARY KEY (`file_id`),
  KEY `INX_OPER_SEQ` (`oper_seq`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Table structure for table `auto_case_results` */

DROP TABLE IF EXISTS `auto_case_results`;

CREATE TABLE `auto_case_results` (
  `system_name` varchar(32) NOT NULL COMMENT '系统名称',
  `job_name` varchar(50) NOT NULL COMMENT 'JOB名称',
  `job_type` varchar(2) NOT NULL COMMENT '01: Auto Case Results; 02: Interface Results; 03: Algorithm Results',
  `system_version` varchar(32) DEFAULT NULL COMMENT '系统版本',
  `run_env` varchar(8) DEFAULT NULL COMMENT '运行环境',
  `class_total` int(11) DEFAULT NULL COMMENT '运行类总数',
  `class_success_no` int(11) DEFAULT NULL COMMENT '类运行成功数',
  `class_fail_no` int(11) DEFAULT NULL COMMENT '类运行失败数',
  `class_success_rate` decimal(5,2) DEFAULT NULL COMMENT '类运行失败率',
  `method_total` int(11) DEFAULT NULL COMMENT '运行方法总数',
  `success_no` int(11) DEFAULT NULL COMMENT '运行成功案例数',
  `fail_no` int(11) DEFAULT NULL COMMENT '运行失败案例数',
  `success_rate` decimal(5,2) DEFAULT NULL COMMENT '运行成功率',
  `complete_date` datetime NOT NULL COMMENT '运行结束时间',
  `fcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '入库时间',
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '运行结束时间',
  PRIMARY KEY (`system_name`,`job_name`,`job_type`,`complete_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `auto_case_total` */

DROP TABLE IF EXISTS `auto_case_total`;

CREATE TABLE `auto_case_total` (
  `system_name` varchar(30) NOT NULL,
  `class_total_no` int(11) DEFAULT NULL,
  `total_no` int(11) DEFAULT NULL,
  `analyze_date` date NOT NULL,
  `fcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`system_name`,`analyze_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `auto_job_type_table` */

DROP TABLE IF EXISTS `auto_job_type_table`;

CREATE TABLE `auto_job_type_table` (
  `job_type` varchar(2) NOT NULL COMMENT '自动化测试JOB类型',
  `full_name` varchar(20) DEFAULT NULL COMMENT 'JOB类型全称',
  `fcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`job_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `bug_check_time` */

DROP TABLE IF EXISTS `bug_check_time`;

CREATE TABLE `bug_check_time` (
  `system_version` varchar(50) NOT NULL COMMENT '版本号',
  `deal_or_check` varchar(20) NOT NULL COMMENT '处理或验证',
  `one_day` varchar(10) DEFAULT NULL COMMENT '超时验证缺陷数-超8小时',
  `two_day` varchar(10) DEFAULT NULL COMMENT '超时验证缺陷数-超16小时',
  `more_than_two_day` varchar(10) DEFAULT NULL COMMENT '超时验证缺陷数-超24小时',
  `overtime` varchar(10) DEFAULT NULL COMMENT '超时验证缺陷数-超4小时',
  `no_overtime` varchar(10) DEFAULT NULL COMMENT '未超超时验证缺陷数',
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
  `fcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  PRIMARY KEY (`system_version`,`deal_or_check`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `bug_checkordeal_time` */

DROP TABLE IF EXISTS `bug_checkordeal_time`;

CREATE TABLE `bug_checkordeal_time` (
  `system_version` varchar(200) DEFAULT NULL,
  `bug_id` varchar(34) NOT NULL,
  `check_or_deal` varchar(20) NOT NULL,
  `hour_1` float(6,2) DEFAULT NULL,
  `is_over_time` varchar(10) DEFAULT NULL COMMENT 'Y,N',
  `over_time_date` date NOT NULL,
  `warning_grade` varchar(10) DEFAULT NULL,
  `warning_info` longtext,
  `fcd` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `lcd` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`bug_id`,`check_or_deal`,`over_time_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `bug_distribute` */

DROP TABLE IF EXISTS `bug_distribute`;

CREATE TABLE `bug_distribute` (
  `system_name` varchar(100) DEFAULT NULL COMMENT '系统名',
  `system_version` varchar(100) NOT NULL COMMENT '版本号',
  `modual_name` varchar(100) NOT NULL COMMENT '模块名',
  `bug_num` decimal(10,0) DEFAULT NULL COMMENT '缺陷总数',
  `modual_bug_abnormity_grade` varchar(20) DEFAULT NULL COMMENT '模块缺陷占比异常占比级别',
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
  `fcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  PRIMARY KEY (`system_version`,`modual_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `bug_found_trend` */

DROP TABLE IF EXISTS `bug_found_trend`;

CREATE TABLE `bug_found_trend` (
  `system_version` varchar(50) NOT NULL COMMENT '版本号',
  `test_date` date NOT NULL COMMENT '测试日期',
  `L1_bug_everydate` int(10) DEFAULT NULL COMMENT '每天发现L1缺陷数',
  `L2_bug_everydate` int(10) DEFAULT NULL COMMENT '每天发现L2缺陷数',
  `L3_bug_everydate` int(10) DEFAULT NULL COMMENT '每天发现L3缺陷数',
  `L4_bug_everydate` int(10) DEFAULT NULL COMMENT '每天发现L4缺陷数',
  `L1_cumulate_found_bug` int(10) DEFAULT NULL COMMENT '累计发现L1缺陷数',
  `L2_cumulate_found_bug` int(10) DEFAULT NULL COMMENT '累计发现L2缺陷数',
  `cumulate_found_bug` int(10) DEFAULT NULL COMMENT '累计发现缺陷数',
  `cumulate_del_bug` int(10) DEFAULT NULL COMMENT '累计解决缺陷数',
  `cumulate_close_bug` int(10) DEFAULT NULL COMMENT '累计关闭缺陷数',
  `system` varchar(200) DEFAULT NULL COMMENT '系统名',
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
  `fcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  PRIMARY KEY (`system_version`,`test_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `bug_found_trend_sum` */

DROP TABLE IF EXISTS `bug_found_trend_sum`;

CREATE TABLE `bug_found_trend_sum` (
  `system` varchar(200) NOT NULL COMMENT '系统名',
  `test_date` date NOT NULL COMMENT '测试日期',
  `L1_bug_everydate` varchar(10) DEFAULT NULL COMMENT '每天发现L1缺陷数',
  `L2_bug_everydate` varchar(10) DEFAULT NULL COMMENT '每天发现L2缺陷数',
  `L3_bug_everydate` varchar(10) DEFAULT NULL COMMENT '每天发现L3缺陷数',
  `L4_bug_everydate` varchar(10) DEFAULT NULL COMMENT '每天发现L4缺陷数',
  `L1_cumulate_found_bug` varchar(10) DEFAULT NULL COMMENT '累计发现L1缺陷数',
  `L2_cumulate_found_bug` varchar(10) DEFAULT NULL COMMENT '累计发现L2缺陷数',
  `cumulate_found_bug` varchar(10) DEFAULT NULL COMMENT '累计发现缺陷数',
  `cumulate_del_bug` varchar(10) DEFAULT NULL COMMENT '累计解决缺陷数',
  `cumulate_close_bug` varchar(10) DEFAULT NULL COMMENT '累计关闭缺陷数',
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
  `fcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  PRIMARY KEY (`system`,`test_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `bug_group_by_person` */

DROP TABLE IF EXISTS `bug_group_by_person`;

CREATE TABLE `bug_group_by_person` (
  `system_version` varchar(200) NOT NULL,
  `person_name` varchar(200) NOT NULL,
  `person_type` varchar(20) DEFAULT NULL,
  `bug_num` decimal(4,0) DEFAULT NULL,
  `L1_bug_num` decimal(4,0) DEFAULT NULL,
  `L2_bug_num` decimal(4,0) DEFAULT NULL,
  `L3_bug_num` decimal(4,0) DEFAULT NULL,
  `L4_bug_num` decimal(4,0) DEFAULT NULL,
  `fcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
  PRIMARY KEY (`system_version`,`person_name`),
  KEY `INX_FCD` (`fcd`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `child_problem_list` */

DROP TABLE IF EXISTS `child_problem_list`;

CREATE TABLE `child_problem_list` (
  `childpro_id` varchar(20) NOT NULL COMMENT '子问题编号',
  `childpro_theme` varchar(200) DEFAULT NULL COMMENT '子问题主题',
  `childpro_status` varchar(20) DEFAULT NULL COMMENT '子问题状态',
  `childpro_system` varchar(50) DEFAULT NULL COMMENT '子问题子系统',
  `childpro_deal_person` varchar(20) DEFAULT NULL COMMENT '子问题处理人',
  `childpro_submit_date` datetime DEFAULT NULL COMMENT '子问题提交时间',
  `pro_assign_date` datetime DEFAULT NULL COMMENT '分配时间',
  `pro_resolve_date` datetime DEFAULT NULL COMMENT '解决时间',
  `pro_resolve_time` datetime DEFAULT NULL COMMENT '解决期限',
  `is_overtime` varchar(10) DEFAULT NULL COMMENT '是否超时',
  `pro_class` varchar(200) DEFAULT NULL COMMENT '问题分类',
  `pro_second_class` varchar(200) DEFAULT NULL COMMENT '问题二级分类',
  `pro_reason` varchar(500) DEFAULT NULL COMMENT '原因分析',
  `pro_produce_phrase` varchar(200) DEFAULT NULL COMMENT '植入阶段',
  `pro_id` varchar(200) DEFAULT NULL COMMENT '问题编号',
  `pro_phase` varchar(200) DEFAULT NULL COMMENT '问题发现阶段',
  `pro_version` varchar(200) DEFAULT NULL COMMENT '发现版本',
  `pro_system` varchar(200) DEFAULT NULL COMMENT '问题子系统',
  `pro_program` varchar(200) DEFAULT NULL COMMENT '问题上报项目',
  `sub_pro_program` varchar(200) DEFAULT NULL COMMENT '子问题所属项目',
  `pro_level` varchar(200) DEFAULT NULL COMMENT '问题级别',
  `pro_pri` varchar(200) DEFAULT NULL COMMENT '修复优先级',
  `pro_submit_date` datetime DEFAULT NULL COMMENT '问题上报时间',
  `pro_close_date` datetime DEFAULT NULL COMMENT '问题关闭时间',
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
  `fcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  PRIMARY KEY (`childpro_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `dept_base_table` */

DROP TABLE IF EXISTS `dept_base_table`;

CREATE TABLE `dept_base_table` (
  `paic_unique_deptid` varchar(50) NOT NULL,
  `paic_set_id` varchar(20) DEFAULT NULL,
  `paic_set_name` varchar(100) DEFAULT NULL,
  `dept_id` varchar(25) DEFAULT NULL,
  `dept_name` varchar(100) DEFAULT NULL,
  `team_name` varchar(100) DEFAULT NULL,
  `parent_dept_id` varchar(25) DEFAULT NULL,
  `fcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`paic_unique_deptid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `dept_system` */

DROP TABLE IF EXISTS `dept_system`;

CREATE TABLE `dept_system` (
  `dept_code` varchar(20) DEFAULT NULL COMMENT '部门编码',
  `dev_dept` varchar(100) NOT NULL COMMENT '开发部门',
  `dev_team` varchar(100) DEFAULT NULL COMMENT '开发分组',
  `test_dept` varchar(100) DEFAULT NULL COMMENT '测试部门',
  `test_team` varchar(100) DEFAULT NULL COMMENT '测试分组',
  `system_alias` varchar(50) NOT NULL COMMENT '子系统简称',
  `system_name` varchar(100) NOT NULL COMMENT '子系统全称',
  `bug_increase_spd` float(6,5) DEFAULT NULL COMMENT '缺陷增长速度(理想基线0.1325)',
  `bug_increase_exp` float(6,5) DEFAULT NULL COMMENT '缺陷增长指数(理想基线0.73632)',
  `dever` varchar(100) DEFAULT NULL COMMENT '开发负责人',
  `tester` varchar(100) DEFAULT NULL COMMENT '测试负责人',
  `assistants` varchar(200) DEFAULT NULL COMMENT '辅助测试人员',
  `module` varchar(2000) DEFAULT NULL COMMENT '系统模块定义',
  `need_sync` varchar(1) DEFAULT 'Y' COMMENT '是否同步数据',
  `case_source` varchar(50) DEFAULT NULL COMMENT '测试用例管理平台',
  `need_email` varchar(1) DEFAULT 'Y' COMMENT '是否需要邮件通知',
  `warning_define` varchar(300) DEFAULT NULL COMMENT '预警规则定义',
  `is_valid` varchar(1) DEFAULT 'Y' COMMENT '是否有效',
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
  `fcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  PRIMARY KEY (`dev_dept`,`system_alias`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `dept_system_temp` */

DROP TABLE IF EXISTS `dept_system_temp`;

CREATE TABLE `dept_system_temp` (
  `system_alias` varchar(200) NOT NULL,
  `system_name` varchar(200) DEFAULT NULL,
  `dev_dept` varchar(200) NOT NULL,
  `dev_team` varchar(200) DEFAULT NULL,
  `module` varchar(2000) DEFAULT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`system_alias`,`dev_dept`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `exe_procedure_log` */

DROP TABLE IF EXISTS `exe_procedure_log`;

CREATE TABLE `exe_procedure_log` (
  `system_version` varchar(200) NOT NULL,
  `prucedure_name` varchar(100) NOT NULL,
  `is_success` varchar(20) DEFAULT NULL,
  `error_log` longtext,
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`system_version`,`prucedure_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `gompertz_define` */

DROP TABLE IF EXISTS `gompertz_define`;

CREATE TABLE `gompertz_define` (
  `system_version` varchar(200) NOT NULL,
  `expect_bug_num` decimal(3,0) DEFAULT NULL,
  `test_date` date NOT NULL,
  `bug_found_num` decimal(3,0) DEFAULT NULL,
  `fcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`system_version`,`test_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `job` */

DROP TABLE IF EXISTS `job`;

CREATE TABLE `job` (
  `job_name` varchar(200) DEFAULT NULL,
  `job_no` varchar(100) NOT NULL,
  `job_status` varchar(10) NOT NULL COMMENT '01：待执行02：执行中03：执行成功04：执行失败',
  `plan_start_time` datetime DEFAULT NULL,
  `actual_start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
  `fcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  PRIMARY KEY (`job_no`,`job_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `job_log` */

DROP TABLE IF EXISTS `job_log`;

CREATE TABLE `job_log` (
  `job_no` varchar(100) DEFAULT NULL,
  `error_log` mediumtext,
  `fcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  KEY `FK_job_no` (`job_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `kb_gragh_link` */

DROP TABLE IF EXISTS `kb_gragh_link`;

CREATE TABLE `kb_gragh_link` (
  `link_jsp` varchar(50) NOT NULL,
  `gragh_name` varchar(50) NOT NULL,
  `gragh_type` varchar(20) DEFAULT NULL,
  `fcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `need_info` */

DROP TABLE IF EXISTS `need_info`;

CREATE TABLE `need_info` (
  `id_need` varchar(20) NOT NULL COMMENT '需求编号',
  `need_name` varchar(500) DEFAULT NULL COMMENT '需求标题',
  `need_state` varchar(20) DEFAULT NULL COMMENT '需求状态',
  `need_type` varchar(20) DEFAULT NULL COMMENT '需求类型',
  `sys_name` varchar(500) DEFAULT NULL COMMENT '系统',
  `subsys_name` varchar(500) DEFAULT NULL COMMENT '子系统',
  `subchannel_name` varchar(200) DEFAULT NULL COMMENT '子通道名称',
  `benefit_name` varchar(200) DEFAULT NULL COMMENT '受益人',
  `urgency` varchar(20) DEFAULT NULL COMMENT '优先级',
  `submit_person_name` varchar(200) DEFAULT NULL COMMENT '提交人',
  `submit_person` varchar(20) DEFAULT NULL COMMENT '提交人帐号',
  `submit_dept` varchar(200) DEFAULT NULL COMMENT '提交人部门',
  `presenter` varchar(200) DEFAULT NULL COMMENT '提出人',
  `dept_id` varchar(200) DEFAULT NULL COMMENT '提出人部门',
  `date_submit` datetime DEFAULT NULL COMMENT '提交日期',
  `date_exp_finish` datetime DEFAULT NULL COMMENT '期望完成时间',
  `need_new_type` varchar(200) DEFAULT NULL COMMENT '需求分析属性',
  `sa_est_workload` varchar(20) DEFAULT NULL COMMENT 'SA预计工作量(人日)',
  `date_need_close` datetime DEFAULT NULL COMMENT '需求关闭时间',
  `date_need_rel` datetime DEFAULT NULL COMMENT '需求发布时间',
  `devgroup` varchar(200) DEFAULT NULL COMMENT '开发分组',
  `id_sr` varchar(200) DEFAULT NULL COMMENT 'SR号',
  `sr_subsys_name` varchar(200) DEFAULT NULL COMMENT 'SR子系统',
  `sr_name` varchar(200) DEFAULT NULL COMMENT 'SR标题',
  `sr_state` varchar(200) DEFAULT NULL COMMENT 'SR状态',
  `ucp_count` varchar(200) DEFAULT NULL COMMENT 'SR-UCP小计',
  `exp_cost` varchar(200) DEFAULT NULL COMMENT 'SR工作量',
  `units` varchar(200) DEFAULT NULL COMMENT 'SR工作量单位',
  `rm_no` varchar(200) DEFAULT NULL COMMENT '版本号',
  `date_rm_freeze` datetime DEFAULT NULL COMMENT '版本冻结时间',
  `date_plan_rel` datetime DEFAULT NULL COMMENT 'SA排期发布时间',
  `date_release_end_base` datetime DEFAULT NULL COMMENT 'SR基准计划发布时间',
  `date_release_end_plan` datetime DEFAULT NULL COMMENT 'SR计划发布时间',
  `date_release_end_fact` datetime DEFAULT NULL COMMENT 'SR实际发布时间',
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
  `fcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  PRIMARY KEY (`id_need`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `problem_list` */

DROP TABLE IF EXISTS `problem_list`;

CREATE TABLE `problem_list` (
  `pro_id` varchar(20) NOT NULL COMMENT '问题编号',
  `pro_theme` varchar(500) DEFAULT NULL COMMENT '问题主题',
  `pro_status` varchar(10) DEFAULT NULL COMMENT '问题状态',
  `pro_level` varchar(10) DEFAULT NULL COMMENT '问题级别',
  `pro_pri` varchar(10) DEFAULT NULL COMMENT '修复优先级',
  `pro_system` varchar(200) DEFAULT NULL COMMENT '子系统',
  `pro_dept` varchar(50) DEFAULT NULL COMMENT '部门',
  `pro_group` varchar(50) DEFAULT NULL COMMENT '开发分组',
  `pro_program` varchar(50) DEFAULT NULL COMMENT '问题上报项目',
  `pro_phase` varchar(20) DEFAULT NULL COMMENT '问题产生阶段',
  `pro_source` varchar(20) DEFAULT NULL COMMENT '问题来源',
  `pro_version` varchar(50) DEFAULT NULL COMMENT '发现版本',
  `pro_sr` varchar(20) DEFAULT NULL COMMENT '引发BUG的SR',
  `pro_module` varchar(50) DEFAULT NULL COMMENT '模块',
  `pro_found_person` varchar(50) DEFAULT NULL COMMENT '上报人',
  `pro_found_date` datetime DEFAULT NULL COMMENT '问题上报时间',
  `pro_deal_person` varchar(50) DEFAULT NULL COMMENT '处理人',
  `pro_deal_status` varchar(20) DEFAULT NULL COMMENT '问题解决程度',
  `pro_check_person` varchar(50) DEFAULT NULL COMMENT '验证人',
  `pro_deal_date` datetime DEFAULT NULL COMMENT '开发验证通过时间',
  `pro_close_date` datetime DEFAULT NULL COMMENT '关闭时间',
  `pro_nopass_num` varchar(100) DEFAULT NULL COMMENT '验证不通过次数',
  `pro_ownid` varchar(50) DEFAULT NULL COMMENT '所属归并问题ID',
  `pro_sourceid` varchar(50) DEFAULT NULL COMMENT '来源编号',
  `pro_type` varchar(20) DEFAULT NULL COMMENT '缺陷类型',
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
  `fcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  PRIMARY KEY (`pro_id`),
  KEY `INDEX_PRO_SR` (`pro_sr`),
  KEY `INDEX_PRO_VERSION` (`pro_version`),
  KEY `INDEX_SYS_FOUND` (`pro_found_person`,`pro_system`),
  KEY `INDEX_SYS_DEAL` (`pro_deal_person`,`pro_system`),
  KEY `INDEX_VER_FOUND` (`pro_version`,`pro_found_person`),
  KEY `INDEX_VER_DEAL` (`pro_version`,`pro_deal_person`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `problem_source_table` */

DROP TABLE IF EXISTS `problem_source_table`;

CREATE TABLE `problem_source_table` (
  `source_code` int(11) NOT NULL,
  `source_desc` varchar(50) COLLATE utf8_bin NOT NULL,
  `fcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
  PRIMARY KEY (`source_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Table structure for table `problem_status_table` */

DROP TABLE IF EXISTS `problem_status_table`;

CREATE TABLE `problem_status_table` (
  `status_code` int(11) NOT NULL,
  `status_desc` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `fcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
  PRIMARY KEY (`status_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Table structure for table `spcode_analyze_result` */

DROP TABLE IF EXISTS `spcode_analyze_result`;

CREATE TABLE `spcode_analyze_result` (
  `db_name` varchar(10) NOT NULL,
  `sid` varchar(10) NOT NULL,
  `owner` varchar(20) NOT NULL,
  `sp_unit_name` varchar(50) NOT NULL,
  `unit_called` longtext,
  `analyze_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `fcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
  PRIMARY KEY (`db_name`,`sp_unit_name`),
  UNIQUE KEY `IX_DB_SPUNIT` (`sid`,`sp_unit_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `spcode_anaylze_base` */

DROP TABLE IF EXISTS `spcode_anaylze_base`;

CREATE TABLE `spcode_anaylze_base` (
  `sid` varchar(10) DEFAULT NULL,
  `owner` varchar(20) NOT NULL,
  `object_name` varchar(40) NOT NULL,
  `fcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
  UNIQUE KEY `IX_SINGLE_DATA` (`sid`,`owner`,`object_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `sr_info` */

DROP TABLE IF EXISTS `sr_info`;

CREATE TABLE `sr_info` (
  `system_version` varchar(50) NOT NULL,
  `need_id` varchar(50) DEFAULT NULL,
  `sr_id` varchar(20) NOT NULL,
  `date_submit` date DEFAULT NULL COMMENT 'SR拆分日期',
  `date_add_to_rm` date DEFAULT NULL COMMENT 'SR纳入版本日期',
  `date_handover_plan` date DEFAULT NULL COMMENT 'SR计划首移日期',
  `date_dev_complete` date DEFAULT NULL COMMENT 'SR开发完成日期',
  `date_deploy_prd_plan` date DEFAULT NULL COMMENT 'SR计划发布日期',
  `date_deploy_prd_fact` date DEFAULT NULL COMMENT 'SR发布日期',
  PRIMARY KEY (`sr_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `system_domain` */

DROP TABLE IF EXISTS `system_domain`;

CREATE TABLE `system_domain` (
  `system_name` varchar(20) NOT NULL COMMENT '系统名称',
  `instance_name` varchar(100) NOT NULL COMMENT '部署环境名称',
  `instance_type` varchar(20) NOT NULL COMMENT '环境类型',
  `console` varchar(200) DEFAULT NULL COMMENT 'Console Admin URL',
  `domain_id` varchar(10) DEFAULT NULL COMMENT 'Console Domain ID',
  `midware` varchar(20) DEFAULT NULL COMMENT '中间件软件',
  `url_domain` varchar(200) NOT NULL COMMENT '关联域名',
  `cluster` varchar(20) DEFAULT NULL COMMENT '集群',
  `del_flag` int(2) DEFAULT NULL COMMENT '失效标记',
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改时间',
  `fcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`instance_name`,`url_domain`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `system_info` */

DROP TABLE IF EXISTS `system_info`;

CREATE TABLE `system_info` (
  `system_id` int(10) NOT NULL AUTO_INCREMENT,
  `system_name` varchar(20) NOT NULL,
  `dept_name` varchar(50) NOT NULL,
  `test_team` varchar(50) NOT NULL,
  `dev_team` varchar(50) NOT NULL,
  `instance_name` varchar(50) NOT NULL,
  `login_address` varchar(800) DEFAULT NULL,
  `t3_uri` varchar(200) DEFAULT NULL,
  `jdbc_tns` varchar(500) DEFAULT NULL,
  `test_users` varchar(100) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `del_flag` int(2) DEFAULT '0' COMMENT '删除标志（0为未删除，1为已删除）',
  `fcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
  PRIMARY KEY (`system_id`),
  UNIQUE KEY `INX_SYS_INS` (`system_name`,`instance_name`,`del_flag`)
) ENGINE=InnoDB AUTO_INCREMENT=446 DEFAULT CHARSET=utf8;

/*Table structure for table `system_relation_result` */

DROP TABLE IF EXISTS `system_relation_result`;

CREATE TABLE `system_relation_result` (
  `system_name` varchar(20) NOT NULL,
  `instance_name` varchar(50) NOT NULL,
  `jndi_name` varchar(100) NOT NULL,
  `jndi_value` varchar(1000) NOT NULL,
  `protocol` varchar(50) DEFAULT NULL,
  `target_instance` varchar(200) NOT NULL,
  `fcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
  PRIMARY KEY (`system_name`,`instance_name`,`jndi_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `test_execute_plan` */

DROP TABLE IF EXISTS `test_execute_plan`;

CREATE TABLE `test_execute_plan` (
  `system_version` varchar(200) NOT NULL,
  `test_date` date NOT NULL,
  `execute_percent` varchar(10) DEFAULT NULL,
  `st_actual_execute_percent` varchar(10) DEFAULT NULL,
  `uat_actual_execute_percent` varchar(10) DEFAULT NULL,
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
  `fcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  PRIMARY KEY (`system_version`,`test_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `test_schedule` */

DROP TABLE IF EXISTS `test_schedule`;

CREATE TABLE `test_schedule` (
  `system_alias` varchar(50) NOT NULL,
  `system_version` varchar(200) NOT NULL,
  `test_plan` varchar(200) NOT NULL,
  `schedule_date` date NOT NULL,
  `need_code` varchar(20) NOT NULL,
  `sr_code` varchar(20) DEFAULT NULL,
  `case_count` int(5) NOT NULL DEFAULT '0',
  `execute_percent` varchar(10) NOT NULL DEFAULT '0',
  `passed_percent` varchar(10) NOT NULL DEFAULT '0',
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
  `fcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  PRIMARY KEY (`system_version`,`test_plan`,`schedule_date`,`need_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `test_team_info` */

DROP TABLE IF EXISTS `test_team_info`;

CREATE TABLE `test_team_info` (
  `test_team` varchar(50) NOT NULL,
  `leader` varchar(20) DEFAULT NULL,
  `dev_dept` varchar(50) NOT NULL,
  `tm_auto` varchar(1) DEFAULT 'N',
  `fcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
  PRIMARY KEY (`test_team`,`dev_dept`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `uat_feedback` */

DROP TABLE IF EXISTS `uat_feedback`;

CREATE TABLE `uat_feedback` (
  `need_id` varchar(20) NOT NULL,
  `submiter` varchar(50) NOT NULL,
  `env_useful` varchar(50) DEFAULT NULL,
  `text_env_useful` varchar(500) DEFAULT NULL,
  `tester_useful` varchar(50) DEFAULT NULL,
  `text_tester_useful` varchar(500) DEFAULT NULL,
  `problem_useful` varchar(50) DEFAULT NULL,
  `text_problem_useful` varchar(500) DEFAULT NULL,
  `developer_useful` varchar(50) DEFAULT NULL,
  `text_developer_useful` varchar(500) DEFAULT NULL,
  `need_useful` varchar(50) DEFAULT NULL,
  `text_need_useful` varchar(500) DEFAULT NULL,
  `sa_useful` varchar(50) DEFAULT NULL,
  `text_sa_useful` varchar(500) DEFAULT NULL,
  `flow_useful` varchar(50) DEFAULT NULL,
  `text_flow_useful` varchar(500) DEFAULT NULL,
  `feedback_time` date DEFAULT NULL,
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
  `fcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  PRIMARY KEY (`need_id`,`submiter`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `uioc_info` */

DROP TABLE IF EXISTS `uioc_info`;

CREATE TABLE `uioc_info` (
  `event_id` varchar(20) NOT NULL,
  `event_href` varchar(100) DEFAULT NULL,
  `team` varchar(30) DEFAULT NULL,
  `problem_system` blob,
  `problem_discover_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `problem_solved_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `event_fire_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `event_end_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `problem_overview` blob,
  `problem_reason_first_view` blob,
  `problem_operation` blob,
  `problem_reason` blob,
  `problem_reason_type` varchar(200) DEFAULT NULL,
  `problem_solution` blob,
  `is_change_related` varchar(2) DEFAULT NULL,
  `change_type` varchar(20) DEFAULT NULL,
  `change_detail` blob,
  `fundation_component_type` varchar(20) DEFAULT NULL,
  `is_critical_event` varchar(2) DEFAULT NULL,
  `critical_event_id` varchar(20) DEFAULT NULL,
  `critical_event_href` varchar(100) DEFAULT NULL,
  `is_test_relative` varchar(1) DEFAULT NULL,
  `test_team` varchar(200) DEFAULT NULL,
  `test_miss_reason` blob,
  `test_improvement` blob,
  `fcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`event_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `um_info` */

DROP TABLE IF EXISTS `um_info`;

CREATE TABLE `um_info` (
  `um_no` varchar(50) COLLATE utf8_bin NOT NULL,
  `full_name` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `user_rank` int(1) NOT NULL,
  `dept_code` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `dept_name` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `team_name` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `leader_um` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `leader_name` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `is_vendor` varchar(1) COLLATE utf8_bin DEFAULT 'N',
  `fcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
  PRIMARY KEY (`um_no`),
  KEY `INDEX_NAME` (`full_name`),
  KEY `INDEX_LEADER_UM` (`leader_um`),
  KEY `INDEX_LEADER_NAME` (`leader_name`),
  KEY `FK_RANK` (`user_rank`),
  CONSTRAINT `FK_RANK` FOREIGN KEY (`user_rank`) REFERENCES `user_rank_table` (`user_rank`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/*Table structure for table `user_problem_record` */

DROP TABLE IF EXISTS `user_problem_record`;

CREATE TABLE `user_problem_record` (
  `pro_id` int(11) NOT NULL AUTO_INCREMENT,
  `pro_summary` varchar(200) NOT NULL,
  `pro_source` int(11) DEFAULT NULL,
  `pro_user` varchar(20) DEFAULT NULL,
  `pro_status` int(11) DEFAULT '1',
  `sys_version` varchar(50) DEFAULT NULL,
  `suggest_fixer` varchar(50) DEFAULT NULL,
  `real_fixer` varchar(50) DEFAULT NULL,
  `pro_attach` decimal(25,0) DEFAULT NULL,
  `pro_detail` varchar(1000) DEFAULT NULL,
  `fix_desc` varchar(1000) DEFAULT NULL,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `fix_date` timestamp NULL DEFAULT NULL,
  `close_date` timestamp NULL DEFAULT NULL,
  `fcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
  PRIMARY KEY (`pro_id`),
  KEY `IX_CREATE_DATE` (`create_date`),
  KEY `IX_FIX_DATE` (`fix_date`),
  KEY `IX_CLOSE_DATE` (`close_date`),
  KEY `FK_PRO_SOURCE` (`pro_source`),
  KEY `FK_PRO_STATUS` (`pro_status`),
  CONSTRAINT `FK_PRO_SOURCE` FOREIGN KEY (`pro_source`) REFERENCES `problem_source_table` (`source_code`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `FK_PRO_STATUS` FOREIGN KEY (`pro_status`) REFERENCES `problem_status_table` (`status_code`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=utf8;

/*Table structure for table `user_rank_table` */

DROP TABLE IF EXISTS `user_rank_table`;

CREATE TABLE `user_rank_table` (
  `user_rank` int(1) NOT NULL COMMENT '用户级别代码',
  `rank_desc` varchar(100) DEFAULT NULL COMMENT '用户级别描述',
  `fcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_rank`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `version_manpower` */

DROP TABLE IF EXISTS `version_manpower`;

CREATE TABLE `version_manpower` (
  `system_version` varchar(200) NOT NULL COMMENT '版本号',
  `sr_code` varchar(50) NOT NULL,
  `sr_name` varchar(200) NOT NULL,
  `source_id` varchar(200) DEFAULT NULL COMMENT '上游编号',
  `man_power` varchar(20) DEFAULT NULL COMMENT '投入人力',
  `bug_num` int(20) DEFAULT '0' COMMENT '缺陷数(含开发上报，算密度用)',
  `bug_num_amount` int(20) DEFAULT '0' COMMENT '缺陷数(不含开发上报，未关联SR报警用)',
  `sr_density` varchar(20) DEFAULT NULL COMMENT 'SR缺陷密度',
  `version_density` varchar(20) DEFAULT NULL COMMENT '版本缺陷密度',
  `sr_bug_sum` int(20) DEFAULT '0' COMMENT '缺陷总数(含开发上报)',
  `sr_bug_sum_amount` int(20) DEFAULT '0' COMMENT '缺陷总数(不含开发上报)',
  `sr_bug_abnormity_grade` varchar(20) DEFAULT NULL,
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
  `fcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  PRIMARY KEY (`system_version`,`sr_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `version_plantime` */

DROP TABLE IF EXISTS `version_plantime`;

CREATE TABLE `version_plantime` (
  `system_version` varchar(200) NOT NULL COMMENT '版本号',
  `rm_create_date` date DEFAULT NULL,
  `first_handover_test_time` date DEFAULT NULL COMMENT '版本首次移交日期',
  `first_deploy_test_time` date DEFAULT NULL COMMENT '版本首次部署日期',
  `systest_end_time` date DEFAULT NULL COMMENT '系统测试结束日期',
  `reviewtest_end_date` date DEFAULT NULL COMMENT '回归测试结束日期',
  `version_status` varchar(50) DEFAULT NULL COMMENT '版本状态',
  `version_type` varchar(50) DEFAULT NULL COMMENT '版本类型',
  `sub_system_name` varchar(200) DEFAULT NULL COMMENT '子系统名称',
  `dev_dept` varchar(500) DEFAULT NULL COMMENT '开发部门',
  `date_prd_transfer_base` datetime DEFAULT NULL COMMENT '（基准）正式发布版本移交计划完成时间',
  `date_prd_transfer_fact` datetime DEFAULT NULL COMMENT '（实际）正式发布版本移交完成时间',
  `owner_project` varchar(500) DEFAULT NULL,
  `is_delay` varchar(10) DEFAULT NULL COMMENT 'YorN',
  `environment` varchar(1000) DEFAULT NULL COMMENT '环境',
  `fcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
  PRIMARY KEY (`system_version`),
  KEY `INX_TEST_BEGIN` (`first_handover_test_time`),
  KEY `INX_RELEASE_TIME` (`reviewtest_end_date`),
  FULLTEXT KEY `INX_SYSTEM_NAME` (`sub_system_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `visitor_analysis` */

DROP TABLE IF EXISTS `visitor_analysis`;

CREATE TABLE `visitor_analysis` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vdate` datetime NOT NULL,
  `ip` varchar(20) DEFAULT NULL,
  `user` varchar(50) DEFAULT NULL,
  `url` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `INX_VISIT_DATE` (`vdate`),
  KEY `INX_REQUEST_URLIP` (`url`(255),`ip`),
  KEY `INX_VISITOR_USER` (`user`),
  FULLTEXT KEY `INX_VISITOR_IP` (`ip`)
) ENGINE=InnoDB AUTO_INCREMENT=11548 DEFAULT CHARSET=utf8;

/*Table structure for table `warning_define` */

DROP TABLE IF EXISTS `warning_define`;

CREATE TABLE `warning_define` (
  `warning_type` varchar(10) NOT NULL COMMENT '01:缺陷趋势分析预警规02:缺陷密度分析预警规则03:缺陷修复时效分析-按版本预警规则04:缺陷验证时效分析-按版本预警规则05:版本发布分析-延期版本显示',
  `rule_no` varchar(10) NOT NULL,
  `rule_name` varchar(100) DEFAULT NULL,
  `owner` varchar(20) DEFAULT NULL,
  `warning_grade` varchar(10) NOT NULL,
  `warning` varchar(500) DEFAULT NULL,
  `custom_field1` varchar(100) NOT NULL,
  `custom_field2` varchar(100) DEFAULT NULL,
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
  `fcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  PRIMARY KEY (`warning_type`,`rule_no`,`warning_grade`,`custom_field1`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `warning_define_temp` */

DROP TABLE IF EXISTS `warning_define_temp`;

CREATE TABLE `warning_define_temp` (
  `warning_type` varchar(50) NOT NULL,
  `warning_flag` varchar(50) NOT NULL,
  PRIMARY KEY (`warning_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `warning_info` */

DROP TABLE IF EXISTS `warning_info`;

CREATE TABLE `warning_info` (
  `system_version` varchar(200) NOT NULL,
  `warning_date` date NOT NULL,
  `warning_type` varchar(20) NOT NULL,
  `rule_no` varchar(20) NOT NULL,
  `warning_grade` varchar(20) NOT NULL,
  `warning_info` varchar(500) DEFAULT NULL,
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新日期',
  `fcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建日期',
  PRIMARY KEY (`system_version`,`warning_date`,`warning_type`,`rule_no`,`warning_grade`),
  KEY `INDEX_WARN_DATE` (`warning_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `work_calendar` */

DROP TABLE IF EXISTS `work_calendar`;

CREATE TABLE `work_calendar` (
  `proc_date` date NOT NULL,
  `is_work_day` int(11) NOT NULL DEFAULT '1',
  `fcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `lcd` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`proc_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!50106 set global event_scheduler = 1*/;

/* Event structure for event `data_process_0` */

/*!50106 DROP EVENT IF EXISTS `data_process_0`*/;

DELIMITER $$

/*!50106 CREATE DEFINER=`sqaopr`@`%` EVENT `data_process_0` ON SCHEDULE EVERY 1 DAY STARTS '2016-01-23 02:04:15' ON COMPLETION NOT PRESERVE ENABLE DO CALL exec_procedure_by_dev('产险系统开发部') */$$
DELIMITER ;

/* Event structure for event `data_process_1` */

/*!50106 DROP EVENT IF EXISTS `data_process_1`*/;

DELIMITER $$

/*!50106 CREATE DEFINER=`sqaopr`@`%` EVENT `data_process_1` ON SCHEDULE EVERY 1 DAY STARTS '2016-01-23 02:04:15' ON COMPLETION NOT PRESERVE ENABLE DO CALL exec_procedure_by_dev('信托系统开发部') */$$
DELIMITER ;

/* Event structure for event `data_process_10` */

/*!50106 DROP EVENT IF EXISTS `data_process_10`*/;

DELIMITER $$

/*!50106 CREATE DEFINER=`sqaopr`@`%` EVENT `data_process_10` ON SCHEDULE EVERY 1 DAY STARTS '2016-01-23 02:04:15' ON COMPLETION NOT PRESERVE ENABLE DO CALL exec_procedure_by_dev('数科系统开发部') */$$
DELIMITER ;

/* Event structure for event `data_process_11` */

/*!50106 DROP EVENT IF EXISTS `data_process_11`*/;

DELIMITER $$

/*!50106 CREATE DEFINER=`sqaopr`@`%` EVENT `data_process_11` ON SCHEDULE EVERY 1 DAY STARTS '2016-01-23 02:04:15' ON COMPLETION NOT PRESERVE ENABLE DO CALL exec_procedure_by_dev('多媒体接触平台部') */$$
DELIMITER ;

/* Event structure for event `data_process_12` */

/*!50106 DROP EVENT IF EXISTS `data_process_12`*/;

DELIMITER $$

/*!50106 CREATE DEFINER=`sqaopr`@`%` EVENT `data_process_12` ON SCHEDULE EVERY 1 DAY STARTS '2016-01-23 02:04:15' ON COMPLETION NOT PRESERVE ENABLE DO CALL exec_procedure_by_dev('CRM团队') */$$
DELIMITER ;

/* Event structure for event `data_process_2` */

/*!50106 DROP EVENT IF EXISTS `data_process_2`*/;

DELIMITER $$

/*!50106 CREATE DEFINER=`sqaopr`@`%` EVENT `data_process_2` ON SCHEDULE EVERY 1 DAY STARTS '2016-01-23 02:04:15' ON COMPLETION NOT PRESERVE ENABLE DO CALL exec_procedure_by_dev('投资管理系统开发部') */$$
DELIMITER ;

/* Event structure for event `data_process_3` */

/*!50106 DROP EVENT IF EXISTS `data_process_3`*/;

DELIMITER $$

/*!50106 CREATE DEFINER=`sqaopr`@`%` EVENT `data_process_3` ON SCHEDULE EVERY 1 DAY STARTS '2016-01-23 02:04:15' ON COMPLETION NOT PRESERVE ENABLE DO CALL exec_procedure_by_dev('集团系统开发部') */$$
DELIMITER ;

/* Event structure for event `data_process_4` */

/*!50106 DROP EVENT IF EXISTS `data_process_4`*/;

DELIMITER $$

/*!50106 CREATE DEFINER=`sqaopr`@`%` EVENT `data_process_4` ON SCHEDULE EVERY 1 DAY STARTS '2016-01-23 02:04:15' ON COMPLETION NOT PRESERVE ENABLE DO CALL exec_procedure_by_dev('医健系统开发部') */$$
DELIMITER ;

/* Event structure for event `data_process_5` */

/*!50106 DROP EVENT IF EXISTS `data_process_5`*/;

DELIMITER $$

/*!50106 CREATE DEFINER=`sqaopr`@`%` EVENT `data_process_5` ON SCHEDULE EVERY 1 DAY STARTS '2016-01-23 02:04:15' ON COMPLETION NOT PRESERVE ENABLE DO CALL exec_procedure_by_dev('养老险系统开发部') */$$
DELIMITER ;

/* Event structure for event `data_process_6` */

/*!50106 DROP EVENT IF EXISTS `data_process_6`*/;

DELIMITER $$

/*!50106 CREATE DEFINER=`sqaopr`@`%` EVENT `data_process_6` ON SCHEDULE EVERY 1 DAY STARTS '2016-01-23 02:04:15' ON COMPLETION NOT PRESERVE ENABLE DO CALL exec_procedure_by_dev('网络金融系统开发部') */$$
DELIMITER ;

/* Event structure for event `data_process_7` */

/*!50106 DROP EVENT IF EXISTS `data_process_7`*/;

DELIMITER $$

/*!50106 CREATE DEFINER=`sqaopr`@`%` EVENT `data_process_7` ON SCHEDULE EVERY 1 DAY STARTS '2016-01-23 02:04:15' ON COMPLETION NOT PRESERVE ENABLE DO CALL exec_procedure_by_dev('寿险系统开发部') */$$
DELIMITER ;

/* Event structure for event `data_process_8` */

/*!50106 DROP EVENT IF EXISTS `data_process_8`*/;

DELIMITER $$

/*!50106 CREATE DEFINER=`sqaopr`@`%` EVENT `data_process_8` ON SCHEDULE EVERY 1 DAY STARTS '2016-01-23 02:04:15' ON COMPLETION NOT PRESERVE ENABLE DO CALL exec_procedure_by_dev('公共平台开发部') */$$
DELIMITER ;

/* Event structure for event `data_process_9` */

/*!50106 DROP EVENT IF EXISTS `data_process_9`*/;

DELIMITER $$

/*!50106 CREATE DEFINER=`sqaopr`@`%` EVENT `data_process_9` ON SCHEDULE EVERY 1 DAY STARTS '2016-01-23 02:04:15' ON COMPLETION NOT PRESERVE ENABLE DO CALL exec_procedure_by_dev('信贷系统开发部') */$$
DELIMITER ;

/* Function  structure for function  `calculate_test_execute` */

/*!50003 DROP FUNCTION IF EXISTS `calculate_test_execute` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` FUNCTION `calculate_test_execute`(SystemVersion varchar(200),TestDate date) RETURNS decimal(4,0)
BEGIN
	declare v_case_count_temp DECIMAL(4,0);
	declare v_actual_percent varchar(10);
	DECLARE v_case_exe_sum DECIMAL(4,0) DEFAULT 0;
	DECLARE v_case_exe_sum_temp DECIMAL(4,0);
	declare v_case_count_st DECIMAL(4,0)  DEFAULT 0 ;
	DECLARE v_case_count_uat DECIMAL(4,0) DEFAULT 0 ;
	DECLARE notfound INT DEFAULT 0 ;
	declare v_test_date date;
	DECLARE c_actual_exe_percent CURSOR FOR
		SELECT case_count,execute_percent FROM test_schedule WHERE  schedule_date=TestDate AND system_version=systemVersion AND test_plan='ST进度计划';
	DECLARE c_actual_uat_exe_percent CURSOR FOR
		SELECT case_count,execute_percent FROM test_schedule WHERE  schedule_date=TestDate AND system_version=systemVersion AND test_plan='UAT进度计划';
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET notfound = 1;
	OPEN c_actual_exe_percent;
	REPEAT
           FETCH c_actual_exe_percent INTO v_case_count_temp,v_actual_percent;
             IF notfound<>1 THEN
                set v_case_count_st:=v_case_count_st+if(v_case_count_temp=0,1,v_case_count_temp);	
		SET v_case_exe_sum_temp:=ROUND(v_case_count_temp*ROUND((REPLACE(v_actual_percent,'%','')*100/10000),2),0);
		SET v_case_exe_sum:=v_case_exe_sum+v_case_exe_sum_temp;
		-- select v_case_count_temp, v_actual_percent,v_case_exe_sum_temp,v_case_exe_sum;
	     END IF;
	UNTIL notfound=1
	END REPEAT;
	SET notfound:=0;
	CLOSE c_actual_exe_percent;
	UPDATE test_execute_plan SET st_actual_execute_percent=ifnull(ROUND(v_case_exe_sum/v_case_count_st,2),0.00) WHERE system_version=systemVersion AND test_date=TestDate;
	SET v_case_exe_sum:=0;
	OPEN c_actual_uat_exe_percent;
	REPEAT
           FETCH c_actual_uat_exe_percent INTO v_case_count_temp,v_actual_percent;
             IF notfound<>1 THEN
                SET v_case_count_uat:=v_case_count_uat+IF(v_case_count_temp=0,1,v_case_count_temp);	
		SET v_case_exe_sum_temp:=ROUND(v_case_count_temp*ROUND((REPLACE(v_actual_percent,'%','')*100/10000),2),0);
		SET v_case_exe_sum:=v_case_exe_sum+v_case_exe_sum_temp;
	     END IF;
	  UNTIL notfound=1
	END REPEAT;
	CLOSE c_actual_uat_exe_percent;
	UPDATE test_execute_plan SET uat_actual_execute_percent=ifnull(ROUND(v_case_exe_sum/v_case_count_uat,2),0.00) WHERE system_version=systemVersion AND test_date=TestDate;   
        RETURN v_case_count_uat;
    END */$$
DELIMITER ;

/* Function  structure for function  `calculate_workdays` */

/*!50003 DROP FUNCTION IF EXISTS `calculate_workdays` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` FUNCTION `calculate_workdays`(systemVersion VARCHAR(200)) RETURNS decimal(3,0)
BEGIN
    DECLARE c_start_date DATE;
    DECLARE c_end_date DATE;
    DECLARE c_date_temp DATE;
    DECLARE flag BOOLEAN;
    DECLARE days DECIMAL(3,0)DEFAULT 0;
    declare day_sum DECIMAL(3,0)DEFAULT 0;
    SELECT first_deploy_test_time,DATE_ADD(reviewTest_end_date,INTERVAL -1 DAY) INTO c_start_date,c_end_date FROM version_plantime WHERE system_version =systemVersion;
    SET c_date_temp:=c_start_date;   
    WHILE c_date_temp<=c_end_date DO
	SELECT judgement_workday(c_date_temp) INTO flag;
        IF(flag) THEN
		SET days:=days+1;
		SELECT COUNT(*) into day_sum FROM  test_execute_plan WHERE system_version=systemVersion AND test_date=c_date_temp;  
		if day_sum=0 then
			replace into test_execute_plan(system_version,test_date,execute_percent)values(systemVersion,c_date_temp,null);
		end if;
	END IF; 
	SET c_date_temp= DATE_ADD(c_date_temp,INTERVAL 1 DAY);      
    END WHILE;  
    RETURN days;    
    END */$$
DELIMITER ;

/* Function  structure for function  `deal_gompertz_data` */

/*!50003 DROP FUNCTION IF EXISTS `deal_gompertz_data` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` FUNCTION `deal_gompertz_data`(systemVersion VARCHAR (200),expect_bugNum DECIMAL (3, 0),part_define_orginal FLOAT,part_define float,part_rate_define_orginal FLOAT ,part_rate_define float) RETURNS decimal(3,0)
BEGIN
  DECLARE test_date_temp DATE ;
  DECLARE test_date_num DECIMAL (3, 0) ;
  DECLARE rate FLOAT ;
  DECLARE rate_temp FLOAT ;
  DECLARE start_date DATE ;
  DECLARE end_date DATE ;
  DECLARE i INTEGER DEFAULT 1;
  DECLARE notfound INT DEFAULT 0 ;
  DECLARE cur_test_date CURSOR FOR 
  SELECT 
    test_date 
  FROM
    bug_found_trend 
  WHERE system_version = systemVersion ;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET notfound = 1 ;
 
  SELECT 
    query_test_date (systemVersion, part_define_orginal) INTO start_date ;
  SELECT 
    query_test_date (systemVersion, part_define) INTO end_date ;
  SELECT 
    COUNT(*) INTO test_date_num 
  FROM
    bug_found_trend 
  WHERE system_version = systemVersion 
    AND test_date >= start_date 
    AND test_date < end_date ;
   SET rate = round((part_rate_define-part_rate_define_orginal)/ test_date_num ,2);
   OPEN cur_test_date ;
  REPEAT
    FETCH cur_test_date INTO test_date_temp ;
    IF test_date_temp >= start_date && test_date_temp!=end_date THEN
    SET rate_temp=ROUND(rate*i,2)+part_rate_define_orginal;
    IF i=test_date_num THEN
    SET rate_temp=part_rate_define;
    END IF;
       REPLACE INTO `sqcs`.`Gompertz_modual_define` (
      `system_version`,
      `expect_bug_num`,
      `test_date`,
      `bug_found_rate`,
      `bug_found_num`
    ) 
    VALUES
      (
        systemVersion,
        expect_bugNum,
        test_date_temp,
        rate_temp,
        ceil(expect_bugNum * rate_temp)
      ) ;
      SET i=i+1;
      END IF ;
     UNTIL test_date_temp = end_date 
    END REPEAT ;
    CLOSE cur_test_date;
    return test_date_num;
    END */$$
DELIMITER ;

/* Function  structure for function  `func_get_splitStringTotal` */

/*!50003 DROP FUNCTION IF EXISTS `func_get_splitStringTotal` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` FUNCTION `func_get_splitStringTotal`( 
f_string varchar(10000),f_delimiter varchar(50) 
) RETURNS int(11)
BEGIN 
return 1+(length(f_string) - length(replace(f_string,f_delimiter,''))); 
END */$$
DELIMITER ;

/* Function  structure for function  `func_splitString` */

/*!50003 DROP FUNCTION IF EXISTS `func_splitString` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` FUNCTION `func_splitString`( f_string varchar(1000),f_delimiter varchar(5),f_order int) RETURNS varchar(255) CHARSET utf8
BEGIN 
declare result varchar(255) default ''; 
set result = reverse(substring_index(reverse(substring_index(f_string,f_delimiter,f_order)),f_delimiter,1)); 
return result; 
END */$$
DELIMITER ;

/* Function  structure for function  `judgement_workday` */

/*!50003 DROP FUNCTION IF EXISTS `judgement_workday` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` FUNCTION `judgement_workday`(test_date date) RETURNS tinyint(1)
BEGIN
  DECLARE v_flag BOOLEAN ;
  DECLARE flag BOOLEAN ;
  SELECT 
    is_work_day into v_flag 
  FROM
    work_calendar 
  WHERE proc_date = test_date ;
  IF NOT v_flag 
  THEN SET flag = FALSE ;
  ELSE SET flag = TRUE ;
  END IF ;
  RETURN flag ;
END */$$
DELIMITER ;

/* Function  structure for function  `query_bug_by_developer` */

/*!50003 DROP FUNCTION IF EXISTS `query_bug_by_developer` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` FUNCTION `query_bug_by_developer`(
  person VARCHAR (100),
  system_version VARCHAR (200),
  systemOrVersion VARCHAR (50),
  bug_level VARCHAR (100)
) RETURNS decimal(4,0)
BEGIN
  DECLARE bug_sum DECIMAL (4, 0) ;
  DECLARE system_name VARCHAR (200) ;
  IF systemOrVersion = 'system' 
  THEN IF bug_level = '' 
  THEN 
  SELECT 
    COUNT(*) INTO bug_sum 
  FROM
    problem_list 
  WHERE pro_system = q_sysname_by_version (system_version) 
    AND pro_deal_person = person ;
  ELSE 
  SELECT 
    COUNT(*) INTO bug_sum 
  FROM
    problem_list 
  WHERE pro_system = q_sysname_by_version (system_version) 
    AND pro_deal_person = person 
    AND pro_level = bug_level ;
  END IF ;
  ELSE IF bug_level = '' 
  THEN 
  SELECT 
    COUNT(*) INTO bug_sum 
  FROM
    problem_list 
  WHERE pro_version = system_version 
    AND pro_deal_person = person ;
  ELSE 
  SELECT 
    COUNT(*) INTO bug_sum 
  FROM
    problem_list 
  WHERE pro_version = system_version 
    AND pro_deal_person = person 
    AND pro_level = bug_level ;
  END IF ;
  END IF ;
  RETURN bug_sum ;
END */$$
DELIMITER ;

/* Function  structure for function  `query_bug_by_tester` */

/*!50003 DROP FUNCTION IF EXISTS `query_bug_by_tester` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` FUNCTION `query_bug_by_tester`(
  person VARCHAR (100),
  system_version VARCHAR (200),
  systemOrVersion VARCHAR (50),
  bug_level VARCHAR (100)
) RETURNS decimal(4,0)
BEGIN
  DECLARE bug_sum DECIMAL (4, 0) ;
  DECLARE system_name VARCHAR (200) ;
  IF systemOrVersion = 'system' 
  THEN 
  SELECT 
    pro_system INTO system_name 
  FROM
    problem_list 
  WHERE pro_version = system_version 
  LIMIT 0, 1 ;
  IF person = '部署' 
  and bug_level = '' 
  then 
  SELECT 
    COUNT(*) INTO bug_sum 
  FROM
    problem_list 
  WHERE pro_system = system_name 
    AND pro_source = '部署' ;
  end if ;
  if person = '部署' 
  AND bug_level <> '' 
  THEN 
  SELECT 
    COUNT(*) INTO bug_sum 
  FROM
    problem_list 
  WHERE pro_system = system_name 
    AND pro_source = '部署' 
    AND pro_level = bug_level ;
  end if ;
  IF person <> '部署' 
  AND bug_level = '' 
  THEN 
  SELECT 
    COUNT(*) INTO bug_sum 
  FROM
    problem_list 
  WHERE pro_system = system_name 
    AND pro_found_person = person ;
  END IF ;
  IF person <> '部署' 
  AND bug_level <> '' 
  THEN 
  SELECT 
    COUNT(*) INTO bug_sum 
  FROM
    problem_list 
  WHERE pro_system = system_name 
    AND pro_found_person = person 
    AND pro_level = bug_level ;
  END IF ;
  ELSE IF person = '部署' 
  AND bug_level = '' 
  THEN 
  SELECT 
    COUNT(*) INTO bug_sum 
  FROM
    problem_list 
  WHERE pro_version = system_version 
    AND pro_source = '部署' ;
  end if ;
  IF person = '部署' 
  AND bug_level <> '' 
  THEN 
  SELECT 
    COUNT(*) INTO bug_sum 
  FROM
    problem_list 
  WHERE pro_version = system_version 
    AND pro_source = '部署' 
    AND pro_level = bug_level ;
  END IF ;
  IF person <> '部署' 
  AND bug_level = '' 
  THEN 
  SELECT 
    COUNT(*) INTO bug_sum 
  FROM
    problem_list 
  WHERE pro_version = system_version 
    AND pro_found_person = person ;
  END IF ;
  IF person <> '部署' 
  AND bug_level <> '' 
  THEN 
  SELECT 
    COUNT(*) INTO bug_sum 
  FROM
    problem_list 
  WHERE pro_version = system_version 
    AND pro_found_person = person 
    AND pro_level = bug_level ;
  END IF ;
  END IF ;
  RETURN bug_sum ;
END */$$
DELIMITER ;

/* Function  structure for function  `query_bug_close_sum_everyday` */

/*!50003 DROP FUNCTION IF EXISTS `query_bug_close_sum_everyday` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`10.43.122.47` FUNCTION `query_bug_close_sum_everyday`(
  test_date DATE,
  VERSION varchar (100),
  test_last_date DATE
) RETURNS decimal(4,0)
BEGIN
  -- 查出每天关闭的BUG数 
  declare v_bug_close_sum varchar (20) ;
  declare c_bug_close_sum cursor for 
  SELECT 
    COUNT(*) bug_sum 
  FROM
    (SELECT 
      pro_id 
    FROM
      problem_list 
    WHERE DATE_FORMAT(pro_close_date,'%Y-%m-%d') <= test_date 
      AND pro_version = VERSION
     -- and pro_dept='平安科技养老险及健康险系统开发部'
      AND pro_source IN (
        '系统测试',
        '冒烟测试',
        '回归测试',
        '用户验收测试',
        '测试人员上报'
      ) 
      and pro_id not in 
      (SELECT 
        pro_id 
      FROM
        problem_list 
      WHERE DATE_FORMAT(pro_close_date,'%Y-%m-%d') < test_last_date 
        AND pro_version = VERSION
     --   AND pro_dept='平安科技养老险及健康险系统开发部'
        AND pro_source IN (
          '系统测试',
          '冒烟测试',
          '回归测试',
          '用户验收测试',
          '测试人员上报'
        ))) as a ;
  open c_bug_close_sum ;
  fetch c_bug_close_sum into v_bug_close_sum ;
  return cast(v_bug_close_sum as decimal) ;
END */$$
DELIMITER ;

/* Function  structure for function  `query_bug_deal_sum_everyday` */

/*!50003 DROP FUNCTION IF EXISTS `query_bug_deal_sum_everyday` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`10.43.122.47` FUNCTION `query_bug_deal_sum_everyday`(
  test_date DATE,
  VERSION varchar (100),
  test_last_date DATE
) RETURNS decimal(4,0)
BEGIN
  -- 查出每天解决的BUG数 
  DECLARE bug_deal_sum varchar (20) ;
  declare c_bug_deal_sum cursor for 
  SELECT 
    COUNT(*) bug_sum 
  FROM
    (SELECT 
      pro_id 
    FROM
      problem_list 
    WHERE DATE_FORMAT(pro_deal_date,'%Y-%m-%d') <= test_date 
      AND pro_version = VERSION
    --  AND pro_dept='平安科技养老险及健康险系统开发部'
      AND pro_source IN (
        '系统测试',
        '冒烟测试',
        '回归测试',
        '用户验收测试',
        '测试人员上报'
      ) 
      AND pro_id NOT IN 
      (SELECT 
        pro_id 
      FROM
        problem_list 
      WHERE DATE_FORMAT(pro_deal_date,'%Y-%m-%d') < test_last_date 
        AND pro_version = VERSION
        
        AND pro_source IN (
          '系统测试',
          '冒烟测试',
          '回归测试',
          '用户验收测试',
          '测试人员上报'
        ))) AS a ;
  open c_bug_deal_sum ;
  fetch c_bug_deal_sum into bug_deal_sum ;
  return cast(bug_deal_sum as decimal) ;
END */$$
DELIMITER ;

/* Function  structure for function  `query_bug_found_sum_everyday` */

/*!50003 DROP FUNCTION IF EXISTS `query_bug_found_sum_everyday` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`10.43.122.47` FUNCTION `query_bug_found_sum_everyday`(
  test_date DATE,
  VERSION varchar (100),
  test_last_date DATE
) RETURNS decimal(4,0)
BEGIN
  declare v_bug_sum varchar (20) ;
  declare v_bug_sum_everyday cursor for 
  SELECT 
    COUNT(*) bug_sum 
  FROM
    (SELECT 
      pro_id 
    FROM
      problem_list 
    WHERE DATE_FORMAT(pro_found_date,'%Y-%m-%d') <= test_date 
      AND pro_version = VERSION
    --  AND pro_dept='平安科技养老险及健康险系统开发部'
      AND pro_source IN (
        '系统测试',
        '冒烟测试',
        '回归测试',
        '用户验收测试',
        '测试人员上报'
      ) 
      AND pro_id NOT IN 
      (SELECT 
        pro_id 
      FROM
        problem_list 
      WHERE DATE_FORMAT(pro_found_date,'%Y-%m-%d') < test_last_date 
        AND pro_version = VERSION
       -- AND pro_dept='平安科技养老险及健康险系统开发部'
        AND pro_source IN (
          '系统测试',
          '冒烟测试',
          '回归测试',
          '用户验收测试',
          '测试人员上报'
        ))) AS a ;
  open v_bug_sum_everyday ;
  fetch v_bug_sum_everyday into v_bug_sum ;
  return CAST(v_bug_sum as DECIMAL) ;
END */$$
DELIMITER ;

/* Function  structure for function  `query_bug_increase_exp` */

/*!50003 DROP FUNCTION IF EXISTS `query_bug_increase_exp` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` FUNCTION `query_bug_increase_exp`(p_system_name VARCHAR (200)) RETURNS decimal(6,5)
BEGIN
  DECLARE v_bug_increase_exp DECIMAL (6, 5) ;
  SELECT 
    bug_increase_exp INTO v_bug_increase_exp 
  FROM
    dept_system 
  WHERE system_alias = p_system_name 
  LIMIT 0, 1 ;
  return v_bug_increase_exp ;
END */$$
DELIMITER ;

/* Function  structure for function  `query_bug_increase_spd` */

/*!50003 DROP FUNCTION IF EXISTS `query_bug_increase_spd` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` FUNCTION `query_bug_increase_spd`(p_system_name VARCHAR (200)) RETURNS decimal(6,5)
BEGIN
  DECLARE v_bug_increase_spd DECIMAL (6, 5) ;
  SELECT 
    bug_increase_spd INTO v_bug_increase_spd 
  FROM
    dept_system 
  WHERE system_alias = p_system_name 
  LIMIT 0, 1 ;
  RETURN v_bug_increase_spd ;
END */$$
DELIMITER ;

/* Function  structure for function  `query_bug_null_close` */

/*!50003 DROP FUNCTION IF EXISTS `query_bug_null_close` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`10.50.124.135` FUNCTION `query_bug_null_close`(system_version VARCHAR (60)) RETURNS decimal(4,0)
BEGIN
  DECLARE bug_close_sum VARCHAR (60) ;
  DECLARE v_close_bug CURSOR FOR 
  SELECT 
    COUNT(*) 
  FROM
    problem_list 
  WHERE pro_version = system_version 
    AND pro_close_date IS NULL 
 --   AND pro_dept='平安科技养老险及健康险系统开发部'
    AND pro_source IN (
      '系统测试',
      '冒烟测试',
      '回归测试',
      '测试人员上报'
    ) ;
  OPEN v_close_bug ;
  FETCH v_close_bug INTO bug_close_sum ;
  CLOSE v_close_bug ;
  IF bug_close_sum IS NULL 
  THEN SET bug_close_sum = 0 ;
  END IF ;
  RETURN CAST(bug_close_sum AS DECIMAL) ;
END */$$
DELIMITER ;

/* Function  structure for function  `query_bug_null_closedate` */

/*!50003 DROP FUNCTION IF EXISTS `query_bug_null_closedate` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`10.50.124.135` FUNCTION `query_bug_null_closedate`(system_version VARCHAR (60)) RETURNS decimal(4,0)
BEGIN
  DECLARE bug_close_sum VARCHAR (60) ;
  DECLARE v_close_bug CURSOR FOR 
  SELECT 
    COUNT(*) 
  FROM
    problem_list 
  WHERE pro_version = system_version 
    AND pro_close_date IS NULL 
  --  AND pro_dept='平安科技养老险及健康险系统开发部'
    AND pro_source IN (
      '系统测试',
      '冒烟测试',
      '回归测试',
      '测试人员上报'
    ) ;
  OPEN v_close_bug ;
  FETCH v_close_bug INTO bug_close_sum ;
  CLOSE v_close_bug ;
  IF bug_close_sum IS NULL 
  THEN SET bug_close_sum = 0 ;
  END IF ;
  RETURN CAST(bug_close_sum AS DECIMAL) ;
END */$$
DELIMITER ;

/* Function  structure for function  `query_bug_null_deal` */

/*!50003 DROP FUNCTION IF EXISTS `query_bug_null_deal` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`10.50.124.135` FUNCTION `query_bug_null_deal`(system_version VARCHAR (60)) RETURNS decimal(4,0)
BEGIN
  DECLARE bug_deal_sum VARCHAR (60) ;
  DECLARE v_deal_bug CURSOR FOR 
  SELECT 
    COUNT(*) 
  FROM
    problem_list 
  WHERE pro_version = system_version 
    AND pro_deal_date IS NULL 
  --  AND pro_dept='平安科技养老险及健康险系统开发部'
    AND pro_source IN (
      '系统测试',
      '冒烟测试',
      '回归测试',
      '测试人员上报'
    ) ;
  OPEN v_deal_bug ;
  FETCH v_deal_bug INTO bug_deal_sum ;
  CLOSE v_deal_bug ;
  IF bug_deal_sum IS NULL 
  THEN SET bug_deal_sum = 0 ;
  END IF ;
  RETURN CAST(bug_deal_sum AS DECIMAL) ;
END */$$
DELIMITER ;

/* Function  structure for function  `query_bug_null_dealdate` */

/*!50003 DROP FUNCTION IF EXISTS `query_bug_null_dealdate` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`10.50.124.135` FUNCTION `query_bug_null_dealdate`(system_version VARCHAR (60)) RETURNS decimal(4,0)
BEGIN
  DECLARE bug_deal_sum VARCHAR (60) ;
  DECLARE v_deal_bug CURSOR FOR 
  SELECT 
    COUNT(*) 
  FROM
    problem_list 
  WHERE pro_version = system_version 
    AND pro_deal_date IS NULL 
  --  AND pro_dept='平安科技养老险及健康险系统开发部'
    AND pro_source IN (
      '系统测试',
      '冒烟测试',
      '回归测试',
      '测试人员上报'
    ) ;
  OPEN v_deal_bug ;
  FETCH v_deal_bug INTO bug_deal_sum ;
  CLOSE v_deal_bug ;
  IF bug_deal_sum IS NULL 
  THEN SET bug_deal_sum = 0 ;
  END IF ;
  RETURN CAST(bug_deal_sum AS DECIMAL) ;
END */$$
DELIMITER ;

/* Function  structure for function  `query_bug_serious_sum_everyday` */

/*!50003 DROP FUNCTION IF EXISTS `query_bug_serious_sum_everyday` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`10.43.122.47` FUNCTION `query_bug_serious_sum_everyday`(
  test_date DATE,
  bug_level varchar (20),
  VERSION VARCHAR (50),
  test_last_date DATE
) RETURNS decimal(4,0)
BEGIN
  -- 按BUG等级汇总每天发现的BUG数
  declare v_bug_sum_bylevel varchar (20) ;
  declare c_bug_sum_byLevel cursor for 
  SELECT 
    COUNT(*) bug_sum 
  FROM
    (SELECT 
      pro_id 
    FROM
      problem_list 
    WHERE DATE_FORMAT(pro_found_date,'%Y-%m-%d') <= test_date 
      AND pro_level = bug_level 
      AND pro_version = VERSION
     -- AND pro_dept='平安科技养老险及健康险系统开发部'
      AND pro_source IN (
        '系统测试',
        '冒烟测试',
        '回归测试',
        '测试人员上报'
      ) 
      and pro_id not in 
      (SELECT 
        pro_id 
      FROM
        problem_list 
      WHERE DATE_FORMAT(pro_found_date,'%Y-%m-%d') < test_last_date 
        AND pro_level = bug_level 
        AND pro_version = VERSION
       -- AND pro_dept='平安科技养老险及健康险系统开发部'
        AND pro_source IN (
          '系统测试',
          '冒烟测试',
          '回归测试',
          '测试人员上报'
        ))) as a ;
  open c_bug_sum_byLevel ;
  fetch c_bug_sum_byLevel into v_bug_sum_bylevel ;
  return cast(v_bug_sum_bylevel as decimal) ;
END */$$
DELIMITER ;

/* Function  structure for function  `query_deal_overtime_bug` */

/*!50003 DROP FUNCTION IF EXISTS `query_deal_overtime_bug` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`10.50.124.135` FUNCTION `query_deal_overtime_bug`(
  pro_id_temp VARCHAR (60)
  ) RETURNS float(6,2)
BEGIN
  DECLARE check_bug_time FLOAT(6,2);
  DECLARE check_bug_hour DECIMAL(10,0);
  DECLARE check_bug_sceond FLOAT(6,2);
  DECLARE start_time_temp DATE ;
  DECLARE end_time_temp DATE ;
  DECLARE start_time DATETIME ;
  DECLARE end_time DATETIME ;
  DECLARE sec TIME ;
  DECLARE sec_tmp TIME ;
  DECLARE flag BOOLEAN;
  SELECT pro_found_date,pro_deal_date INTO start_time_temp,end_time_temp FROM problem_list WHERE pro_id = pro_id_temp ;
  SELECT pro_found_date,pro_deal_date INTO start_time,end_time FROM problem_list WHERE pro_id = pro_id_temp ;
  IF end_time IS NULL THEN
  SET end_time_temp=DATE(NOW());
  SET end_time=NOW();
  END IF;
   SELECT  TIMEDIFF(end_time, start_time) INTO sec;-- FROM  problem_list WHERE pro_id = pro_id_temp  ; 
 
  SELECT judgement_workday(start_time_temp) INTO flag;
  IF NOT flag THEN
     SELECT 
          IF(DATE(end_time)>DATE(start_time),TIMEDIFF('23:59:59',TIME(start_time)),TIMEDIFF(TIME(end_time),TIME(start_time)))
        INTO sec_tmp ;
       -- FROM problem_list  WHERE pro_id=pro_id_temp;
     SELECT  TIMEDIFF(sec, sec_tmp) INTO sec ;     
   -- 如果是工作日
   ELSE
      -- 如果开始日期早于上班时间，减去这段时间
      SELECT IF(TIME(start_time)<'08:55:00',TIMEDIFF('08:55:00',TIME(start_time)),'00:00:00') INTO sec_tmp;-- FROM problem_list WHERE pro_id=pro_id_temp;
      SELECT TIMEDIFF(sec, sec_tmp) INTO sec ;
       -- 如果中间有午休时间，去掉午休时间
      SELECT IF(TIME(start_time)<'12:00:00' AND (TIME(end_time)>'13:30:00' OR DATE(end_time)>DATE(start_time)),'01:30:00','00:00:00') INTO sec_tmp;-- FROM problem_list WHERE pro_id=pro_id_temp;
      SELECT TIMEDIFF(sec, sec_tmp) INTO sec ;  
      -- 去掉第一天下班后的时间，如果结束日大于开始日，下班后的时间为 TIMEDIFF('23:59:59','18:00:00')；否则如果结束日大于下班时间，下班后时间为TIMEDIFF(TIME(end_time),'18:00:00')，否则为0
      SELECT IF(DATE(end_time)>DATE(start_time)AND TIME(start_time)<'18:00:00',TIMEDIFF('23:59:59','18:00:00'),IF(DATE(end_time)>DATE(start_time)AND TIME(start_time)>'18:00:00',TIMEDIFF('23:59:59',TIME(start_time)),'00:00:00')) INTO sec_tmp;-- FROM problem_list WHERE pro_id=pro_id_temp;      
      SELECT  TIMEDIFF(sec, sec_tmp) INTO sec ;
    END IF ;    
     -- 如果结束日期>开始日期人，减去最后一天的非工作时
   IF end_time_temp>start_time_temp THEN
 -- 判断最后一天是否工作日
    SELECT judgement_workday(end_time_temp) INTO flag; 
  -- 如果不是工作日,减去这一天
    IF NOT flag THEN
     SELECT TIME(end_time)INTO sec_tmp;-- FROM problem_list WHERE pro_id=pro_id_temp;
     SELECT TIMEDIFF(sec, sec_tmp) INTO sec ;
   -- 如果是工作日
    ELSE
    -- 如果结束日期晚于上班时间，减去这段时间
      SELECT IF(TIME(end_time)>'18:00:00',TIMEDIFF(TIME(end_time),'18:00:00'),'00:00:00') INTO sec_tmp;-- FROM problem_list WHERE pro_id=pro_id_temp; 
      SELECT TIMEDIFF(sec, sec_tmp) INTO sec ; 
    -- 去掉午休时间
      SELECT IF(TIME(end_time)>'13:30:00','01:30:00','00:00:00') INTO sec_tmp;-- FROM problem_list WHERE pro_id=pro_id_temp;
      SELECT TIMEDIFF(sec, sec_tmp) INTO sec ;  
    -- 如果结束日期大于8：55：00，减去上班之前的时间（8：55），否则减去close date的时间
      SELECT IF(TIME(end_time)>'08:55:00','08:55:00',TIME(end_time))INTO sec_tmp;-- FROM problem_list WHERE pro_id=pro_id_temp;
      SELECT TIMEDIFF(sec, sec_tmp) INTO sec ;
    END IF;  
  -- 处理除第一天和最后一天的时间  
  SELECT DATE_ADD(start_time_temp, INTERVAL 1 DAY) INTO start_time_temp;  
  WHILE start_time_temp<end_time_temp DO
    SELECT judgement_workday(start_time_temp)INTO flag;
  -- 如果不是工作日
    IF NOT flag THEN
      SET sec_tmp='24:00:00';
      SELECT TIMEDIFF(sec, sec_tmp) INTO sec ;  
     -- 如果是调整上班日,减去非工作时（一天工作7.58小时）   
     ELSE
      SELECT TIMEDIFF('24:00:00', '07:34:08') INTO sec_tmp ;
      SELECT TIMEDIFF(sec, sec_tmp) INTO sec ;  
    END IF;
    SELECT DATE_ADD(start_time_temp, INTERVAL 1 DAY) INTO start_time_temp; 
   END WHILE;
  END IF;  
  SELECT HOUR(sec) INTO check_bug_hour;
  SELECT SECOND(sec)INTO check_bug_sceond;
  SET check_bug_sceond=check_bug_sceond/60;
  SET check_bug_time=check_bug_hour+check_bug_sceond;
  RETURN check_bug_time;
END */$$
DELIMITER ;

/* Function  structure for function  `query_deal_overtime_bug_fordone` */

/*!50003 DROP FUNCTION IF EXISTS `query_deal_overtime_bug_fordone` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`10.50.124.135` FUNCTION `query_deal_overtime_bug_fordone`(
  pro_id_temp VARCHAR (60)
  ) RETURNS float(6,2)
BEGIN
  DECLARE check_bug_time FLOAT(6,2);
  DECLARE check_bug_hour DECIMAL(10,0);
  DECLARE check_bug_sceond FLOAT(6,2);
  DECLARE start_time_temp DATE ;
  DECLARE end_time_temp DATE ;
  DECLARE sec TIME ;
  DECLARE sec_tmp TIME ;
  DECLARE flag BOOLEAN;
  SELECT pro_found_date,pro_deal_date INTO start_time_temp,end_time_temp FROM problem_list WHERE pro_id = pro_id_temp ;
 
   SELECT  TIMEDIFF(pro_deal_date, pro_found_date) INTO sec FROM  problem_list WHERE pro_id = pro_id_temp  ; 
 
  SELECT judgement_workday(start_time_temp) INTO flag;
  IF NOT flag THEN
     SELECT 
          IF(DATE(pro_deal_date)>DATE(pro_found_date),TIMEDIFF('23:59:59',TIME(pro_found_date)),TIMEDIFF(TIME(pro_deal_date),TIME(pro_found_date)))
        INTO sec_tmp 
        FROM problem_list
        WHERE pro_id=pro_id_temp;
     SELECT  TIMEDIFF(sec, sec_tmp) INTO sec ;     
   -- 如果是工作日
   ELSE
      -- 如果开始日期早于上班时间，减去这段时间
      SELECT IF(TIME(pro_found_date)<'08:55:00',TIMEDIFF('08:55:00',TIME(pro_found_date)),'00:00:00') INTO sec_tmp FROM problem_list WHERE pro_id=pro_id_temp;
      SELECT TIMEDIFF(sec, sec_tmp) INTO sec ;
       -- 如果中间有午休时间，去掉午休时间
      SELECT IF(TIME(pro_found_date)<'12:00:00' AND (TIME(pro_deal_date)>'13:30:00' OR DATE(pro_deal_date)>DATE(pro_found_date)),'01:30:00','00:00:00') INTO sec_tmp FROM problem_list WHERE pro_id=pro_id_temp;
      SELECT TIMEDIFF(sec, sec_tmp) INTO sec ;  
      -- 去掉第一天下班后的时间，如果结束日大于开始日，下班后的时间为 TIMEDIFF('23:59:59','18:00:00')；否则如果结束日大于下班时间，下班后时间为TIMEDIFF(TIME(pro_deal_date),'18:00:00')，否则为0
      SELECT IF(DATE(pro_deal_date)>DATE(pro_found_date)AND TIME(pro_found_date)<'18:00:00',TIMEDIFF('23:59:59','18:00:00'),IF(DATE(pro_deal_date)>DATE(pro_found_date)AND TIME(pro_found_date)>'18:00:00',TIMEDIFF('23:59:59',TIME(pro_found_date)),'00:00:00')) INTO sec_tmp FROM problem_list WHERE pro_id=pro_id_temp;      
      SELECT  TIMEDIFF(sec, sec_tmp) INTO sec ;
    END IF ;    
     -- 如果结束日期>开始日期人，减去最后一天的非工作时
   IF end_time_temp>start_time_temp THEN
 -- 判断最后一天是否工作日
    SELECT judgement_workday(end_time_temp) INTO flag; 
  -- 如果不是工作日,减去这一天
    IF NOT flag THEN
     SELECT TIME(pro_deal_date)INTO sec_tmp FROM problem_list WHERE pro_id=pro_id_temp;
     SELECT TIMEDIFF(sec, sec_tmp) INTO sec ;
   -- 如果是工作日
    ELSE
    -- 如果结束日期晚于上班时间，减去这段时间
      SELECT IF(TIME(pro_deal_date)>'18:00:00',TIMEDIFF(TIME(pro_deal_date),'18:00:00'),'00:00:00') INTO sec_tmp FROM problem_list WHERE pro_id=pro_id_temp; 
      SELECT TIMEDIFF(sec, sec_tmp) INTO sec ; 
    -- 去掉午休时间
      SELECT IF(TIME(pro_deal_date)>'13:30:00','01:30:00','00:00:00') INTO sec_tmp FROM problem_list WHERE pro_id=pro_id_temp;
      SELECT TIMEDIFF(sec, sec_tmp) INTO sec ;  
    -- 如果结束日期大于8：55：00，减去上班之前的时间（8：55），否则减去close date的时间
      SELECT IF(TIME(pro_deal_date)>'08:55:00','08:55:00',TIME(pro_deal_date))INTO sec_tmp FROM problem_list WHERE pro_id=pro_id_temp;
      SELECT TIMEDIFF(sec, sec_tmp) INTO sec ;
    END IF;  
  -- 处理除第一天和最后一天的时间  
  SELECT DATE_ADD(start_time_temp, INTERVAL 1 DAY) INTO start_time_temp;  
  WHILE start_time_temp<end_time_temp DO
    SELECT judgement_workday(start_time_temp)INTO flag;
  -- 如果不是工作日
    IF NOT flag THEN
      SET sec_tmp='24:00:00';
      SELECT TIMEDIFF(sec, sec_tmp) INTO sec ;  
     -- 如果是调整上班日,减去非工作时（一天工作7.58小时）   
     ELSE
      SELECT TIMEDIFF('24:00:00', '07:34:08') INTO sec_tmp ;
      SELECT TIMEDIFF(sec, sec_tmp) INTO sec ;  
    END IF;
    SELECT DATE_ADD(start_time_temp, INTERVAL 1 DAY) INTO start_time_temp; 
   END WHILE;
  END IF;  
  SELECT HOUR(sec) INTO check_bug_hour;
  SELECT SECOND(sec)INTO check_bug_sceond;
  SET check_bug_sceond=check_bug_sceond/60;
  SET check_bug_time=check_bug_hour+check_bug_sceond;
  RETURN check_bug_time;
END */$$
DELIMITER ;

/* Function  structure for function  `query_expect_bug_num` */

/*!50003 DROP FUNCTION IF EXISTS `query_expect_bug_num` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` FUNCTION `query_expect_bug_num`(systemVersion varchar (200)) RETURNS decimal(3,0)
BEGIN
  declare man_power_temp decimal (3, 0) ;
  DECLARE man_power_system DECIMAL (3, 0) ;
  DECLARE expect_bug_num DECIMAL (3, 0) ;
  DECLARE version_density_temp float ;
  declare temp decimal (3, 0) default 10000 ;
  declare version_temp varchar (200) ;
  DECLARE version_temp1 VARCHAR (200) ;
  DECLARE notfound INT DEFAULT 0 ;
  declare man_power_cur cursor for 
  SELECT 
    man_power,
    system_version 
  FROM
    version_manpower 
  WHERE SR_CODE LIKE concat(
      LEFT(
        SUBSTRING_INDEX(systemVersion, '.', '1'),
        LEAST(
          IF(
            LOCATE(
              '0',
              SUBSTRING_INDEX(systemVersion, '.', '1')
            ) > 0,
            LOCATE(
              '0',
              SUBSTRING_INDEX(systemVersion, '.', '1')
            ),
            999
          ),
          IF(
            LOCATE(
              '1',
              SUBSTRING_INDEX(systemVersion, '.', '1')
            ) > 0,
            LOCATE(
              '1',
              SUBSTRING_INDEX(systemVersion, '.', '1')
            ),
            999
          ),
          IF(
            LOCATE(
              '2',
              SUBSTRING_INDEX(systemVersion, '.', '1')
            ) > 0,
            LOCATE(
              '2',
              SUBSTRING_INDEX(systemVersion, '.', '1')
            ),
            999
          ),
          IF(
            LOCATE(
              '3',
              SUBSTRING_INDEX(systemVersion, '.', '1')
            ) > 0,
            LOCATE(
              '3',
              SUBSTRING_INDEX(systemVersion, '.', '1')
            ),
            999
          ),
          IF(
            LOCATE(
              '4',
              SUBSTRING_INDEX(systemVersion, '.', '1')
            ) > 0,
            LOCATE(
              '4',
              SUBSTRING_INDEX(systemVersion, '.', '1')
            ),
            999
          ),
          IF(
            LOCATE(
              '5',
              SUBSTRING_INDEX(systemVersion, '.', '1')
            ) > 0,
            LOCATE(
              '5',
              SUBSTRING_INDEX(systemVersion, '.', '1')
            ),
            999
          ),
          IF(
            LOCATE(
              '6',
              SUBSTRING_INDEX(systemVersion, '.', '1')
            ) > 0,
            LOCATE(
              '6',
              SUBSTRING_INDEX(systemVersion, '.', '1')
            ),
            999
          ),
          IF(
            LOCATE(
              '7',
              SUBSTRING_INDEX(systemVersion, '.', '1')
            ) > 0,
            LOCATE(
              '7',
              SUBSTRING_INDEX(systemVersion, '.', '1')
            ),
            999
          ),
          IF(
            LOCATE(
              '8',
              SUBSTRING_INDEX(systemVersion, '.', '1')
            ) > 0,
            LOCATE(
              '8',
              SUBSTRING_INDEX(systemVersion, '.', '1')
            ),
            999
          ),
          IF(
            LOCATE(
              '9',
              SUBSTRING_INDEX(systemVersion, '.', '1')
            ) > 0,
            LOCATE(
              '9',
              SUBSTRING_INDEX(systemVersion, '.', '1')
            ),
            999
          )
        ) - 1
      ),
      '%'
    ) 
    and SR_CODE <> systemVersion 
    and man_power <> 0 ;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET notfound = 1 ;
  SELECT 
    man_power into man_power_system 
  FROM
    version_manpower 
  WHERE SR_CODE = systemVersion ;
  OPEN man_power_cur ;
  REPEAT
    FETCH man_power_cur into man_power_temp,
    version_temp ;
    if abs(
      man_power_temp - man_power_system
    ) < temp 
    then set temp = ABS(
      man_power_temp - man_power_system
    ) ;
    set version_temp1 = version_temp ;
    end if ;
    until notfound = 1 
  end repeat ;
  CLOSE man_power_cur ;
  SELECT 
    version_density into version_density_temp 
  FROM
    version_manpower 
  WHERE SR_code = version_temp1 ;
  if version_density_temp is not null 
  then set expect_bug_num = man_power_system * version_density_temp ;
  else set expect_bug_num = 0 ;
  end if ;
  return expect_bug_num ;
END */$$
DELIMITER ;

/* Function  structure for function  `query_modual_bug_abnormity` */

/*!50003 DROP FUNCTION IF EXISTS `query_modual_bug_abnormity` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` FUNCTION `query_modual_bug_abnormity`(systemVersion VARCHAR (100),warningGrade VARCHAR (10)) RETURNS decimal(4,0)
BEGIN
	DECLARE c_modual_sum DECIMAL(4,0);
	DECLARE c_bug_sum DECIMAL(4,0);
	DECLARE c_bug_percent_version DECIMAL(4,2);
	DECLARE c_temp DECIMAL(4,0);
	DECLARE notfound INT DEFAULT 0;
	DECLARE c_modual_name VARCHAR (50);
	DECLARE modual_bug_proportion_grade3 DECIMAL(4,2);
	DECLARE modual_bug_proportion_grade2 DECIMAL(4,2);
	DECLARE modual_bug_proportion_grade1 DECIMAL(4,2);
	DECLARE c_modual_bug_percent_version DECIMAL(4,2);
	declare c_modual_bug decimal(4,0);
	DECLARE v_modual CURSOR FOR 
		SELECT modual_name  FROM bug_distribute WHERE system_version=systemVersion ;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET notfound = 1 ;
	call bug_distributing(systemVersion);
	SELECT custom_field2 INTO modual_bug_proportion_grade3 FROM warning_define WHERE warning_type='02' AND rule_no='4' AND warning_grade='3';
	SELECT custom_field2 INTO modual_bug_proportion_grade2 FROM warning_define WHERE warning_type='02' AND rule_no='4' AND warning_grade='2';
	SELECT custom_field2 INTO modual_bug_proportion_grade1 FROM warning_define WHERE warning_type='02' AND rule_no='4' AND warning_grade='1';	
	SELECT COUNT(*) INTO c_modual_sum FROM bug_distribute WHERE system_version=systemVersion;
	SELECT SUM(bug_num) INTO c_bug_sum FROM bug_distribute WHERE system_version=systemVersion;
	OPEN v_modual;
		REPEAT
			FETCH v_modual INTO c_modual_name;
			SELECT bug_num INTO c_modual_bug FROM bug_distribute WHERE modual_name=c_modual_name and system_version=systemVersion;
			SET c_bug_percent_version:=round(c_modual_bug/c_bug_sum,2)-ROUND(1/c_modual_sum,2);
			IF c_bug_percent_version>0 THEN
				SET c_modual_bug_percent_version:=c_bug_percent_version;
				IF c_modual_bug_percent_version>=modual_bug_proportion_grade3 THEN
					UPDATE bug_distribute SET modual_bug_abnormity_grade='3' WHERE modual_name=c_modual_name AND system_version=systemVersion;
				END IF;
				IF c_modual_bug_percent_version>=modual_bug_proportion_grade2 AND c_modual_bug_percent_version<modual_bug_proportion_grade3 THEN
					UPDATE bug_distribute SET modual_bug_abnormity_grade='2' WHERE modual_name=c_modual_name AND system_version=systemVersion;
				END IF;
				IF c_modual_bug_percent_version>=modual_bug_proportion_grade1 AND c_modual_bug_percent_version<modual_bug_proportion_grade2 THEN
					UPDATE bug_distribute SET modual_bug_abnormity_grade='1' WHERE modual_name=c_modual_name AND system_version=systemVersion;
				END IF;
				if c_modual_bug_percent_version<modual_bug_proportion_grade1 then
					UPDATE bug_distribute SET modual_bug_abnormity_grade='' WHERE modual_name=c_modual_name AND system_version=systemVersion;
				end if;
			END IF;
			if c_bug_percent_version<=0 THEN
				UPDATE bug_distribute SET modual_bug_abnormity_grade='' WHERE modual_name=c_modual_name AND system_version=systemVersion;
			END IF;
		UNTIL notfound = 1 
		END REPEAT ;
	CLOSE v_modual;
	SELECT COUNT(*) INTO c_temp FROM bug_distribute WHERE system_version=systemVersion AND modual_bug_abnormity_grade=warningGrade;
	RETURN c_temp;
    END */$$
DELIMITER ;

/* Function  structure for function  `query_overtime_bug` */

/*!50003 DROP FUNCTION IF EXISTS `query_overtime_bug` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`10.50.124.135` FUNCTION `query_overtime_bug`(
  pro_id_temp varchar (60)
  ) RETURNS float(6,2)
BEGIN
    DECLARE check_bug_time FLOAT(6,2);
  DECLARE check_bug_hour DECIMAL(10,0);
  DECLARE check_bug_sceond FLOAT(6,2);
  DECLARE start_time_temp DATE ;
  DECLARE end_time_temp DATE ;
  DECLARE start_time DATETIME ;
  DECLARE end_time DATETIME ;
  DECLARE sec TIME ;
  DECLARE sec_tmp TIME ;
  DECLARE flag BOOLEAN;
  SELECT pro_deal_date,pro_close_date INTO start_time_temp,end_time_temp FROM problem_list WHERE pro_id = pro_id_temp ;
  SELECT pro_deal_date,pro_close_date INTO start_time,end_time FROM problem_list WHERE pro_id = pro_id_temp ;
   IF end_time IS NULL THEN
   SET end_time=NOW();
   SET end_time_temp=DATE(NOW());
   END IF;
   
   SELECT  TIMEDIFF(end_time, start_time) INTO sec; -- FROM  problem_list WHERE pro_id = pro_id_temp  ; 
   
  SELECT judgement_workday(start_time_temp) INTO flag;
  IF NOT flag THEN
     SELECT 
          IF(DATE(end_time)>DATE(start_time),TIMEDIFF('23:59:59',TIME(start_time)),TIMEDIFF(TIME(end_time),TIME(start_time)))
        INTO sec_tmp; 
      --  FROM problem_list     WHERE pro_id=pro_id_temp;
     SELECT  TIMEDIFF(sec, sec_tmp) INTO sec ; 
   -- 如果是工作日
   ELSE
      -- 如果开始日期早于上班时间，减去这段时间
      SELECT IF(TIME(start_time)<'08:55:00',TIMEDIFF('08:55:00',TIME(start_time)),'00:00:00') INTO sec_tmp;-- FROM problem_list WHERE pro_id=pro_id_temp;
      SELECT TIMEDIFF(sec, sec_tmp) INTO sec ;
       -- 如果中间有午休时间，去掉午休时间
      SELECT IF(TIME(start_time)<'12:00:00' AND (TIME(end_time)>'13:30:00' OR DATE(end_time)>DATE(start_time)),'01:30:00','00:00:00') INTO sec_tmp;-- FROM problem_list WHERE pro_id=pro_id_temp;
      SELECT TIMEDIFF(sec, sec_tmp) INTO sec ;  
      -- 去掉第一天下班后的时间，如果结束日大于开始日，下班后的时间为 TIMEDIFF('23:59:59','18:00:00')；否则如果结束日大于下班时间，下班后时间为TIMEDIFF(TIME(end_time),'18:00:00')，否则为0    
      SELECT IF(DATE(end_time)>DATE(start_time)AND TIME(start_time)<'18:00:00',TIMEDIFF('23:59:59','18:00:00'),IF(DATE(end_time)>DATE(start_time)AND TIME(start_time)>'18:00:00',TIMEDIFF('23:59:59',TIME(start_time)),'00:00:00')) INTO sec_tmp; -- FROM problem_list WHERE pro_id=pro_id_temp;
      SELECT TIMEDIFF(sec, sec_tmp) INTO sec ;
      
    END IF ;    
     -- 如果结束日期>开始日期人，减去最后一天的非工作时
   IF end_time_temp>start_time_temp THEN
 -- 判断最后一天是否工作日
    SELECT judgement_workday(end_time_temp) INTO flag; 
  -- 如果不是工作日,减去这一天
    IF NOT flag THEN
     SELECT TIME(end_time)INTO sec_tmp;-- FROM problem_list WHERE pro_id=pro_id_temp;
     SELECT TIMEDIFF(sec, sec_tmp) INTO sec ;
   -- 如果是工作日
    ELSE
    -- 如果结束日期晚于上班时间，减去这段时间
      SELECT IF(TIME(end_time)>'18:00:00',TIMEDIFF(TIME(end_time),'18:00:00'),'00:00:00') INTO sec_tmp;-- FROM problem_list WHERE pro_id=pro_id_temp; 
      SELECT TIMEDIFF(sec, sec_tmp) INTO sec ; 
    -- 去掉午休时间
      SELECT IF(TIME(end_time)>'13:30:00','01:30:00','00:00:00') INTO sec_tmp;-- FROM problem_list WHERE pro_id=pro_id_temp;
      SELECT TIMEDIFF(sec, sec_tmp) INTO sec ;  
    -- 如果结束日期大于8：55：00，减去上班之前的时间（8：55），否则减去close date的时间
      SELECT IF(TIME(end_time)>'08:55:00','08:55:00',TIME(end_time))INTO sec_tmp;-- FROM problem_list WHERE pro_id=pro_id_temp;
      SELECT TIMEDIFF(sec, sec_tmp) INTO sec ;
    END IF;  
  -- 处理除第一天和最后一天的时间  
  SELECT DATE_ADD(start_time_temp, INTERVAL 1 DAY) INTO start_time_temp;  
  WHILE start_time_temp<end_time_temp DO
    SELECT judgement_workday(start_time_temp)INTO flag;
  -- 如果不是工作日
    IF NOT flag THEN
      SET sec_tmp='24:00:00';
      SELECT TIMEDIFF(sec, sec_tmp) INTO sec ;  
     -- 如果是调整上班日,减去非工作时（一天工作7.58小时）   
     ELSE
      SELECT TIMEDIFF('24:00:00', '07:34:08') INTO sec_tmp ;
      SELECT TIMEDIFF(sec, sec_tmp) INTO sec ;  
    END IF;
    SELECT DATE_ADD(start_time_temp, INTERVAL 1 DAY) INTO start_time_temp; 
   END WHILE;
  END IF;  
  SELECT HOUR(sec) INTO check_bug_hour;
  SELECT SECOND(sec)INTO check_bug_sceond;
  SET check_bug_sceond=check_bug_sceond/60;
  SET check_bug_time=check_bug_hour+check_bug_sceond;
  return  check_bug_time;
END */$$
DELIMITER ;

/* Function  structure for function  `query_overtime_bug_forclose` */

/*!50003 DROP FUNCTION IF EXISTS `query_overtime_bug_forclose` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`10.50.124.135` FUNCTION `query_overtime_bug_forclose`(
  pro_id_temp varchar (60)
  ) RETURNS datetime
BEGIN
  DECLARE check_bug_time FLOAT(6,2);
  declare check_bug_hour decimal(10,0);
  DECLARE check_bug_sceond FLOAT(6,2);
  DECLARE start_time_temp DATE ;
  DECLARE end_time_temp DATE ;
  DECLARE sec TIME ;
  DECLARE sec_tmp TIME ;
  DECLARE flag BOOLEAN;
  SELECT pro_deal_date,pro_close_date INTO start_time_temp,end_time_temp FROM problem_list WHERE pro_id = pro_id_temp ;
 
   if end_time_temp is null then
   set end_time_temp=now();
   end if;
   SELECT  TIMEDIFF(pro_close_date, pro_deal_date) INTO sec FROM  problem_list WHERE pro_id = pro_id_temp  ; 
 
  SELECT judgement_workday(start_time_temp) INTO flag;
  IF NOT flag THEN
     SELECT 
          IF(DATE(pro_close_date)>DATE(pro_deal_date),TIMEDIFF('23:59:59',TIME(pro_deal_date)),TIMEDIFF(TIME(pro_close_date),TIME(pro_deal_date)))
        INTO sec_tmp 
        FROM problem_list
        WHERE pro_id=pro_id_temp;
     SELECT  TIMEDIFF(sec, sec_tmp) INTO sec ;     
   -- 如果是工作日
   ELSE
      -- 如果开始日期早于上班时间，减去这段时间
      SELECT IF(TIME(pro_deal_date)<'08:55:00',TIMEDIFF('08:55:00',TIME(pro_deal_date)),'00:00:00') INTO sec_tmp FROM problem_list WHERE pro_id=pro_id_temp;
      SELECT TIMEDIFF(sec, sec_tmp) INTO sec ;
       -- 如果中间有午休时间，去掉午休时间
      SELECT IF(TIME(pro_deal_date)<'12:00:00' AND (TIME(pro_close_date)>'13:30:00' OR DATE(pro_close_date)>DATE(pro_deal_date)),'01:30:00','00:00:00') INTO sec_tmp FROM problem_list WHERE pro_id=pro_id_temp;
      SELECT TIMEDIFF(sec, sec_tmp) INTO sec ;  
      -- 去掉第一天下班后的时间，如果结束日大于开始日，下班后的时间为 TIMEDIFF('23:59:59','18:00:00')；否则如果结束日大于下班时间，下班后时间为TIMEDIFF(TIME(pro_close_date),'18:00:00')，否则为0    
      SELECT IF(DATE(pro_close_date)>DATE(pro_deal_date)AND TIME(pro_deal_date)<'18:00:00',TIMEDIFF('23:59:59','18:00:00'),IF(DATE(pro_close_date)>DATE(pro_deal_date)AND TIME(pro_deal_date)>'18:00:00',TIMEDIFF('23:59:59',TIME(pro_deal_date)),'00:00:00')) INTO sec_tmp FROM problem_list WHERE pro_id=pro_id_temp;
      SELECT TIMEDIFF(sec, sec_tmp) INTO sec ;
      
    END IF ;    
     -- 如果结束日期>开始日期人，减去最后一天的非工作时
   IF end_time_temp>start_time_temp THEN
 -- 判断最后一天是否工作日
    SELECT judgement_workday(end_time_temp) INTO flag; 
  -- 如果不是工作日,减去这一天
    IF NOT flag THEN
     SELECT TIME(pro_close_date)INTO sec_tmp FROM problem_list WHERE pro_id=pro_id_temp;
     SELECT TIMEDIFF(sec, sec_tmp) INTO sec ;
   -- 如果是工作日
    ELSE
    -- 如果结束日期晚于上班时间，减去这段时间
      SELECT IF(TIME(pro_close_date)>'18:00:00',TIMEDIFF(TIME(pro_close_date),'18:00:00'),'00:00:00') INTO sec_tmp FROM problem_list WHERE pro_id=pro_id_temp; 
      SELECT TIMEDIFF(sec, sec_tmp) INTO sec ; 
    -- 去掉午休时间
      SELECT IF(TIME(pro_close_date)>'13:30:00','01:30:00','00:00:00') INTO sec_tmp FROM problem_list WHERE pro_id=pro_id_temp;
      SELECT TIMEDIFF(sec, sec_tmp) INTO sec ;  
    -- 如果结束日期大于8：55：00，减去上班之前的时间（8：55），否则减去close date的时间
      SELECT IF(TIME(pro_close_date)>'08:55:00','08:55:00',TIME(pro_close_date))INTO sec_tmp FROM problem_list WHERE pro_id=pro_id_temp;
      SELECT TIMEDIFF(sec, sec_tmp) INTO sec ;
    END IF;  
  -- 处理除第一天和最后一天的时间  
  SELECT DATE_ADD(start_time_temp, INTERVAL 1 DAY) INTO start_time_temp;  
  WHILE start_time_temp<end_time_temp DO
    SELECT judgement_workday(start_time_temp)INTO flag;
  -- 如果不是工作日
    IF NOT flag THEN
      SET sec_tmp='24:00:00';
      SELECT TIMEDIFF(sec, sec_tmp) INTO sec ;  
     -- 如果是调整上班日,减去非工作时（一天工作7.58小时）   
     ELSE
      SELECT TIMEDIFF('24:00:00', '07:34:08') INTO sec_tmp ;
      SELECT TIMEDIFF(sec, sec_tmp) INTO sec ;  
    END IF;
    SELECT DATE_ADD(start_time_temp, INTERVAL 1 DAY) INTO start_time_temp; 
   END WHILE;
  END IF;  
  SELECT HOUR(sec) INTO check_bug_hour;
  select second(sec)into check_bug_sceond;
  set check_bug_sceond=check_bug_sceond/60;
  set check_bug_time=check_bug_hour+check_bug_sceond;
  return end_time_temp;-- check_bug_time;
END */$$
DELIMITER ;

/* Function  structure for function  `query_rest_day` */

/*!50003 DROP FUNCTION IF EXISTS `query_rest_day` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`10.43.122.47` FUNCTION `query_rest_day`(test_date DATE) RETURNS tinyint(1)
BEGIN
     -- 查询是否国定放假日
     declare v_flag boolean default false;
     declare v_rest_day varchar(20);
     DECLARE notfound INT DEFAULT 0 ;
     declare c_rest_day CURSOR for
           SELECT special_date FROM special_day 
              WHERE special_date=test_date 
               AND is_weekend='N' 
               AND is_worktime='N';
     DECLARE CONTINUE HANDLER FOR NOT FOUND SET notfound = 1 ;
     open  c_rest_day;
     fetch c_rest_day into v_rest_day;
     CLOSE c_rest_day;
     if notfound =1 then
         set v_flag=true;
     end if;
     return v_flag;
    END */$$
DELIMITER ;

/* Function  structure for function  `query_sr_bug_abnormity` */

/*!50003 DROP FUNCTION IF EXISTS `query_sr_bug_abnormity` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` FUNCTION `query_sr_bug_abnormity`(systemVersion VARCHAR (100),warningGrade varchar (10)) RETURNS decimal(4,0)
BEGIN
	declare c_sr_sum decimal(4,0);
	declare c_bug_sum decimal(4,0);
	DECLARE c_sr_bug DECIMAL(4,0);
	declare c_bug_percent_version decimal(4,2);
	declare c_temp DECIMAL(4,0);
	declare notfound int default 0;
	declare c_sr_code varchar (50);
	declare sr_bug_proportion_grade3 DECIMAL(4,2);
	DECLARE sr_bug_proportion_grade2 DECIMAL(4,2);
	DECLARE sr_bug_proportion_grade1 DECIMAL(4,2);
	declare c_sr_bug_percent_version DECIMAL(4,2);
	declare v_sr cursor for 
		SELECT sr_code  FROM version_manpower WHERE system_version=systemVersion AND( sr_code LIKE 'SR%' OR (sr_code LIKE 'EGIS%' AND bug_num>0));
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET notfound = 1 ;
	SELECT custom_field2 INTO sr_bug_proportion_grade3 FROM warning_define WHERE warning_type='02' AND rule_no='3' AND warning_grade='3';
	SELECT custom_field2 INTO sr_bug_proportion_grade2 FROM warning_define WHERE warning_type='02' AND rule_no='3' AND warning_grade='2';
	SELECT custom_field2 INTO sr_bug_proportion_grade1 FROM warning_define WHERE warning_type='02' AND rule_no='3' AND warning_grade='1';	
	SELECT COUNT(*) INTO c_sr_sum FROM version_manpower WHERE system_version=systemVersion AND( sr_code LIKE 'SR%' OR (sr_code NOT LIKE 'SR%' AND bug_num>0));
	SELECT sr_bug_sum into c_bug_sum FROM version_manpower WHERE sr_code=systemVersion;
	open v_sr;
		repeat
			fetch v_sr into c_sr_code;
			SELECT bug_num into c_sr_bug FROM version_manpower WHERE system_version=systemVersion and sr_code=c_sr_code;
			SET c_bug_percent_version:=round(c_sr_bug/c_bug_sum,2)-ROUND(1/c_sr_sum,2);
			if c_bug_percent_version>0 then
				set c_sr_bug_percent_version:=c_bug_percent_version;
				if c_sr_bug_percent_version>=sr_bug_proportion_grade3 then
					update version_manpower set sr_bug_abnormity_grade='3' where sr_code=c_sr_code;
				end if;
				IF c_sr_bug_percent_version>=sr_bug_proportion_grade2 and c_sr_bug_percent_version<sr_bug_proportion_grade3 THEN
					UPDATE version_manpower SET sr_bug_abnormity_grade='2' WHERE sr_code=c_sr_code;
				END IF;
				IF c_sr_bug_percent_version>=sr_bug_proportion_grade1 and c_sr_bug_percent_version<sr_bug_proportion_grade2 THEN
					UPDATE version_manpower SET sr_bug_abnormity_grade='1' WHERE sr_code=c_sr_code;
				END IF;
				if c_sr_bug_percent_version<sr_bug_proportion_grade1 then
					UPDATE version_manpower SET sr_bug_abnormity_grade='' WHERE sr_code=c_sr_code;
				end if;
			end if;
			if c_bug_percent_version<=0 then
				UPDATE version_manpower SET sr_bug_abnormity_grade='' WHERE sr_code=c_sr_code;
			end if;
		UNTIL notfound = 1 
		END REPEAT ;
	close v_sr;
	SELECT COUNT(*) into c_temp FROM version_manpower WHERE system_version=systemVersion AND sr_bug_abnormity_grade=warningGrade;
	return c_temp;
    END */$$
DELIMITER ;

/* Function  structure for function  `query_sr_power` */

/*!50003 DROP FUNCTION IF EXISTS `query_sr_power` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`10.50.124.135` FUNCTION `query_sr_power`(
  SR_CODE VARCHAR (60),
  intention varchar (30),
  versionorsr VARCHAR (30)
) RETURNS varchar(60) CHARSET latin1
BEGIN
  DECLARE SrBugNum VARCHAR (60) ;
  if versionorsr = 'SR' and intention = 'density' then 
  SELECT 
    COUNT(*) into SrBugNum 
  FROM
    problem_list 
  WHERE pro_sr = SR_CODE 
    AND pro_source IN (
      '系统测试',
      '冒烟测试',
      '回归测试',
      '用户验收测试',
      '测试人员上报',
      '开发人员上报'
    ) ;
  END IF ;
  IF versionorsr = 'SR' 
  AND intention = 'num' 
  then 
  SELECT 
    COUNT(*) INTO SrBugNum 
  FROM
    problem_list 
  WHERE pro_sr = SR_CODE 
    AND pro_source IN (
      '系统测试',
      '冒烟测试',
      '回归测试',
      '用户验收测试',
      '测试人员上报'
    ) ;
  end if ;
  IF versionorsr = 'version' AND intention = 'num' THEN 
  SELECT 
    COUNT(*) INTO SrBugNum 
  FROM
    problem_list 
  WHERE pro_version = SR_CODE 
    AND pro_source IN (
      '系统测试',
      '冒烟测试',
      '回归测试',
      '用户验收测试',
      '测试人员上报'
    ) ;
  END IF ;
  IF versionorsr = 'version' AND intention = 'density' THEN 
  SELECT 
    COUNT(*) INTO SrBugNum 
  FROM
    problem_list 
  WHERE pro_version = SR_CODE 
    AND pro_source IN (
      '系统测试',
      '冒烟测试',
      '回归测试',
      '用户验收测试',
      '测试人员上报',
      '开发人员上报'
    ) ;
  END IF ;
  RETURN SrBugNum ;
END */$$
DELIMITER ;

/* Function  structure for function  `query_system_by_version` */

/*!50003 DROP FUNCTION IF EXISTS `query_system_by_version` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` FUNCTION `query_system_by_version`(p_system_version VARCHAR (200)) RETURNS varchar(200) CHARSET utf8
BEGIN
  DECLARE system_name VARCHAR (200) ;
  SELECT 
    ds.system_alias into system_name 
  FROM
    dept_system ds,
    version_plantime vp 
  WHERE vp.sub_system_name = ds.system_name 
    AND vp.system_version = p_system_version
  LIMIT 0, 1 ;
  
  return system_name;
END */$$
DELIMITER ;

/* Function  structure for function  `query_test_date` */

/*!50003 DROP FUNCTION IF EXISTS `query_test_date` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` FUNCTION `query_test_date`(systemVersion varchar(200),rate float) RETURNS date
BEGIN
    declare temp INTEGER DEFAULT 0;
    DECLARE temp1 INTEGER DEFAULT 0;
    DECLARE test_date_temp date;
    SELECT COUNT(*) INTO temp FROM bug_found_trend WHERE system_version=systemVersion; 
    set temp1=round(temp*rate);
    if temp1=temp then
    set temp1=temp-1;
    end if;
    SELECT test_date into test_date_temp FROM bug_found_trend WHERE system_version=systemVersion LIMIT temp1,1;
    return test_date_temp;
    END */$$
DELIMITER ;

/* Function  structure for function  `query_user_name` */

/*!50003 DROP FUNCTION IF EXISTS `query_user_name` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` FUNCTION `query_user_name`(person_id varchar(200)) RETURNS varchar(200) CHARSET utf8
BEGIN
    declare person_name varchar(200);
    DECLARE notfound INT DEFAULT 0 ;
    declare query_name cursor for 
    SELECT full_name FROM um_info WHERE um_no=person_id;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET notfound = 1 ;
    open query_name;
    fetch query_name into person_name;
    if notfound=1 then
      set person_name=person_id;
    end if ;
    return person_name;
    END */$$
DELIMITER ;

/* Function  structure for function  `query_warning_for_bugs1` */

/*!50003 DROP FUNCTION IF EXISTS `query_warning_for_bugs1` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` FUNCTION `query_warning_for_bugs1`(systemVersion varchar (200),date1 date) RETURNS float
BEGIN
    declare fect_bugNum decimal (4,0);
    declare expect_bugNum DECIMAL (4,0);
    declare base_bugNum decimal (4,0);
    DECLARE FLAG BOOLEAN;
    declare base FLOAT;
    declare dates int;
    declare i int;
    declare date_one_third date;
    DECLARE date_two_third DATE;
    DECLARE date_three_third DATE;
    select count(*)into dates from bug_found_trend where system_version=systemVersion;
    set i=dates/3-1;
    SELECT test_date into date_one_third FROM bug_found_trend WHERE system_version =systemVersion ORDER BY test_date LIMIT i,1;
    set i=(i+1)*2-1;
    SELECT test_date INTO date_two_third FROM bug_found_trend WHERE system_version =systemVersion ORDER BY test_date LIMIT i,1;
    set i=dates-1;
    SELECT test_date INTO date_three_third FROM bug_found_trend WHERE system_version =systemVersion ORDER BY test_date LIMIT i,1;
    
    SELECT cumulate_found_bug INTO fect_bugNum FROM bug_found_trend WHERE system_version =systemVersion AND TEST_DATE=date1;
    SELECT BUG_FOUND_NUM INTO expect_bugNum FROM gompertz_define WHERE system_version =systemVersion AND TEST_DATE=date1 ;
    if date1<=date_one_third then
        SELECT custom_field2 into base FROM warning_define WHERE warning_type='01' AND rule_no='1' AND warning_grade='1';
	SET base_bugNum=expect_bugNum*base;
	IF expect_bugNum-fect_bugNum>base_bugNum THEN
		REPLACE INTO `sqcs`.`warning_info`
		(`system_version`,
		`warning_date`,
		`warning_type`,
		`rule_no`,
		`warning_grade`,
		`warning_info`)
		VALUES (systemVersion,
		date1,
		'01',
		'1',
		'1',
		'理想缺陷高于实际发现缺陷大于20%'
		);
	END IF;
    elseif date1>date_one_third and date1<=date_two_third then
        SELECT custom_field2 INTO base FROM warning_define WHERE warning_type='01' AND rule_no='1' AND warning_grade='2';
	SET base_bugNum=expect_bugNum*base;
	IF  expect_bugNum-fect_bugNum>base_bugNum THEN
	REPLACE INTO `sqcs`.`warning_info`
            (`system_version`,
             `warning_date`,
             `warning_type`,
             `rule_no`,
             `warning_grade`,
             `warning_info`)
	VALUES (systemVersion,
		date1,
		'01',
		'1',
		'2',
		'理想缺陷高于实际发现缺陷大于50%'
		);
	END IF;
      else -- if date1>date_two_third and date1<=date_three_third then
        SELECT custom_field2 INTO base FROM warning_define WHERE warning_type='01' AND rule_no='1' AND warning_grade='3';
	SET base_bugNum=expect_bugNum*base;
	IF  expect_bugNum-fect_bugNum>base_bugNum THEN
	REPLACE INTO `sqcs`.`warning_info`
            (`system_version`,
             `warning_date`,
             `warning_type`,
             `rule_no`,
             `warning_grade`,
             `warning_info`)
	VALUES (systemVersion,
		date1,
		'01',
		'1',
		'3',
		'理想缺陷高于实际发现缺陷大于100%'
		);
	END IF;
     end if;
     RETURN base_bugNum;  
    END */$$
DELIMITER ;

/* Function  structure for function  `query_warning_for_bugs1_new` */

/*!50003 DROP FUNCTION IF EXISTS `query_warning_for_bugs1_new` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` FUNCTION `query_warning_for_bugs1_new`(systemVersion varchar (200),date1 date) RETURNS float
BEGIN
    declare fect_bugNum decimal (4,0);
    declare expect_bugNum DECIMAL (4,0);
    declare base_bugNum1 decimal (4,0);
    DECLARE base_bugNum2 DECIMAL (4,0);
    DECLARE base_bugNum3 DECIMAL (4,0);
    declare v_bug_num decimal(4,0);
    DECLARE FLAG BOOLEAN;
    declare base1 FLOAT;
    DECLARE base2 FLOAT;
    DECLARE base3 FLOAT;
    declare v_warning_info1 varchar(500);
    DECLARE v_warning_info2 VARCHAR(500);
    DECLARE v_warning_info3 VARCHAR(500);
    SELECT cumulate_found_bug INTO fect_bugNum FROM bug_found_trend WHERE system_version =systemVersion AND TEST_DATE=date1;
    SELECT BUG_FOUND_NUM INTO expect_bugNum FROM gompertz_define WHERE system_version =systemVersion AND TEST_DATE=date1 ;
    set v_bug_num=expect_bugNum-fect_bugNum;
    SELECT custom_field2,warning into base1,v_warning_info1 FROM warning_define WHERE warning_type='01' AND rule_no='1' AND warning_grade='1';
    SET base_bugNum1=expect_bugNum*base1;
    SELECT custom_field2,warning INTO base2,v_warning_info2 FROM warning_define WHERE warning_type='01' AND rule_no='1' AND warning_grade='2';
    SET base_bugNum2=expect_bugNum*base2;
    SELECT custom_field2,warning INTO base3,v_warning_info3 FROM warning_define WHERE warning_type='01' AND rule_no='1' AND warning_grade='3';
    SET base_bugNum3=expect_bugNum*base3;
    IF v_bug_num>=base_bugNum1 and v_bug_num<base_bugNum2 THEN
		REPLACE INTO `sqcs`.`warning_info`
		(`system_version`,
		`warning_date`,
		`warning_type`,
		`rule_no`,
		`warning_grade`,
		`warning_info`)
		VALUES (systemVersion,
		date1,
		'01',
		'1',
		'1',
		v_warning_info1
		);
      end if;
      if v_bug_num>=base_bugNum2 AND v_bug_num<base_bugNum3 then
		REPLACE INTO `sqcs`.`warning_info`
		(`system_version`,
		`warning_date`,
		`warning_type`,
		`rule_no`,
		`warning_grade`,
		`warning_info`)
		VALUES (systemVersion,
		date1,
		'01',
		'1',
		'2',
		v_warning_info2
		);
	end if;
	if v_bug_num>=base_bugNum3 then
          REPLACE INTO `sqcs`.`warning_info`
            (`system_version`,
             `warning_date`,
             `warning_type`,
             `rule_no`,
             `warning_grade`,
             `warning_info`)
	VALUES (systemVersion,
		date1,
		'01',
		'1',
		'3',
		v_warning_info3
		);
	END IF;
     RETURN base_bugNum1;  
    END */$$
DELIMITER ;

/* Function  structure for function  `query_warning_for_bugs2` */

/*!50003 DROP FUNCTION IF EXISTS `query_warning_for_bugs2` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` FUNCTION `query_warning_for_bugs2`(systemVersion VARCHAR (200),date1 DATE) RETURNS decimal(4,0)
BEGIN
      DECLARE found_bugNum DECIMAL (4, 0) ;
  DECLARE del_bugNum DECIMAL (4, 0) ;
  DECLARE base_bugNum DECIMAL (4, 0) ;
  DECLARE FLAG BOOLEAN ;
  DECLARE base FLOAT ;
  DECLARE dates INT ;
  declare v_warning_info varchar(200);
  SELECT 
    cumulate_found_bug INTO found_bugNum 
  FROM
    bug_found_trend 
  WHERE system_version = systemVersion 
    AND TEST_DATE = date1 ;
  SELECT 
    cumulate_del_bug INTO del_bugNum 
  FROM
    bug_found_trend 
  WHERE system_version = systemVersion 
    AND TEST_DATE = date1 ;
  SELECT 
    custom_field2,warning INTO base,v_warning_info
  FROM
    warning_define 
  WHERE warning_type = '01' 
    AND rule_no = '3' 
    AND warning_grade = '1' ;
  SET base_bugNum = found_bugNum * base ;
  IF found_bugNum - del_bugNum > base_bugNum 
  THEN REPLACE INTO `sqcs`.`warning_info` (
    `system_version`,
    `warning_date`,
    `warning_type`,
    `rule_no`,
    `warning_grade`,
    `warning_info`
  ) 
  VALUES
    (
      systemVersion,
      date1,
      '01',
      '3',
      '1',
     v_warning_info
    ) ;
    END IF ;
    RETURN base_bugNum ;
    END */$$
DELIMITER ;

/* Function  structure for function  `query_warning_for_bugs3` */

/*!50003 DROP FUNCTION IF EXISTS `query_warning_for_bugs3` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` FUNCTION `query_warning_for_bugs3`(systemVersion VARCHAR (200),date1 DATE) RETURNS decimal(4,0)
BEGIN
DECLARE check_bugNum DECIMAL (4, 0) ;
  DECLARE del_bugNum DECIMAL (4, 0) ;
  DECLARE base_bugNum DECIMAL (4, 0) ;
  DECLARE FLAG BOOLEAN ;
  DECLARE base FLOAT ;
  DECLARE dates INT ;
  DECLARE v_warning_info VARCHAR(200);
  SELECT 
    cumulate_close_bug INTO check_bugNum 
  FROM
    bug_found_trend 
  WHERE system_version = systemVersion 
    AND TEST_DATE = date1 ;
  SELECT 
    cumulate_del_bug INTO del_bugNum 
  FROM
    bug_found_trend 
  WHERE system_version = systemVersion 
    AND TEST_DATE = date1 ;
  SELECT 
    custom_field2,warning INTO base,v_warning_info
  FROM
    warning_define 
  WHERE warning_type = '01' 
    AND rule_no = '2' 
    AND warning_grade = '1' ;
  SET base_bugNum = del_bugNum * base ;
  IF del_bugNum - check_bugNum > base_bugNum 
  THEN REPLACE INTO `sqcs`.`warning_info` (
    `system_version`,
    `warning_date`,
    `warning_type`,
    `rule_no`,
    `warning_grade`,
    `warning_info`
  ) 
  VALUES
    (
      systemVersion,
      date1,
      '01',
      '2',
      '1',
      v_warning_info
    ) ;
    END IF ;
    RETURN base_bugNum ;
    END */$$
DELIMITER ;

/* Function  structure for function  `query_warning_for_bugs4` */

/*!50003 DROP FUNCTION IF EXISTS `query_warning_for_bugs4` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` FUNCTION `query_warning_for_bugs4`(systemVersion VARCHAR (200),date1 DATE) RETURNS decimal(4,0)
BEGIN
    declare pass_level_three DECIMAL (4,0);
    DECLARE pass_level_two DECIMAL (4,0);
    DECLARE pass_level_one DECIMAL (4,0);
    DECLARE pass_level_three_temp DECIMAL (4,0);
    DECLARE pass_level_two_temp DECIMAL (4,0);
    DECLARE pass_level_one_temp DECIMAL (4,0);
    select count(*) into pass_level_one from problem_list where pro_version=systemVersion and pro_nopass_num=1 AND pro_close_date is not null and date(pro_close_date)=date1 ;
    SELECT COUNT(*) INTO pass_level_one_temp FROM problem_list WHERE pro_version=systemVersion AND pro_nopass_num=1 AND pro_close_date IS  NULL AND DATE(now())=date1 ;
    SELECT COUNT(*) INTO pass_level_two FROM problem_list WHERE pro_version=systemVersion AND pro_nopass_num=2 AND pro_close_date IS NOT NULL AND DATE(pro_close_date)=date1;
    SELECT COUNT(*) INTO pass_level_two_temp FROM problem_list WHERE pro_version=systemVersion AND pro_nopass_num=2 AND pro_close_date IS NULL AND DATE(now())=date1;    
    SELECT COUNT(*) INTO pass_level_three FROM problem_list WHERE pro_version=systemVersion AND pro_nopass_num>=3 AND pro_close_date IS NOT NULL AND DATE(pro_close_date)=date1;
    SELECT COUNT(*) INTO pass_level_three_temp FROM problem_list WHERE pro_version=systemVersion AND pro_nopass_num>=3 AND pro_close_date IS NULL AND DATE(now())=date1;    
    set   pass_level_one:=pass_level_one+  pass_level_one_temp;
    SET   pass_level_two:=pass_level_two+  pass_level_two_temp;
    SET   pass_level_three:=pass_level_three+  pass_level_three_temp;
    if pass_level_three>0 then
    REPLACE INTO `sqcs`.`warning_info` (
    `system_version`,
    `warning_date`,
    `warning_type`,
    `rule_no`,
    `warning_grade`,
    `warning_info`
  ) 
  VALUES
    (
      systemVersion,
      date1,
      '06',
      '1',
      '3',
     '缺陷修改了4次及以上'
    ) ;
    end if;
    IF pass_level_two>0 THEN
    REPLACE INTO `sqcs`.`warning_info` (
    `system_version`,
    `warning_date`,
    `warning_type`,
    `rule_no`,
    `warning_grade`,
    `warning_info`
  ) 
  VALUES
    (
      systemVersion,
      date1,
      '06',
      '1',
      '2',
     '缺陷修改3次'
    ) ;
    END IF;
    IF pass_level_one>0 THEN
    REPLACE INTO `sqcs`.`warning_info` (
    `system_version`,
    `warning_date`,
    `warning_type`,
    `rule_no`,
    `warning_grade`,
    `warning_info`
  ) 
  VALUES
    (
      systemVersion,
      date1,
      '06',
      '1',
      '1',
     '缺陷修改2次'
    ) ;
    END IF;
    return pass_level_two;
    END */$$
DELIMITER ;

/* Function  structure for function  `q_sysname_by_version` */

/*!50003 DROP FUNCTION IF EXISTS `q_sysname_by_version` */;
DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` FUNCTION `q_sysname_by_version`(p_system_version VARCHAR (200)) RETURNS varchar(200) CHARSET utf8
BEGIN
  DECLARE system_name VARCHAR (200) ;
  SELECT 
    ds.system_name INTO system_name 
  FROM
    dept_system ds,
    version_plantime vp 
  WHERE vp.sub_system_name = ds.system_name 
    AND vp.system_version = p_system_version
  LIMIT 0, 1 ;
  
  RETURN system_name;
END */$$
DELIMITER ;

/* Procedure structure for procedure `bug_check_date_analyse` */

/*!50003 DROP PROCEDURE IF EXISTS  `bug_check_date_analyse` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`10.50.124.135` PROCEDURE `bug_check_date_analyse`(in SYSversion varchar (60))
BEGIN
  DECLARE v_oneday_bugSum DECIMAL (4, 0) DEFAULT 0;
  DECLARE v_twoday_bugSum DECIMAL (4, 0)DEFAULT 0 ;
  DECLARE v_morethantwoday_bugSum DECIMAL (4, 0) DEFAULT 0;
  DECLARE v_bug_check_time FLOAT(6,2) DEFAULT 0;
  DECLARE v_overtime DECIMAL (4, 0) DEFAULT 0 ;
  DECLARE v_no_overtime DECIMAL (4, 0) DEFAULT 0 ;
  DECLARE notfound INT DEFAULT 0 ;
  declare v_bug_id varchar (20);
  declare v_time1 int;
  DECLARE v_time2 int;
  DECLARE v_time3 int;  
  declare v_warning_info1 varchar(500);
  DECLARE v_warning_info2 VARCHAR(500);
  DECLARE v_warning_info3 VARCHAR(500);
  declare v_overtime_date date;
  declare c_bug CURSOR for 
 SELECT 
  pro_id,pro_close_date
FROM
  problem_list pl 
WHERE pro_version = SYSversion
  AND pro_status='待验证'
  AND pro_source<>'开发人员上报'
UNION ALL 
SELECT 
  pro_id ,pro_close_date
FROM
  problem_list pl 
WHERE pro_version = SYSversion
  AND pro_status = '已关闭' 
  AND pro_source<>'开发人员上报'
  AND NOT EXISTS 
  (SELECT 
    bug_id 
  FROM
    bug_checkordeal_time 
  WHERE check_or_deal = 'check' 
    AND pl.pro_id=bug_id
    AND system_version = pl.pro_version 
    AND over_time_date = DATE(pl.pro_close_date));
    
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET notfound = 1 ;
    
  SELECT custom_field2,warning into v_time1,v_warning_info1 FROM warning_define WHERE warning_type='04' AND rule_no='1' AND warning_grade='1';
  SELECT custom_field2,warning INTO v_time2,v_warning_info2 FROM warning_define WHERE warning_type='04' AND rule_no='1' AND warning_grade='2';  
  SELECT custom_field2,warning INTO v_time3,v_warning_info3 FROM warning_define WHERE warning_type='04' AND rule_no='1' AND warning_grade='3';         
  open c_bug;
  repeat 
    fetch c_bug into v_bug_id,v_overtime_date ;
  --  SELECT v_bug_id;
    if notfound<>1 then
    if v_overtime_date is null then
    set v_overtime_date=DATE_ADD(DATE(NOW()), INTERVAL -1 DAY);
    end if;
    select query_overtime_bug(v_bug_id) into v_bug_check_time;
    -- SELECT v_bug_check_time;
    replace into bug_checkordeal_time (system_version,bug_id,check_or_deal,hour_1,over_time_date)values(SYSversion,v_bug_id,'check',v_bug_check_time,v_overtime_date);
    if v_bug_check_time>v_time1 and v_bug_check_time<=v_time2 then
  --  set v_overtime=v_overtime+1;
    UPDATE bug_checkordeal_time SET is_over_time='Y',warning_grade='1',warning_info=v_warning_info1 WHERE bug_id=v_bug_id and check_or_deal='check' and over_time_date=v_overtime_date;
    end if ;
    IF v_bug_check_time>v_time2 and v_bug_check_time<=16 THEN
   -- SET v_oneday_bugSum=v_oneday_bugSum+1;
    UPDATE bug_checkordeal_time SET is_over_time='Y',warning_grade='2',warning_info=v_warning_info2 WHERE bug_id=v_bug_id AND check_or_deal='check' and over_time_date=v_overtime_date;
    END IF ;
    IF v_bug_check_time>16 and v_bug_check_time<=v_time3 THEN
  --  SET v_twoday_bugSum=v_twoday_bugSum+1;
    UPDATE bug_checkordeal_time SET is_over_time='Y',warning_grade='2',warning_info=v_warning_info2 WHERE bug_id=v_bug_id AND check_or_deal='check' and over_time_date=v_overtime_date;
    END IF ;
    IF v_bug_check_time>v_time3 THEN
 --   SET v_morethantwoday_bugSum=v_morethantwoday_bugSum+1;
    UPDATE bug_checkordeal_time SET is_over_time='Y',warning_grade='3',warning_info=v_warning_info3 WHERE bug_id=v_bug_id AND check_or_deal='check' and over_time_date=v_overtime_date;
    END IF ;
    IF v_bug_check_time<=4 THEN
    UPDATE bug_checkordeal_time SET is_over_time='N' WHERE bug_id=v_bug_id AND check_or_deal='check';
    end if;
    end if;
   until notfound=1
  end repeat;
  close c_bug ;
  
  -- 未超时缺陷数
  SELECT 
 COUNT(DISTINCT bug_id) INTO v_no_overtime
FROM
  bug_checkordeal_time 
WHERE system_version = SYSversion
  AND check_or_deal = 'check' 
  AND is_over_time = 'N' 
  AND bug_id NOT IN (SELECT 
  DISTINCT bug_id 
FROM
  bug_checkordeal_time 
WHERE system_version = SYSversion
  AND check_or_deal = 'check' 
  AND is_over_time = 'Y' );
  -- 超时4小时缺陷数
  SELECT 
  COUNT(*) INTO v_overtime
FROM
  (SELECT 
    bug_id 
  FROM
    bug_checkordeal_time 
  WHERE system_version = SYSversion
    AND check_or_deal = 'check' 
    AND is_over_time = 'Y' 
  GROUP BY bug_id 
  HAVING MAX(hour_1) >= 4 
    AND MAX(hour_1) < 8) a ;
  
  
  -- 超时1天缺陷数
  SELECT 
  COUNT(*) INTO v_oneday_bugSum
FROM
  (SELECT 
    bug_id 
  FROM
    bug_checkordeal_time 
  WHERE system_version = SYSversion
    AND check_or_deal = 'check' 
    AND is_over_time = 'Y' 
  GROUP BY bug_id 
  HAVING MAX(hour_1) >= 8 
    AND MAX(hour_1) < 16) a ;
 -- 超时2 天缺陷数
SELECT 
  COUNT(*) INTO v_twoday_bugSum
FROM
  (SELECT 
    bug_id 
  FROM
    bug_checkordeal_time 
  WHERE system_version = SYSversion
    AND check_or_deal = 'check' 
    AND is_over_time = 'Y' 
  GROUP BY bug_id 
  HAVING MAX(hour_1) >= 16 
    AND MAX(hour_1) < 32) b ; 
    
 -- 超时3 天缺陷数
SELECT 
  COUNT(*) INTO v_morethantwoday_bugSum
FROM
  (SELECT 
    bug_id 
  FROM
    bug_checkordeal_time 
  WHERE system_version = SYSversion
    AND check_or_deal = 'check' 
    AND is_over_time = 'Y' 
  GROUP BY bug_id 
  HAVING MAX(hour_1) >= 32) c;
  
  replace INTO bug_check_time (
    system_version,
    deal_or_check,
    one_day,
    two_day,
    more_than_two_day,
    overtime,
    no_overtime
  ) 
  VALUES
    (
      SYSversion,
      'check',
      cast(v_oneday_bugSum as char),
      cast(v_twoday_bugSum as char),
      cast(v_morethantwoday_bugSum as char),
      CAST(v_overtime as char) ,
      cast(v_no_overtime as char)
    ) ;
        
END */$$
DELIMITER ;

/* Procedure structure for procedure `bug_check_date_warning` */

/*!50003 DROP PROCEDURE IF EXISTS  `bug_check_date_warning` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `bug_check_date_warning`(IN SYSversion VARCHAR (60))
BEGIN
  DECLARE v_warning_grade INT ;
  SELECT 
    COUNT(*) INTO v_warning_grade 
  FROM
    bug_checkordeal_time 
  WHERE is_over_time = 'Y' 
    AND check_or_deal = 'check' 
    AND system_version = SYSversion 
    AND warning_grade = '1' 
    AND over_time_date = DATE_ADD(DATE(NOW()), INTERVAL - 1 DAY) ;
  IF v_warning_grade > 0 
  THEN REPLACE INTO `sqcs`.`warning_info` (
    `system_version`,
    `warning_date`,
    `warning_type`,
    `rule_no`,
    `warning_grade`,
    `warning_info`
  ) 
  VALUES
    (
      SYSversion,
      DATE_ADD(DATE(NOW()), INTERVAL - 1 DAY),
      '04',
      '1',
      '1',
      (SELECT warning FROM warning_define WHERE warning_type='04' AND rule_no='1' AND warning_grade='1')
    ) ;
    END IF ;
    SELECT 
      COUNT(*) INTO v_warning_grade 
    FROM
      bug_checkordeal_time 
    WHERE is_over_time = 'Y' 
      AND check_or_deal = 'check' 
      AND system_version = SYSversion 
      AND warning_grade = '2' 
      AND over_time_date = DATE_ADD(DATE(NOW()), INTERVAL - 1 DAY) ;
    IF v_warning_grade > 0 
    THEN REPLACE INTO `sqcs`.`warning_info` (
      `system_version`,
      `warning_date`,
      `warning_type`,
      `rule_no`,
      `warning_grade`,
      `warning_info`
    ) 
    VALUES
      (
        SYSversion,
        DATE_ADD(DATE(NOW()), INTERVAL - 1 DAY),
        '04',
        '1',
        '2',
        (SELECT warning FROM warning_define WHERE warning_type='04' AND rule_no='1' AND warning_grade='2')
      ) ;
      END IF ;
      SELECT 
        COUNT(*) INTO v_warning_grade 
      FROM
        bug_checkordeal_time 
      WHERE is_over_time = 'Y' 
        AND check_or_deal = 'check' 
        AND system_version = SYSversion 
        AND warning_grade = '3' 
        AND over_time_date = DATE_ADD(DATE(NOW()), INTERVAL - 1 DAY) ;
      IF v_warning_grade > 0 
      THEN REPLACE INTO `sqcs`.`warning_info` (
        `system_version`,
        `warning_date`,
        `warning_type`,
        `rule_no`,
        `warning_grade`,
        `warning_info`
      ) 
      VALUES
        (
          SYSversion,
          DATE_ADD(DATE(NOW()), INTERVAL - 1 DAY),
          '04',
          '1',
          '3',
          (SELECT warning FROM warning_define WHERE warning_type='04' AND rule_no='1' AND warning_grade='3')
        ) ;
        END IF ;
      END */$$
DELIMITER ;

/* Procedure structure for procedure `bug_deal_date_analyse` */

/*!50003 DROP PROCEDURE IF EXISTS  `bug_deal_date_analyse` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `bug_deal_date_analyse`(IN SYSversion VARCHAR (60))
BEGIN
  DECLARE v_oneday_bugSum DECIMAL (4, 0) DEFAULT 0 ;
  DECLARE v_twoday_bugSum DECIMAL (4, 0) DEFAULT 0 ;
  DECLARE v_morethantwoday_bugSum DECIMAL (4, 0) DEFAULT 0 ;
  DECLARE v_bug_deal_time float (6, 2) DEFAULT 0 ;
  DECLARE v_overtime DECIMAL (4, 0) DEFAULT 0 ;
  DECLARE v_no_overtime DECIMAL (4, 0) DEFAULT 0 ;
  DECLARE notfound INT DEFAULT 0 ;
  DECLARE v_bug_id VARCHAR (20) ;
  declare bug_level varchar (20) ;
  DECLARE v_time1_L1 INT ;
  DECLARE v_time2_L1 INT ;
  DECLARE v_time3_L1 INT ;
  DECLARE v_warning_info1_L1 VARCHAR (500) ;
  DECLARE v_warning_info2_L1 VARCHAR (500) ;
  DECLARE v_warning_info3_L1 VARCHAR (500) ;
  DECLARE v_time1_L2 INT ;
  DECLARE v_time2_L2 INT ;
  DECLARE v_time3_L2 INT ;
  DECLARE v_warning_info1_L2 VARCHAR (500) ;
  DECLARE v_warning_info2_L2 VARCHAR (500) ;
  DECLARE v_warning_info3_L2 VARCHAR (500) ;
  DECLARE v_over_date date ;
  DECLARE v_warning_info1_L3 VARCHAR (500) ;
  DECLARE v_warning_info2_L3 VARCHAR (500) ;
  DECLARE v_warning_info3_L3 VARCHAR (500) ;
  -- bug sum
  DECLARE c_bug CURSOR FOR 
  SELECT 
    pro_id,
    pro_deal_date 
  FROM
    problem_list pl 
  WHERE pro_version = SYSversion 
    AND pro_status = '处理中' 
    AND pro_source <> '开发人员上报' 
  UNION
  ALL 
  SELECT 
    pro_id,
    pro_deal_date 
  FROM
    problem_list pl 
  WHERE pro_version = SYSversion 
    AND pro_status IN ('已关闭', '待验证') 
    AND pro_source <> '开发人员上报' 
    AND NOT exists 
    (SELECT 
      bug_id 
    FROM
      bug_checkordeal_time 
    WHERE check_or_deal = 'deal' 
      and pl.pro_id = bug_id 
      AND system_version = pl.pro_version 
      AND over_time_date = DATE(pl.pro_deal_date)) ;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET notfound = 1 ;
  -- 统计超时缺陷数
  OPEN c_bug ;
  REPEAT
    FETCH c_bug INTO v_bug_id,
    v_over_date ;
    if v_over_date is null 
    then set v_over_date = DATE_ADD(DATE(NOW()), INTERVAL - 1 DAY) ;
    end if ;
    if notfound <> 1 
    then 
    SELECT 
      query_deal_overtime_bug (v_bug_id) INTO v_bug_deal_time ;
    -- 计算缺陷处理时长
    SELECT 
      pro_level INTO bug_level 
    FROM
      problem_list 
    WHERE pro_id = v_bug_id ;
    REPLACE INTO bug_checkordeal_time (
      system_version,
      bug_id,
      check_or_deal,
      hour_1,
      over_time_date,
      is_over_time
    ) 
    VALUES
      (
        SYSversion,
        v_bug_id,
        'deal',
        v_bug_deal_time,
        v_over_date,
        'N'
      ) ;
      IF bug_level = 'L1' 
      THEN -- 取出L1缺陷的处理时效指标
      SELECT 
        custom_field2,
        warning INTO v_time1_L1,
        v_warning_info1_L1 
      FROM
        warning_define 
      WHERE warning_type = '03' 
        AND rule_no = '1' 
        AND warning_grade = '1' 
        AND custom_field1 = 'L1' ;
      SELECT 
        custom_field2,
        warning INTO v_time2_L1,
        v_warning_info2_L1 
      FROM
        warning_define 
      WHERE warning_type = '03' 
        AND rule_no = '1' 
        AND warning_grade = '2' 
        AND custom_field1 = 'L1' ;
      SELECT 
        custom_field2,
        warning INTO v_time3_L1,
        v_warning_info3_L1 
      FROM
        warning_define 
      WHERE warning_type = '03' 
        AND rule_no = '1' 
        AND warning_grade = '3' 
        AND custom_field1 = 'L1' ;
      IF v_bug_deal_time > v_time1_L1 
      AND v_bug_deal_time <= v_time2_L1 
      THEN --    SET v_overtime=v_overtime+1;
      UPDATE 
        bug_checkordeal_time 
      SET
        is_over_time = 'Y',
        warning_grade = '1',
        warning_info = v_warning_info1_L1 
      WHERE bug_id = v_bug_id 
        and check_or_deal = 'deal' 
        and over_time_date = v_over_date ;
      ELSEIF v_bug_deal_time > v_time2_L1 
      AND v_bug_deal_time <= 16 
      THEN --   SET v_oneday_bugSum=v_oneday_bugSum+1;
      UPDATE 
        bug_checkordeal_time 
      SET
        is_over_time = 'Y',
        warning_grade = '2',
        warning_info = v_warning_info2_L1 
      WHERE bug_id = v_bug_id 
        AND check_or_deal = 'deal' 
        AND over_time_date = v_over_date ;
      ELSEIF v_bug_deal_time > 16 
      AND v_bug_deal_time <= v_time3_L1 
      THEN --   SET  v_twoday_bugSum=v_twoday_bugSum+1;
      UPDATE 
        bug_checkordeal_time 
      SET
        is_over_time = 'Y',
        warning_grade = '2',
        warning_info = v_warning_info2_L1 
      WHERE bug_id = v_bug_id 
        AND check_or_deal = 'deal' 
        AND over_time_date = v_over_date ;
      ELSEIF v_bug_deal_time > v_time3_L1 
      THEN --    SET  v_morethantwoday_bugSum=v_morethantwoday_bugSum+1;
      UPDATE 
        bug_checkordeal_time 
      SET
        is_over_time = 'Y',
        warning_grade = '3',
        warning_info = v_warning_info3_L1 
      WHERE bug_id = v_bug_id 
        AND check_or_deal = 'deal' 
        AND over_time_date = v_over_date ;
      END IF ;
      ELSEIF bug_level = 'L2' 
      or bug_level = 'L3' 
      then 
      SELECT 
        custom_field2,
        warning INTO v_time1_L2,
        v_warning_info1_L2 
      FROM
        warning_define 
      WHERE warning_type = '03' 
        AND rule_no = '1' 
        AND warning_grade = '1' 
        AND custom_field1 = 'L2' ;
      SELECT 
        custom_field2,
        warning INTO v_time2_L2,
        v_warning_info2_L2 
      FROM
        warning_define 
      WHERE warning_type = '03' 
        AND rule_no = '1' 
        AND warning_grade = '2' 
        AND custom_field1 = 'L2' ;
      SELECT 
        custom_field2,
        warning INTO v_time3_L2,
        v_warning_info3_L2 
      FROM
        warning_define 
      WHERE warning_type = '03' 
        AND rule_no = '1' 
        AND warning_grade = '3' 
        AND custom_field1 = 'L2' ;
      IF v_bug_deal_time > v_time1_L2 
      AND v_bug_deal_time <= v_time2_L2 
      THEN --   SET v_overtime=v_overtime+1;
      UPDATE 
        bug_checkordeal_time 
      SET
        is_over_time = 'Y',
        warning_grade = '1',
        warning_info = v_warning_info1_L2 
      WHERE bug_id = v_bug_id 
        AND check_or_deal = 'deal' 
        AND over_time_date = v_over_date ;
      ELSEIF v_bug_deal_time > v_time2_L2 
      AND v_bug_deal_time <= v_time3_L2 
      THEN --   SET v_oneday_bugSum=v_oneday_bugSum+1;
      UPDATE 
        bug_checkordeal_time 
      SET
        is_over_time = 'Y',
        warning_grade = '2',
        warning_info = v_warning_info2_L2 
      WHERE bug_id = v_bug_id 
        AND check_or_deal = 'deal' 
        AND over_time_date = v_over_date ;
      eLSEIF v_bug_deal_time > v_time3_L2 
      AND v_bug_deal_time <= 32 
      THEN --   SET  v_twoday_bugSum=v_twoday_bugSum+1;
      UPDATE 
        bug_checkordeal_time 
      SET
        is_over_time = 'Y',
        warning_grade = '3',
        warning_info = v_warning_info3_L2 
      WHERE bug_id = v_bug_id 
        AND check_or_deal = 'deal' 
        AND over_time_date = v_over_date ;
      eLSEIF v_bug_deal_time > 32 
      THEN --     SET  v_morethantwoday_bugSum=v_morethantwoday_bugSum+1;
      UPDATE 
        bug_checkordeal_time 
      SET
        is_over_time = 'Y',
        warning_grade = '3',
        warning_info = v_warning_info3_L2 
      WHERE bug_id = v_bug_id 
        AND check_or_deal = 'deal' 
        AND over_time_date = v_over_date ;
      END IF ;
      end if ;
      END IF ;
      UNTIL notfound = 1 
    END REPEAT ;
    CLOSE c_bug ;
    SELECT 
      COUNT(DISTINCT bug_id) into v_no_overtime 
    FROM
      bug_checkordeal_time 
    WHERE system_version = SYSversion 
      AND check_or_deal = 'deal' 
      AND is_over_time = 'N' 
      AND bug_id NOT IN 
      (SELECT DISTINCT 
        bug_id 
      FROM
        bug_checkordeal_time 
      WHERE system_version = SYSversion 
        AND check_or_deal = 'deal' 
        AND is_over_time = 'Y') ;
    -- 超时4小时缺陷数
    SELECT 
      COUNT(*) INTO v_overtime 
    FROM
      (SELECT 
        bug_id 
      FROM
        bug_checkordeal_time 
      WHERE system_version = SYSversion 
        AND check_or_deal = 'deal' 
        AND is_over_time = 'Y' 
      GROUP BY bug_id 
      HAVING MAX(hour_1) >= 4 
        AND MAX(hour_1) < 8) a ;
    -- 超时1天缺陷数
    SELECT 
      COUNT(*) into v_oneday_bugSum 
    FROM
      (SELECT 
        bug_id 
      FROM
        bug_checkordeal_time 
      WHERE system_version = SYSversion 
        AND check_or_deal = 'deal' 
        AND is_over_time = 'Y' 
      GROUP BY bug_id 
      HAVING MAX(hour_1) >= 8 
        AND MAX(hour_1) < 16) a ;
    -- 超时2 天缺陷数
    SELECT 
      COUNT(*) into v_twoday_bugSum 
    FROM
      (SELECT 
        bug_id 
      FROM
        bug_checkordeal_time 
      WHERE system_version = SYSversion 
        AND check_or_deal = 'deal' 
        AND is_over_time = 'Y' 
      GROUP BY bug_id 
      HAVING MAX(hour_1) >= 16 
        AND MAX(hour_1) < 32) b ;
    -- 超时3 天缺陷数
    SELECT 
      COUNT(*) into v_morethantwoday_bugSum 
    FROM
      (SELECT 
        bug_id 
      FROM
        bug_checkordeal_time 
      WHERE system_version = SYSversion 
        AND check_or_deal = 'deal' 
        AND is_over_time = 'Y' 
      GROUP BY bug_id 
      HAVING MAX(hour_1) >= 32) c ;
    REPLACE INTO bug_check_time (
      system_version,
      deal_or_check,
      one_day,
      two_day,
      more_than_two_day,
      overtime,
      no_overtime
    ) 
    VALUES
      (
        SYSversion,
        'deal',
        CAST(v_oneday_bugSum AS CHAR),
        CAST(v_twoday_bugSum AS CHAR),
        CAST(v_morethantwoday_bugSum AS CHAR),
        CAST(v_overtime AS CHAR),
        CAST(v_no_overtime AS CHAR)
      ) ;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `bug_deal_date_warning` */

/*!50003 DROP PROCEDURE IF EXISTS  `bug_deal_date_warning` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `bug_deal_date_warning`(IN SYSversion VARCHAR (60))
BEGIN
  DECLARE v_warning_grade INT ;
  SELECT 
    COUNT(*) INTO v_warning_grade 
  FROM
    bug_checkordeal_time 
  WHERE is_over_time = 'Y' 
    AND check_or_deal = 'deal' 
    AND system_version = SYSversion 
    AND warning_grade = '1' 
    AND over_time_date = DATE_ADD(DATE(NOW()), INTERVAL - 1 DAY) ;
  IF v_warning_grade > 0 
  THEN REPLACE INTO `sqcs`.`warning_info` (
    `system_version`,
    `warning_date`,
    `warning_type`,
    `rule_no`,
    `warning_grade`,
    `warning_info`
  ) 
  VALUES
    (
      SYSversion,
      DATE_ADD(DATE(NOW()), INTERVAL - 1 DAY),
      '03',
      '1',
      '1',
      (SELECT 
        warning 
      FROM
        warning_define 
      WHERE warning_type = '03' 
        AND rule_no = '1' 
        AND warning_grade = '1' 
        AND custom_field1 = 'L1')
    ) ;
    END IF ;
    SELECT 
      COUNT(*) INTO v_warning_grade 
    FROM
      bug_checkordeal_time 
    WHERE is_over_time = 'Y' 
      AND check_or_deal = 'deal' 
      AND system_version = SYSversion 
      AND warning_grade = '2' 
      AND over_time_date = DATE_ADD(DATE(NOW()), INTERVAL - 1 DAY) ;
    IF v_warning_grade > 0 
    THEN REPLACE INTO `sqcs`.`warning_info` (
      `system_version`,
      `warning_date`,
      `warning_type`,
      `rule_no`,
      `warning_grade`,
      `warning_info`
    ) 
    VALUES
      (
        SYSversion,
        DATE_ADD(DATE(NOW()), INTERVAL - 1 DAY),
        '03',
        '1',
        '2',
        (SELECT 
          warning 
        FROM
          warning_define 
        WHERE warning_type = '03' 
          AND rule_no = '1' 
          AND warning_grade = '2' 
          AND custom_field1 = 'L1')
      ) ;
      END IF ;
      SELECT 
        COUNT(*) INTO v_warning_grade 
      FROM
        bug_checkordeal_time 
      WHERE is_over_time = 'Y' 
        AND check_or_deal = 'deal' 
        AND system_version = SYSversion 
        AND warning_grade = '3' 
        AND over_time_date = DATE_ADD(DATE(NOW()), INTERVAL - 1 DAY) ;
      IF v_warning_grade > 0 
      THEN REPLACE INTO `sqcs`.`warning_info` (
        `system_version`,
        `warning_date`,
        `warning_type`,
        `rule_no`,
        `warning_grade`,
        `warning_info`
      ) 
      VALUES
        (
          SYSversion,
          DATE_ADD(DATE(NOW()), INTERVAL - 1 DAY),
          '03',
          '1',
          '3',
          (SELECT 
            warning 
          FROM
            warning_define 
          WHERE warning_type = '03' 
            AND rule_no = '1' 
            AND warning_grade = '3' 
            AND custom_field1 = 'L1')
        ) ;
        END IF ;
      END */$$
DELIMITER ;

/* Procedure structure for procedure `bug_density_analyse` */

/*!50003 DROP PROCEDURE IF EXISTS  `bug_density_analyse` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`10.50.124.135` PROCEDURE `bug_density_analyse`(IN p_version varchar (60))
BEGIN
  DECLARE v_srBugNum varchar (30) ;
  declare v_srBugNum_a VARCHAR (30) ;
  DECLARE v_sr_manpower VARCHAR (50) ;
  DECLARE v_version_bugNum DECIMAL (4, 0) DEFAULT 0 ;
  declare v_version_bugNum_a DECIMAL (4, 0) DEFAULT 0 ;
  DECLARE v_version_manPower DECIMAL (4, 0) DEFAULT 0 ;
  DECLARE v_sr_density DECIMAL (4, 2) DEFAULT 0 ;
  DECLARE v_version_density DECIMAL (4, 2) DEFAULT 0 ;
  DECLARE v_sr_code VARCHAR (20) ;
  declare v_null_sr_bug DECIMAL (4, 0) DEFAULT 0 ;
  declare v_null_sr_bug_a DECIMAL (4, 0) DEFAULT 0 ;
  declare v_bug_num DECIMAL (4, 0) DEFAULT 0 ;
  declare v_bug_num_a DECIMAL (4, 0) DEFAULT 0 ;
  DECLARE notfound INT DEFAULT 0 ;
  declare c_version_sr CURSOR for 
  select 
    sr_code,
    man_power 
  from
    version_manpower 
  where system_version = p_version 
    and sr_code like 'SR%' ;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET notfound = 1 ;
  open c_version_sr ;
  repeat
    fetch c_version_sr into v_sr_code,
    v_sr_manpower ;
    if notfound <> 1 
    then set v_version_manPower = v_version_manPower + cast(v_sr_manpower as DECIMAL) ;
    select 
      query_sr_power (v_sr_code, 'density', 'SR') into v_srBugNum ;
    SELECT 
      query_sr_power (v_sr_code, 'num', 'SR') INTO v_srBugNum_a ;
    set v_version_bugNum = v_version_bugNum + cast(v_srBUgNum AS DECIMAL) ;
    SET v_version_bugNum_a = v_version_bugNum_a + CAST(v_srBUgNum_a AS DECIMAL) ;
    set v_sr_density = (v_srBugNum * 1.0) / (v_sr_manpower * 1.0) ;
    update 
      version_manpower 
    set
      sr_density = v_sr_density,
      bug_num = v_srBugNum,
      bug_num_amount = v_srBugNum_a 
    where sr_code = v_sr_code ;
    end if ;
    until notfound = 1 
  end repeat ;
  close c_version_sr ;
  SELECT 
    query_sr_power (p_version, 'density', 'version') into v_bug_num ;
  SET v_version_density = ROUND(v_bug_num / v_version_manPower, 2) ;
  SELECT 
    query_sr_power (p_version, 'num', 'version') INTO v_bug_num_a ;
  set v_null_sr_bug = v_bug_num - v_version_bugNum ;
  SET v_null_sr_bug_a = v_bug_num_a - v_version_bugNum_a ;
  replace into version_manpower (
    system_version,
    sr_code,
    sr_name,
    source_id,
    man_power,
    bug_num,
    bug_num_amount,
    sr_density,
    version_density,
    sr_bug_sum,
    sr_bug_sum_amount
  ) 
  values
    (
      p_version,
      p_version,
      q_sysname_by_version (p_version),
      null,
      v_version_manPower,
      v_null_sr_bug,
      v_null_sr_bug_a,
      null,
      v_version_density,
      v_bug_num,
      v_bug_num_a
    ) ;
  END */$$
DELIMITER ;

/* Procedure structure for procedure `bug_distributing` */

/*!50003 DROP PROCEDURE IF EXISTS  `bug_distributing` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `bug_distributing`(in sysversion varchar (100))
BEGIN
  declare no_modual_bug_num decimal (4, 0) ;
  declare bug_num decimal (4, 0) ;
  declare systemname varchar (100) ;
  declare modual_name varchar (100) ;
  declare modual_bug_num decimal (4, 0) ;
  
  -- 处理按版本、模块统计缺陷数 
  replace INTO bug_distribute  ( system_name,
            system_version,
             modual_name,
             bug_num
             )
  SELECT 
    pro_system,
    pro_version,
    IF(REPLACE(pro_module, ',', '') ='','无模块缺陷', REPLACE(pro_module, ',','')) AS pro_module,
    COUNT(*) 
  FROM
    problem_list 
  WHERE pro_module IS NOT NULL 
    AND pro_module <> '' 
    AND pro_version = sysversion
    and pro_found_date > '2015-11-30'  -- DPM子系统模块功能上线时间
    AND pro_source IN (
        '系统测试',
        '冒烟测试',
        '回归测试',
        '用户验收测试',
        '测试人员上报'
      ) 
  GROUP BY
    pro_module ;
  -- 从bug_found_trend表获取缺陷总数，只包含测试发现缺陷    
  select 
    max(cumulate_found_bug) into bug_num 
  from
    bug_found_trend 
  where system_version = sysversion ;
 -- 计算出测试发现的缺陷并关联了模块的缺陷数
  SELECT 
    COUNT(*) INTO modual_bug_num 
  FROM
    problem_list 
  WHERE pro_version = sysversion 
    AND pro_module IS NOT NULL 
    AND pro_module <> '' 
    AND pro_found_date > '2015-11-30'  -- DPM子系统模块功能上线时间
    AND pro_source IN (
        '系统测试',
        '冒烟测试',
        '回归测试',
        '用户验收测试',
        '测试人员上报'
      ) ;
 -- 获取系统名
  SELECT sub_system_name INTO systemname FROM version_plantime WHERE system_version=sysversion;
  
  SET no_modual_bug_num = bug_num - modual_bug_num ;
  REPLACE INTO bug_distribute (
    system_name,
    system_version,
    modual_name,
    bug_num
  ) 
  VALUES
    (
      systemname,
      sysversion,
      '无模块缺陷',
      no_modual_bug_num
    ) ;
    
  -- 按系统、模块处理缺陷数
  
  REPLACE INTO bug_distribute  ( system_name,
            system_version,
             modual_name,
             bug_num
             )
  SELECT 
    pro_system,
    pro_system,
    IF(REPLACE(pro_module, ',', '') ='','无模块缺陷', REPLACE(pro_module, ',','')) AS pro_module,
    COUNT(*) bug_num 
  FROM
    problem_list 
  WHERE pro_system = systemname 
    AND pro_module IS NOT NULL 
    AND pro_module <> '' 
    AND pro_found_date > '2015-11-30'  -- DPM子系统模块功能上线时间
    AND pro_source IN (
        '系统测试',
        '冒烟测试',
        '回归测试',
        '用户验收测试',
        '测试人员上报'
      ) 
  GROUP BY 
    pro_module ;
 
  SELECT 
    COUNT(*) INTO no_modual_bug_num 
  FROM
    problem_list 
  WHERE pro_system = systemname 
    AND (pro_module IS NULL 
    or pro_module ='')
    AND pro_found_date > '2015-11-30'  -- DPM子系统模块功能上线时间
     AND pro_source IN (
        '系统测试',
        '冒烟测试',
        '回归测试',
        '用户验收测试',
        '测试人员上报'
      ) ;
    
    replace INTO bug_distribute (
    system_name,
    system_version,
    modual_name,
    bug_num
  ) 
  VALUES
    (
      systemname,
      systemname,
      '无模块缺陷',
      no_modual_bug_num
    ) ;
END */$$
DELIMITER ;

/* Procedure structure for procedure `bug_distributing_abnormity` */

/*!50003 DROP PROCEDURE IF EXISTS  `bug_distributing_abnormity` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `bug_distributing_abnormity`(in systemVersion VARCHAR (200))
BEGIN
  declare no_sr_num decimal (10, 4) ;
  declare bug_num decimal (10, 4) ;
  declare no_modual_num DECIMAL (10, 4) ;
  DECLARE modual_num DECIMAL (10, 4) ;
  declare no_module_percent DECIMAL (4, 2) ;
  DECLARE no_sr_percent DECIMAL (4, 2) ;
  declare no_sr_percent_1 decimal (4, 2) ;
  DECLARE no_sr_percent_2 DECIMAL (4, 2) ;
  DECLARE no_sr_percent_3 DECIMAL (4, 2) ;
  DECLARE no_module_percent_1 DECIMAL (4, 2) ;
  DECLARE no_module_percent_2 DECIMAL (4, 2) ;
  DECLARE no_module_percent_3 DECIMAL (4, 2) ;
  declare sr_bug_abnormity decimal (10, 4) ;
  DECLARE module_bug_abnormity DECIMAL (10, 4) ;
  declare warning_date date ;
  set warning_date := DATE_ADD(DATE(NOW()), INTERVAL - 1 DAY) ;
  SELECT 
    sr_bug_sum_amount into bug_num 
  FROM
    version_manpower 
  WHERE sr_code = systemVersion ;
  SELECT 
    bug_num_amount into no_sr_num 
  FROM
    version_manpower 
  WHERE sr_code = systemVersion ;
  SELECT 
    custom_field2 into no_sr_percent_1 
  FROM
    warning_define 
  WHERE warning_type = '02' 
    AND rule_no = '1' 
    AND warning_grade = '1' ;
  SELECT 
    custom_field2 into no_sr_percent_2 
  FROM
    warning_define 
  WHERE warning_type = '02' 
    AND rule_no = '1' 
    AND warning_grade = '2' ;
  SELECT 
    custom_field2 into no_sr_percent_3 
  FROM
    warning_define 
  WHERE warning_type = '02' 
    AND rule_no = '1' 
    AND warning_grade = '2' ;
  SELECT 
    custom_field2 INTO no_module_percent_1 
  FROM
    warning_define 
  WHERE warning_type = '02' 
    AND rule_no = '2' 
    AND warning_grade = '1' ;
  SELECT 
    custom_field2 INTO no_module_percent_2 
  FROM
    warning_define 
  WHERE warning_type = '02' 
    AND rule_no = '2' 
    AND warning_grade = '2' ;
  SELECT 
    custom_field2 INTO no_module_percent_3 
  FROM
    warning_define 
  WHERE warning_type = '02' 
    AND rule_no = '2' 
    AND warning_grade = '2' ;
  -- SR占比异常
  if no_sr_num > 0 
  then set no_sr_percent := round(no_sr_num / bug_num, 2) ;
  if no_sr_percent >= no_sr_percent_3 
  then REPLACE INTO `sqcs`.`warning_info` (
    `system_version`,
    `warning_date`,
    `warning_type`,
    `rule_no`,
    `warning_grade`,
    `warning_info`
  ) 
  VALUES
    (
      systemVersion,
      warning_date,
      '02',
      '1',
      '3',
      (SELECT 
        warning 
      FROM
        warning_define 
      WHERE warning_type = '02' 
        AND rule_no = '1' 
        AND warning_grade = '3')
    ) ;
    end if ;
    if no_sr_percent >= no_sr_percent_2 
    and no_sr_percent < no_sr_percent_3 
    then REPLACE INTO `sqcs`.`warning_info` (
      `system_version`,
      `warning_date`,
      `warning_type`,
      `rule_no`,
      `warning_grade`,
      `warning_info`
    ) 
    VALUES
      (
        systemVersion,
        warning_date,
        '02',
        '1',
        '2',
        (SELECT 
          warning 
        FROM
          warning_define 
        WHERE warning_type = '02' 
          AND rule_no = '1' 
          AND warning_grade = '2')
      ) ;
      end if ;
      IF no_sr_percent >= no_sr_percent_1 
      AND no_sr_percent < no_sr_percent_2 
      THEN REPLACE INTO `sqcs`.`warning_info` (
        `system_version`,
        `warning_date`,
        `warning_type`,
        `rule_no`,
        `warning_grade`,
        `warning_info`
      ) 
      VALUES
        (
          systemVersion,
          warning_date,
          '02',
          '1',
          '1',
          (SELECT 
            warning 
          FROM
            warning_define 
          WHERE warning_type = '02' 
            AND rule_no = '1' 
            AND warning_grade = '1')
        ) ;
        END IF ;
        end if ;
        -- 模块占比异常
        SELECT 
          SUM(bug_num) into modual_num 
        FROM
          bug_distribute 
        WHERE system_version = systemVersion ;
        set no_modual_num := bug_num - modual_num ;
        if no_modual_num > 0 
        then set no_module_percent := round(no_modual_num / bug_num, 2) ;
        IF no_module_percent >= no_module_percent_3 
        THEN REPLACE INTO `sqcs`.`warning_info` (
          `system_version`,
          `warning_date`,
          `warning_type`,
          `rule_no`,
          `warning_grade`,
          `warning_info`
        ) 
        VALUES
          (
            systemVersion,
            warning_date,
            '02',
            '2',
            '3',
            (SELECT 
              warning 
            FROM
              warning_define 
            WHERE warning_type = '02' 
              AND rule_no = '2' 
              AND warning_grade = '3')
          ) ;
          END IF ;
          IF no_module_percent >= no_module_percent_2 
          AND no_module_percent < no_module_percent_3 
          THEN REPLACE INTO `sqcs`.`warning_info` (
            `system_version`,
            `warning_date`,
            `warning_type`,
            `rule_no`,
            `warning_grade`,
            `warning_info`
          ) 
          VALUES
            (
              systemVersion,
              warning_date,
              '02',
              '2',
              '2',
              (SELECT 
                warning 
              FROM
                warning_define 
              WHERE warning_type = '02' 
                AND rule_no = '2' 
                AND warning_grade = '2')
            ) ;
            END IF ;
            IF no_module_percent >= no_module_percent_1 
            AND no_module_percent < no_module_percent_2 
            THEN REPLACE INTO `sqcs`.`warning_info` (
              `system_version`,
              `warning_date`,
              `warning_type`,
              `rule_no`,
              `warning_grade`,
              `warning_info`
            ) 
            VALUES
              (
                systemVersion,
                warning_date,
                '02',
                '2',
                '1',
                (SELECT 
                  warning 
                FROM
                  warning_define 
                WHERE warning_type = '02' 
                  AND rule_no = '2' 
                  AND warning_grade = '1')
              ) ;
              END IF ;
              end if ;
              -- 单个SR占比异常
              select 
                query_sr_bug_abnormity (systemVersion, '3') into sr_bug_abnormity ;
              if sr_bug_abnormity > 0 
              then REPLACE INTO `sqcs`.`warning_info` (
                `system_version`,
                `warning_date`,
                `warning_type`,
                `rule_no`,
                `warning_grade`,
                `warning_info`
              ) 
              VALUES
                (
                  systemVersion,
                  warning_date,
                  '02',
                  '3',
                  '3',
                  (SELECT 
                    warning 
                  FROM
                    warning_define 
                  WHERE warning_type = '02' 
                    AND rule_no = '3' 
                    AND warning_grade = '3')
                ) ;
                end if ;
                SELECT 
                  query_sr_bug_abnormity (systemVersion, '2') INTO sr_bug_abnormity ;
                IF sr_bug_abnormity > 0 
                THEN REPLACE INTO `sqcs`.`warning_info` (
                  `system_version`,
                  `warning_date`,
                  `warning_type`,
                  `rule_no`,
                  `warning_grade`,
                  `warning_info`
                ) 
                VALUES
                  (
                    systemVersion,
                    warning_date,
                    '02',
                    '3',
                    '2',
                    (SELECT 
                      warning 
                    FROM
                      warning_define 
                    WHERE warning_type = '02' 
                      AND rule_no = '3' 
                      AND warning_grade = '2')
                  ) ;
                  END IF ;
                  SELECT 
                    query_sr_bug_abnormity (systemVersion, '1') INTO sr_bug_abnormity ;
                  IF sr_bug_abnormity > 0 
                  THEN REPLACE INTO `sqcs`.`warning_info` (
                    `system_version`,
                    `warning_date`,
                    `warning_type`,
                    `rule_no`,
                    `warning_grade`,
                    `warning_info`
                  ) 
                  VALUES
                    (
                      systemVersion,
                      warning_date,
                      '02',
                      '3',
                      '1',
                      (SELECT 
                        warning 
                      FROM
                        warning_define 
                      WHERE warning_type = '02' 
                        AND rule_no = '3' 
                        AND warning_grade = '1')
                    ) ;
                    END IF ;
                    -- 单个模块占比异常
                    SELECT 
                      query_modual_bug_abnormity (systemVersion, '3') INTO module_bug_abnormity ;
                    IF module_bug_abnormity > 0 
                    THEN REPLACE INTO `sqcs`.`warning_info` (
                      `system_version`,
                      `warning_date`,
                      `warning_type`,
                      `rule_no`,
                      `warning_grade`,
                      `warning_info`
                    ) 
                    VALUES
                      (
                        systemVersion,
                        warning_date,
                        '02',
                        '4',
                        '3',
                        (SELECT 
                          warning 
                        FROM
                          warning_define 
                        WHERE warning_type = '02' 
                          AND rule_no = '4' 
                          AND warning_grade = '3')
                      ) ;
                      END IF ;
                      SELECT 
                        query_modual_bug_abnormity (systemVersion, '2') INTO module_bug_abnormity ;
                      IF module_bug_abnormity > 0 
                      THEN REPLACE INTO `sqcs`.`warning_info` (
                        `system_version`,
                        `warning_date`,
                        `warning_type`,
                        `rule_no`,
                        `warning_grade`,
                        `warning_info`
                      ) 
                      VALUES
                        (
                          systemVersion,
                          warning_date,
                          '02',
                          '4',
                          '2',
                          (SELECT 
                            warning 
                          FROM
                            warning_define 
                          WHERE warning_type = '02' 
                            AND rule_no = '4' 
                            AND warning_grade = '2')
                        ) ;
                        END IF ;
                        SELECT 
                          query_modual_bug_abnormity (systemVersion, '1') INTO module_bug_abnormity ;
                        IF module_bug_abnormity > 0 
                        THEN REPLACE INTO `sqcs`.`warning_info` (
                          `system_version`,
                          `warning_date`,
                          `warning_type`,
                          `rule_no`,
                          `warning_grade`,
                          `warning_info`
                        ) 
                        VALUES
                          (
                            systemVersion,
                            warning_date,
                            '02',
                            '4',
                            '1',
                            (SELECT 
                              warning 
                            FROM
                              warning_define 
                            WHERE warning_type = '02' 
                              AND rule_no = '4' 
                              AND warning_grade = '1')
                          ) ;
                          END IF ;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `bug_found_trend_analyse` */

/*!50003 DROP PROCEDURE IF EXISTS  `bug_found_trend_analyse` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`10.43.122.47` PROCEDURE `bug_found_trend_analyse`(IN p_system_verion VARCHAR (60))
BEGIN
  DECLARE v_test_date DATE ;
  DECLARE v_day VARCHAR (20) ;
  DECLARE v_flag BOOLEAN ;
  DECLARE v_test_start_date DATE ;
  DECLARE v_test_end_date DATE ;
  DECLARE v_test_last_date DATE ;
  DECLARE v_bug_found_everydate DECIMAL (4, 0) ;
  DECLARE v_bug_cumulate_found DECIMAL (4, 0) DEFAULT 0 ;
  DECLARE v_bug_deal_everydate VARCHAR (10) ;
  DECLARE v_bug_cumulate_deal DECIMAL (4, 0) DEFAULT 0 ;
  DECLARE v_bug_cumulate_deal_null decimal (4, 0) default 0 ;
  DECLARE v_bug_close_everydate VARCHAR (10) ;
  DECLARE v_bug_cumulate_close DECIMAL (4, 0) DEFAULT 0 ;
  DECLARE v_bug_cumulate_close_null DECIMAL (4, 0) DEFAULT 0 ;
  DECLARE v_L1bug_found_everydate VARCHAR (10) ;
  DECLARE v_L1bug_cumulate_found DECIMAL (4, 0) DEFAULT 0 ;
  DECLARE v_L2bug_found_everydate VARCHAR (10) ;
  DECLARE v_L2bug_cumulate_found DECIMAL (4, 0) DEFAULT 0 ;
  DECLARE v_L3bug_found_everydate VARCHAR (10) ;
  DECLARE v_L4bug_found_everydate VARCHAR (10) ;
  DECLARE v_system_name VARCHAR (200) CHARACTER SET utf8 ;
  DECLARE c_system CURSOR FOR 
  SELECT 
    sub_system_name 
  FROM
    version_plantime 
  WHERE system_version = p_system_verion ;
  declare c_test_begin_date cursor for 
  SELECT 
    MIN(pro_found_date) 
  FROM
    problem_list 
  WHERE pro_version = p_system_verion ;
  DECLARE c_test_end_date CURSOR FOR 
  SELECT 
    reviewTest_end_date 
  FROM
    version_plantime 
  WHERE system_version = p_system_verion ;
  DELETE 
  FROM
    bug_found_trend 
  WHERE system_version = p_system_verion ;
  OPEN c_system ;
  FETCH c_system INTO v_system_name ;
  CLOSE c_system ;
  OPEN c_test_begin_date ;
  FETCH c_test_begin_date INTO v_test_start_date ;
  CLOSE c_test_begin_date ;
  OPEN c_test_end_date ;
  FETCH c_test_end_date INTO v_test_end_date ;
  CLOSE c_test_end_date ;
  SET v_test_date = v_test_start_date ;
  IF(
    DATE(v_test_start_date) <= DATE(v_test_end_date)
  ) 
  THEN main_loop :
  LOOP
    select 
      judgement_workday (v_test_date) into v_flag ;
    IF v_flag = TRUE 
    THEN SET v_bug_found_everydate = 0 ;
    SET v_bug_deal_everydate = 0 ;
    SET v_bug_close_everydate = 0 ;
    SET v_L1bug_found_everydate = 0 ;
    SET v_L2bug_found_everydate = 0 ;
    SET v_L3bug_found_everydate = 0 ;
    SET v_L4bug_found_everydate = 0 ;
    IF TRIM(v_day) = 'monday' 
    THEN 
    SELECT 
      DATE_ADD(v_test_date, INTERVAL - 2 DAY) INTO v_test_last_date ;
    SELECT 
      query_bug_found_sum_everyday (
        v_test_date,
        p_system_verion,
        v_test_last_date
      ) INTO v_bug_found_everydate ;
    SELECT 
      query_bug_deal_sum_everyday (
        v_test_date,
        p_system_verion,
        v_test_last_date
      ) INTO v_bug_deal_everydate ;
    SELECT 
      query_bug_close_sum_everyday (
        v_test_date,
        p_system_verion,
        v_test_last_date
      ) INTO v_bug_close_everydate ;
    SELECT 
      query_bug_serious_sum_everyday (
        v_test_date,
        'L1',
        p_system_verion,
        v_test_last_date
      ) INTO v_L1bug_found_everydate ;
    SELECT 
      query_bug_serious_sum_everyday (
        v_test_date,
        'L2',
        p_system_verion,
        v_test_last_date
      ) INTO v_L2bug_found_everydate ;
    SELECT 
      query_bug_serious_sum_everyday (
        v_test_date,
        'L3',
        p_system_verion,
        v_test_last_date
      ) INTO v_L3bug_found_everydate ;
    SELECT 
      query_bug_serious_sum_everyday (
        v_test_date,
        'L4',
        p_system_verion,
        v_test_last_date
      ) INTO v_L4bug_found_everydate ;
    ELSE 
    SELECT 
      query_bug_found_sum_everyday (
        v_test_date,
        p_system_verion,
        v_test_date
      ) INTO v_bug_found_everydate ;
    SELECT 
      query_bug_deal_sum_everyday (
        v_test_date,
        p_system_verion,
        v_test_date
      ) INTO v_bug_deal_everydate ;
    SELECT 
      query_bug_close_sum_everyday (
        v_test_date,
        p_system_verion,
        v_test_date
      ) INTO v_bug_close_everydate ;
    SELECT 
      query_bug_serious_sum_everyday (
        v_test_date,
        'L1',
        p_system_verion,
        v_test_date
      ) INTO v_L1bug_found_everydate ;
    SELECT 
      query_bug_serious_sum_everyday (
        v_test_date,
        'L2',
        p_system_verion,
        v_test_date
      ) INTO v_L2bug_found_everydate ;
    SELECT 
      query_bug_serious_sum_everyday (
        v_test_date,
        'L3',
        p_system_verion,
        v_test_date
      ) INTO v_L3bug_found_everydate ;
    SELECT 
      query_bug_serious_sum_everyday (
        v_test_date,
        'L4',
        p_system_verion,
        v_test_date
      ) INTO v_L4bug_found_everydate ;
    END IF ;
    SET v_bug_cumulate_found = v_bug_cumulate_found + v_bug_found_everydate ;
    SET v_bug_cumulate_deal = v_bug_cumulate_deal + v_bug_deal_everydate ;
    SET v_bug_cumulate_close = v_bug_cumulate_close + v_bug_close_everydate ;
    -- select v_bug_cumulate_close;
    SET v_L1bug_cumulate_found = v_L1bug_cumulate_found + v_L1bug_found_everydate ;
    SET v_L2bug_cumulate_found = v_L2bug_cumulate_found + v_L2bug_found_everydate ;
    replace INTO bug_found_trend (
      system_version,
      test_date,
      L1_bug_everydate,
      L2_bug_everydate,
      L3_bug_everydate,
      L4_bug_everydate,
      L1_cumulate_found_bug,
      L2_cumulate_found_bug,
      cumulate_found_bug,
      cumulate_del_bug,
      cumulate_close_bug,
      system
    ) 
    VALUES
      (
        p_system_verion,
        v_test_date,
        v_L1bug_found_everydate,
        v_L2bug_found_everydate,
        v_L3bug_found_everydate,
        v_L4bug_found_everydate,
        v_L1bug_cumulate_found,
        v_L2bug_cumulate_found,
        v_bug_cumulate_found,
        v_bug_cumulate_deal,
        v_bug_cumulate_close,
        v_system_name
      ) ;
      END IF ;
      SET v_test_date = DATE_ADD(v_test_date, INTERVAL 1 DAY) ;
      IF v_test_date = DATE_ADD(v_test_end_date, INTERVAL 1 DAY) 
      THEN LEAVE main_loop ;
      END IF ;
      IF v_test_date = v_test_end_date 
      THEN 
      SELECT 
        query_bug_null_close (p_system_verion) INTO v_bug_cumulate_close_null ;
      SET v_bug_cumulate_close = v_bug_cumulate_close + cast(
        v_bug_cumulate_close_null as decimal
      ) ;
      select 
        query_bug_null_deal (p_system_verion) into v_bug_cumulate_deal_null ;
      SET v_bug_cumulate_deal = v_bug_cumulate_deal + CAST(
        v_bug_cumulate_deal_null AS DECIMAL
      ) ;
      end if ;
    END LOOP ;
    END IF ;
  END */$$
DELIMITER ;

/* Procedure structure for procedure `bug_found_trend_analyse_sum` */

/*!50003 DROP PROCEDURE IF EXISTS  `bug_found_trend_analyse_sum` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`10.50.124.135` PROCEDURE `bug_found_trend_analyse_sum`(
  IN SYSversion varchar(60)
)
BEGIN
  declare start_date date;
  declare end_date date;
  DECLARE SysName varchar(500) CHARACTER SET utf8;
  
  select first_deploy_test_time INTO start_date from version_plantime where system_version=SYSversion ;
  SELECT reviewTest_end_date INTO end_date FROM version_plantime  WHERE system_version=SYSversion ;
  -- insert into test SELECT pro_system FROM problem_list WHERE pro_version =SYSversion;
  SELECT DISTINCT pro_system into SysName FROM problem_list WHERE pro_version =SYSversion;
  replace INTO bug_found_trend_sum 
  SELECT 
    system,
    test_date,
    SUM(L1_BUG_EVERyDATE),
    SUM(L2_BUG_EVERYDATE),
    SUM(L3_BUG_EVERYDATE),
    SUM(L4_BUG_EVERYDATE),
    SUM(L1_CUMULATE_FOUND_BUG),
    SUM(L2_CUMULATE_FOUND_BUG),
    SUM(cumulate_found_bug),
    SUM(cumulate_del_bug),
    SUM(cumulate_close_bug),
     LCD,
    FCD 
  FROM
    bug_found_trend 
  WHERE  system_version=SYSversion
  GROUP BY system,
    test_date 
  ORDER BY system,
    test_date ;
  END */$$
DELIMITER ;

/* Procedure structure for procedure `bug_group_by_developer` */

/*!50003 DROP PROCEDURE IF EXISTS  `bug_group_by_developer` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `bug_group_by_developer`(IN p_system_version VARCHAR (200))
BEGIN
  DECLARE bug_num DECIMAL (4, 0) ;
  DECLARE L1_bug_num DECIMAL (4, 0) ;
  DECLARE L2_bug_num DECIMAL (4, 0) ;
  DECLARE L3_bug_num DECIMAL (4, 0) ;
  DECLARE L4_bug_num DECIMAL (4, 0) ;
  DECLARE developer VARCHAR(200);
  DECLARE tester VARCHAR(200);
  DECLARE notfound INT DEFAULT 0 ;
  DECLARE developer_name VARCHAR(200);
  DECLARE tester_name VARCHAR(200);
  
  -- 查找某个版本的开人发员
  DECLARE developer_version CURSOR FOR 
  SELECT DISTINCT
    pro_deal_person 
  FROM
    problem_list 
  WHERE pro_version = p_system_version 
    AND pro_deal_person IS NOT NULL;
    
  -- 查找某个系统的开人发员
  DECLARE developer_system CURSOR FOR 
  SELECT DISTINCT 
    pro_deal_person 
  FROM
    problem_list 
  WHERE pro_system IN 
    (SELECT 
      sub_system_name 
    FROM
      version_plantime 
    WHERE system_version = p_system_version) 
    AND pro_deal_person IS NOT NULL;
    
  -- 查找某个版本的测试人员
  DECLARE tester_version CURSOR FOR 
  SELECT DISTINCT
    pro_found_person 
  FROM
    problem_list 
  WHERE pro_version = p_system_version 
    AND pro_found_person IS NOT NULL 
    AND pro_source<>'部署';
    
  -- 查找某个系统的测试人员
  DECLARE tester_system CURSOR FOR 
  SELECT DISTINCT
    pro_found_person 
  FROM
    problem_list 
  WHERE pro_system IN 
    (SELECT 
      sub_system_name 
    FROM
      version_plantime 
    WHERE system_version = p_system_version) 
    AND pro_found_person IS NOT NULL 
    AND pro_source<>'部署';
  
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET notfound = 1 ;
  
  -- 从版本维度统计每个开发产生的缺陷数
  OPEN developer_version;
  REPEAT 
    FETCH developer_version INTO developer; 
    IF notfound<>1 THEN
      SELECT query_user_name(developer) INTO developer_name;
      SELECT query_bug_by_developer(developer,p_system_version,'','') INTO bug_num;
      SELECT query_bug_by_developer(developer,p_system_version,'','L1') INTO L1_bug_num;
      SELECT query_bug_by_developer(developer,p_system_version,'','L2') INTO L2_bug_num;
      SELECT query_bug_by_developer(developer,p_system_version,'','L3') INTO L3_bug_num;
      SELECT query_bug_by_developer(developer,p_system_version,'','L4') INTO L4_bug_num;
      REPLACE INTO sqcs.bug_group_by_person
              (system_version,
               person_name,
               person_type,
               bug_num,
               L1_bug_num,
               L2_bug_num,
               L3_bug_num,
               L4_bug_num)
      VALUES (p_system_version,
              developer_name,
              'developer',
              bug_num,
              L1_bug_num,
              L2_bug_num,
              L3_bug_num,
              L4_bug_num);
    END IF;
  UNTIL notfound=1
  END REPEAT;
  CLOSE developer_version;
  SET notfound=0;
  SET developer='';
  SET developer_name='';
  
  -- 从系统维度统计每个开发产生的缺陷数
  OPEN developer_system;
  REPEAT 
    FETCH developer_system INTO developer; 
    IF notfound<>1 THEN
      SELECT query_user_name(developer) INTO developer_name;
      SELECT query_bug_by_developer(developer,p_system_version,'system','') INTO bug_num;
      SELECT query_bug_by_developer(developer,p_system_version,'system','L1') INTO L1_bug_num;
      SELECT query_bug_by_developer(developer,p_system_version,'system','L2') INTO L2_bug_num;
      SELECT query_bug_by_developer(developer,p_system_version,'system','L3') INTO L3_bug_num;
      SELECT query_bug_by_developer(developer,p_system_version,'system','L4') INTO L4_bug_num;
      REPLACE INTO sqcs.bug_group_by_person
              (system_version,
               person_name,
               person_type,
               bug_num,
               L1_bug_num,
               L2_bug_num,
               L3_bug_num,
               L4_bug_num)
      VALUES (q_sysname_by_version(p_system_version),
              developer_name,
              'developer',
              bug_num,
              L1_bug_num,
              L2_bug_num,
              L3_bug_num,
              L4_bug_num);
    END IF;
  UNTIL notfound=1
  END REPEAT; 
  CLOSE developer_system;
  SET notfound=0;
  -- 从版本维度统计每个测试发现的缺陷数
  OPEN tester_version;
  REPEAT 
    FETCH tester_version INTO tester;
    IF notfound<>1 THEN
      SELECT query_user_name(tester) INTO tester_name;
      SELECT query_bug_by_tester(tester,p_system_version,'','') INTO bug_num;
      SELECT query_bug_by_tester(tester,p_system_version,'','L1') INTO L1_bug_num;
      SELECT query_bug_by_tester(tester,p_system_version,'','L2') INTO L2_bug_num;
      SELECT query_bug_by_tester(tester,p_system_version,'','L3') INTO L3_bug_num;
      SELECT query_bug_by_tester(tester,p_system_version,'','L4') INTO L4_bug_num;
      REPLACE INTO sqcs.bug_group_by_person
              (system_version,
               person_name,
               person_type,
               bug_num,
               L1_bug_num,
               L2_bug_num,
               L3_bug_num,
               L4_bug_num)
      VALUES (p_system_version,
              tester_name,
              'tester',
              bug_num,
              L1_bug_num,
              L2_bug_num,
              L3_bug_num,
              L4_bug_num);
    END IF;
  UNTIL notfound=1
  END REPEAT; 
  CLOSE tester_version;
  SET notfound=0;
  SET tester_name='';
  SET tester='';
  
  -- 从系统维度统计每个测试发现的缺陷数
  OPEN tester_system;
  REPEAT 
    FETCH tester_system INTO tester;
    IF notfound<>1 THEN
      SELECT query_user_name(tester) INTO tester_name;
      SELECT query_bug_by_tester(tester,p_system_version,'system','') INTO bug_num;
      SELECT query_bug_by_tester(tester,p_system_version,'system','L1') INTO L1_bug_num;
      SELECT query_bug_by_tester(tester,p_system_version,'system','L2') INTO L2_bug_num;
      SELECT query_bug_by_tester(tester,p_system_version,'system','L3') INTO L3_bug_num;
      SELECT query_bug_by_tester(tester,p_system_version,'system','L4') INTO L4_bug_num;
      REPLACE INTO sqcs.bug_group_by_person
              (system_version,
               person_name,
               person_type,
               bug_num,
               L1_bug_num,
               L2_bug_num,
               L3_bug_num,
               L4_bug_num)
      VALUES (q_sysname_by_version(p_system_version),
              tester_name,
              'tester',
              bug_num,
              L1_bug_num,
              L2_bug_num,
              L3_bug_num,
              L4_bug_num);
    END IF;
  UNTIL notfound=1
  END REPEAT; 
  CLOSE tester_system;
  
  -- 统计部署缺陷
  SELECT query_bug_by_tester('部署',p_system_version,'system','') INTO bug_num;
  SELECT query_bug_by_tester('部署',p_system_version,'system','L1') INTO L1_bug_num;
  SELECT query_bug_by_tester('部署',p_system_version,'system','L2') INTO L2_bug_num;
  SELECT query_bug_by_tester('部署',p_system_version,'system','L3') INTO L3_bug_num;
  SELECT query_bug_by_tester('部署',p_system_version,'system','L4') INTO L4_bug_num;
  REPLACE INTO sqcs.bug_group_by_person
      (system_version,
       person_name,
       person_type,
       bug_num,
       L1_bug_num,
       L2_bug_num,
       L3_bug_num,
       L4_bug_num)
  VALUES (q_sysname_by_version(p_system_version),
      '部署',
      'tester',
      bug_num,
      L1_bug_num,
      L2_bug_num,
      L3_bug_num,
      L4_bug_num);
            
END */$$
DELIMITER ;

/* Procedure structure for procedure `calu_test_exec_plan` */

/*!50003 DROP PROCEDURE IF EXISTS  `calu_test_exec_plan` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `calu_test_exec_plan`(in systemVersion varchar (50))
BEGIN
  declare v_exe_precend decimal (4, 2) ;
  declare v_workdays decimal (4, 0) default 0 ;
  declare v_test_date date ;
  declare i int default 1 ;
  DECLARE notfound INT DEFAULT 0 ;
  declare v_st_actual_execute_percent varchar (20) ;
  declare v_uat_actual_execute_percent varchar (20) ;
  declare c_test_date cursor for 
  select 
    test_date 
  from
    test_execute_plan 
  where system_version = systemVersion 
  order by test_date ;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET notfound = 1 ;
  -- 计算版本测试时间  
  SELECT 
    calculate_workdays (systemVersion) into v_workdays ;
  if v_workdays > 0 
  then set v_exe_precend := round(1 / v_workdays, 2) ;
  end if ;
  open c_test_date ;
  REPEAT
    -- 计算计划执行率
    FETCH c_test_date INTO v_test_date ;
    if i < v_workdays 
    then 
    update 
      test_execute_plan 
    set
      execute_percent = round((v_exe_precend * i), 2) 
    where system_version = systemVersion 
      and test_date = v_test_date ;
    elseif i = v_workdays 
    then 
    UPDATE 
      test_execute_plan 
    SET
      execute_percent = 1 
    WHERE system_version = systemVersion 
      AND test_date = v_test_date ;
    end if ;
    -- 计算实际执行率
    if v_test_date < date(now()) 
    then 
    select 
      systemVersion,
      v_test_date ;
    SELECT 
      calculate_test_execute (systemVersion, v_test_date) ;
    else 
    SELECT 
      st_actual_execute_percent,
      uat_actual_execute_percent into v_st_actual_execute_percent,
      v_uat_actual_execute_percent 
    FROM
      test_execute_plan 
    WHERE system_version = systemVersion 
      AND test_date = 
      (select 
        max(test_date) 
      from
        test_execute_plan 
      where system_version = systemVersion 
        and test_date < v_test_date) ;
    UPDATE 
      test_execute_plan 
    SET
      st_actual_execute_percent = v_st_actual_execute_percent 
    WHERE system_version = systemVersion 
      AND test_date = v_test_date ;
    UPDATE 
      test_execute_plan 
    SET
      uat_actual_execute_percent = v_uat_actual_execute_percent 
    WHERE system_version = systemVersion 
      AND test_date = v_test_date ;
    end if ;
    SET i := i + 1 ;
    UNTIL notfound = 1 
  END REPEAT ;
  close c_test_date ;
END */$$
DELIMITER ;

/* Procedure structure for procedure `delete_warning_info` */

/*!50003 DROP PROCEDURE IF EXISTS  `delete_warning_info` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `delete_warning_info`()
BEGIN
	DECLARE c_system_version varchar(40);
	declare c_warning_date date;
	declare c_warning_grade varchar(20);
	declare c_count decimal(4,0);
	DECLARE notfound INT DEFAULT 0;
	declare c_waning_info cursor for 
		SELECT system_version,warning_date,warning_grade FROM warning_info WHERE warning_type='03' and warning_date>date'2015-07-01';
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET notfound=1; 
	OPEN c_waning_info;
	REPEAT
		FETCH c_waning_info INTO c_system_version,c_warning_date,c_warning_grade;
		IF notfound<>1 THEN
		SELECT COUNT(*) into c_count FROM bug_checkordeal_time WHERE system_version=c_system_version AND check_or_deal='deal' AND over_time_date=c_warning_date AND warning_grade=c_warning_grade;
		if c_count=0 then
			delete from warning_info where system_version=c_system_version and warning_date=c_warning_date and warning_grade=c_warning_grade and warning_type='03';
		end if;
		end if;
	UNTIL notfound=1
	END REPEAT;
	cLOSE c_waning_info;
      
     
    END */$$
DELIMITER ;

/* Procedure structure for procedure `exec_procedure` */

/*!50003 DROP PROCEDURE IF EXISTS  `exec_procedure` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `exec_procedure`()
BEGIN
  DECLARE v_version VARCHAR (100) ;
  DECLARE notfound INT DEFAULT 0 ;
  DECLARE c_system_version CURSOR FOR 
  SELECT DISTINCT 
    a.system_version 
  FROM
    version_plantime a 
  WHERE DATE_ADD(
      reviewTest_end_date,
      INTERVAL 1 DAY
    ) >= DATE(NOW()) ;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET notfound = 1 ;
  OPEN c_system_version ;
  REPEAT
    FETCH c_system_version INTO v_version ;
    IF notfound <> 1 
    THEN CALL exec_procedure_by_version (v_version) ;
    end if ;
    UNTIL notfound = 1 
  END REPEAT ;
  close c_system_version;
END */$$
DELIMITER ;

/* Procedure structure for procedure `exec_procedure_by_dev` */

/*!50003 DROP PROCEDURE IF EXISTS  `exec_procedure_by_dev` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `exec_procedure_by_dev`(in p_dev_dept varchar(200))
BEGIN
    DECLARE v_version VARCHAR(200);
    DECLARE notfound INT DEFAULT 0;
    DECLARE err INT DEFAULT 0;
    DECLARE errorlog LONGTEXT;
    DECLARE v_system_version CURSOR FOR
	SELECT DISTINCT 
	  a.system_version 
	FROM
	  version_plantime a,
	  dept_system b 
	WHERE a.sub_system_name = b.system_name 
	  AND DATE_ADD(
	    a.reviewTest_end_date,
	    INTERVAL 1 DAY
	  ) >= DATE(NOW()) 
	  AND a.version_status NOT IN ('已关闭') 
	  AND b.dev_dept = p_dev_dept;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET notfound=1;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION,SQLWARNING SET err=1;
    OPEN v_system_version;
     REPEAT
      FETCH v_system_version INTO v_version;
      SELECT v_version;
      IF notfound<>1 THEN
     -- 缺陷趋势分析
     SET err=0;
      CALL bug_found_trend_analyse(v_version);
       IF err<>1 THEN
        REPLACE INTO exe_procedure_log(system_version,prucedure_name,is_success) VALUES(v_version,'缺陷趋势分析','Y');
       ELSE
        REPLACE INTO exe_procedure_log(system_version,prucedure_name,is_success,error_log) VALUES(v_version,'缺陷趋势分析','N','ERROR'); 
       END IF;
       
      -- 缺陷模块分布分析      
       SET err=0;
       CALL bug_distributing(v_version);
       IF err<>1 THEN
        REPLACE INTO exe_procedure_log(system_version,prucedure_name,is_success) VALUES(v_version,'缺陷模块分布分析','Y');
       ELSE
        REPLACE INTO exe_procedure_log(system_version,prucedure_name,is_success,error_log) VALUES(v_version,'缺陷模块分布分析','N','ERROR'); 
       END IF;
       
       -- 缺陷验证时效分析
       SET err=0;
       CALL bug_check_date_analyse(v_version);
       IF err<>1 THEN
        REPLACE INTO exe_procedure_log(system_version,prucedure_name,is_success) VALUES(v_version,'缺陷验证时效分析','Y');
       ELSE
        REPLACE INTO exe_procedure_log(system_version,prucedure_name,is_success,error_log) VALUES(v_version,'缺陷验证时效分析','N','ERROR'); 
       END IF;
       
       -- 缺陷处理时效分析
       SET err=0;
       CALL bug_deal_date_analyse(v_version);
       IF err<>1 THEN
        REPLACE INTO exe_procedure_log(system_version,prucedure_name,is_success) VALUES(v_version,'缺陷处理时效分析','Y');
       ELSE
        REPLACE INTO exe_procedure_log(system_version,prucedure_name,is_success,error_log) VALUES(v_version,'缺陷处理时效分析','N','ERROR'); 
       END IF;
       
       -- 缺陷按人员处理
       SET err=0;
       CALL bug_group_by_developer(v_version);
       IF err<>1 THEN
        REPLACE INTO exe_procedure_log(system_version,prucedure_name,is_success) VALUES(v_version,'缺陷按人员处理','Y');
       ELSE
        REPLACE INTO exe_procedure_log(system_version,prucedure_name,is_success,error_log) VALUES(v_version,'缺陷按人员处理','N','ERROR'); 
       END IF;   
       
       -- 缺陷趋势分析汇总
       SET err=0;
       CALL bug_found_trend_analyse_sum(v_version);
       IF err<>1 THEN
        REPLACE INTO exe_procedure_log(system_version,prucedure_name,is_success) VALUES(v_version,'缺陷趋势分析汇总','Y');
       ELSE
        REPLACE INTO exe_procedure_log(system_version,prucedure_name,is_success,error_log) VALUES(v_version,'缺陷趋势分析汇总','N','ERROR'); 
       END IF;
       
       -- 缺陷密度分析
       SET err=0;
       CALL bug_density_analyse(v_version);
       IF err<>1 THEN
        REPLACE INTO exe_procedure_log(system_version,prucedure_name,is_success) VALUES(v_version,'缺陷密度分析','Y');
       ELSE
        REPLACE INTO exe_procedure_log(system_version,prucedure_name,is_success,error_log) VALUES(v_version,'缺陷密度分析','N','ERROR'); 
       END IF;
       
       -- 版本缺陷理想模型
       SET err=0;
       CALL gompertz_calculation(v_version);
       IF err<>1 THEN
        REPLACE INTO exe_procedure_log(system_version,prucedure_name,is_success) VALUES(v_version,'版本缺陷理想模型','Y');
       ELSE
        REPLACE INTO exe_procedure_log(system_version,prucedure_name,is_success,error_log) VALUES(v_version,'版本缺陷理想模型','N','ERROR'); 
       END IF;  
			
	-- 计算当前测试进度情况
	SET err=0;
	CALL calu_test_exec_plan(v_version);
	IF err<>1 THEN
		REPLACE INTO exe_procedure_log(system_version,prucedure_name,is_success) VALUES(v_version,'版本预警','Y');
	ELSE
		REPLACE INTO exe_procedure_log(system_version,prucedure_name,is_success,error_log) VALUES(v_version,'版本预警','N','ERROR'); 
	END IF; 
	
        -- 版本预警
        SET err=0;
       CALL warning_check_version(v_version);
       IF err<>1 THEN
        REPLACE INTO exe_procedure_log(system_version,prucedure_name,is_success) VALUES(v_version,'版本预警','Y');
       ELSE
        REPLACE INTO exe_procedure_log(system_version,prucedure_name,is_success,error_log) VALUES(v_version,'版本预警','N','ERROR'); 
       END IF; 
      END IF;
      UNTIL notfound=1
      END REPEAT;
      CLOSE v_system_version;
      CALL is_version_delay();
      call update_dept_base_dev(p_dev_dept);
    END */$$
DELIMITER ;

/* Procedure structure for procedure `exec_procedure_by_version` */

/*!50003 DROP PROCEDURE IF EXISTS  `exec_procedure_by_version` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `exec_procedure_by_version`(v_version varchar(50))
BEGIN
    DECLARE err INT DEFAULT 0;
    DECLARE errorlog LONGTEXT;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION,SQLWARNING SET err=1;
     -- 缺陷趋势分析
     SET err=0;
      CALL bug_found_trend_analyse(v_version);
       IF err<>1 THEN
        REPLACE INTO exe_procedure_log(system_version,prucedure_name,is_success) VALUES(v_version,'缺陷趋势分析','Y');
       ELSE
        REPLACE INTO exe_procedure_log(system_version,prucedure_name,is_success,error_log) VALUES(v_version,'缺陷趋势分析','N','ERROR'); 
       END IF;
       
      -- 缺陷模块分布分析      
       SET err=0;
       CALL bug_distributing(v_version);
       IF err<>1 THEN
        REPLACE INTO exe_procedure_log(system_version,prucedure_name,is_success) VALUES(v_version,'缺陷模块分布分析','Y');
       ELSE
        REPLACE INTO exe_procedure_log(system_version,prucedure_name,is_success,error_log) VALUES(v_version,'缺陷模块分布分析','N','ERROR'); 
       END IF;
       
       -- 缺陷验证时效分析
       SET err=0;
       CALL bug_check_date_analyse(v_version);
       IF err<>1 THEN
        REPLACE INTO exe_procedure_log(system_version,prucedure_name,is_success) VALUES(v_version,'缺陷验证时效分析','Y');
       ELSE
        REPLACE INTO exe_procedure_log(system_version,prucedure_name,is_success,error_log) VALUES(v_version,'缺陷验证时效分析','N','ERROR'); 
       END IF;
       
       -- 缺陷处理时效分析
       SET err=0;
       CALL bug_deal_date_analyse(v_version);
       IF err<>1 THEN
        REPLACE INTO exe_procedure_log(system_version,prucedure_name,is_success) VALUES(v_version,'缺陷处理时效分析','Y');
       ELSE
        REPLACE INTO exe_procedure_log(system_version,prucedure_name,is_success,error_log) VALUES(v_version,'缺陷处理时效分析','N','ERROR'); 
       END IF;
       
       -- 缺陷按人员处理
       SET err=0;
       CALL bug_group_by_developer(v_version);
       IF err<>1 THEN
        REPLACE INTO exe_procedure_log(system_version,prucedure_name,is_success) VALUES(v_version,'缺陷按人员处理','Y');
       ELSE
        REPLACE INTO exe_procedure_log(system_version,prucedure_name,is_success,error_log) VALUES(v_version,'缺陷按人员处理','N','ERROR'); 
       END IF;   
       
       -- 缺陷趋势分析汇总
       SET err=0;
       CALL bug_found_trend_analyse_sum(v_version);
       IF err<>1 THEN
        REPLACE INTO exe_procedure_log(system_version,prucedure_name,is_success) VALUES(v_version,'缺陷趋势分析汇总','Y');
       ELSE
        REPLACE INTO exe_procedure_log(system_version,prucedure_name,is_success,error_log) VALUES(v_version,'缺陷趋势分析汇总','N','ERROR'); 
       END IF;
       
       -- 缺陷密度分析
       SET err=0;
       CALL bug_density_analyse(v_version);
       IF err<>1 THEN
        REPLACE INTO exe_procedure_log(system_version,prucedure_name,is_success) VALUES(v_version,'缺陷密度分析','Y');
       ELSE
        REPLACE INTO exe_procedure_log(system_version,prucedure_name,is_success,error_log) VALUES(v_version,'缺陷密度分析','N','ERROR'); 
       END IF;
       
       -- 版本缺陷理想模型
       SET err=0;
       CALL gompertz_calculation(v_version);
       IF err<>1 THEN
        REPLACE INTO exe_procedure_log(system_version,prucedure_name,is_success) VALUES(v_version,'版本缺陷理想模型','Y');
       ELSE
        REPLACE INTO exe_procedure_log(system_version,prucedure_name,is_success,error_log) VALUES(v_version,'版本缺陷理想模型','N','ERROR'); 
       END IF;  
			
	-- 计算当前测试进度情况
	SET err=0;
	CALL calu_test_exec_plan(v_version);
	IF err<>1 THEN
		REPLACE INTO exe_procedure_log(system_version,prucedure_name,is_success) VALUES(v_version,'版本预警','Y');
	ELSE
		REPLACE INTO exe_procedure_log(system_version,prucedure_name,is_success,error_log) VALUES(v_version,'版本预警','N','ERROR'); 
	END IF; 
	
        -- 版本预警
        SET err=0;
       CALL warning_check_version(v_version);
       IF err<>1 THEN
        REPLACE INTO exe_procedure_log(system_version,prucedure_name,is_success) VALUES(v_version,'版本预警','Y');
       ELSE
        REPLACE INTO exe_procedure_log(system_version,prucedure_name,is_success,error_log) VALUES(v_version,'版本预警','N','ERROR'); 
       END IF;  
    END */$$
DELIMITER ;

/* Procedure structure for procedure `gompertz_calculation` */

/*!50003 DROP PROCEDURE IF EXISTS  `gompertz_calculation` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `gompertz_calculation`(IN p_system_version VARCHAR (200))
BEGIN
  DECLARE expect_bugNum DECIMAL (3, 0) DEFAULT 40 ;
  DECLARE test_date_temp DATE ;
  DECLARE notfound INT DEFAULT 0 ;
  DECLARE i INTEGER DEFAULT 0 ;
  DECLARE bug_num DECIMAL (3, 0) ;
  DECLARE cur_test_date CURSOR FOR 
  SELECT 
    test_date 
  FROM
    bug_found_trend 
  WHERE system_version = p_system_version 
    and test_date is not null ;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET notfound = 1 ;
  -- 查出人力相似版本的缺陷数作为本次版本预期缺陷数
  SELECT 
    query_expect_bug_num (p_system_version) INTO expect_bugNum ;
  OPEN cur_test_date ;
  REPEAT
    FETCH cur_test_date INTO test_date_temp ;
    SET bug_num = ROUND(
      expect_bugNum * POWER(
        query_bug_increase_spd (
          query_system_by_version (p_system_version)
        ),
        POWER(
          query_bug_increase_exp (
            query_system_by_version (p_system_version)
          ),
          i
        )
      ),
      0
    ) ;
    if test_date_temp is not null 
    then REPLACE INTO gompertz_define (
      system_version,
      expect_bug_num,
      test_date,
      bug_found_num
    ) 
    VALUES
      (
        p_system_version,
        expect_bugNum,
        test_date_temp,
        bug_num
      ) ;
      end if ;
      SET i = i + 1 ;
      UNTIL notfound = 1 
    END REPEAT ;
    CLOSE cur_test_date ;
  END */$$
DELIMITER ;

/* Procedure structure for procedure `is_version_delay` */

/*!50003 DROP PROCEDURE IF EXISTS  `is_version_delay` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `is_version_delay`()
BEGIN
    DECLARE v_system_version VARCHAR(200);
    DECLARE v_transfer_base DATETIME;
    DECLARE v_transfer_fact DATETIME;
    DECLARE v_time int;
    DECLARE notfound INT DEFAULT 0;
    DECLARE version_delay CURSOR FOR 
      SELECT system_version FROM version_plantime WHERE is_delay IS NULL AND DATE_PRD_TRANSFER_FACT IS NOT NULL;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET notfound = 1 ;
    OPEN version_delay;
    REPEAT
     FETCH version_delay INTO v_system_version;
     IF notfound<>1 THEN
       SELECT DATE_PRD_TRANSFER_BASE,DATE_PRD_TRANSFER_FACT INTO v_transfer_base,v_transfer_fact FROM version_plantime  WHERE system_version=v_system_version;
        -- select v_transfer_base,v_transfer_fact;       
       select UNIX_TIMESTAMP(v_transfer_fact)-UNIX_TIMESTAMP(v_transfer_base) into v_time;
       -- select v_time;      
       IF v_time>0 THEN
         UPDATE version_plantime SET is_delay='Y' WHERE system_version=v_system_version;
       ELSE 
         UPDATE version_plantime SET is_delay='N' WHERE system_version=v_system_version;
       END IF;
     END IF;
     UNTIL notfound=1
     END REPEAT;
     CLOSE version_delay;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `test_schedule_analyse` */

/*!50003 DROP PROCEDURE IF EXISTS  `test_schedule_analyse` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `test_schedule_analyse`()
BEGIN
  DECLARE c_system_version VARCHAR (200) ;
  DECLARE notfound INT DEFAULT 0 ;
  DECLARE version_list CURSOR FOR 
  SELECT DISTINCT 
    system_version 
  FROM
    test_schedule ;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET notfound = 1 ;
  OPEN version_list ;
  REPEAT
    FETCH version_list INTO c_system_version ;
    CALL test_schedule_analyse_version (c_system_version) ;
    UNTIL notfound = 1 
  END REPEAT ;
  CLOSE version_list ;
END */$$
DELIMITER ;

/* Procedure structure for procedure `test_schedule_analyse_version` */

/*!50003 DROP PROCEDURE IF EXISTS  `test_schedule_analyse_version` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `test_schedule_analyse_version`(IN systemVersion VARCHAR(200))
BEGIN
	DECLARE c_test_plan VARCHAR(50);
	DECLARE notfound INT DEFAULT 0 ;
	DECLARE c_uat_warning_date DATE;
	declare c_st_exe_percent decimal(4,2);
	declare st_grade3 decimal(4,2);
	DECLARE st_grade2 DECIMAL(4,2);
	DECLARE st_grade1 DECIMAL(4,2);
	DECLARE uat_grade3 DECIMAL(4,2);
	DECLARE uat_grade2 DECIMAL(4,2);
	DECLARE uat_grade1 DECIMAL(4,2);
	Declare c_need_count DECIMAL(4,0); 
	declare flag boolean default false;
	DECLARE v_test_plan CURSOR FOR 
		SELECT test_plan FROM test_schedule WHERE  schedule_date=DATE_ADD(DATE(NOW()), INTERVAL -1 DAY) AND system_version=systemVersion GROUP BY test_plan;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET notfound = 1;
	call calu_test_exec_plan(systemVersion);
	SELECT custom_field2 into st_grade3 FROM warning_define WHERE warning_type='07' AND rule_no='3' AND warning_grade='3';
	SELECT custom_field2 INTO st_grade2 FROM warning_define WHERE warning_type='07' AND rule_no='3' AND warning_grade='2';
	SELECT custom_field2 INTO st_grade1 FROM warning_define WHERE warning_type='07' AND rule_no='3' AND warning_grade='1';
	SELECT custom_field2 INTO uat_grade3 FROM warning_define WHERE warning_type='07' AND rule_no='4' AND warning_grade='3';
	SELECT custom_field2 INTO uat_grade2 FROM warning_define WHERE warning_type='07' AND rule_no='4' AND warning_grade='2';
	SELECT custom_field2 INTO uat_grade1 FROM warning_define WHERE warning_type='07' AND rule_no='4' AND warning_grade='1';
	-- select st_grade3,st_grade2,st_grade1,uat_grade3,uat_grade2,uat_grade1;
	SELECT query_test_date(systemVersion,'0.5') INTO c_uat_warning_date FROM version_plantime WHERE system_version=systemVersion;
	SELECT COUNT(*) into c_need_count FROM need_info WHERE id_need IN (SELECT DISTINCT source_id FROM version_manpower WHERE system_version=systemVersion AND source_id IS NOT NULL);
	OPEN v_test_plan;
		REPEAT
			FETCH v_test_plan INTO c_test_plan;
			IF(c_test_plan='尚未建立ST测试计划') THEN
				REPLACE INTO `sqcs`.`warning_info`
				    (`system_version`,
				     `warning_date`,
				     `warning_type`,
				     `rule_no`,
				     `warning_grade`,
				     `warning_info`             
				     )
				VALUES(systemVersion,
				       DATE_ADD(DATE(NOW()), INTERVAL -1 DAY),
				       '07',
				       '1',
				       '3',
				       (SELECT warning FROM warning_define WHERE warning_type='07' AND rule_no='1'));
			END IF;
			IF(c_test_plan='尚未建立UAT测试计划' AND DATE_ADD(DATE(NOW()), INTERVAL -1 DAY)>=c_uat_warning_date and c_need_count>0) THEN
				REPLACE INTO `sqcs`.`warning_info`
				    (`system_version`,
				     `warning_date`,
				     `warning_type`,
				     `rule_no`,
				     `warning_grade`,
				     `warning_info`             
				     )
				VALUES(systemVersion,
				       DATE_ADD(DATE(NOW()), INTERVAL -1 DAY),
				       '07',
				       '2',
				       '3',
				       (SELECT warning FROM warning_define WHERE warning_type='07' AND rule_no='2'));
			END IF;
			IF c_test_plan='ST进度计划' THEN
				SELECT if(execute_percent-st_actual_execute_percent>0,execute_percent-st_actual_execute_percent,'0') into c_st_exe_percent FROM test_execute_plan WHERE system_version = systemVersion AND test_date = DATE_ADD(DATE(NOW()), INTERVAL -1 DAY);
				-- SELECT st_grade3,st_grade2,st_grade1,uat_grade3,uat_grade2,uat_grade1,c_st_exe_percent AS st;
				if c_st_exe_percent>=st_grade3 then
					REPLACE INTO `sqcs`.`warning_info`
					    (`system_version`,
					     `warning_date`,
					     `warning_type`,
					     `rule_no`,
					     `warning_grade`,
					     `warning_info`             
					     )
					VALUES(systemVersion,
					       DATE_ADD(DATE(NOW()), INTERVAL -1 DAY),
					       '07',
					       '3',
					       '3',
					       ( SELECT warning FROM warning_define WHERE warning_type='07' AND rule_no='3' AND warning_grade='3' ));
			        end if;
			        IF c_st_exe_percent>=st_grade2 and c_st_exe_percent<st_grade3 THEN
					REPLACE INTO `sqcs`.`warning_info`
					    (`system_version`,
					     `warning_date`,
					     `warning_type`,
					     `rule_no`,
					     `warning_grade`,
					     `warning_info`             
					     )
					VALUES(systemVersion,
					       DATE_ADD(DATE(NOW()), INTERVAL -1 DAY),
					       '07',
					       '3',
					       '2',
					       ( SELECT warning FROM warning_define WHERE warning_type='07' AND rule_no='3' AND warning_grade='2' ));
			        END IF;
			        IF c_st_exe_percent>=st_grade1 AND c_st_exe_percent<st_grade2 THEN
					REPLACE INTO `sqcs`.`warning_info`
					    (`system_version`,
					     `warning_date`,
					     `warning_type`,
					     `rule_no`,
					     `warning_grade`,
					     `warning_info`             
					     )
					VALUES(systemVersion,
					       DATE_ADD(DATE(NOW()), INTERVAL -1 DAY),
					       '07',
					       '3',
					       '1',
					       ( SELECT warning FROM warning_define WHERE warning_type='07' AND rule_no='3' AND warning_grade='1' ));
			        END IF;
			end if;     
			IF c_test_plan='UAT进度计划' THEN
				SELECT if(execute_percent-uat_actual_execute_percent>0,execute_percent-uat_actual_execute_percent,'0') INTO c_st_exe_percent FROM test_execute_plan WHERE system_version = systemVersion AND test_date =DATE_ADD(DATE(NOW()), INTERVAL -1 DAY);
				-- select c_st_exe_percent as uat;
				IF c_st_exe_percent>=uat_grade3 THEN
					REPLACE INTO `sqcs`.`warning_info`
					    (`system_version`,
					     `warning_date`,
					     `warning_type`,
					     `rule_no`,
					     `warning_grade`,
					     `warning_info`             
					     )
					VALUES(systemVersion,
					       DATE_ADD(DATE(NOW()), INTERVAL -1 DAY),
					       '07',
					       '4',
					       '3',
					       ( SELECT warning FROM warning_define WHERE warning_type='07' AND rule_no='4' AND warning_grade='3' ));
			        END IF;
			        IF c_st_exe_percent>=uat_grade2 AND c_st_exe_percent<uat_grade3 THEN
					REPLACE INTO `sqcs`.`warning_info`
					    (`system_version`,
					     `warning_date`,
					     `warning_type`,
					     `rule_no`,
					     `warning_grade`,
					     `warning_info`             
					     )
					VALUES(systemVersion,
					       DATE_ADD(DATE(NOW()), INTERVAL -1 DAY),
					       '07',
					       '4',
					       '2',
					       ( SELECT warning FROM warning_define WHERE warning_type='07' AND rule_no='4' AND warning_grade='2' ));
			        END IF;
			        IF c_st_exe_percent>=uat_grade1 AND c_st_exe_percent<uat_grade2 THEN
					REPLACE INTO `sqcs`.`warning_info`
					    (`system_version`,
					     `warning_date`,
					     `warning_type`,
					     `rule_no`,
					     `warning_grade`,
					     `warning_info`             
					     )
					VALUES(systemVersion,
					       DATE_ADD(DATE(NOW()), INTERVAL -1 DAY),
					       '07',
					       '4',
					       '1',
					       ( SELECT warning FROM warning_define WHERE warning_type='07' AND rule_no='4' AND warning_grade='1' ));
			        END IF;
			END IF; 	
		UNTIL notfound=1
		END REPEAT;
	set notfound:=0;
	close v_test_plan;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `uat_feedback_warning` */

/*!50003 DROP PROCEDURE IF EXISTS  `uat_feedback_warning` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `uat_feedback_warning`(IN systemVersion VARCHAR (200))
BEGIN
  DECLARE notfound INT DEFAULT 0 ;
  DECLARE feedback_sum INT DEFAULT 0 ;
  DECLARE c_need_code VARCHAR (50) ;
  DECLARE flag BOOLEAN DEFAULT FALSE ;
  DECLARE v_uat_feedback CURSOR FOR 
  SELECT 
    need_code 
  FROM
    test_schedule 
  WHERE system_version = systemVersion 
    AND test_plan = 'UAT进度计划' 
    AND passed_percent = '100.00%' ;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET notfound = 1 ;
  OPEN v_uat_feedback ;
  REPEAT
    FETCH v_uat_feedback INTO c_need_code ;
    IF notfound <> 1 
    THEN 
    SELECT 
      COUNT(*) into feedback_sum 
    FROM
      uat_feedback 
    WHERE need_id = c_need_code ;
    IF feedback_sum = 0 
    THEN SET flag := TRUE ;
    END IF ;
    END IF ;
    UNTIL notfound = 1 
  END REPEAT ;
  CLOSE v_uat_feedback ;
  IF flag 
  THEN REPLACE INTO `sqcs`.`warning_info` (
    `system_version`,
    `warning_date`,
    `warning_type`,
    `rule_no`,
    `warning_grade`,
    `warning_info`
  ) 
  VALUES
    (
      systemVersion,
      DATE_ADD(DATE(NOW()), INTERVAL - 1 DAY),
      '05',
      '1',
      '1',
      (SELECT 
        warning 
      FROM
        warning_define 
      WHERE warning_type = '05' 
        AND rule_no = '1' 
        AND warning_grade = '1')
    ) ;
    END IF ;
  END */$$
DELIMITER ;

/* Procedure structure for procedure `um_info_initialize` */

/*!50003 DROP PROCEDURE IF EXISTS  `um_info_initialize` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`10.50.124.117` PROCEDURE `um_info_initialize`()
BEGIN
  DECLARE v_dev_dept VARCHAR (200) ;
  DECLARE v_dev_team VARCHAR (200) ;
  DECLARE notfound INT DEFAULT 0 ;
  DECLARE c_dept_info CURSOR FOR 
  SELECT DISTINCT 
    dev_dept,
    dev_team 
  FROM
    dept_system ;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET notfound = 1 ;
  OPEN c_dept_info ;
  REPEAT
    FETCH c_dept_info INTO v_dev_dept,
    v_dev_team ;
    UPDATE 
      um_info 
    SET
      team_name = v_dev_team 
    WHERE dept_name = v_dev_dept 
      AND (
        SUBSTR(team_name, 1, 4) = SUBSTR(v_dev_team, 1, 4) 
        OR SUBSTR(team_name, 2, 4) = SUBSTR(v_dev_team, 2, 4) 
        OR SUBSTR(team_name, 3, 4) = SUBSTR(v_dev_team, 3, 4) 
        OR SUBSTR(team_name, 4, 4) = SUBSTR(v_dev_team, 4, 4) 
        OR SUBSTR(team_name, 5, 4) = SUBSTR(v_dev_team, 5, 4)
      ) ;
    UNTIL notfound = 1 
  END REPEAT ;
  CLOSE c_dept_info ;
END */$$
DELIMITER ;

/* Procedure structure for procedure `update_dept_base` */

/*!50003 DROP PROCEDURE IF EXISTS  `update_dept_base` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `update_dept_base`()
BEGIN
  DECLARE notfound INT DEFAULT 0 ;
  DECLARE devDept VARCHAR (50) ;
  DECLARE deptCode VARCHAR (50) ;
  
  DECLARE dev_info CURSOR FOR 
  SELECT DISTINCT 
    dev_dept 
  FROM
    test_team_info 
  where dev_dept not in (
      '平安科技',
      '测试管理部'
    ) ;
    
  DECLARE dept_code_info CURSOR FOR 
  SELECT DISTINCT 
    dept_name,
    paic_unique_deptid 
  FROM
    dept_base_table 
  WHERE dept_name IN 
    (SELECT DISTINCT 
      dev_dept 
    FROM
      dept_system_temp) ;
      
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET notfound = 1 ;
  
  OPEN dev_info ;
  REPEAT
    FETCH dev_info INTO devDept;
    call update_dept_base_dev(devDept) ;
    UNTIL notfound = 1 
  END REPEAT ;
  CLOSE dev_info ;
  
  OPEN dept_code_info ;
  REPEAT
    FETCH dept_code_info INTO devDept,
    deptCode ;
    UPDATE 
      dept_system 
    SET
      dept_code = deptCode 
    WHERE dev_dept = devDept ;
    UNTIL notfound = 1 
  END REPEAT ;
  CLOSE dept_code_info ;
END */$$
DELIMITER ;

/* Procedure structure for procedure `update_dept_base_dev` */

/*!50003 DROP PROCEDURE IF EXISTS  `update_dept_base_dev` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `update_dept_base_dev`(IN devDept VARCHAR (200))
BEGIN
  DECLARE notfound INT DEFAULT 0 ;
  DECLARE systemAlias VARCHAR (50) ;
  DECLARE systemName VARCHAR (500) ;
  DECLARE devTeam VARCHAR (500) ;
  DECLARE module_temp VARCHAR (5000) ;
  DECLARE num DECIMAL (2, 0) ;
  DECLARE system_info CURSOR FOR 
  SELECT 
    system_alias,
    system_name,
    dev_team,
    module 
  FROM
    dept_system_temp 
  WHERE dev_dept = devDept ;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET notfound = 1 ;
  OPEN system_info ;
  REPEAT
    FETCH system_info INTO systemAlias,
    systemName,
    devTeam,
    module_temp ;
    SELECT 
      COUNT(*) INTO num 
    FROM
      dept_system 
    WHERE system_alias = systemAlias 
      AND dev_dept = devDept ;
    IF(num > 0) 
    THEN 
    UPDATE 
      dept_system 
    SET
      module = module_temp 
    WHERE system_alias = systemAlias 
      AND dev_dept = devDept ;
    ELSE 
    INSERT INTO dept_system (
      dev_dept,
      dev_team,
      system_alias,
      system_name,
      module
    ) 
    VALUES
      (
        devDept,
        devTeam,
        systemAlias,
        systemName,
        module_temp
      ) ;
    END IF ;
    UNTIL notfound = 1 
  END REPEAT ;
  CLOSE system_info ;
END */$$
DELIMITER ;

/* Procedure structure for procedure `warning_check_version` */

/*!50003 DROP PROCEDURE IF EXISTS  `warning_check_version` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `warning_check_version`(in systemVersion varchar (200))
BEGIN
  declare c_test_date date ;
  DECLARE notfound INT DEFAULT 0 ;
  declare c_warning_define varchar (500) ;
  declare c_warning_define_temp VARCHAR (500) ;
  declare c_warning_info varchar (20) ;
  DECLARE c_warning_type VARCHAR (20) ;
  DECLARE c_warning_flag VARCHAR (20) ;
  DECLARE c_warning_type_num int default 0 ;
  DECLARE c_warning_type_num_temp INT DEFAULT 0 ;
  DECLARE c_warning_type_num_temp1 INT DEFAULT 0 ;
  DECLARE i INT DEFAULT 1 ;
  declare test_date_list cursor for 
  SELECT 
    test_date 
  from
    bug_found_trend 
  where system_version = systemVersion 
    AND test_date NOT IN 
    (SELECT 
      first_deploy_test_time 
    FROM
      version_plantime 
    WHERE system_version = systemVersion) 
    AND test_date <= date_add(DATE(NOW()), interval - 1 day) ;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET notfound = 1 ;
  SELECT 
    COUNT(DISTINCT warning_type) into c_warning_type_num 
  FROM
    warning_define  ;
  SELECT 
    warning_define into c_warning_define 
  FROM
    dept_system 
  WHERE system_name IN 
    (SELECT 
      sub_system_name 
    FROM
      version_plantime 
    WHERE system_version = systemVersion)
  and warning_define is not null
  LIMIT 0, 1;
  IF(c_warning_define IS NOT NULL) 
  THEN 
  while
    (i <= c_warning_type_num) do 
    SELECT 
      func_splitString (c_warning_define, ";", i) into c_warning_define_temp ;
    SELECT 
      func_splitString (c_warning_define_temp, ":", "1") INTO c_warning_type ;
    SELECT 
      func_splitString (c_warning_define_temp, ":", "2") INTO c_warning_flag ;
    replace INTO warning_define_temp (warning_type, warning_flag) 
    VALUES
      (c_warning_type, c_warning_flag) ;
      set i := i + 1 ;
    end while ;
    END IF ;
    IF(c_warning_define IS NULL) 
    THEN 
    WHILE
      (i <= c_warning_type_num) DO 
      REPLACE INTO warning_define_temp (warning_type, warning_flag) 
      VALUES
        (CONCAT("0",i) , "Y") ;
        SET i := i + 1 ;
      END WHILE ;
      END IF ;
      select 
        count(*) into c_warning_type_num_temp 
      from
        warning_define_temp 
      where warning_type = '02' 
        and warning_flag = 'Y' ;
      if (c_warning_type_num_temp > 0)then 
	call bug_distributing_abnormity (systemVersion) ;
      -- 02
      end if ;
      SELECT 
        COUNT(*) INTO c_warning_type_num_temp 
      FROM
        warning_define_temp 
      WHERE warning_type = '03' 
        AND warning_flag = 'Y' ;
      IF (c_warning_type_num_temp > 0) 
      THEN call bug_deal_date_warning (systemVersion) ;
      -- 03
      END IF ;
      SELECT 
        COUNT(*) INTO c_warning_type_num_temp 
      FROM
        warning_define_temp 
      WHERE warning_type = '04' 
        AND warning_flag = 'Y' ;
      IF (c_warning_type_num_temp > 0) 
      THEN call bug_check_date_warning (systemVersion) ;
      -- 04
      END IF ;
      SELECT 
        COUNT(*) INTO c_warning_type_num_temp 
      FROM
        warning_define_temp 
      WHERE warning_type = '05' 
        AND warning_flag = 'Y' ;
      IF (c_warning_type_num_temp > 0) 
      THEN call uat_feedback_warning (systemVersion) ;
      -- 05
      END IF ;
      SELECT 
        COUNT(*) INTO c_warning_type_num_temp 
      FROM
        warning_define_temp 
      WHERE warning_type = '07' 
        AND warning_flag = 'Y' ;
      IF (c_warning_type_num_temp > 0) 
      THEN CALL test_schedule_analyse_version (systemVersion) ;
      -- 07 
      END IF ;
      SELECT 
        COUNT(*) INTO c_warning_type_num_temp 
      FROM
        warning_define_temp 
      WHERE warning_type = '01' 
        AND warning_flag = 'Y' ;
      SELECT 
        COUNT(*) INTO c_warning_type_num_temp1 
      FROM
        warning_define_temp 
      WHERE warning_type = '06' 
        AND warning_flag = 'Y' ;
      if (
        c_warning_type_num_temp > 0 
        or c_warning_type_num_temp1 > 0
      ) 
      then open test_date_list ;
      repeat
        fetch test_date_list into c_test_date ;
        if(c_warning_type_num_temp > 0) 
        then 
        select 
          query_warning_for_bugs1_new (systemVersion, c_test_date) ;
        -- 01
        SELECT 
          query_warning_for_bugs2 (systemVersion, c_test_date) ;
        -- 01
        SELECT 
          query_warning_for_bugs3 (systemVersion, c_test_date) ;
        -- 01
        end if ;
        if(c_warning_type_num_temp1 > 0) 
        then 
        select 
          query_warning_for_bugs4 (systemVersion, c_test_date) ;
        -- 06
        end if ;
        until notfound = 1 
      end repeat ;
      close test_date_list ;
      end if ;
    END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
