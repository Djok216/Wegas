-- TRIGGERS FOR CLUBS --
CREATE OR REPLACE TRIGGER CLUBS_ID
  BEFORE INSERT ON CLUBS
  FOR EACH ROW
BEGIN
  :new.id := CLUB_ID.nextval;
END;
/
CREATE OR REPLACE PACKAGE PACKAGE_CLUBS AS
  PROCEDURE INSERT_NEW_CLUB(p_name CLUBS.NAME%TYPE);
  PROCEDURE DELETE_CLUB(p_id CLUBS.ID%TYPE);
  PROCEDURE DELETE_CLUB(p_name CLUBS.NAME%TYPE);
  PROCEDURE UPDATE_RATING(p_id CLUBS.ID%TYPE, p_rating CLUBS.RATING%TYPE);
  FUNCTION EXISTS_CLUB(p_name CLUBS.NAME%TYPE) RETURN INTEGER;
  FUNCTION GET_NAME(p_id CLUBS.ID%TYPE) RETURN CLUBS.NAME%TYPE;
  FUNCTION GET_RATING(p_id CLUBS.ID%TYPE) RETURN CLUBS.RATING%TYPE;
  
  FUNCTION IS_MEMBER(p_club_name CLUBS.NAME%TYPE, p_user_name USERS.NAME%TYPE) RETURN INTEGER;
  PROCEDURE ADD_MEMBER(p_club_name CLUBS.NAME%TYPE, p_user_name USERS.NAME%TYPE);
  PROCEDURE DELETE_MEMBER(p_user_name USERS.NAME%TYPE);
END;
/
CREATE OR REPLACE PACKAGE BODY PACKAGE_CLUBS AS
  PROCEDURE INSERT_NEW_CLUB(p_name CLUBS.NAME%TYPE) AS
  BEGIN
    INSERT INTO CLUBS(NAME, RATING) VALUES(initcap(lower(p_name)), 0);
  END;
  
  PROCEDURE UPDATE_RATING(p_id CLUBS.ID%TYPE, p_rating CLUBS.RATING%TYPE) AS
  BEGIN
    UPDATE clubs set rating = p_rating where id = p_id;
  END;
  
  PROCEDURE DELETE_CLUB(p_name CLUBS.NAME%TYPE) AS 
  BEGIN
    DELETE FROM clubs WHERE lower(NAME) = lower(p_name);
  END;
  
  PROCEDURE DELETE_CLUB(p_id CLUBS.ID%TYPE) AS 
  BEGIN
    DELETE FROM clubs WHERE id = p_id;
  END;
  
  FUNCTION GET_NAME(p_id CLUBS.ID%TYPE) RETURN CLUBS.NAME%TYPE AS 
    v_name CLUBS.NAME%TYPE;
  BEGIN
    SELECT name INTO v_name from CLUBS WHERE id=p_id;
    RETURN v_name;
  END;
  
  FUNCTION GET_ID(p_NAME CLUBS.NAME%TYPE) RETURN CLUBS.ID%TYPE AS
    v_id CLUBS.NAME%TYPE;
  BEGIN
    SELECT id INTO v_id from CLUBS WHERE lower(name) = lower(p_NAME);
    RETURN v_id;
  END;

  FUNCTION EXISTS_CLUB(p_name CLUBS.NAME%TYPE) RETURN INTEGER AS
    v_cnt INTEGER;
  BEGIN
    SELECT COUNT(*) INTO v_cnt from clubs where LOWER(NAME) = LOWER(p_name);
    RETURN v_cnt;
  END;

  FUNCTION GET_RATING(p_id CLUBS.ID%TYPE) RETURN CLUBS.RATING%TYPE AS 
    v_rating CLUBS.RATING%TYPE;
  BEGIN
    SELECT rating INTO v_rating from CLUBS WHERE id=p_id;
    RETURN v_rating;
  END;

  FUNCTION IS_MEMBER(p_club_name CLUBS.NAME%TYPE, p_user_name USERS.NAME%TYPE) RETURN INTEGER AS
    v_result integer;
    v_user_club_id integer;
    v_club_id integer;
  BEGIN
    select club_id into v_user_club_id from users where lower(name) like lower(p_user_name);
    select id into v_club_id from clubs where lower(name) like lower(p_club_name);
    if(v_user_club_id = v_club_id) then
      return 1;
    END IF;
    return 0;
  END;

  PROCEDURE ADD_MEMBER(p_club_name CLUBS.NAME%TYPE, p_user_NAME USERS.NAME%TYPE) AS
  BEGIN
    -- CHECKED USER FROM JAVA, PACKAGE_USERS.EXISTS_USER
    -- CHECKED CLUB_NAME FROM JAVA, PACKAGE_CLUBS.EXISTS_CLUB
    UPDATE users set club_id = (select id from clubs where lower(name) like lower(p_club_name)) where lower(name) = lower(p_user_name);
  END;

  PROCEDURE DELETE_MEMBER(p_user_name USERS.NAME%TYPE) AS
  BEGIN
    -- CHECKED USER FROM JAVA, PACKAGE_USERS.EXISTS_USER
    -- CHECKED CLUB_NAME FROM JAVA, PACKAGE_CLUBS.EXISTS_CLUB
    UPDATE users set club_id = NULL where lower(name) = lower(p_user_name);
  END;
END;
/
commit;
/
select * from clubs;

set serveroutput on;
BEGIN
  PACKAGE_CLUBS.ADD_MEMBER('nicusori', 'nicusor');
  --PACKAGE_CLUBS.DELETE_MEMBER('nicusor');
  DBMS_OUTPUT.PUT_LINE(PACKAGE_CLUBS.IS_MEMBER('nicusori', 'nicusor'));
END;

select * from users;