set serveroutput on;
declare
  password1 VARCHAR(50);
BEGIN
  PACKAGE_USERS.INSERT_NEW_USER('nicusor','nicusor','nicusor','nicusor');
END;

set serveroutput on;
BEGIN
  DBMS_OUTPUT.PUT_LINE(PACKAGE_USERS.DUMMY(1));
END;

set serveroutput on;
BEGIN
  SELEC;
END;

SELECT * FROM USERS WHERE  NAME LIKE 'IONESCU1';