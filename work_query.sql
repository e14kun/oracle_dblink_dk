-- DB유저 조회
SELECT * FROM all_users;

SELECT * FROM V$SESSION WHERE USERNAME IS NOT NULL;

SELECT machine, program, username, osuser, sid, serial#, logon_time, status, 
       process, client_info, action, module, client_identifier, client_version
  FROM v$session
 WHERE audsid = userenv('sessionid');

SELECT * FROM USER_SYS_PRIVS;
SELECT * FROM DBA_SYS_PRIVS WHERE GRANTEE = 'JY_USER';

SELECT * FROM DBA_SYS_PRIVS WHERE PRIVILEGE = 'SHUTDOWN';

SELECT * 
FROM DBA_ROLE_PRIVS
WHERE GRANTED_ROLE IN (
    SELECT GRANTED_ROLE
    FROM DBA_SYS_PRIVS
    WHERE PRIVILEGE = 'SHUTDOWN'
);


SELECT * FROM V$PWFILE_USERS WHERE SYSDBA = 'TRUE';

SELECT USER FROM DUAL;  -- 현재 접속유저 조회
SELECT tablespace_name FROM dba_tablespaces;  -- 테이블스페이스 리스트 조회
SELECT username, default_tablespace FROM dba_users WHERE username = USER;  -- 현재 접속유저의 테이블스페이스 조회
SELECT username, default_tablespace FROM dba_users WHERE username = 'JY_USER2';  -- 현재 접속유저의 테이블스페이스 조회



SELECT NAME FROM V$DATABASE;
SELECT USERNAME FROM DBA_USERS;
SELECT * FROM USER_SYS_PRIVS;

--유저 생성
CREATE USER jy_user1 IDENTIFIED BY 1234
 DEFAULT TABLESPACE jy_tablespace1;

CREATE USER jy_user2 IDENTIFIED BY link1234
DEFAULT TABLESPACE jy_tablespace1;



 DEFAULT TABLESPACE jy_tablespace2;
DROP USER jy_user2;

SELECT * FROM USER_ROLE_PRIVS;
 
-- DROP USER jy_user cascade;
GRANT 
	CREATE table, CREATE VIEW, CREATE PROCEDURE 
	,DROP ANY TABLE, DROP ANY VIEW, DROP ANY PROCEDURE 
	,alter ANY TABLE, alter ANY PROCEDURE 
	,CREATE DATABASE LINK, ALTER DATABASE LINK
	,CONNECT,resource
	TO jy_user2;

GRANT SELECT ON jy_user1.JY_TEST_TABLE1 TO jy_user2;


GRANT shutdown TO system;
-- REVOKE 

CREATE TABLESPACE jy_tablespace2
  DATAFILE '/u01/app/oracle/oradata/XE/jy_tablespace_file2.dbf'
  SIZE 100M;
 DROP TABLESPACE jy_tablespace2

CREATE DATABASE LINK jy_dblink CONNECT TO jy_user2
USING 'tns_entry';

-- 열어주는 쪽
create DATABASE LINK JY_USER_DBLINK
CONNECT TO jy_user2 IDENTIFIED BY link1234
USING '(DESCRIPTION=
          (ADDRESS=(PROTOCOL=TCP)(HOST=10.89.0.12)(PORT=1521))
          (CONNECT_DATA=
            (SID=XE)
          ))';
         
         
CREATE DATABASE LINK JY_USER_DBLINK
CONNECT TO jy_user2 IDENTIFIED BY link1234
USING 'JY_USER_DBLINK';

         
DROP DATABASE LINK JY_USER_DBLINK;
DROP DATABASE link JY_USER_DBLINK_FROM_U2_U1;

SELECT * FROM DBA_DB_LINKS;
SELECT OWNER, DB_LINK FROM DBA_DB_LINKS;
SELECT OWNER, DB_LINK FROM ALL_DB_LINKS;
SELECT * FROM ALL_DB_LINKS;
         
-- dblink 확인 쿼리들
SELECT * FROM JY_TEST_TABLE1@JY_USER_DBLINK
SELECT * FROM JY_TEST_TABLE@JY_USER_DBLINK;

SELECT rmt.*,my.*
FROM JY_USER1.JY_TEST_TABLE1@JY_USER_DBLINK rmt
LEFT JOIN JY_V2_TABLE my ON rmt.val=my.val;

SELECT * FROM JY_V2_TABLE jvt;

-- 접속하는 쪽에 JY_SERV_1 를 tnsnames.ora 에 선언해야함
--
--JY_SERV_1 =
--  (DESCRIPTION =
--    (ADDRESS = (PROTOCOL = TCP)(HOST = 10.89.0.11)(PORT = 1521))
    --(CONNECT_DATA =
--      (SID = xe)
    --)
--  )
CREATE DATABASE LINK JY_USER_DBLINK
CONNECT TO jy_user2 IDENTIFIED BY link1234
USING 'JY_SERV_1';


-- 설정값 확인들
SELECT * FROM v$dblink;
SELECT instance_name FROM v$instance;
SELECT * FROM v$instance;
SELECT name FROM v$active_services;
SELECT * FROM v$parameter WHERE name LIKE '%listen%';
SELECT * FROM v$listener;
SELECT instance_name, host_name, version FROM v$instance;
SELECT * FROM V$services;

-- 테이블 생성
CREATE TABLE JY_USER.JY_TEST_TABLE (
	VAL VARCHAR2(100) NULL
)
TABLESPACE jy_tablespace;
  

 SELECT DISTINCT tablespace_name 
FROM dba_segments 
-- WHERE owner = 'JY_USER';
