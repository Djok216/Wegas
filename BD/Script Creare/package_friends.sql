CREATE OR REPLACE PACKAGE PACKAGE_FRIENDS AS
  PROCEDURE ADD_FRIENDS(p_first_user_id USERS.ID%TYPE, p_second_user_id USERS.ID%TYPE);
  FUNCTION CHECH_FRIENDSHIP_EXISTS(p_first_user_id USERS.ID%TYPE, p_second_user_id
  USERS.ID%TYPE) RETURN INTEGER;
END;
/
CREATE OR REPLACE PACKAGE BODY PACKAGE_FRIENDS AS
  PROCEDURE ADD_FRIENDS(p_first_user_id USERS.ID%TYPE, p_second_user_id USERS.ID%TYPE) AS
  BEGIN
    INSERT INTO FRIENDS VALUES(p_first_user_id, p_second_user_id);
  END;
  
  FUNCTION CHECH_FRIENDSHIP_EXISTS(p_first_user_id USERS.ID%TYPE, p_second_user_id
  USERS.ID%TYPE) RETURN INTEGER AS
    v_cnt integer;
  BEGIN
    SELECT COUNT(*) INTO v_cnt FROM FRIENDS WHERE (FIRST_USER_ID = p_first_user_id
    and SECOND_USER_ID = p_second_user_id) or (FIRST_USER_ID = p_second_user_id and
    SECOND_USER_ID = p_first_user_id);
    return v_cnt;
  END;
END;

select * from friends;

select * from users where rownum < 3;