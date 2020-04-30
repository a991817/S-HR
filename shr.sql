/*
 Navicat Premium Data Transfer

 Source Server         : zyxy_vm
 Source Server Type    : MySQL
 Source Server Version : 50724
 Source Host           : 192.168.126.128:3306
 Source Schema         : shr

 Target Server Type    : MySQL
 Target Server Version : 50724
 File Encoding         : 65001

 Date: 26/04/2020 18:40:28
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tb_address
-- ----------------------------
DROP TABLE IF EXISTS `tb_address`;
CREATE TABLE `tb_address`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) NOT NULL COMMENT '员工号',
  `province` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '省',
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '市',
  `area` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '区',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_address
-- ----------------------------
INSERT INTO `tb_address` VALUES (2, 3, '13', '1305', '130524');

-- ----------------------------
-- Table structure for tb_admin
-- ----------------------------
DROP TABLE IF EXISTS `tb_admin`;
CREATE TABLE `tb_admin`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `status` tinyint(255) UNSIGNED NULL DEFAULT 1 COMMENT '0：禁用 1：可用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_admin
-- ----------------------------
INSERT INTO `tb_admin` VALUES (1, 'zhangsan', '123456', 1);

-- ----------------------------
-- Table structure for tb_apply
-- ----------------------------
DROP TABLE IF EXISTS `tb_apply`;
CREATE TABLE `tb_apply`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) NOT NULL COMMENT '员工号',
  `type` tinyint(2) NOT NULL COMMENT '申请类型 1-签到补卡 2-签退补卡 3-请假 4-离职',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注，理由',
  `state` tinyint(2) NULL DEFAULT 0 COMMENT '是否解决 0-未审批 1-审批通过 2-审批未通过',
  `date` datetime(0) NOT NULL COMMENT '申请日期',
  `start_time` datetime(0) NULL DEFAULT NULL COMMENT '如果是请假的话，请假开始时间',
  `end_time` datetime(0) NULL DEFAULT NULL COMMENT '请假结束时间',
  PRIMARY KEY (`id`, `type`, `date`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_apply
-- ----------------------------
INSERT INTO `tb_apply` VALUES (5, 3, 2, '321', 0, '2020-04-11 18:21:08', '2020-04-10 16:04:46', '2020-04-10 16:04:53');
INSERT INTO `tb_apply` VALUES (7, 3, 3, '35', 2, '2020-04-16 10:30:13', '2020-04-17 10:30:16', '2020-04-25 10:30:20');
INSERT INTO `tb_apply` VALUES (12, 3, 2, 'qt', 1, '2020-04-16 17:16:19', '2020-04-10 18:00:00', '2020-04-10 18:00:00');
INSERT INTO `tb_apply` VALUES (13, 3, 1, 'qd', 1, '2020-04-16 17:20:51', '2020-04-10 08:00:00', '2020-04-10 08:00:00');
INSERT INTO `tb_apply` VALUES (17, 3, 1, '忘记4', 1, '2020-04-20 12:56:01', '2020-04-11 08:00:00', '2020-04-11 08:00:00');
INSERT INTO `tb_apply` VALUES (18, 3, 2, '忘记签退', 1, '2020-04-20 12:58:06', '2020-04-16 18:00:00', '2020-04-16 18:00:00');
INSERT INTO `tb_apply` VALUES (19, 3, 3, '儿科', 2, '2020-04-20 15:24:33', '2020-04-20 00:00:00', '2020-04-21 00:00:00');
INSERT INTO `tb_apply` VALUES (20, 3, 3, '777', 1, '2020-04-20 15:30:47', '2020-04-24 00:00:00', '2020-04-20 00:00:00');
INSERT INTO `tb_apply` VALUES (21, 3, 3, '777', 0, '2020-04-20 15:31:15', '2020-04-24 00:00:00', '2020-04-20 00:00:00');
INSERT INTO `tb_apply` VALUES (22, 3, 3, '123123123', 0, '2020-04-20 15:39:59', '2020-04-20 00:00:00', '2020-04-23 00:00:00');
INSERT INTO `tb_apply` VALUES (23, 3, 4, '321', 1, '2020-04-20 16:01:31', '2020-04-23 00:00:00', '2020-04-23 16:32:38');
INSERT INTO `tb_apply` VALUES (24, 5, 4, '123', 0, '2020-04-20 16:32:50', '2020-04-26 16:32:53', '2020-04-26 16:32:58');

-- ----------------------------
-- Table structure for tb_attendance
-- ----------------------------
DROP TABLE IF EXISTS `tb_attendance`;
CREATE TABLE `tb_attendance`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) NOT NULL COMMENT '员工Id',
  `date` date NOT NULL COMMENT '考情日日期',
  `sign_in_time` datetime(0) NULL DEFAULT NULL COMMENT '签到时间',
  `sign_out_time` datetime(0) NULL DEFAULT NULL COMMENT '签退时间',
  `work_hours` int(255) NULL DEFAULT NULL COMMENT '工作时长',
  `overtime_hours` int(255) NULL DEFAULT NULL COMMENT '加班时长',
  `sign_in_state` int(2) NULL DEFAULT 0 COMMENT '0-正常 1-迟到',
  `sign_out_state` int(2) NULL DEFAULT 0 COMMENT '0-正常 2-早退',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_attendance
-- ----------------------------
INSERT INTO `tb_attendance` VALUES (7, 5, '2020-04-10', '2020-04-10 13:35:48', '2020-04-10 15:35:52', 0, 0, 1, 1);
INSERT INTO `tb_attendance` VALUES (8, 3, '2020-04-10', '2020-04-10 08:00:00', '2020-04-10 18:00:00', 10, 0, 0, 0);
INSERT INTO `tb_attendance` VALUES (11, 3, '2020-04-11', '2020-04-11 08:00:00', '2020-04-11 18:54:32', 10, 0, 0, 0);
INSERT INTO `tb_attendance` VALUES (14, 3, '2020-04-16', '2020-04-16 07:27:40', '2020-04-16 18:00:00', 11, 1, 1, 0);

-- ----------------------------
-- Table structure for tb_bonus
-- ----------------------------
DROP TABLE IF EXISTS `tb_bonus`;
CREATE TABLE `tb_bonus`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) NOT NULL COMMENT '员工号',
  `bonus` decimal(10, 2) NOT NULL COMMENT '奖金',
  `pay_year_month` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '发奖金的月份',
  `type` int(2) NOT NULL COMMENT '奖金类型 1-年终奖 2-当月奖金',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1772 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_bonus
-- ----------------------------
INSERT INTO `tb_bonus` VALUES (1575, 3, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1576, 24, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1577, 28, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1578, 40, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1579, 44, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1580, 52, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1581, 56, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1582, 1368, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1583, 1380, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1584, 1412, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1585, 1416, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1586, 1420, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1587, 1424, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1588, 1428, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1589, 1436, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1590, 1440, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1591, 1444, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1592, 1448, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1593, 1452, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1594, 1456, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1595, 1460, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1596, 1464, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1597, 1468, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1598, 1472, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1599, 1476, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1600, 1480, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1601, 1484, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1602, 1496, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1603, 1500, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1604, 1504, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1605, 1508, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1606, 1512, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1607, 1520, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1608, 1532, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1609, 1536, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1610, 1540, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1611, 1548, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1612, 1556, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1613, 1560, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1614, 1564, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1615, 1572, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1616, 1576, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1617, 1580, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1618, 1584, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1619, 1588, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1620, 1592, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1621, 1600, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1622, 1604, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1623, 1612, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1624, 1620, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1625, 1624, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1626, 1632, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1627, 1636, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1628, 1640, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1629, 1648, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1630, 1656, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1631, 1660, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1632, 1664, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1633, 1668, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1634, 1672, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1635, 1676, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1636, 1680, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1637, 1712, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1638, 1744, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1639, 1748, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1640, 1752, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1641, 1760, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1642, 1764, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1643, 1768, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1644, 1772, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1645, 1776, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1646, 1792, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1647, 1796, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1648, 1800, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1649, 1808, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1650, 1824, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1651, 1832, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1652, 1836, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1653, 1840, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1654, 1844, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1655, 1848, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1656, 1852, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1657, 1856, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1658, 1864, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1659, 1876, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1660, 1880, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1661, 1884, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1662, 1888, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1663, 1892, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1664, 1893, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1665, 1904, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1666, 1908, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1667, 1912, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1668, 1920, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1669, 1924, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1670, 1928, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1671, 1932, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1672, 1936, 500.00, '2020-04', 2);
INSERT INTO `tb_bonus` VALUES (1673, 3, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1674, 24, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1675, 28, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1676, 40, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1677, 44, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1678, 52, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1679, 56, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1680, 1368, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1681, 1380, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1682, 1412, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1683, 1416, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1684, 1420, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1685, 1424, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1686, 1428, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1687, 1436, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1688, 1440, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1689, 1444, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1690, 1448, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1691, 1452, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1692, 1456, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1693, 1460, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1694, 1464, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1695, 1468, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1696, 1472, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1697, 1476, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1698, 1480, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1699, 1484, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1700, 1496, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1701, 1500, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1702, 1504, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1703, 1508, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1704, 1512, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1705, 1520, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1706, 1532, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1707, 1536, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1708, 1540, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1709, 1548, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1710, 1556, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1711, 1560, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1712, 1564, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1713, 1572, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1714, 1576, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1715, 1580, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1716, 1584, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1717, 1588, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1718, 1592, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1719, 1600, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1720, 1604, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1721, 1612, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1722, 1620, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1723, 1624, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1724, 1632, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1725, 1636, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1726, 1640, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1727, 1648, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1728, 1656, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1729, 1660, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1730, 1664, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1731, 1668, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1732, 1672, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1733, 1676, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1734, 1680, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1735, 1712, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1736, 1744, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1737, 1748, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1738, 1752, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1739, 1760, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1740, 1764, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1741, 1768, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1742, 1772, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1743, 1776, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1744, 1792, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1745, 1796, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1746, 1800, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1747, 1808, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1748, 1824, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1749, 1832, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1750, 1836, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1751, 1840, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1752, 1844, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1753, 1848, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1754, 1852, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1755, 1856, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1756, 1864, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1757, 1876, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1758, 1880, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1759, 1884, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1760, 1888, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1761, 1892, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1762, 1893, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1763, 1904, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1764, 1908, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1765, 1912, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1766, 1920, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1767, 1924, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1768, 1928, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1769, 1932, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1770, 1936, 1.00, '2020-12', 1);
INSERT INTO `tb_bonus` VALUES (1771, 3, 600.00, '2020-04', 2);

-- ----------------------------
-- Table structure for tb_department
-- ----------------------------
DROP TABLE IF EXISTS `tb_department`;
CREATE TABLE `tb_department`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dep_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '部门名称',
  `leader_id` int(11) NULL DEFAULT NULL COMMENT '部门领导id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_department
-- ----------------------------
INSERT INTO `tb_department` VALUES (1, '研发部', 1772);
INSERT INTO `tb_department` VALUES (2, '人力资源部', 2);
INSERT INTO `tb_department` VALUES (3, '销售部', 3);
INSERT INTO `tb_department` VALUES (4, '客服务', 35);
INSERT INTO `tb_department` VALUES (9, 'abc', 1948);
INSERT INTO `tb_department` VALUES (10, 'abcd', NULL);

-- ----------------------------
-- Table structure for tb_employee
-- ----------------------------
DROP TABLE IF EXISTS `tb_employee`;
CREATE TABLE `tb_employee`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '员工编号',
  `name` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '员工姓名',
  `gender` char(4) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别',
  `birthday` date NULL DEFAULT NULL COMMENT '出生日期',
  `id_number` char(18) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身份证号',
  `wedlock` enum('已婚','未婚','离异') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '婚姻状况',
  `nationId` int(8) NULL DEFAULT NULL COMMENT '民族',
  `native_place` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '籍贯',
  `email` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话号码',
  `department_id` int(11) NULL DEFAULT NULL COMMENT '所属部门',
  `position_id` int(11) NULL DEFAULT NULL COMMENT '职位ID',
  `tiptop_degree` enum('博士','硕士','本科','大专','高中','初中','小学','其他') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最高学历',
  `school` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '毕业院校',
  `begin_date` date NULL DEFAULT NULL COMMENT '入职日期',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '123456' COMMENT '密码',
  `work_state` int(11) NULL DEFAULT 1 COMMENT '在职状态 1-在职 0-离职',
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '居住地址',
  `basic_salary` decimal(10, 2) NULL DEFAULT 0.00 COMMENT '基本工资',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id_number`(`id_number`) USING BTREE,
  INDEX `departmentId`(`department_id`) USING BTREE,
  INDEX `dutyId`(`position_id`) USING BTREE,
  INDEX `nationId`(`nationId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1949 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_employee
-- ----------------------------
INSERT INTO `tb_employee` VALUES (2, '张三2', '女', '1990-01-02', '161553138655313865', '已婚', 1, '海南', 'chenjing@qq.com', '16155313865', 6, 3, '高中', '武汉大学', '2015-06-09', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (3, '张三3', '女', '1995-12-11', '158744614804461480', '已婚', 1, '陕西', 'liushijie@qq.com', '15874461480', 1, 4, '博士', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 12000.00);
INSERT INTO `tb_employee` VALUES (5, '张三5', '女', '1990-01-02', '197855609021978556', '已婚', 1, '河南', 'yaosen@qq.com', '19785560902', 2, 2, '硕士', '西北大学', '2017-01-02', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (6, '张三6', '女', '1990-01-02', '179163349937916334', '已婚', 1, '陕西西安', 'yunxing@qq.com', '17916334993', 3, 3, '硕士', '西安电子科技学校', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (9, '张三9', '女', '1990-01-02', '162980142352980142', '已婚', 1, '陕西西安', 'xuelei@qq.com', '16298014235', 2, 2, '初中', '华胥中学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (10, '张三10', '女', '1990-01-02', '188770393657039365', '未婚', 1, '海南', 'zhangjie@qq.com', '18877039365', 3, 3, '高中', '海南侨中', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (11, '张三11', '女', '1990-01-02', '176373401716373401', '已婚', 1, '陕西', 'laowang@qq.com', '17637340171', 4, 4, '本科', '深圳大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (13, '张三13', '女', '1990-01-02', '177430096181774300', '未婚', 1, '陕西', 'zhao@qq.com', '17743009618', 2, 2, '博士', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (15, '张三15', '女', '1990-01-02', '196967956766967956', '已婚', 1, '河南', 'yaosen@qq.com', '19696795676', 4, 4, '初中', '西北大学', '2017-01-02', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (17, '张三17', '女', '1990-01-02', '158677057666770576', '已婚', 1, '广东广州', 'jiaxuming@qq.com', '15867705766', 2, 2, '初中', '西北大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (18, '张三18', '女', '1990-01-02', '193975708411939757', '已婚', 1, '广东', 'zhangliming@qq.com', '19397570841', 3, 3, '高中', '清华大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (21, '张三21', '女', '1990-01-02', '195938587979593858', '已婚', 1, '陕西', 'laowang@qq.com', '19593858797', 2, 2, '本科', '深圳大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (24, '张三24', '女', '1989-12-30', '198206850000685001', '已婚', 1, '陕西', 'zhao@qq.com', '19820685000', 1, 1, '高中', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (25, '张三25', '女', '1990-01-02', '193759658483759658', '已婚', 1, '河南', 'yaosen@qq.com', '19375965848', 2, 2, '初中', '西北大学', '2017-01-02', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (28, '张三28', '女', '1990-01-02', '166447551301664475', '已婚', 1, '广东', 'zhangliming@qq.com', '16644755130', 1, 1, '高中', '清华大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (31, '张三31', '女', '1990-01-02', '194903792740379274', '已婚', 1, '陕西', 'laowang@qq.com', '19490379274', 4, 4, '本科', '深圳大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (33, '张三33', '女', '1990-01-02', '178300845160084516', '未婚', 1, '陕西', 'zhao@qq.com', '17830084516', 2, 2, '博士', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (34, '张三34', '女', '1990-01-02', '172035868630358686', '已婚', 1, '陕西', 'zhao@qq.com', '17203586863', 3, 3, '高中', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (35, '张三35', '女', '1990-01-02', '166738668216673866', '已婚', 1, '河南', 'yaosen@qq.com', '16673866821', 4, 4, '初中', '西北大学', '2017-01-02', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (37, '张三37', '女', '1990-01-02', '176483834291764838', '已婚', 1, '广东广州', 'jiaxuming@qq.com', '17648383429', 2, 2, '初中', '西北大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (38, '张三38', '女', '1990-01-02', '166738244987382449', '已婚', 1, '广东', 'zhangliming@qq.com', '16673824498', 3, 3, '高中', '清华大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (39, '张三39', '女', '1990-01-02', '185701582531857015', '已婚', 1, '陕西西安', 'xuelei@qq.com', '18570158253', 4, 4, '初中', '华胥中学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (40, '张三40', '女', '1990-01-02', '189755038288975503', '未婚', 1, '海南', 'zhangjie@qq.com', '18975503828', 1, 1, '高中', '海南侨中', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (41, '张三41', '女', '1990-01-02', '193132304323230432', '已婚', 1, '陕西', 'laowang@qq.com', '19313230432', 2, 2, '本科', '深圳大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (42, '张三42', '女', '1990-01-02', '197858267328582673', '已婚', 1, '海南', 'chenjing@qq.com', '19785826732', 3, 3, '高中', '武汉大学', '2015-06-09', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (43, '张三43', '女', '1990-01-02', '171356284155628415', '未婚', 1, '陕西', 'zhao@qq.com', '17135628415', 4, 4, '博士', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (44, '张三44', '女', '1990-01-02', '184668479336684793', '已婚', 1, '陕西', 'zhao@qq.com', '18466847933', 1, 1, '高中', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (45, '张三45', '女', '1990-01-02', '170735404737073540', '已婚', 1, '河南', 'yaosen@qq.com', '17073540473', 2, 2, '初中', '西北大学', '2017-01-02', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (47, '张三47', '女', '1990-01-02', '194922877339492287', '已婚', 1, '广东广州', 'jiaxuming@qq.com', '19492287733', 4, 4, '初中', '西北大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (49, '张三49', '女', '1990-01-02', '180072771451800727', '已婚', 1, '陕西西安', 'xuelei@qq.com', '18007277145', 2, 2, '初中', '华胥中学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (51, '张三51', '女', '1990-01-02', '160233506340233506', '已婚', 1, '陕西', 'laowang@qq.com', '16023350634', 4, 4, '本科', '深圳大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (52, '张三52', '女', '1990-01-02', '191235416163541616', '已婚', 1, '海南', 'chenjing@qq.com', '19123541616', 1, 1, '高中', '武汉大学', '2015-06-09', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (53, '张三53', '女', '1990-01-02', '196938422293842229', '未婚', 1, '陕西', 'zhao@qq.com', '19693842229', 2, 2, '博士', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (54, '张三54', '女', '1990-01-02', '172447723501724477', '已婚', 1, '陕西', 'zhao@qq.com', '17244772350', 3, 3, '高中', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (55, '张三55', '女', '1990-01-02', '192885211188521118', '已婚', 1, '河南', 'yaosen@qq.com', '19288521118', 4, 4, '初中', '西北大学', '2017-01-02', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (56, '张三56', '女', '1990-01-02', '168544745944474594', '已婚', 1, '陕西西安', 'yunxing@qq.com', '16854474594', 1, 1, '硕士', '西安电子科技学校', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1351, '张三1351', '女', '1990-01-02', '185529956705529956', '已婚', 1, '陕西', 'laowang@qq.com', '18552995670', 4, 4, '本科', '深圳大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1354, '张三1354', '女', '1990-01-02', '182324749002474900', '已婚', 1, '陕西', 'zhao@qq.com', '18232474900', 3, 3, '高中', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1358, '张三1358', '女', '1990-01-02', '172687836648783664', '已婚', 1, '广东', 'zhangliming@qq.com', '17268783664', 3, 3, '高中', '清华大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1359, '张三1359', '女', '1990-01-02', '186810083756810083', '已婚', 1, '陕西西安', 'xuelei@qq.com', '18681008375', 4, 4, '初中', '华胥中学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1366, '张三1366', '女', '1990-01-02', '172872649897287264', '已婚', 1, '陕西西安', 'yunxing@qq.com', '17287264989', 3, 3, '硕士', '西安电子科技学校', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1367, '张三1367', '女', '1990-01-02', '171111661217111166', '已婚', 1, '广东广州', 'jiaxuming@qq.com', '17111166121', 4, 4, '初中', '西北大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1368, '张三1368', '女', '1990-01-02', '178402216901784022', '已婚', 1, '广东', 'zhangliming@qq.com', '17840221690', 1, 1, '高中', '清华大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1373, '张三1373', '女', '1990-01-02', '171603248436032484', '已婚', 1, '陕西', 'zhao@qq.com', '17160324843', 2, 2, '高中', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1375, '张三1375', '女', '1990-01-02', '171660917276609172', '已婚', 1, '陕西西安', 'yunxing@qq.com', '17166091727', 4, 4, '硕士', '西安电子科技学校', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1377, '张三1377', '女', '1990-01-02', '170284937008493700', '已婚', 1, '广东', 'zhangliming@qq.com', '17028493700', 2, 2, '高中', '清华大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1380, '张三1380', '女', '1990-01-02', '191764176899176417', '已婚', 1, '海南', 'chenjing@qq.com', '19176417689', 1, 1, '高中', '武汉大学', '2015-06-09', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1381, '张三1381', '女', '1990-01-02', '169415867754158677', '未婚', 1, '陕西', 'zhao@qq.com', '16941586775', 2, 2, '博士', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1382, '张三1382', '女', '1990-01-02', '193248668612486686', '已婚', 1, '陕西', 'zhao@qq.com', '19324866861', 3, 3, '高中', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1383, '张三1383', '女', '1990-01-02', '179457600331794576', '已婚', 1, '河南', 'yaosen@qq.com', '17945760033', 4, 4, '初中', '西北大学', '2017-01-02', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1385, '张三1385', '女', '1990-01-02', '178108341238108341', '已婚', 1, '广东广州', 'jiaxuming@qq.com', '17810834123', 2, 2, '初中', '西北大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1412, '张三1412', '女', '1990-01-02', '182096825278209682', '已婚', 1, '广东', '584991843@qq.com', '18209682527', 1, 1, '大专', '广东职业技术学院', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1413, '张三1413', '女', '1990-01-02', '186969993816969993', '已婚', 1, '1', '584991843@qq.com', '18696999381', 2, 2, '本科', '1', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1414, '张三1414', '女', '1990-01-02', '190021353819002135', '已婚', 1, '1', '584991843@qq.com', '19002135381', 3, 3, '大专', '1', '2018-01-31', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1416, '张三1416', '女', '1990-01-02', '184691039726910397', '已婚', 1, '1', '584991843@qq.com', '18469103972', 1, 1, '大专', '1', '2018-01-31', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1418, '张三1418', '女', '1990-01-02', '172094315317209431', '已婚', 1, '1', '584991843@qq.com', '17209431531', 3, 3, '大专', '1', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1419, '张三1419', '女', '1990-01-02', '163110092703110092', '未婚', 1, '1', '584991843@qq.com', '16311009270', 4, 4, '大专', '1', '2018-01-31', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1420, '张三1420', '女', '1990-01-02', '180729378118072937', '已婚', 1, '1', '584991843@qq.com', '18072937811', 1, 1, '大专', '1', '2018-01-31', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1422, '张三1422', '女', '1990-01-02', '178166091201781660', '已婚', 1, '海南', 'chenjing@qq.com', '17816609120', 3, 3, '高中', '武汉大学', '2015-06-09', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1423, '张三1423', '女', '1990-01-02', '164956897546495689', '未婚', 1, '陕西', 'zhao@qq.com', '16495689754', 4, 4, '博士', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1424, '张三1424', '女', '1990-01-02', '171748074647480746', '已婚', 1, '陕西', 'zhao@qq.com', '17174807464', 1, 1, '高中', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1425, '张三1425', '女', '1990-01-02', '165331541121653315', '已婚', 1, '河南', 'yaosen@qq.com', '16533154112', 2, 2, '硕士', '西北大学', '2017-01-02', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1426, '张三1426', '女', '1990-01-02', '192875342221928753', '已婚', 1, '陕西西安', 'yunxing@qq.com', '19287534222', 3, 3, '硕士', '西安电子科技学校', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1428, '张三1428', '女', '1990-01-02', '172055575160555751', '已婚', 1, '广东', 'zhangliming@qq.com', '17205557516', 1, 1, '高中', '清华大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1431, '张三1431', '女', '1990-01-02', '176511149911114991', '已婚', 1, '陕西', 'laowang@qq.com', '17651114991', 4, 4, '本科', '深圳大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1434, '张三1434', '女', '1990-01-02', '191408211444082114', '已婚', 1, '陕西', 'zhao@qq.com', '19140821144', 3, 3, '高中', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1435, '张三1435', '女', '1990-01-02', '187510210168751021', '已婚', 1, '河南', 'yaosen@qq.com', '18751021016', 4, 4, '初中', '西北大学', '2017-01-02', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1436, '张三1436', '女', '1990-01-02', '164788277018827701', '已婚', 1, '陕西西安', 'yunxing@qq.com', '16478827701', 1, 1, '硕士', '西安电子科技学校', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1437, '张三1437', '女', '1990-01-02', '182872615112872615', '已婚', 1, '广东广州', 'jiaxuming@qq.com', '18287261511', 2, 2, '初中', '西北大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1440, '张三1440', '女', '1990-01-02', '177804247807804247', '未婚', 1, '海南', 'zhangjie@qq.com', '17780424780', 1, 1, '高中', '海南侨中', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1442, '张三1442', '女', '1990-01-02', '198296507411982965', '已婚', 1, '海南', 'chenjing@qq.com', '19829650741', 3, 3, '高中', '武汉大学', '2015-06-09', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1444, '张三1444', '女', '1990-01-02', '180552155515521555', '已婚', 1, '河南', 'yaosen@qq.com', '18055215551', 1, 1, '初中', '西北大学', '2017-01-02', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1445, '张三1445', '女', '1990-01-02', '175834747765834747', '已婚', 1, '陕西西安', 'yunxing@qq.com', '17583474776', 2, 2, '硕士', '西安电子科技学校', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1446, '张三1446', '女', '1990-01-02', '178979132798979132', '已婚', 1, '广东广州', 'jiaxuming@qq.com', '17897913279', 3, 3, '初中', '西北大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1447, '张三1447', '女', '1990-01-02', '168853281238532812', '已婚', 1, '广东', 'zhangliming@qq.com', '16885328123', 4, 4, '高中', '清华大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1448, '张三1448', '女', '1990-01-02', '188790868291887908', '已婚', 1, '陕西西安', 'xuelei@qq.com', '18879086829', 1, 1, '初中', '华胥中学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1449, '张三1449', '女', '1990-01-02', '158856358318563583', '已婚', 1, '陕西', 'laowang@qq.com', '15885635831', 2, 2, '本科', '深圳大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1451, '张三1451', '女', '1990-01-02', '191748021617480216', '未婚', 1, '陕西', 'zhao@qq.com', '19174802161', 4, 4, '博士', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1452, '张三1452', '女', '1990-01-02', '192088827000888270', '已婚', 1, '陕西', 'zhao@qq.com', '19208882700', 1, 1, '高中', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1454, '张三1454', '女', '1990-01-02', '198505033078505033', '已婚', 1, '陕西西安', 'yunxing@qq.com', '19850503307', 3, 3, '硕士', '西安电子科技学校', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1456, '张三1456', '女', '1990-01-02', '175952930131759529', '已婚', 1, '广东', 'zhangliming@qq.com', '17595293013', 1, 1, '高中', '清华大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1458, '张三1458', '女', '1990-01-02', '169717119721711972', '未婚', 1, '海南', 'zhangjie@qq.com', '16971711972', 3, 3, '高中', '海南侨中', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1460, '张三1460', '女', '1990-01-02', '174205648322056483', '已婚', 1, '海南', 'chenjing@qq.com', '17420564832', 1, 1, '高中', '武汉大学', '2015-06-09', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1462, '张三1462', '女', '1990-01-02', '195609985405609985', '已婚', 1, '陕西', 'zhao@qq.com', '19560998540', 3, 3, '高中', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1463, '张三1463', '女', '1990-01-02', '173452745665274566', '已婚', 1, '河南', 'yaosen@qq.com', '17345274566', 4, 4, '初中', '西北大学', '2017-01-02', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1464, '张三1464', '女', '1990-01-02', '161895632608956326', '已婚', 1, '陕西西安', 'yunxing@qq.com', '16189563260', 1, 1, '硕士', '西安电子科技学校', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1468, '张三1468', '女', '1990-01-02', '161090067671610900', '未婚', 1, '海南', 'zhangjie@qq.com', '16109006767', 1, 1, '高中', '海南侨中', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1469, '张三1469', '女', '1990-01-02', '167504262530426253', '已婚', 1, '陕西', 'laowang@qq.com', '16750426253', 2, 2, '本科', '深圳大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1472, '张三1472', '女', '1990-01-02', '161892568858925688', '已婚', 1, '陕西', 'zhao@qq.com', '16189256885', 1, 1, '高中', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1473, '张三1473', '女', '1990-01-02', '178382933507838293', '已婚', 1, '河南', 'yaosen@qq.com', '17838293350', 2, 2, '初中', '西北大学', '2017-01-02', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1474, '张三1474', '女', '1990-01-02', '167698821477698821', '已婚', 1, '陕西西安', 'yunxing@qq.com', '16769882147', 3, 3, '硕士', '西安电子科技学校', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1476, '张三1476', '女', '1990-01-02', '182401233191824012', '已婚', 1, '海南', 'chenjing@qq.com', '18240123319', 1, 1, '高中', '武汉大学', '2015-06-09', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1477, '张三1477', '女', '1990-01-02', '159046524254652425', '未婚', 1, '陕西', 'zhao@qq.com', '15904652425', 2, 2, '博士', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1480, '张三1480', '女', '1990-01-02', '191870507591870507', '已婚', 1, '广东广州', 'jiaxuming@qq.com', '19187050759', 1, 1, '初中', '西北大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1481, '张三1481', '女', '1990-01-02', '165485802344858023', '已婚', 1, '广东', 'zhangliming@qq.com', '16548580234', 2, 2, '高中', '清华大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1482, '张三1482', '女', '1990-01-02', '173279349457327934', '已婚', 1, '陕西西安', 'xuelei@qq.com', '17327934945', 3, 3, '初中', '华胥中学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1483, '张三1483', '女', '1990-01-02', '171401200764012007', '未婚', 1, '海南', 'zhangjie@qq.com', '17140120076', 4, 4, '高中', '海南侨中', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1484, '张三1484', '女', '1990-01-02', '178629815971786298', '已婚', 1, '陕西', 'laowang@qq.com', '17862981597', 1, 1, '本科', '深圳大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1485, '张三1485', '女', '1990-01-02', '180407338130733813', '已婚', 1, '海南', 'chenjing@qq.com', '18040733813', 2, 2, '高中', '武汉大学', '2015-06-09', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1487, '张三1487', '女', '1990-01-02', '178285362447828536', '已婚', 1, '陕西', 'zhao@qq.com', '17828536244', 4, 4, '高中', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1489, '张三1489', '女', '1990-01-02', '176912588091769125', '已婚', 1, '陕西西安', 'yunxing@qq.com', '17691258809', 2, 2, '硕士', '西安电子科技学校', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1490, '张三1490', '女', '1990-01-02', '195840712045840712', '已婚', 1, '广东广州', 'jiaxuming@qq.com', '19584071204', 3, 3, '初中', '西北大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1491, '张三1491', '女', '1990-01-02', '169927656481699276', '已婚', 1, '广东', 'zhangliming@qq.com', '16992765648', 4, 4, '高中', '清华大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1493, '张三1493', '女', '1990-01-02', '169568925105689251', '未婚', 1, '海南', 'zhangjie@qq.com', '16956892510', 2, 2, '高中', '海南侨中', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1495, '张三1495', '女', '1990-01-02', '185617413478561741', '已婚', 1, '海南', 'chenjing@qq.com', '18561741347', 4, 4, '高中', '武汉大学', '2015-06-09', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1496, '张三1496', '女', '1990-01-02', '193831530963831530', '已婚', 1, '陕西', 'zhao@qq.com', '19383153096', 1, 1, '高中', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1500, '张三1500', '女', '1990-01-02', '195942166935942166', '已婚', 1, '广东', 'zhangliming@qq.com', '19594216693', 1, 1, '高中', '清华大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1504, '张三1504', '女', '1990-01-02', '169354849841693548', '未婚', 1, '陕西', 'zhao@qq.com', '16935484984', 1, 1, '博士', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1506, '张三1506', '女', '1990-01-02', '159472656741594726', '已婚', 1, '河南', 'yaosen@qq.com', '15947265674', 3, 3, '初中', '西北大学', '2017-01-02', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1507, '张三1507', '女', '1990-01-02', '191179936799117993', '已婚', 1, '陕西西安', 'yunxing@qq.com', '19117993679', 4, 4, '硕士', '西安电子科技学校', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1508, '张三1508', '女', '1990-01-02', '158943574251589435', '已婚', 1, '广东广州', 'jiaxuming@qq.com', '15894357425', 1, 1, '初中', '西北大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1511, '张三1511', '女', '1990-01-02', '162695820491626958', '已婚', 1, '1', '584991843@qq.com', '16269582049', 4, 4, '本科', '1', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1512, '张三1512', '女', '1990-01-02', '181448728471814487', '已婚', 1, '1', '584991843@qq.com', '18144872847', 1, 1, '大专', '1', '2018-01-31', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1513, '张三1513', '女', '1990-01-02', '180618041400618041', '已婚', 1, '1', '584991843@qq.com', '18061804140', 2, 2, '大专', '1', '2018-01-31', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1514, '张三1514', '女', '1990-01-02', '160205882162058821', '已婚', 1, '1', '584991843@qq.com', '16020588216', 3, 3, '大专', '1', '2018-01-31', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1515, '张三1515', '女', '1990-01-02', '180637147128063714', '已婚', 1, '1', '584991843@qq.com', '18063714712', 4, 4, '大专', '1', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1517, '张三1517', '女', '1990-01-02', '179700167351797001', '未婚', 1, '1', '584991843@qq.com', '17970016735', 2, 2, '大专', '1', '2018-01-31', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1519, '张三1519', '女', '1990-01-02', '161725600446172560', '已婚', 1, '陕西', 'laowang@qq.com', '16172560044', 4, 4, '本科', '深圳大学', '2017-12-31', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1520, '张三1520', '女', '1990-01-02', '166471317577131757', '已婚', 1, '陕西', 'laowang@qq.com', '16647131757', 1, 1, '本科', '深圳大学', '2019-11-05', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1521, '张三1521', '女', '1990-01-02', '188641647068864164', '已婚', 1, '', 'laowang@qq.com', '18864164706', 2, 2, '本科', '深圳大学', '2019-11-05', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1522, '张三1522', '女', '1990-01-02', '165256143116525614', '已婚', 1, '陕西', 'laowan@123.com', '16525614311', 3, 3, '本科', '深圳大学', '2017-12-31', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1523, '张三1523', '女', '1990-01-02', '181817634918181763', '已婚', 1, '陕西', 'laowan@123.com', '18181763491', 4, 4, '本科', '深圳大学', '2017-12-31', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1529, '张三1529', '女', '1990-01-02', '165220738736522073', '已婚', 1, '广东', '123@qq.com', '16522073873', 2, 2, '本科', '深圳大学', '2019-11-10', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1530, '张三1530', '女', '1990-01-02', '167459654931674596', '已婚', 1, '陕西', 'laowang@qq.com', '16745965493', 3, 3, '本科', '深圳大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1532, '张三1532', '女', '1990-01-02', '174572490707249070', '未婚', 1, '陕西', 'zhao@qq.com', '17457249070', 1, 1, '博士', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1533, '张三1533', '女', '1990-01-02', '165030557046503055', '已婚', 1, '陕西', 'zhao@qq.com', '16503055704', 2, 2, '高中', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1536, '张三1536', '女', '1990-01-02', '197050627701970506', '已婚', 1, '广东广州', 'jiaxuming@qq.com', '19705062770', 1, 1, '初中', '西北大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1537, '张三1537', '女', '1990-01-02', '164146826166414682', '已婚', 1, '广东', 'zhangliming@qq.com', '16414682616', 2, 2, '高中', '清华大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1538, '张三1538', '女', '1990-01-02', '191044108279104410', '已婚', 1, '陕西西安', 'xuelei@qq.com', '19104410827', 3, 3, '初中', '华胥中学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1539, '张三1539', '女', '1990-01-02', '184241923382419233', '未婚', 1, '海南', 'zhangjie@qq.com', '18424192338', 4, 4, '高中', '海南侨中', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1540, '张三1540', '女', '1990-01-02', '189539152649539152', '已婚', 1, '陕西', 'laowang@qq.com', '18953915264', 1, 1, '本科', '深圳大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1541, '张三1541', '女', '1990-01-02', '196431853596431853', '已婚', 1, '海南', 'chenjing@qq.com', '19643185359', 2, 2, '高中', '武汉大学', '2015-06-09', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1542, '张三1542', '女', '1990-01-02', '175003670550367055', '未婚', 1, '陕西', 'zhao@qq.com', '17500367055', 3, 3, '博士', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1543, '张三1543', '女', '1990-01-02', '167184652511671846', '已婚', 1, '陕西', 'zhao@qq.com', '16718465251', 4, 4, '高中', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1545, '张三1545', '女', '1990-01-02', '181778460247784602', '已婚', 1, '陕西西安', 'yunxing@qq.com', '18177846024', 2, 2, '硕士', '西安电子科技学校', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1546, '张三1546', '女', '1990-01-02', '173231827411732318', '已婚', 1, '广东广州', 'jiaxuming@qq.com', '17323182741', 3, 3, '初中', '西北大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1548, '张三1548', '女', '1990-01-02', '173194462567319446', '已婚', 1, '陕西西安', 'xuelei@qq.com', '17319446256', 1, 1, '初中', '华胥中学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1549, '张三1549', '女', '1990-01-02', '180577322798057732', '未婚', 1, '海南', 'zhangjie@qq.com', '18057732279', 2, 2, '高中', '海南侨中', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1550, '张三1550', '女', '1990-01-02', '184765086806508680', '已婚', 1, '陕西', 'laowang@qq.com', '18476508680', 3, 3, '本科', '深圳大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1551, '张三1551', '女', '1990-01-02', '183555326153555326', '已婚', 1, '海南', 'chenjing@qq.com', '18355532615', 4, 4, '高中', '武汉大学', '2015-06-09', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1553, '张三1553', '女', '1990-01-02', '195512036615120366', '已婚', 1, '河南', 'yaosen@qq.com', '19551203661', 2, 2, '初中', '西北大学', '2017-01-02', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1554, '张三1554', '女', '1990-01-02', '164192350854192350', '已婚', 1, '陕西西安', 'yunxing@qq.com', '16419235085', 3, 3, '硕士', '西安电子科技学校', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1555, '张三1555', '女', '1990-01-02', '195887504979588750', '已婚', 1, '广东广州', 'jiaxuming@qq.com', '19588750497', 4, 4, '初中', '西北大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1556, '张三1556', '女', '1990-01-02', '168322332811683223', '已婚', 1, '广东', 'zhangliming@qq.com', '16832233281', 1, 1, '高中', '清华大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1558, '张三1558', '女', '1990-01-02', '173549910583549910', '已婚', 1, '陕西', 'laowang@qq.com', '17354991058', 3, 3, '本科', '深圳大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1560, '张三1560', '女', '1990-01-02', '195704050479570405', '未婚', 1, '陕西', 'zhao@qq.com', '19570405047', 1, 1, '博士', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1561, '张三1561', '女', '1990-01-02', '191046959909104695', '已婚', 1, '陕西', 'zhao@qq.com', '19104695990', 2, 2, '高中', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1562, '张三1562', '女', '1990-01-02', '169584508639584508', '已婚', 1, '河南', 'yaosen@qq.com', '16958450863', 3, 3, '初中', '西北大学', '2017-01-02', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1563, '张三1563', '女', '1990-01-02', '196243523961962435', '已婚', 1, '陕西西安', 'yunxing@qq.com', '19624352396', 4, 4, '硕士', '西安电子科技学校', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1564, '张三1564', '女', '1990-01-02', '193925954441939259', '已婚', 1, '广东广州', 'jiaxuming@qq.com', '19392595444', 1, 1, '初中', '西北大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1565, '张三1565', '女', '1990-01-02', '182361060853610608', '已婚', 1, '广东', 'zhangliming@qq.com', '18236106085', 2, 2, '高中', '清华大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1569, '张三1569', '女', '1990-01-02', '176585720026585720', '已婚', 1, '海南', 'chenjing@qq.com', '17658572002', 2, 2, '高中', '武汉大学', '2015-06-09', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1570, '张三1570', '女', '1990-01-02', '186030811170308111', '未婚', 1, '陕西', 'zhao@qq.com', '18603081117', 3, 3, '博士', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1571, '张三1571', '女', '1990-01-02', '161858756368587563', '已婚', 1, '陕西', 'zhao@qq.com', '16185875636', 4, 4, '高中', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1572, '张三1572', '女', '1990-01-02', '172663208821726632', '已婚', 1, '河南', 'yaosen@qq.com', '17266320882', 1, 1, '初中', '西北大学', '2017-01-02', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1575, '张三1575', '女', '1990-01-02', '161259013082590130', '已婚', 1, '广东', 'zhangliming@qq.com', '16125901308', 4, 4, '高中', '清华大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1576, '张三1576', '女', '1990-01-02', '189315690431893156', '已婚', 1, '陕西西安', 'xuelei@qq.com', '18931569043', 1, 1, '初中', '华胥中学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1577, '张三1577', '女', '1990-01-02', '184263273438426327', '未婚', 1, '海南', 'zhangjie@qq.com', '18426327343', 2, 2, '高中', '海南侨中', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1578, '张三1578', '女', '1990-01-02', '194831156403115640', '已婚', 1, '陕西', 'laowang@qq.com', '19483115640', 3, 3, '本科', '深圳大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1579, '张三1579', '女', '1990-01-02', '182827822228278222', '已婚', 1, '海南', 'chenjing@qq.com', '18282782222', 4, 4, '高中', '武汉大学', '2015-06-09', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1580, '张三1580', '女', '1990-01-02', '171107502451075024', '未婚', 1, '陕西', 'zhao@qq.com', '17110750245', 1, 1, '博士', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1581, '张三1581', '女', '1990-01-02', '188515906101590610', '已婚', 1, '陕西', 'zhao@qq.com', '18851590610', 2, 2, '高中', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1583, '张三1583', '女', '1990-01-02', '189508560821895085', '已婚', 1, '陕西西安', 'yunxing@qq.com', '18950856082', 4, 4, '硕士', '西安电子科技学校', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1584, '张三1584', '女', '1990-01-02', '176848013461768480', '已婚', 1, '陕西', 'laowang@qq.com', '17684801346', 1, 1, '本科', '深圳大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1585, '张三1585', '女', '1990-01-02', '197176245387624538', '已婚', 1, '海南', 'chenjing@qq.com', '19717624538', 2, 2, '高中', '武汉大学', '2015-06-09', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1586, '张三1586', '女', '1990-01-02', '176799047056799047', '未婚', 1, '陕西', 'zhao@qq.com', '17679904705', 3, 3, '博士', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1587, '张三1587', '女', '1990-01-02', '173928359651739283', '已婚', 1, '陕西', 'zhao@qq.com', '17392835965', 4, 4, '高中', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1588, '张三1588', '女', '1990-01-02', '180706517650651765', '已婚', 1, '河南', 'yaosen@qq.com', '18070651765', 1, 1, '初中', '西北大学', '2017-01-02', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1589, '张三1589', '女', '1990-01-02', '183209369808320936', '已婚', 1, '广东广州', 'jiaxuming@qq.com', '18320936980', 2, 2, '初中', '西北大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1590, '张三1590', '女', '1990-01-02', '175389156628915662', '已婚', 1, '广东', 'zhangliming@qq.com', '17538915662', 3, 3, '高中', '清华大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1591, '张三1591', '女', '1990-01-02', '168779534238779534', '已婚', 1, '陕西西安', 'xuelei@qq.com', '16877953423', 4, 4, '初中', '华胥中学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1592, '张三1592', '女', '1990-01-02', '159192061801591920', '未婚', 1, '海南', 'zhangjie@qq.com', '15919206180', 1, 1, '高中', '海南侨中', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1595, '张三1595', '女', '1990-01-02', '184728707104728707', '未婚', 1, '陕西', 'zhao@qq.com', '18472870710', 4, 4, '博士', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1600, '张三1600', '女', '1990-01-02', '174828235308282353', '已婚', 1, '广东', 'zhangliming@qq.com', '17482823530', 1, 1, '高中', '清华大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1601, '张三1601', '女', '1990-01-02', '178553446895534468', '已婚', 1, '陕西西安', 'xuelei@qq.com', '17855344689', 2, 2, '初中', '华胥中学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1604, '张三1604', '女', '1990-01-02', '184846019444846019', '已婚', 1, '海南', 'chenjing@qq.com', '18484601944', 1, 1, '高中', '武汉大学', '2015-06-09', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1605, '张三1605', '女', '1990-01-02', '182121562052156205', '已婚', 1, '陕西', 'zhao@qq.com', '18212156205', 2, 2, '高中', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1606, '张三1606', '女', '1990-01-02', '197531612481975316', '已婚', 1, '河南', 'yaosen@qq.com', '19753161248', 3, 3, '初中', '西北大学', '2017-01-02', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1607, '张三1607', '女', '1990-01-02', '162755236785523678', '已婚', 1, '陕西西安', 'yunxing@qq.com', '16275523678', 4, 4, '硕士', '西安电子科技学校', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1610, '张三1610', '女', '1990-01-02', '185593165525931655', '已婚', 1, '陕西西安', 'xuelei@qq.com', '18559316552', 3, 3, '初中', '华胥中学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1612, '张三1612', '女', '1990-01-02', '175638026735638026', '已婚', 1, '海南', 'chenjing@qq.com', '17563802673', 1, 1, '高中', '武汉大学', '2015-06-09', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1615, '张三1615', '女', '1990-01-02', '173929885497392988', '已婚', 1, '河南', 'yaosen@qq.com', '17392988549', 4, 4, '初中', '西北大学', '2017-01-02', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1618, '张三1618', '女', '1990-01-02', '168180865731808657', '离异', 1, '江苏', '584991843@qq.com', '16818086573', 3, 3, '本科', '南华大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1619, '张三1619', '女', '1990-01-02', '174014587311458731', '已婚', 1, '广东', '584991843@qq.com', '17401458731', 4, 4, '大专', '广东职业技术学院', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1620, '张三1620', '女', '1990-01-02', '166992199889921998', '已婚', 1, '1', '584991843@qq.com', '16699219988', 1, 1, '本科', '1', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1622, '张三1622', '女', '1990-01-02', '192380750921923807', '已婚', 1, '1', '584991843@qq.com', '19238075092', 3, 3, '大专', '1', '2018-01-31', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1623, '张三1623', '女', '1990-01-02', '180228321138022832', '已婚', 1, '1', '584991843@qq.com', '18022832113', 4, 4, '大专', '1', '2018-01-31', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1624, '张三1624', '女', '1990-01-02', '165461213416121341', '已婚', 1, '1', '584991843@qq.com', '16546121341', 1, 1, '大专', '1', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1625, '张三1625', '女', '1990-01-02', '168082964210829642', '已婚', 1, '1', '584991843@qq.com', '16808296421', 2, 2, '大专', '1', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1626, '张三1626', '女', '1990-01-02', '185493041344930413', '未婚', 1, '1', '584991843@qq.com', '18549304134', 3, 3, '大专', '1', '2018-01-31', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1627, '张三1627', '女', '1990-01-02', '184678174627817462', '已婚', 1, '1', '584991843@qq.com', '18467817462', 4, 4, '大专', '1', '2018-01-31', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1629, '张三1629', '女', '1990-01-02', '169295384711692953', '已婚', 1, '海南', 'chenjing@qq.com', '16929538471', 2, 2, '高中', '武汉大学', '2015-06-09', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1630, '张三1630', '女', '1990-01-02', '182817955271795527', '未婚', 1, '陕西', 'zhao@qq.com', '18281795527', 3, 3, '博士', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1631, '张三1631', '女', '1990-01-02', '167665482736654827', '已婚', 1, '陕西', 'zhao@qq.com', '16766548273', 4, 4, '高中', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1632, '张三1632', '女', '1990-01-02', '171335408403540840', '已婚', 1, '河南', 'yaosen@qq.com', '17133540840', 1, 1, '硕士', '西北大学', '2017-01-02', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1633, '张三1633', '女', '1990-01-02', '195142454361424543', '已婚', 1, '陕西西安', 'yunxing@qq.com', '19514245436', 2, 2, '硕士', '西安电子科技学校', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1635, '张三1635', '女', '1990-01-02', '171874032971874032', '已婚', 1, '广东', 'zhangliming@qq.com', '17187403297', 4, 4, '高中', '清华大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1636, '张三1636', '女', '1990-01-02', '191328304071328304', '已婚', 1, '陕西西安', 'xuelei@qq.com', '19132830407', 1, 1, '初中', '华胥中学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1638, '张三1638', '女', '1990-01-02', '159883358265988335', '已婚', 1, '陕西', 'laowang@qq.com', '15988335826', 3, 3, '本科', '深圳大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1639, '张三1639', '女', '1990-01-02', '193434805879343480', '已婚', 1, '海南', 'chenjing@qq.com', '19343480587', 4, 4, '高中', '武汉大学', '2015-06-09', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1640, '张三1640', '女', '1990-01-02', '168985815109858151', '未婚', 1, '陕西', 'zhao@qq.com', '16898581510', 1, 1, '博士', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1642, '张三1642', '女', '1990-01-02', '184937007341849370', '已婚', 1, '河南', 'yaosen@qq.com', '18493700734', 3, 3, '初中', '西北大学', '2017-01-02', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1643, '张三1643', '女', '1990-01-02', '167887341998734199', '已婚', 1, '陕西西安', 'yunxing@qq.com', '16788734199', 4, 4, '硕士', '西安电子科技学校', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1645, '张三1645', '女', '1990-01-02', '168237576792375767', '已婚', 1, '广东', 'zhangliming@qq.com', '16823757679', 2, 2, '高中', '清华大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1646, '张三1646', '女', '1990-01-02', '184387099178709917', '已婚', 1, '陕西西安', 'xuelei@qq.com', '18438709917', 3, 3, '初中', '华胥中学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1647, '张三1647', '女', '1990-01-02', '178684626026846260', '未婚', 1, '海南', 'zhangjie@qq.com', '17868462602', 4, 4, '高中', '海南侨中', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1648, '张三1648', '女', '1990-01-02', '181723693117236931', '已婚', 1, '陕西', 'laowang@qq.com', '18172369311', 1, 1, '本科', '深圳大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1651, '张三1651', '女', '1990-01-02', '191497623329149762', '已婚', 1, '河南', 'yaosen@qq.com', '19149762332', 4, 4, '初中', '西北大学', '2017-01-02', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1655, '张三1655', '女', '1990-01-02', '191775690957756909', '已婚', 1, '陕西西安', 'xuelei@qq.com', '19177569095', 4, 4, '初中', '华胥中学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1656, '张三1656', '女', '1990-01-02', '172479616987247961', '已婚', 1, '陕西', 'laowang@qq.com', '17247961698', 1, 1, '本科', '深圳大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1660, '张三1660', '女', '1990-01-02', '187900269960026996', '已婚', 1, '河南', 'yaosen@qq.com', '18790026996', 1, 1, '初中', '西北大学', '2017-01-02', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1661, '张三1661', '女', '1990-01-02', '193062894126289412', '已婚', 1, '陕西西安', 'yunxing@qq.com', '19306289412', 2, 2, '硕士', '西安电子科技学校', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1663, '张三1663', '女', '1990-01-02', '197650784486507844', '已婚', 1, '广东', 'zhangliming@qq.com', '19765078448', 4, 4, '高中', '清华大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1664, '张三1664', '女', '1990-01-02', '180489219158048921', '已婚', 1, '陕西西安', 'xuelei@qq.com', '18048921915', 1, 1, '初中', '华胥中学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1667, '张三1667', '女', '1990-01-02', '182456138792456138', '已婚', 1, '海南', 'chenjing@qq.com', '18245613879', 4, 4, '高中', '武汉大学', '2015-06-09', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1668, '张三1668', '女', '1990-01-02', '189425902401894259', '未婚', 1, '陕西', 'zhao@qq.com', '18942590240', 1, 1, '博士', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1669, '张三1669', '女', '1990-01-02', '161222956151612229', '已婚', 1, '陕西', 'zhao@qq.com', '16122295615', 2, 2, '高中', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1670, '张三1670', '女', '1990-01-02', '159298934081592989', '已婚', 1, '河南', 'yaosen@qq.com', '15929893408', 3, 3, '初中', '西北大学', '2017-01-02', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1671, '张三1671', '女', '1990-01-02', '194287662514287662', '已婚', 1, '陕西西安', 'yunxing@qq.com', '19428766251', 4, 4, '硕士', '西安电子科技学校', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1672, '张三1672', '女', '1990-01-02', '175003370817500337', '已婚', 1, '广东广州', 'jiaxuming@qq.com', '17500337081', 1, 1, '初中', '西北大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1673, '张三1673', '女', '1990-01-02', '173615727071736157', '已婚', 1, '广东', 'zhangliming@qq.com', '17361572707', 2, 2, '高中', '清华大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1675, '张三1675', '女', '1990-01-02', '163266596581632665', '未婚', 1, '海南', 'zhangjie@qq.com', '16326659658', 4, 4, '高中', '海南侨中', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1676, '张三1676', '女', '1990-01-02', '184203693070369307', '已婚', 1, '陕西', 'laowang@qq.com', '18420369307', 1, 1, '本科', '深圳大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1679, '张三1679', '女', '1990-01-02', '164687562858756285', '已婚', 1, '陕西', 'zhao@qq.com', '16468756285', 4, 4, '高中', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1680, '张三1680', '女', '1990-01-02', '188139288311881392', '已婚', 1, '河南', 'yaosen@qq.com', '18813928831', 1, 1, '初中', '西北大学', '2017-01-02', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1682, '张三1682', '女', '1990-01-02', '197522063152206315', '已婚', 1, '陕西', 'laowang@qq.com', '19752206315', 3, 3, '本科', '深圳大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1685, '张三1685', '女', '1990-01-02', '191217602381217602', '已婚', 1, '陕西', 'zhao@qq.com', '19121760238', 2, 2, '高中', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1689, '张三1689', '女', '1990-01-02', '193438520391934385', '已婚', 1, '陕西西安', 'xuelei@qq.com', '19343852039', 2, 2, '初中', '华胥中学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1690, '张三1690', '女', '1990-01-02', '167666763716766676', '未婚', 1, '海南', 'zhangjie@qq.com', '16766676371', 3, 3, '高中', '海南侨中', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1693, '张三1693', '女', '1990-01-02', '162332301711623323', '未婚', 1, '陕西', 'zhao@qq.com', '16233230171', 2, 2, '博士', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1694, '张三1694', '女', '1990-01-02', '185536892118553689', '已婚', 1, '陕西', 'zhao@qq.com', '18553689211', 3, 3, '高中', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1695, '张三1695', '女', '1990-01-02', '162149415951621494', '已婚', 1, '河南', 'yaosen@qq.com', '16214941595', 4, 4, '初中', '西北大学', '2017-01-02', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1698, '张三1698', '女', '1990-01-02', '159691731521596917', '已婚', 1, '广东', 'zhangliming@qq.com', '15969173152', 3, 3, '高中', '清华大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1699, '张三1699', '女', '1990-01-02', '180905720390905720', '已婚', 1, '陕西西安', 'xuelei@qq.com', '18090572039', 4, 4, '初中', '华胥中学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1701, '张三1701', '女', '1990-01-02', '193321038973210389', '已婚', 1, '陕西', 'laowang@qq.com', '19332103897', 2, 2, '本科', '深圳大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1703, '张三1703', '女', '1990-01-02', '178105001668105001', '已婚', 1, '陕西', 'zhao@qq.com', '17810500166', 4, 4, '高中', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1705, '张三1705', '女', '1990-01-02', '177262425597726242', '已婚', 1, '陕西西安', 'yunxing@qq.com', '17726242559', 2, 2, '硕士', '西安电子科技学校', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1706, '张三1706', '女', '1990-01-02', '197704646487704646', '已婚', 1, '广东广州', 'jiaxuming@qq.com', '19770464648', 3, 3, '初中', '西北大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1709, '张三1709', '女', '1990-01-02', '163553421281635534', '已婚', 1, '陕西', 'laowang@qq.com', '16355342128', 2, 2, '本科', '深圳大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1711, '张三1711', '女', '1990-01-02', '196891403836891403', '未婚', 1, '陕西', 'zhao@qq.com', '19689140383', 4, 4, '博士', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1712, '张三1712', '女', '1990-01-02', '182264995418226499', '已婚', 1, '陕西', 'zhao@qq.com', '18226499541', 1, 1, '高中', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1714, '张三1714', '女', '1990-01-02', '185230004828523000', '已婚', 1, '陕西西安', 'yunxing@qq.com', '18523000482', 3, 3, '硕士', '西安电子科技学校', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1719, '张三1719', '女', '1990-01-02', '190326049172604917', '已婚', 1, '1', '584991843@qq.com', '19032604917', 4, 4, '大专', '1', '2018-01-31', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1721, '张三1721', '女', '1990-01-02', '184208613368420861', '已婚', 1, '1', '584991843@qq.com', '18420861336', 2, 2, '大专', '1', '2018-01-31', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1723, '张三1723', '女', '1990-01-02', '160185956146018595', '已婚', 1, '1', '584991843@qq.com', '16018595614', 4, 4, '大专', '1', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1727, '张三1727', '女', '1990-01-02', '188918572401857240', '已婚', 1, '陕西', 'laowang@qq.com', '18891857240', 4, 4, '本科', '深圳大学', '2019-11-05', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1731, '张三1731', '女', '1990-01-02', '165553484535553484', '已婚', 1, '陕西', 'laowang@qq.com', '16555348453', 4, 4, '本科', '深圳大学', '2017-12-31', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1733, '张三1733', '女', '1990-01-02', '158990055039900550', '已婚', 1, '广东', '123@qq.com', '15899005503', 2, 2, '本科', '深圳大学', '2019-11-10', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1735, '张三1735', '女', '1990-01-02', '183986429561839864', '已婚', 1, '陕西', 'laowang@qq.com', '18398642956', 4, 4, '本科', '深圳大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1737, '张三1737', '女', '1990-01-02', '197988411237988411', '未婚', 1, '陕西', 'zhao@qq.com', '19798841123', 2, 2, '博士', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1738, '张三1738', '女', '1990-01-02', '190312413050312413', '已婚', 1, '陕西', 'zhao@qq.com', '19031241305', 3, 3, '高中', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1739, '张三1739', '女', '1990-01-02', '159058692091590586', '已婚', 1, '河南', 'yaosen@qq.com', '15905869209', 4, 4, '硕士', '西北大学', '2017-01-02', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1742, '张三1742', '女', '1990-01-02', '190888582058858205', '已婚', 1, '广东', 'zhangliming@qq.com', '19088858205', 3, 3, '高中', '清华大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1743, '张三1743', '女', '1990-01-02', '195776190617619061', '已婚', 1, '陕西西安', 'xuelei@qq.com', '19577619061', 4, 4, '初中', '华胥中学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1744, '张三1744', '女', '1990-01-02', '167677067427677067', '未婚', 1, '海南', 'zhangjie@qq.com', '16767706742', 1, 1, '高中', '海南侨中', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1745, '张三1745', '女', '1990-01-02', '172518625801725186', '已婚', 1, '陕西', 'laowang@qq.com', '17251862580', 2, 2, '本科', '深圳大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1746, '张三1746', '女', '1990-01-02', '161023787271610237', '已婚', 1, '海南', 'chenjing@qq.com', '16102378727', 3, 3, '高中', '武汉大学', '2015-06-09', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1747, '张三1747', '女', '1990-01-02', '169024919471690249', '未婚', 1, '陕西', 'zhao@qq.com', '16902491947', 4, 4, '博士', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1748, '张三1748', '女', '1990-01-02', '163515096091635150', '已婚', 1, '陕西', 'zhao@qq.com', '16351509609', 1, 1, '高中', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1749, '张三1749', '女', '1990-01-02', '191962582581919625', '已婚', 1, '河南', 'yaosen@qq.com', '19196258258', 2, 2, '初中', '西北大学', '2017-01-02', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1750, '张三1750', '女', '1990-01-02', '190729485157294851', '已婚', 1, '陕西西安', 'yunxing@qq.com', '19072948515', 3, 3, '硕士', '西安电子科技学校', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1751, '张三1751', '女', '1990-01-02', '179221538557922153', '已婚', 1, '广东广州', 'jiaxuming@qq.com', '17922153855', 4, 4, '初中', '西北大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1752, '张三1752', '女', '1990-01-02', '165381097846538109', '已婚', 1, '广东', 'zhangliming@qq.com', '16538109784', 1, 1, '高中', '清华大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1753, '张三1753', '女', '1990-01-02', '170702734080273408', '已婚', 1, '陕西西安', 'xuelei@qq.com', '17070273408', 2, 2, '初中', '华胥中学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1754, '张三1754', '女', '1990-01-02', '158832237435883223', '未婚', 1, '海南', 'zhangjie@qq.com', '15883223743', 3, 3, '高中', '海南侨中', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1755, '张三1755', '女', '1990-01-02', '163514845421635148', '已婚', 1, '陕西', 'laowang@qq.com', '16351484542', 4, 4, '本科', '深圳大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1758, '张三1758', '女', '1990-01-02', '171914739401473940', '已婚', 1, '河南', 'yaosen@qq.com', '17191473940', 3, 3, '初中', '西北大学', '2017-01-02', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1759, '张三1759', '女', '1990-01-02', '190192954611929546', '已婚', 1, '陕西西安', 'yunxing@qq.com', '19019295461', 4, 4, '硕士', '西安电子科技学校', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1760, '张三1760', '女', '1990-01-02', '196682415386682415', '已婚', 1, '广东广州', 'jiaxuming@qq.com', '19668241538', 1, 1, '初中', '西北大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1761, '张三1761', '女', '1990-01-02', '174295073629507362', '已婚', 1, '广东', 'zhangliming@qq.com', '17429507362', 2, 2, '高中', '清华大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1764, '张三1764', '女', '1990-01-02', '177924673287792467', '已婚', 1, '海南', 'chenjing@qq.com', '17792467328', 1, 1, '高中', '武汉大学', '2015-06-09', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1765, '张三1765', '女', '1990-01-02', '172005570847200557', '未婚', 1, '陕西', 'zhao@qq.com', '17200557084', 2, 2, '博士', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1766, '张三1766', '女', '1990-01-02', '167715694926771569', '已婚', 1, '陕西', 'zhao@qq.com', '16771569492', 3, 3, '高中', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1767, '张三1767', '女', '1990-01-02', '164023622586402362', '已婚', 1, '河南', 'yaosen@qq.com', '16402362258', 4, 4, '初中', '西北大学', '2017-01-02', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1768, '张三1768', '女', '1990-01-02', '198432888693288869', '已婚', 1, '陕西西安', 'yunxing@qq.com', '19843288869', 1, 1, '硕士', '西安电子科技学校', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1769, '张三1769', '女', '1990-01-02', '181555436241555436', '已婚', 1, '广东广州', 'jiaxuming@qq.com', '18155543624', 2, 2, '初中', '西北大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1772, '张三1772', '女', '1990-01-02', '192127884332127884', '未婚', 1, '海南', 'zhangjie@qq.com', '19212788433', 1, 1, '高中', '海南侨中', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1775, '张三1775', '女', '1990-01-02', '184250715334250715', '未婚', 1, '陕西', 'zhao@qq.com', '18425071533', 4, 4, '博士', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1776, '张三1776', '女', '1990-01-02', '168345939276834593', '已婚', 1, '陕西', 'zhao@qq.com', '16834593927', 1, 1, '高中', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1778, '张三1778', '女', '1990-01-02', '188621097201886210', '已婚', 1, '陕西西安', 'yunxing@qq.com', '18862109720', 3, 3, '硕士', '西安电子科技学校', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1779, '张三1779', '女', '1990-01-02', '193249113862491138', '已婚', 1, '广东广州', 'jiaxuming@qq.com', '19324911386', 4, 4, '初中', '西北大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1787, '张三1787', '女', '1990-01-02', '165880092435880092', '已婚', 1, '河南', 'yaosen@qq.com', '16588009243', 4, 4, '初中', '西北大学', '2017-01-02', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1789, '张三1789', '女', '1990-01-02', '164305307176430530', '已婚', 1, '陕西', 'laowang@qq.com', '16430530717', 2, 2, '本科', '深圳大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1790, '张三1790', '女', '1990-01-02', '178698162011786981', '已婚', 1, '海南', 'chenjing@qq.com', '17869816201', 3, 3, '高中', '武汉大学', '2015-06-09', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1791, '张三1791', '女', '1990-01-02', '162036749093674909', '未婚', 1, '陕西', 'zhao@qq.com', '16203674909', 4, 4, '博士', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1792, '张三1792', '女', '1990-01-02', '195551119975511199', '已婚', 1, '陕西', 'zhao@qq.com', '19555111997', 1, 1, '高中', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1794, '张三1794', '女', '1990-01-02', '160344566111603445', '已婚', 1, '广东广州', 'jiaxuming@qq.com', '16034456611', 3, 3, '初中', '西北大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1796, '张三1796', '女', '1990-01-02', '179743421217974342', '已婚', 1, '陕西西安', 'xuelei@qq.com', '17974342121', 1, 1, '初中', '华胥中学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1800, '张三1800', '女', '1990-01-02', '193898357868983578', '未婚', 1, '陕西', 'zhao@qq.com', '19389835786', 1, 1, '博士', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1801, '张三1801', '女', '1990-01-02', '186166576331665763', '已婚', 1, '陕西', 'zhao@qq.com', '18616657633', 2, 2, '高中', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1802, '张三1802', '女', '1990-01-02', '190599668589966858', '已婚', 1, '河南', 'yaosen@qq.com', '19059966858', 3, 3, '初中', '西北大学', '2017-01-02', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1805, '张三1805', '女', '1990-01-02', '180906572660657266', '已婚', 1, '广东', 'zhangliming@qq.com', '18090657266', 2, 2, '高中', '清华大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1807, '张三1807', '女', '1990-01-02', '166737355276737355', '未婚', 1, '海南', 'zhangjie@qq.com', '16673735527', 4, 4, '高中', '海南侨中', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1808, '张三1808', '女', '1990-01-02', '162351509236235150', '已婚', 1, '陕西', 'laowang@qq.com', '16235150923', 1, 1, '本科', '深圳大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1809, '张三1809', '女', '1990-01-02', '193007340883007340', '已婚', 1, '海南', 'chenjing@qq.com', '19300734088', 2, 2, '高中', '武汉大学', '2015-06-09', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1810, '张三1810', '女', '1990-01-02', '159444037234403723', '已婚', 1, '陕西', 'zhao@qq.com', '15944403723', 3, 3, '高中', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1813, '张三1813', '女', '1990-01-02', '169631134251696311', '已婚', 1, '广东广州', 'jiaxuming@qq.com', '16963113425', 2, 2, '初中', '西北大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1814, '张三1814', '女', '1990-01-02', '185327924225327924', '已婚', 1, '广东', 'zhangliming@qq.com', '18532792422', 3, 3, '高中', '清华大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1815, '张三1815', '女', '1990-01-02', '179208078890807889', '已婚', 1, '陕西西安', 'xuelei@qq.com', '17920807889', 4, 4, '初中', '华胥中学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1819, '张三1819', '女', '1990-01-02', '177454709471774547', '已婚', 1, '陕西', 'zhao@qq.com', '17745470947', 4, 4, '高中', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1821, '张三1821', '女', '1990-01-02', '161925905136192590', '已婚', 1, '陕西西安', 'yunxing@qq.com', '16192590513', 2, 2, '硕士', '西安电子科技学校', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1823, '张三1823', '女', '1990-01-02', '172656557057265655', '离异', 1, '江苏', '584991843@qq.com', '17265655705', 4, 4, '本科', '南华大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1824, '张三1824', '女', '1990-01-02', '190561198669056119', '已婚', 1, '广东', '584991843@qq.com', '19056119866', 1, 1, '大专', '广东职业技术学院', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1825, '张三1825', '女', '1990-01-02', '196298182681962981', '已婚', 1, '1', '584991843@qq.com', '19629818268', 2, 2, '本科', '1', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1826, '张三1826', '女', '1990-01-02', '171269177967126917', '已婚', 1, '1', '584991843@qq.com', '17126917796', 3, 3, '大专', '1', '2018-01-31', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1827, '张三1827', '女', '1990-01-02', '188913202289132022', '已婚', 1, '1', '584991843@qq.com', '18891320228', 4, 4, '大专', '1', '2018-01-31', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1829, '张三1829', '女', '1990-01-02', '195823943995823943', '已婚', 1, '1', '584991843@qq.com', '19582394399', 2, 2, '大专', '1', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1831, '张三1831', '女', '1990-01-02', '193592860069359286', '未婚', 1, '1', '584991843@qq.com', '19359286006', 4, 4, '大专', '1', '2018-01-31', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1832, '张三1832', '女', '1990-01-02', '197664461967664461', '已婚', 1, '1', '584991843@qq.com', '19766446196', 1, 1, '大专', '1', '2018-01-31', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1833, '张三1833', '女', '1990-01-02', '169005590139005590', '已婚', 1, '陕西', 'laowang@qq.com', '16900559013', 2, 2, '本科', '深圳大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1834, '张三1834', '女', '1990-01-02', '173496425323496425', '已婚', 1, '海南', 'chenjing@qq.com', '17349642532', 3, 3, '高中', '武汉大学', '2015-06-09', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1835, '张三1835', '女', '1990-01-02', '161927216732721673', '未婚', 1, '陕西', 'zhao@qq.com', '16192721673', 4, 4, '博士', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1836, '张三1836', '女', '1990-01-02', '170608668237060866', '已婚', 1, '陕西', 'zhao@qq.com', '17060866823', 1, 1, '高中', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1838, '张三1838', '女', '1990-01-02', '173253613322536133', '已婚', 1, '陕西西安', 'yunxing@qq.com', '17325361332', 3, 3, '硕士', '西安电子科技学校', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1839, '张三1839', '女', '1990-01-02', '161559272641559272', '已婚', 1, '广东广州', 'jiaxuming@qq.com', '16155927264', 4, 4, '初中', '西北大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1840, '张三1840', '女', '1990-01-02', '169497383771694973', '已婚', 1, '广东', 'zhangliming@qq.com', '16949738377', 1, 1, '高中', '清华大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1841, '张三1841', '女', '1990-01-02', '164270961482709614', '已婚', 1, '陕西西安', 'xuelei@qq.com', '16427096148', 2, 2, '初中', '华胥中学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1843, '张三1843', '女', '1990-01-02', '160271559187155918', '已婚', 1, '陕西', 'laowang@qq.com', '16027155918', 4, 4, '本科', '深圳大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1844, '张三1844', '女', '1990-01-02', '179846106577984610', '已婚', 1, '海南', 'chenjing@qq.com', '17984610657', 1, 1, '高中', '武汉大学', '2015-06-09', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1848, '张三1848', '女', '1990-01-02', '179472066484720664', '已婚', 1, '陕西西安', 'yunxing@qq.com', '17947206648', 1, 1, '硕士', '西安电子科技学校', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1849, '张三1849', '女', '1990-01-02', '173654253313654253', '已婚', 1, '广东广州', 'jiaxuming@qq.com', '17365425331', 2, 2, '初中', '西北大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1850, '张三1850', '女', '1990-01-02', '171316927653169276', '已婚', 1, '广东', 'zhangliming@qq.com', '17131692765', 3, 3, '高中', '清华大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1851, '张三1851', '女', '1990-01-02', '177083738841770837', '已婚', 1, '陕西西安', 'xuelei@qq.com', '17708373884', 4, 4, '初中', '华胥中学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1852, '张三1852', '女', '1990-01-02', '172929771781729297', '未婚', 1, '海南', 'zhangjie@qq.com', '17292977178', 1, 1, '高中', '海南侨中', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1854, '张三1854', '女', '1990-01-02', '196970059847005984', '已婚', 1, '海南', 'chenjing@qq.com', '19697005984', 3, 3, '高中', '武汉大学', '2015-06-09', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1855, '张三1855', '女', '1990-01-02', '181733650938173365', '已婚', 1, '陕西', 'zhao@qq.com', '18173365093', 4, 4, '高中', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1856, '张三1856', '女', '1990-01-02', '159219935659219935', '已婚', 1, '河南', 'yaosen@qq.com', '15921993565', 1, 1, '初中', '西北大学', '2017-01-02', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1857, '张三1857', '女', '1990-01-02', '172360586021723605', '已婚', 1, '陕西西安', 'yunxing@qq.com', '17236058602', 2, 2, '硕士', '西安电子科技学校', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1858, '张三1858', '女', '1990-01-02', '185604983678560498', '已婚', 1, '广东广州', 'jiaxuming@qq.com', '18560498367', 3, 3, '初中', '西北大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1861, '张三1861', '女', '1990-01-02', '177606866496068664', '已婚', 1, '陕西', 'laowang@qq.com', '17760686649', 2, 2, '本科', '深圳大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1862, '张三1862', '女', '1990-01-02', '169480151928015192', '已婚', 1, '海南', 'chenjing@qq.com', '16948015192', 3, 3, '高中', '武汉大学', '2015-06-09', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1863, '张三1863', '女', '1990-01-02', '196042020660420206', '未婚', 1, '陕西', 'zhao@qq.com', '19604202066', 4, 4, '博士', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1864, '张三1864', '女', '1990-01-02', '193231508063150806', '已婚', 1, '陕西', 'zhao@qq.com', '19323150806', 1, 1, '高中', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1869, '张三1869', '女', '1990-01-02', '161604642871616046', '已婚', 1, '陕西西安', 'xuelei@qq.com', '16160464287', 2, 2, '初中', '华胥中学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1870, '张三1870', '女', '1990-01-02', '190925810440925810', '未婚', 1, '海南', 'zhangjie@qq.com', '19092581044', 3, 3, '高中', '海南侨中', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1871, '张三1871', '女', '1990-01-02', '191276984147698414', '已婚', 1, '陕西', 'laowang@qq.com', '19127698414', 4, 4, '本科', '深圳大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1873, '张三1873', '女', '1990-01-02', '192977657547765754', '未婚', 1, '陕西', 'zhao@qq.com', '19297765754', 2, 2, '博士', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1874, '张三1874', '女', '1990-01-02', '171142098581711420', '已婚', 1, '陕西', 'zhao@qq.com', '17114209858', 3, 3, '高中', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1876, '张三1876', '女', '1990-01-02', '159232468941592324', '已婚', 1, '陕西西安', 'yunxing@qq.com', '15923246894', 1, 1, '硕士', '西安电子科技学校', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1877, '张三1877', '女', '1990-01-02', '162906062769060627', '已婚', 1, '广东广州', 'jiaxuming@qq.com', '16290606276', 2, 2, '初中', '西北大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1878, '张三1878', '女', '1990-01-02', '178294767507829476', '已婚', 1, '广东', 'zhangliming@qq.com', '17829476750', 3, 3, '高中', '清华大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1879, '张三1879', '女', '1990-01-02', '164217509754217509', '已婚', 1, '陕西西安', 'xuelei@qq.com', '16421750975', 4, 4, '初中', '华胥中学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1880, '张三1880', '女', '1990-01-02', '167665106781676651', '未婚', 1, '海南', 'zhangjie@qq.com', '16766510678', 1, 1, '高中', '海南侨中', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1881, '张三1881', '女', '1990-01-02', '187134865181348651', '已婚', 1, '陕西', 'laowang@qq.com', '18713486518', 2, 2, '本科', '深圳大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1882, '张三1882', '女', '1990-01-02', '194140866109414086', '已婚', 1, '海南', 'chenjing@qq.com', '19414086610', 3, 3, '高中', '武汉大学', '2015-06-09', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1883, '张三1883', '女', '1990-01-02', '170761595496159549', '未婚', 1, '陕西', 'zhao@qq.com', '17076159549', 4, 4, '博士', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1884, '张三1884', '女', '1990-01-02', '192847239719284723', '已婚', 1, '陕西', 'zhao@qq.com', '19284723971', 1, 1, '高中', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1885, '张三1885', '女', '1990-01-02', '173413272591734132', '已婚', 1, '河南', 'yaosen@qq.com', '17341327259', 2, 2, '初中', '西北大学', '2017-01-02', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1888, '张三1888', '女', '1990-01-02', '187275170427517042', '已婚', 1, '海南', 'chenjing@qq.com', '18727517042', 1, 1, '高中', '武汉大学', '2015-06-09', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1890, '张三1890', '女', '1990-01-02', '161506443401615064', '已婚', 1, '陕西', 'zhao@qq.com', '16150644340', 3, 3, '高中', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1892, '张三1892', '女', '1990-01-02', '196302635711963026', '已婚', 1, '广东广州', 'jiaxuming@qq.com', '19630263571', 1, 1, '初中', '西北大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1893, '张三1893', '女', '1990-01-01', '175358975851753589', '已婚', 1, '广东', 'zhangliming@qq.com', '17535897585', 1, 1, '高中', '清华大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1894, '张三1894', '女', '1990-01-02', '169348832641693488', '已婚', 1, '陕西西安', 'xuelei@qq.com', '16934883264', 3, 3, '初中', '华胥中学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1897, '张三1897', '女', '1990-01-02', '195378790161953787', '已婚', 1, '海南', 'chenjing@qq.com', '19537879016', 2, 2, '高中', '武汉大学', '2015-06-09', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1898, '张三1898', '女', '1990-01-02', '186173280391861732', '未婚', 1, '陕西', 'zhao@qq.com', '18617328039', 3, 3, '博士', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1899, '张三1899', '女', '1990-01-02', '186191892028619189', '已婚', 1, '陕西', 'zhao@qq.com', '18619189202', 4, 4, '高中', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1901, '张三1901', '女', '1990-01-02', '192393581723935817', '已婚', 1, '陕西西安', 'yunxing@qq.com', '19239358172', 2, 2, '硕士', '西安电子科技学校', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1903, '张三1903', '女', '1990-01-02', '192907769231929077', '已婚', 1, '广东', 'zhangliming@qq.com', '19290776923', 4, 4, '高中', '清华大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1904, '张三1904', '女', '1990-01-02', '160824714386082471', '已婚', 1, '陕西西安', 'xuelei@qq.com', '16082471438', 1, 1, '初中', '华胥中学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1905, '张三1905', '女', '1990-01-02', '186862124766212476', '未婚', 1, '海南', 'zhangjie@qq.com', '18686212476', 2, 2, '高中', '海南侨中', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1907, '张三1907', '女', '1990-01-02', '187367192093671920', '已婚', 1, '海南', 'chenjing@qq.com', '18736719209', 4, 4, '高中', '武汉大学', '2015-06-09', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1908, '张三1908', '女', '1990-01-02', '178402797498402797', '已婚', 1, '陕西', 'zhao@qq.com', '17840279749', 1, 1, '高中', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1909, '张三1909', '女', '1990-01-02', '171374271717137427', '已婚', 1, '河南', 'yaosen@qq.com', '17137427171', 2, 2, '初中', '西北大学', '2017-01-02', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1910, '张三1910', '女', '1990-01-02', '163124826636312482', '已婚', 1, '陕西西安', 'yunxing@qq.com', '16312482663', 3, 3, '硕士', '西安电子科技学校', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1911, '张三1911', '女', '1990-01-02', '182963178569631785', '已婚', 1, '广东广州', 'jiaxuming@qq.com', '18296317856', 4, 4, '初中', '西北大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1912, '张三1912', '女', '1990-01-02', '186903273429032734', '已婚', 1, '广东', 'zhangliming@qq.com', '18690327342', 1, 1, '高中', '清华大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1915, '张三1915', '女', '1990-01-02', '161173284991173284', '已婚', 1, '海南', 'chenjing@qq.com', '16117328499', 4, 4, '高中', '武汉大学', '2015-06-09', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1917, '张三1917', '女', '1990-01-02', '191650932026509320', '已婚', 1, '陕西', 'zhao@qq.com', '19165093202', 2, 2, '高中', '哈尔滨理工大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1918, '张三1918', '女', '1990-01-02', '163491164751634911', '已婚', 1, '河南', 'yaosen@qq.com', '16349116475', 3, 3, '初中', '西北大学', '2017-01-02', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1919, '张三1919', '女', '1990-01-02', '163964888241639648', '已婚', 1, '陕西西安', 'yunxing@qq.com', '16396488824', 4, 4, '硕士', '西安电子科技学校', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1920, '张三1920', '女', '1990-01-02', '170812807477081280', '已婚', 1, '广东广州', 'jiaxuming@qq.com', '17081280747', 1, 1, '初中', '西北大学', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1922, '张三1922', '女', '1990-01-02', '187179603981871796', '已婚', 1, '广东', '584991843@qq.com', '18717960398', 3, 3, '大专', '广东职业技术学院', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1924, '张三1924', '女', '1990-01-02', '192253953181922539', '已婚', 1, '1', '584991843@qq.com', '19225395318', 1, 1, '大专', '1', '2018-01-31', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1925, '张三1925', '女', '1990-01-02', '183333083683333083', '已婚', 1, '1', '584991843@qq.com', '18333308368', 2, 2, '大专', '1', '2018-01-31', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1926, '张三1926', '女', '1990-01-02', '181365419398136541', '已婚', 1, '1', '584991843@qq.com', '18136541939', 3, 3, '大专', '1', '2018-01-31', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1927, '张三1927', '女', '1990-01-02', '198289706459828970', '已婚', 1, '1', '584991843@qq.com', '19828970645', 4, 4, '大专', '1', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1928, '张三1928', '女', '1990-01-02', '168814134611413461', '已婚', 1, '1', '584991843@qq.com', '16881413461', 1, 1, '大专', '1', '2018-01-01', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1929, '张三1929', '女', '1990-01-02', '170663414241706634', '未婚', 1, '1', '584991843@qq.com', '17066341424', 2, 2, '大专', '1', '2018-01-31', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1930, '张三1930', '女', '1990-01-02', '188336527903365279', '已婚', 1, '1', '584991843@qq.com', '18833652790', 3, 3, '大专', '1', '2018-01-31', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1931, '张三1931', '女', '1990-01-02', '191154257321154257', '已婚', 1, '陕西', 'laowang@qq.com', '19115425732', 4, 4, '本科', '深圳大学', '2017-12-31', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1932, '张三1932', '女', '1990-01-02', '192223563421922235', '已婚', 1, '陕西', 'laowang@qq.com', '19222356342', 1, 1, '本科', '深圳大学', '2019-11-05', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1933, '张三1933', '女', '1990-01-02', '189116905661690566', '已婚', 1, '', 'laowang@qq.com', '18911690566', 2, 2, '本科', '深圳大学', '2019-11-05', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1934, '张三1934', '女', '1990-01-02', '170375698607569860', '已婚', 1, '陕西', 'laowan@123.com', '17037569860', 3, 3, '本科', '深圳大学', '2017-12-31', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1935, '张三1935', '女', '1990-01-02', '165989636536598963', '已婚', 1, '陕西', 'laowan@123.com', '16598963653', 4, 4, '本科', '深圳大学', '2017-12-31', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1936, '张三1936', '女', '1990-01-02', '160282947392829473', '已婚', 1, '陕西', 'laowang@qq.com', '16028294739', 1, 1, '本科', '深圳大学', '2017-12-31', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1937, '张三1937', '女', '1990-01-02', '184907687894907687', '已婚', 1, '陕西', 'laowang@qq.com', '18490768789', 2, 2, '本科', '深圳大学', '2017-12-31', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1938, '张三1938', '女', '1990-01-02', '165151457836515145', '已婚', 1, '广东', '123@qq.com', '16515145783', 3, 3, '本科', '深圳大学', '2019-11-10', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1939, '张三1939', '女', '1990-01-02', '192496086021924960', '已婚', 1, '广东', '123@qq.com', '19249608602', 4, 4, '本科', '深圳大学', '2019-11-10', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1941, '张三1941', '女', '1990-01-02', '166413188184131881', '已婚', 1, '广东', '584991843@qq.com', '16641318818', 2, 2, '本科', '深圳大学', '2019-11-24', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1946, '张三1946', '女', '1990-01-02', '188064050008064050', '已婚', NULL, '陕西', 'zhao@qq.com', '18806405000', 3, 3, NULL, NULL, '2020-03-27', '123456', 1, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1947, '张三1947', '女', '1990-01-02', '162542545996254254', '已婚', NULL, '陕西', 'zhao@qq.com', '16254254599', 4, 4, NULL, NULL, '2020-03-27', '123456', 0, NULL, 0.00);
INSERT INTO `tb_employee` VALUES (1948, '测试1', '男', '2020-04-06', '440204199711073000', '', NULL, '东莞', '981502062@qq.com', '13434587898', 9, 1, NULL, NULL, '2020-04-02', '123456', 1, NULL, 0.00);

-- ----------------------------
-- Table structure for tb_login_info
-- ----------------------------
DROP TABLE IF EXISTS `tb_login_info`;
CREATE TABLE `tb_login_info`  (
  `id` int(11) NOT NULL,
  `login_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '登录名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '登陆密码',
  `employee_id` int(11) NULL DEFAULT NULL COMMENT '员工号',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tb_position
-- ----------------------------
DROP TABLE IF EXISTS `tb_position`;
CREATE TABLE `tb_position`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `position_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_position
-- ----------------------------
INSERT INTO `tb_position` VALUES (1, 'Java开发工程师');
INSERT INTO `tb_position` VALUES (2, 'Hr');
INSERT INTO `tb_position` VALUES (3, '销售员');
INSERT INTO `tb_position` VALUES (4, '客服');
INSERT INTO `tb_position` VALUES (20, 'qq');

-- ----------------------------
-- Table structure for tb_salary
-- ----------------------------
DROP TABLE IF EXISTS `tb_salary`;
CREATE TABLE `tb_salary`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) NOT NULL COMMENT '员工号',
  `salary` decimal(10, 2) NOT NULL COMMENT '应发工资',
  `pay_year_month` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '月份',
  `real_salary` decimal(10, 2) NOT NULL COMMENT '实发工资',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_salary
-- ----------------------------
INSERT INTO `tb_salary` VALUES (2, 3, 13100.00, '2020-04', 2814.29);
INSERT INTO `tb_salary` VALUES (3, 31, 0.00, '2020-04', 0.00);
INSERT INTO `tb_salary` VALUES (4, 33, 0.00, '2020-04', 0.00);
INSERT INTO `tb_salary` VALUES (5, 34, 0.00, '2020-04', 0.00);
INSERT INTO `tb_salary` VALUES (6, 35, 0.00, '2020-04', 0.00);
INSERT INTO `tb_salary` VALUES (7, 37, 0.00, '2020-04', 0.00);
INSERT INTO `tb_salary` VALUES (8, 38, 0.00, '2020-04', 0.00);
INSERT INTO `tb_salary` VALUES (9, 39, 0.00, '2020-04', 0.00);

-- ----------------------------
-- Table structure for tb_setting
-- ----------------------------
DROP TABLE IF EXISTS `tb_setting`;
CREATE TABLE `tb_setting`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_setting
-- ----------------------------
INSERT INTO `tb_setting` VALUES (1, 'work_hour', '1');

SET FOREIGN_KEY_CHECKS = 1;
