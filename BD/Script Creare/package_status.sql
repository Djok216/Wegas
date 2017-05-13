CREATE OR REPLACE PACKAGE PACKAGE_STATUS AS
  PROCEDURE CREATE_DEFINED_STATUS;
END;
/
CREATE OR REPLACE PACKAGE BODY PACKAGE_STATUS AS
  PROCEDURE CREATE_DEFINED_STATUS AS
  BEGIN
    INSERT INTO STATUS(ID, DESCRIPTION) VALUES(STATUS_ID.NEXTVAL, 'Public');
    INSERT INTO STATUS(ID, DESCRIPTION) VALUES(STATUS_ID.NEXTVAL, 'Admins');
    INSERT INTO STATUS(ID, DESCRIPTION) VALUES(STATUS_ID.NEXTVAL, 'Private');
    INSERT INTO STATUS(ID, DESCRIPTION) VALUES(STATUS_ID.NEXTVAL, 'Blocked');
  END CREATE_DEFINED_STATUS;
END;
/
-- call procedure to create defined categories
BEGIN
  PACKAGE_STATUS.CREATE_DEFINED_STATUS;
END;
/
commit;