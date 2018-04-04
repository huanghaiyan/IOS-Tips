###SQLite数据库相关知识

####1.数据持久化的方式

1. 文件读写（NSString,NSArray,NSDictionary,NSData）
2. 归档
3. NSUserDefaults
4. SQLite

####2.SQL语法

SQL,结构化查询语句。是一种数据库查询和程序设计语言，用于存取数据以及查询、更新和管理关系数据库系统。

常见的SQL语句有：创建(Create)，插入(Insert)，更新(Update)，删除(Delete)，查询(Select)

	创建语句
	CREATE TABLE 表名称(列名称1 数据类型，列名称2 数据类型，列名称3 数据类型，….)

	插入语句
	INSERT INTO 表名称(列1，列2,….) VALUES (值1，值2,....)

	查询语句
	SELECT 列名称 FROM 表名称

	更新语句
	UPDATE 表名称 SET 列名称 = 新值 WHERE 列名称 = 值

	删除语句
	DELETE FROM 表名称 WHERE 列名称 = 值

1、primary key 是主键的意思,主健在当前表里数据是唯一的,不能重复,可以唯一标识一条数据,一般是整数

2、autoincrement自增,为了让主键不重复,会让主键采用自增的方式

3、if not exists 如果没有表才会创建,防止重复创建覆盖之前数据

4、distinct 关键词用于返回唯一不同的值。

5、where 子句用于提取那些满足指定标准的记录。

6、like 操作符用于在 where 子句中搜索列中的指定模式。例如：SQL 语句选取 name 以字母 "G" 开始的所有客户：SELECT * FROM Websites WHERE name LIKE 'G%';

SQL 语句选取 name 以字母 "k" 结尾的所有客户：SELECT * FROM Websites WHERE name LIKE '%k';

SQL 语句选取 name 包含模式 "oo" 的所有客户：SELECT * FROM Websites WHERE name LIKE '%oo%';

通过使用 NOT 关键字，您可以选取不匹配模式的记录。
下面的 SQL 语句选取 name 不包含模式 "oo" 的所有客户：SELECT * FROM Websites WHERE name NOT LIKE '%oo%';

7、IN 操作符允许您在 WHERE 子句中规定多个值。例如： SQL 语句选取 name 为 "Google" 或 "菜鸟教程" 的所有网站：SELECT * FROM Websites WHERE name IN ('Google','菜鸟教程');

8、BETWEEN 操作符用于选取介于两个值之间的数据范围内的值。SQL 语句选取 alexa 介于 1 和 20 之间的所有网站：SELECT * FROM Websites WHERE alexa BETWEEN 1 AND 20;

如需显示不在上面实例范围内的网站，请使用 NOT BETWEEN：SELECT * FROM Websites WHERE alexa NOT BETWEEN 1 AND 20;

####3.在iOS中实现SQLite数据库的操作
1. 导入框架libsqlite3.tbd
2. 导入头文件<sqlite3.h>

 学习网站：[菜鸟教程](http://www.runoob.com)
