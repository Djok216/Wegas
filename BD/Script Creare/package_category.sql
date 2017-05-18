CREATE OR REPLACE PACKAGE PACKAGE_CATEGORY AS
  PROCEDURE CREATE_DEFINED_CATEGORY;
  FUNCTION GET_CATEGORIES RETURN SYS_REFCURSOR;
  FUNCTION checkCategoryExists(p_id integer) return integer;
END;
/
CREATE OR REPLACE PACKAGE BODY PACKAGE_CATEGORY AS
  PROCEDURE CREATE_DEFINED_CATEGORY AS
  BEGIN
    INSERT INTO CATEGORY(ID, NAME, DESCRIPTION) VALUES(CATEGORY_ID.NEXTVAL, 'General Chess Discussion', 'The place to discuss general chess topics');
    INSERT INTO CATEGORY(ID, NAME, DESCRIPTION) VALUES(CATEGORY_ID.NEXTVAL, 'Game analysis', 'Show us your game and let the community analyse it');
    INSERT INTO CATEGORY(ID, NAME, DESCRIPTION) VALUES(CATEGORY_ID.NEXTVAL, 'Openings', 'Openings discussions');
    INSERT INTO CATEGORY(ID, NAME, DESCRIPTION) VALUES(CATEGORY_ID.NEXTVAL, 'BitChess Feedback', 'Bug reports, feature requests, suggestions');
    INSERT INTO CATEGORY(ID, NAME, DESCRIPTION) VALUES(CATEGORY_ID.NEXTVAL, 'Off-Topic Discussion', 'Everything that is not related to chess');
  END CREATE_DEFINED_CATEGORY;
  
  FUNCTION GET_CATEGORIES RETURN SYS_REFCURSOR IS
    v_categ SYS_REFCURSOR;
  BEGIN
    OPEN v_categ FOR SELECT ID, NAME, DESCRIPTION FROM CATEGORY ORDER BY ID;
    RETURN v_categ;
  END;
  
  FUNCTION checkCategoryExists(p_id integer) return integer is
    v_res integer;
  begin
    select count(*) into v_res from category where id=p_id;
    return v_res;
  end;
END;
/
-- call procedure to create defined categories
BEGIN
  PACKAGE_CATEGORY.CREATE_DEFINED_CATEGORY;
END;
/
-- parse cursor manualy from code
SET serveroutput on;
DECLARE
  v_id integer;
  v_name varchar(511);
  v_description varchar(511);
  v_categ SYS_REFCURSOR;
BEGIN
  v_categ := PACKAGE_CATEGORY.GET_CATEGORIES;
  LOOP
    FETCH v_categ into v_id, v_name, v_description;
    exit when v_categ%notfound;
    DBMS_OUTPUT.PUT_LINE(v_id||' '||v_name||' '||v_description);
  END LOOP;
  CLOSE v_categ;
END;
/
COMMIT;