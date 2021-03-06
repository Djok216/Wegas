CREATE OR REPLACE PACKAGE PACKAGE_USER_STATUS AS
  PROCEDURE CREATE_DEFINED_USER_STATUS;
END;
/
CREATE OR REPLACE PACKAGE BODY PACKAGE_USER_STATUS AS
  PROCEDURE CREATE_DEFINED_USER_STATUS AS
  BEGIN
    INSERT INTO USER_STATUS(ID, DESCRIPTION) VALUES (USER_STATUS_ID.NEXTVAL, 'Admin');
    INSERT INTO USER_STATUS(ID, DESCRIPTION) VALUES (USER_STATUS_ID.NEXTVAL, 'Regular User');
    INSERT INTO USER_STATUS(ID, DESCRIPTION) VALUES (USER_STATUS_ID.NEXTVAL, 'Block');
    INSERT INTO USER_STATUS(ID, DESCRIPTION) VALUES (USER_STATUS_ID.NEXTVAL, 'BitChess Master');
  END CREATE_DEFINED_USER_STATUS;
END;
/
BEGIN
  PACKAGE_USER_STATUS.CREATE_DEFINED_USER_STATUS;
END;
/
commit;