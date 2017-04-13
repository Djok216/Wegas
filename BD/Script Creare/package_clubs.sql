CREATE OR REPLACE PACKAGE PACKAGE_CLUBS AS
  FUNCTION EXISTS_CLUB(p_id CLUBS.ID%TYPE) RETURN INTEGER;
  FUNCTION GET_RATING(p_id CLUBS.ID%TYPE) RETURN CLUBS.RATING%TYPE;
  PROCEDURE INSERT_NEW_CLUB(p_name CLUBS.NAME%TYPE);
  PROCEDURE DELETE_CLUB(p_id CLUBS.ID%TYPE);
  PROCEDURE UPDATE_RATING(p_id CLUBS.ID%TYPE, p_rating CLUBS.RATING%TYPE);
  FUNCTION GET_NAME(p_id CLUBS.ID%TYPE) RETURN CLUBS.NAME%TYPE;
  PROCEDURE ADD_MEMBER(p_club_id USERS.CLUB_ID%TYPE, p_user_id USERS.ID%TYPE);
  PROCEDURE DELETE_MEMBER(p_club_id USERS.CLUB_ID%TYPE, p_user_id USERS.ID%TYPE);
END;
/
CREATE OR REPLACE PACKAGE BODY PACKAGE_CLUBS AS
  
  PROCEDURE INSERT_NEW_CLUB(p_name CLUBS.NAME%TYPE) AS
  BEGIN
    INSERT INTO CLUBS VALUES(CLUB_ID.NEXTVAL, p_name, 0);
  END; 

  PROCEDURE UPDATE_RATING(p_id CLUBS.ID%TYPE, p_rating CLUBS.RATING%TYPE) AS
  BEGIN
    UPDATE clubs set rating = p_rating where id = p_id;
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

  FUNCTION EXISTS_CLUB(p_id CLUBS.ID%TYPE) RETURN INTEGER AS
    v_cnt INTEGER;
  BEGIN
    SELECT COUNT(*) INTO v_cnt from clubs where id=p_id;
    RETURN v_cnt;
  END;


  FUNCTION GET_RATING(p_id CLUBS.ID%TYPE) RETURN CLUBS.RATING%TYPE AS 
    v_rating CLUBS.RATING%TYPE;
  BEGIN
    SELECT rating INTO v_rating from CLUBS WHERE id=p_id;
    RETURN v_rating;
  END;

  PROCEDURE ADD_MEMBER(p_club_id USERS.CLUB_ID%TYPE, p_user_id USERS.ID%TYPE) AS
  BEGIN
    UPDATE users set club_id = p_club_id where id = p_user_id;
  END;

  PROCEDURE DELETE_MEMBER(p_club_id USERS.CLUB_ID%TYPE, p_user_id USERS.ID%TYPE) AS
  BEGIN
    UPDATE users set club_id = NULL where id = p_user_id;
  END;
    
END;
/
commit;