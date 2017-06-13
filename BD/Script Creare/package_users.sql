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
  FUNCTION INSERT_NEW_REGULAR_USER_FB(p_facebookId USERS.FACEBOOK_ID%TYPE, p_email USERS.EMAIL%TYPE, p_nickname USERS.NICKNAME%TYPE, p_name USERS.NAME%TYPE) RETURN INTEGER;
  FUNCTION DUMMY(p_param integer) RETURN INTEGER;
  FUNCTION COMPUTE_RATING(p_nickname USERS.NICKNAME%TYPE) RETURN INTEGER;
  FUNCTION SET_USER_BY_NICKNAME(p_nickname varchar2) RETURN SYS_REFCURSOR;
  PROCEDURE SET_TOKEN_BY_NICKNAME(p_nickname varchar2, p_token varchar2);
  procedure SET_TOKEN_BY_FBID(p_fbid varchar2, p_token varchar2);
  PROCEDURE LOG_OUT(p_token varchar2);
  FUNCTION CHECK_TOKEN(p_token varchar2) RETURN NUMBER;
  FUNCTION GET_ID_BY_TOKEN(p_token varchar2) RETURN NUMBER;
  FUNCTION GET_NICKNAME_BY_ID(p_id USERS.ID%TYPE) RETURN USERS.NICKNAME%TYPE;
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
    OPEN v_cursor FOR SELECT NAME from users where lower(nickname) like lower(p_string_match);
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
    DRAWS, CREATED_AT, STATUS_ID, CLUB_ID, TOKEN) VALUES(p_name, p_email, p_nickname,
    p_password, null, 0, 0, 0, CURRENT_TIMESTAMP, 2, NULL, NULL);
    -- TO DO TRIGGER OR NOT.
  END;
  
  FUNCTION INSERT_NEW_REGULAR_USER_FB(p_facebookId USERS.FACEBOOK_ID%TYPE, p_email USERS.EMAIL%TYPE, p_nickname USERS.NICKNAME%TYPE, p_name USERS.NAME%TYPE) RETURN INTEGER AS
    v_count INTEGER;
  BEGIN
    -- 2 for regular user
    SELECT COUNT(*) INTO v_count FROM USERS WHERE FACEBOOK_ID = p_facebookId;
    IF v_count = 0 THEN  
      INSERT INTO USERS(NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES,
      DRAWS, CREATED_AT, STATUS_ID, CLUB_ID, TOKEN) VALUES(p_name, p_email, p_nickname,
      null, p_facebookId, 0, 0, 0, CURRENT_TIMESTAMP, 2, NULL, NULL);
      return 1;
    end if;
    return 0;
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
  
  procedure SET_TOKEN_BY_NICKNAME(p_nickname varchar2, p_token varchar2) is
  begin
    update users set token=p_token where lower(nickname) like lower(p_nickname);
  end;
  
  procedure SET_TOKEN_BY_FBID(p_fbid varchar2, p_token varchar2) is
  begin
    update users set token=p_token where facebook_id like p_fbid;
  end;
  
  PROCEDURE LOG_OUT(p_token varchar2) is 
  begin
    update users set token=null where token=p_token;
  end;
  
  FUNCTION CHECK_TOKEN(p_token varchar2) RETURN NUMBER is 
    v_res integer;
    v_data_token TIMESTAMP(6);
    v_count integer;
  begin
      select count(*) into v_count from users where token = p_token;
      /*
      if v_count = 0 then
        return -1; -- tokenul este invalid
      end if;
      select token_time_access into v_data_token from users where token=p_token;
      -- + 30 de minute de la data de cand a fost actualizat
      v_data_token:= v_data_token + 30/1440;
      v_res:=1; -- tokenul este valid
      UPDATE USERS SET TOKEN_TIME_ACCESS = CURRENT_TIMESTAMP WHERE TOKEN = P_TOKEN;
      if(CURRENT_TIMESTAMP > v_data_token) then
        v_res:=0; --tokenul nu mai este valid
        UPDATE USERS SET TOKEN = NULL, TOKEN_TIME_ACCESS = NULL WHERE TOKEN = P_TOKEN;
        RETURN V_RES;
      end if;
      */
      return v_count;
    end;
    
    FUNCTION GET_ID_BY_TOKEN(p_token varchar2) RETURN NUMBER IS
        v_id integer;
    BEGIN
        v_id:=-1;
        select id into v_id from users where token like p_token;
        return v_id;
    END;
END;
/
commit;

select * from users where id between 1 and 2;

/*
set serveroutput on;
DECLARE
  v_token varchar2(10000);
BEGIN
  v_token := 'PMYrmaR3friFG40nWrlZdZ/e3GoI2ytp92FrFd1uowvEDUwe3vWipILcQVIgYdr1wiMhvs1kmLyfqma92s8H0C+eCs8KpzJjZtrVwD5mho8';
  DBMS_OUTPUT.PUT_LINE(PACKAGE_USERS.CHECK_TOKEN(v_token));
END;

SET SERVEROUTPUT ON;
DECLARE
  v_result integer;
BEGIN
  v_result :=PACKAGE_USERS.exists_user_id(44);
  DBMS_OUTPUT.PUT_LINE(v_result);
END;*/
