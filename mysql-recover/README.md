1、一个新的MySQL可以正常使用的
5.7.34

2、创建相同名称的数据库

3、跑创建表语句

4、mysql目录下生成两个文件pitaya_888一个表会生成两个文件，一个是frm，一个是ibd
frm表结构，ibd表数据
5、【重要】使用sql语句分离表结构
alter table 表名 DISCARD TABLESPACE;


6、分离之后，frm不变，但是ibd数据不存在；
务必确认检查ibd是否消失

7、将备份目录下的pitaya_888库表名下的ibd文件复制到新的MySQL的路径下；


8、【重要】合并
alter table  表名  IMPORT TABLESPACE;

9、查询表，将内容备份出来；