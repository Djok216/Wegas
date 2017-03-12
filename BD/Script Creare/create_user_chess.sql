DROP TABLESPACE chess INCLUDING CONTENTS CASCADE CONSTRAINTS; 

CREATE TABLESPACE chess
  DATAFILE 'chess_perm_0001.dat' 
    SIZE 500M
    REUSE
    AUTOEXTEND ON NEXT 50M MAXSIZE 2000M
/
    
CREATE TEMPORARY TABLESPACE aplicatie
  TEMPFILE 'chess_temp_0001.dbf'
    SIZE 5M
    AUTOEXTEND ON
/    

CREATE UNDO TABLESPACE aplicatie
  DATAFILE 'chess_undo_0001.dbf'
    SIZE 5M 
    AUTOEXTEND ON
  RETENTION GUARANTEE
/


drop user chess cascade;
create user user_chess identified by user_chess;
alter user user_chess default tablespace chess quota 1990M on chess;

grant connect to user_chess;
grant all privileges to user_chess;
