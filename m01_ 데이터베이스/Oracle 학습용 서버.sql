DROP USER c##md CASCADE;
CREATE USER c##md IDENTIFIED BY md DEFAULT TABLESPACE users TEMPORARY TABLESPACE temp PROFILE DEFAULT;
GRANT CONNECT, RESOURCE TO c##md;
GRANT CREATE VIEW, CREATE SYNONYM TO c##md;
GRANT UNLIMITED TABLESPACE TO c##md;
ALTER USER c##md ACCOUNT UNLOCK;

DROP USER c##hr CASCADE;
CREATE USER c##hr IDENTIFIED BY hr DEFAULT TABLESPACE users TEMPORARY TABLESPACE temp PROFILE DEFAULT;
GRANT CONNECT, RESOURCE TO c##hr;
GRANT CREATE VIEW, CREATE SYNONYM TO c##hr;
GRANT UNLIMITED TABLESPACE TO c##hr;
ALTER USER c##hr ACCOUNT UNLOCK;