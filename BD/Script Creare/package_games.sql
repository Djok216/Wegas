CREATE OR REPLACE TRIGGER GAMES_ID_TRG
  BEFORE INSERT ON GAMES
  FOR EACH ROW
BEGIN
  :new.id := GAMES_ID.nextval;
END;
/
CREATE OR REPLACE TRIGGER GAME_ENDED_TRG
  BEFORE UPDATE OF GAME_RESULT ON GAMES
  REFERENCING OLD AS OLD NEW AS NEW
  FOR EACH ROW
BEGIN
  IF :NEW.GAME_RESULT = 0 THEN        -- It is a draw
    UPDATE USERS SET DRAWS = DRAWS + 1 WHERE ID = :OLD.FIRST_PLAYER_ID OR
    ID = :OLD.SECOND_PLAYER_ID;
  ELSIF :NEW.GAME_RESULT = 1 THEN     -- First player win
    UPDATE USERS SET WINS = WINS + 1 WHERE ID = :OLD.FIRST_PLAYER_ID;
    UPDATE USERS SET LOOSES = LOOSES + 1 WHERE ID = :OLD.SECOND_PLAYER_ID;
  ELSIF :NEW.GAME_RESULT = 2 THEN     -- Second player win
    UPDATE USERS SET WINS = WINS + 1 WHERE ID = :OLD.SECOND_PLAYER_ID;
    UPDATE USERS SET LOOSES = LOOSES + 1 WHERE ID = :OLD.FIRST_PLAYER_ID;
  END IF;
END;
/
CREATE OR REPLACE PACKAGE PACKAGE_GAMES AS
  FUNCTION ADD_GAME_STARTED(p_first_player_id USERS.ID%TYPE, p_second_player_id USERS.ID%TYPE) RETURN GAMES.ID%TYPE;
  PROCEDURE ADD_GAME_ENDED(p_id GAMES.ID%TYPE, p_movements GAMES.MOVEMENTS%TYPE, p_game_result GAMES.GAME_RESULT%TYPE);
  FUNCTION EXISTS_GAME(p_id GAMES.ID%TYPE) RETURN INTEGER;
END;
/
CREATE OR REPLACE PACKAGE BODY PACKAGE_GAMES AS
  FUNCTION ADD_GAME_STARTED(p_first_player_id USERS.ID%TYPE, p_second_player_id USERS.ID%TYPE) RETURN GAMES.ID%TYPE AS
  BEGIN
    INSERT INTO GAMES(STARTED_AT, FIRST_PLAYER_ID, SECOND_PLAYER_ID) VALUES(CURRENT_TIMESTAMP, p_first_player_id, p_second_player_id);
    RETURN GAMES_ID.currval;
  END;
  
  PROCEDURE ADD_GAME_ENDED(p_id GAMES.ID%TYPE, p_movements GAMES.MOVEMENTS%TYPE, p_game_result GAMES.GAME_RESULT%TYPE) AS
  BEGIN
    UPDATE GAMES SET MOVEMENTS = p_movements, game_result = p_game_result where id = p_id;
  END;
  
  FUNCTION EXISTS_GAME(p_id GAMES.ID%TYPE) RETURN INTEGER AS
    v_cnt integer;
  BEGIN
    SELECT count(*) INTO v_cnt FROM GAMES WHERE id = p_id;
    return v_cnt;
  END;
END;

/*
1	43	30	23
2	42	31	96
*/

select id, wins, looses, draws from users where rownum < 3;

select * from games where id = 1048;
/*
DECLARE
  v_id number;
BEGIN
  v_id := PACKAGE_GAMES.ADD_GAME_STARTED(2,3);
  PACKAGE_GAMES.ADD_GAME_ENDED(1,'DSGSGDSGDGSDGS','1/2');
  DBMS_OUTPUT.PUT_LINE(v_id);
END;*/