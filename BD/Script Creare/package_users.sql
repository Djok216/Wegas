-- INDEX ON SIMPLE SELECT, FOR EXISTS USER, ON LIKE CONDITION, 
/*
DROP INDEX USERS_NICKNAME;
CREATE INDEX USERS_NICKNAME ON USERS(NICKNAME);
*/
/*
-- INAINTE DE INDEX;
----------------------------------------------------------------------------
| Id  | Operation          | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------
|   0 | SELECT STATEMENT   |       |     1 |   129 |    17   (0)| 00:00:01 |
|   1 |  SORT AGGREGATE    |       |     1 |   129 |            |          |
|*  2 |   TABLE ACCESS FULL| USERS |  3441 |   433K|    17   (0)| 00:00:01 |
----------------------------------------------------------------------------
-- DUPA INDEX;
----------------------------------------------------------------------------------------
| Id  | Operation             | Name           | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT      |                |     1 |   129 |     7   (0)| 00:00:01 |
|   1 |  SORT AGGREGATE       |                |     1 |   129 |            |          |
|*  2 |   INDEX FAST FULL SCAN| USERS_NICKNAME |  3441 |   433K|     7   (0)| 00:00:01 |
----------------------------------------------------------------------------------------
--
EXPLAIN PLAN FOR SELECT count(*) from users where lower(nickname) like lower('%a%');
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
*/
-- TRIGGERS FOR USERS --
CREATE OR REPLACE TRIGGER USER_ID_TRG
  BEFORE INSERT ON USERS
  FOR EACH ROW
BEGIN
  :new.id := USER_ID.nextval;
END;
/
CREATE OR REPLACE PACKAGE PACKAGE_USERS AS
  -- defined types
  TYPE GAME_HISTORY IS TABLE OF games.id%TYPE INDEX BY PLS_INTEGER;
  -- defined functions
  FUNCTION GET_USERS_MATCH(p_string_match VARCHAR2) RETURN SYS_REFCURSOR;
  FUNCTION EXISTS_USER(p_nickname USERS.NICKNAME%TYPE) RETURN INTEGER;
  FUNCTION EXISTS_USER(p_id USERS.ID%TYPE) RETURN INTEGER;
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
  
  FUNCTION GET_USERS_MATCH(p_string_match VARCHAR2) RETURN SYS_REFCURSOR AS
   v_cursor SYS_REFCURSOR;
  BEGIN
    OPEN v_cursor FOR SELECT NAME from users where lower(nickname) like lower('%'||p_string_match||'%');
    return v_cursor;
  END;
  
  FUNCTION EXISTS_USER(p_nickname USERS.NICKNAME%TYPE) RETURN INTEGER AS
    v_cnt INTEGER;
  BEGIN
    SELECT COUNT(*) INTO v_cnt from users where lower(nickname) like lower(p_nickname);
    RETURN v_cnt;
  END;
  
  FUNCTION EXISTS_USER(p_id USERS.ID%TYPE) RETURN INTEGER AS
    v_cnt INTEGER;
  BEGIN
    SELECT COUNT(*) INTO v_cnt FROM USERS WHERE id = p_id;
    return v_cnt;
  END;
  
  PROCEDURE INSERT_NEW_REGULAR_USER(p_name USERS.NAME%TYPE, p_email USERS.EMAIL%TYPE, p_nickname USERS.NICKNAME%TYPE, p_password USERS.PASSWORD%TYPE) AS
  BEGIN
    -- 2 for regular user
    INSERT INTO USERS(NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES,
    DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES(p_name, p_email, p_nickname,
    p_password, null, 0, 0, 0, CURRENT_TIMESTAMP, 2, NULL);
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
  
  FUNCTION GET_NICKNAME_BY_ID(p_id USERS.ID%TYPE) RETURN USERS.NICKNAME%TYPE AS 
    v_name USERS.NAME%TYPE;
  BEGIN
    SELECT name INTO v_name from USERS WHERE id=p_id;
    RETURN v_name;
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
/
/*
SET SERVEROUTPUT ON;
DECLARE
  v_result integer;
BEGIN
  v_result :=PACKAGE_USERS.exists_user_id(44);
  DBMS_OUTPUT.PUT_LINE(v_result);
END;*/