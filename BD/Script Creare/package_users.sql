CREATE OR REPLACE PACKAGE PACKAGE_USERS AS
  -- defined types
  TYPE GAME_HISTORY IS TABLE OF games.id%TYPE INDEX BY PLS_INTEGER;
  -- defined functions
  FUNCTION EXISTS_USER(p_nickname USERS.NICKNAME%TYPE) RETURN INTEGER;
  FUNCTION GET_PASSWORD(p_nickname USERS.NICKNAME%TYPE) RETURN USERS.PASSWORD%TYPE;
  PROCEDURE INSERT_NEW_REGULAR_USER(p_name USERS.NAME%TYPE, p_email USERS.EMAIL%TYPE, p_nickname USERS.NICKNAME%TYPE, p_password USERS.PASSWORD%TYPE);
  FUNCTION DUMMY(p_param integer) RETURN INTEGER;
  FUNCTION COMPUTE_RATING(p_nickname USERS.NICKNAME%TYPE) RETURN INTEGER;
  FUNCTION SET_USER_BY_NICKNAME(p_nickname varchar2) RETURN SYS_REFCURSOR;
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
  
  PROCEDURE INSERT_NEW_REGULAR_USER(p_name USERS.NAME%TYPE, p_email USERS.EMAIL%TYPE, p_nickname USERS.NICKNAME%TYPE, p_password USERS.PASSWORD%TYPE) AS
  BEGIN
    -- 2 for regular user
    INSERT INTO USERS VALUES(USER_ID.NEXTVAL, p_name, p_email, p_nickname, p_password, null, DBMS_RANDOM.VALUE(10,50), DBMS_RANDOM.VALUE(10,50), DBMS_RANDOM.VALUE(10,100), CURRENT_TIMESTAMP, 2, NULL);
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
    CLOSE hist;
    return v_arr;
  END;
  
  FUNCTION SET_USER_BY_NICKNAME(p_nickname varchar2) RETURN SYS_REFCURSOR IS
    v_user_id integer;
    v_curuser SYS_REFCURSOR;
  BEGIN
    select id into v_user_id from users where nickname like p_nickname;  
    OPEN v_curuser FOR SELECT users.ID, facebook_id, name,  email, nickname, password, wins, looses, 
    draws, created_at, club_id,  status_id, user_status.description FROM users join user_status on users.status_id=user_status.id
    where users.id=v_user_id;
    RETURN v_curuser;
  END;
  
  FUNCTION COMPUTE_RATING(p_nickname USERS.NICKNAME%TYPE) RETURN INTEGER AS
    v_wins INTEGER;
    v_looses INTEGER;
    v_draws INTEGER;
    v_rating INTEGER;
  BEGIN
      select wins, looses, draws into v_wins, v_looses, v_draws from USERS
      where lower(nickname) = lower(p_nickname);
      
      v_rating := v_wins*10 - v_looses*5 + v_draws;
      return v_rating;
  END;
END;
/
commit;
