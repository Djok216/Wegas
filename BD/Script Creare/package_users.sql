CREATE OR REPLACE PACKAGE PACKAGE_USERS AS
  -- defined types
  TYPE GAME_HISTORY IS TABLE OF games.id%TYPE INDEX BY PLS_INTEGER;
  -- defined functions
  FUNCTION EXISTS_USER(p_nickname USERS.NICKNAME%TYPE) RETURN INTEGER;
  FUNCTION GET_PASSWORD(p_nickname USERS.NICKNAME%TYPE) RETURN USERS.PASSWORD%TYPE;
  PROCEDURE INSERT_NEW_USER(p_name USERS.NAME%TYPE, p_email USERS.EMAIL%TYPE, p_nickname USERS.NICKNAME%TYPE, p_password USERS.PASSWORD%TYPE);
  FUNCTION DUMMY(p_param integer) RETURN INTEGER;
END;
/
CREATE OR REPLACE PACKAGE BODY PACKAGE_USERS AS
  FUNCTION DUMMY(p_param integer) RETURN INTEGER AS 
    v_paramIncreased INTEGER;
  BEGIN
    v_paramIncreased := p_param + 1;
    return v_paramIncreased;
  END;
  
  FUNCTION EXISTS_USER(p_nickname USERS.NICKNAME%TYPE) RETURN INTEGER AS
    v_cnt INTEGER;
  BEGIN
    SELECT COUNT(*) INTO v_cnt from users where lower(nickname) = lower(p_nickname);
    RETURN v_cnt;
  END;
  
  PROCEDURE INSERT_NEW_USER(p_name USERS.NAME%TYPE, p_email USERS.EMAIL%TYPE, p_nickname USERS.NICKNAME%TYPE, p_password USERS.PASSWORD%TYPE) AS
  BEGIN
    -- AICI AM HARCODAT VALOARE 4 PENTRU CA SE INCALCA CHEIA STRAINA
    -- TO REMOVE!!!!!
    INSERT INTO USERS VALUES(USER_ID.NEXTVAL, p_name, p_email, p_nickname, p_password, 0, 0, 0, CURRENT_TIMESTAMP, 4, NULL);
    -- TO DO TRIGGER OR NOT.
  END;
  
  PROCEDURE UPDATE_USER_DATA(p_id USERS.ID%TYPE, p_name USERS.NAME%TYPE, p_email USERS.EMAIL%TYPE, p_password USERS.PASSWORD%TYPE) AS
  BEGIN
    UPDATE users set name = p_name, email = p_email, password = p_password where id = p_id;
  END;
  
  PROCEDURE DELETE_USER(p_id USERS.ID%TYPE) AS 
  BEGIN
    DELETE FROM users WHERE id = p_id;
  END;
  
  FUNCTION GET_ID(p_nickname USERS.NICKNAME%TYPE) RETURN USERS.ID%TYPE AS 
    v_id USERS.ID%TYPE;
  BEGIN
    SELECT id INTO v_id from USERS WHERE lower(p_nickname) like lower(nickname);
    RETURN v_id;
  END;
  
  FUNCTION GET_PASSWORD(p_nickname USERS.NICKNAME%TYPE) RETURN USERS.PASSWORD%TYPE AS 
    v_password USERS.NICKNAME%TYPE;
  BEGIN
    SELECT password INTO v_password from USERS WHERE lower(p_nickname) like lower(nickname);
    RETURN v_password;
  END;
  
  FUNCTION GET_NAME(p_nickname USERS.NICKNAME%TYPE) RETURN USERS.NAME%TYPE AS 
    v_name USERS.NAME%TYPE;
  BEGIN
    SELECT name INTO v_name from USERS WHERE lower(p_nickname) like lower(nickname);
    RETURN v_name;
  END;
  
  FUNCTION GET_EMAIL(p_nickname USERS.NICKNAME%TYPE) RETURN USERS.EMAIL%TYPE AS 
    v_email USERS.EMAIL%TYPE;
  BEGIN
    SELECT email INTO v_email from USERS WHERE lower(p_nickname) like lower(nickname);
    RETURN v_email;
  END;
  
  FUNCTION GET_HISTORY(p_id USERS.ID%TYPE) RETURN GAME_HISTORY AS
    v_arr GAME_HISTORY;
    v_ind INTEGER;
    v_id_game games.id%TYPE;
    CURSOR hist IS (SELECT id FROM games where first_player_id = p_id or second_player_id = p_id);
  BEGIN
    OPEN hist;
    v_ind := 0;
    LOOP
      FETCH hist INTO v_id_game;
      EXIT WHEN hist%NOTFOUND;
      v_arr(v_ind) := v_id_game;
      v_ind := v_ind + 1;
    END LOOP;
    return v_arr;
  END;
END;
/
commit;

select nickname,password from users;
