set serverouput on;

--DROP SEQUENCES IF EXISTS
DROP SEQUENCE USER_ID;
DROP SEQUENCE USER_STATUS_ID;
DROP SEQUENCE CLUB_ID;
DROP SEQUENCE CATEGORY_ID;
DROP SEQUENCE THREAD_ID;
DROP SEQUENCE GAMES_ID;
DROP SEQUENCE OPENING_ID;
DROP SEQUENCE STATUS_ID;
DROP SEQUENCE COMMENT_ID;

-- CREATE SEQUENCES FOR PRIMARY KEYS IN TABLES
CREATE SEQUENCE USER_ID INCREMENT BY 1 START WITH 1 MAXVALUE 100000;
CREATE SEQUENCE USER_STATUS_ID INCREMENT BY 1 START WITH 1 MAXVALUE 100000;
CREATE SEQUENCE CLUB_ID INCREMENT BY 1 START WITH 1 MAXVALUE 100000;
CREATE SEQUENCE CATEGORY_ID INCREMENT BY 1 START WITH 1 MAXVALUE 100000;
CREATE SEQUENCE THREAD_ID INCREMENT BY 1 START WITH 1 MAXVALUE 100000;
CREATE SEQUENCE GAMES_ID INCREMENT BY 1 START WITH 1 MAXVALUE 100000;
CREATE SEQUENCE OPENING_ID INCREMENT BY 1 START WITH 1 MAXVALUE 100000;
CREATE SEQUENCE STATUS_ID INCREMENT BY 1 START WITH 1 MAXVALUE 100000;
CREATE SEQUENCE COMMENT_ID INCREMENT BY 1 START WITH 1 MAXVALUE 100000;

-- DROP TABLES IF EXISTS
DROP TABLE USER_STATUS CASCADE CONSTRAINTS;
DROP TABLE OPENINGS CASCADE CONSTRAINTS;
DROP TABLE GAMES CASCADE CONSTRAINTS;
DROP TABLE STATUS CASCADE CONSTRAINTS;
DROP TABLE POST CASCADE CONSTRAINTS;
DROP TABLE THREAD CASCADE CONSTRAINTS;
DROP TABLE CATEGORY CASCADE CONSTRAINTS;
DROP TABLE CLUBS CASCADE CONSTRAINTS;
DROP TABLE FRIENDS CASCADE CONSTRAINTS;
DROP TABLE USERS CASCADE CONSTRAINTS;

-- TABLES CREATION
CREATE TABLE USER_STATUS (
  id          number(10, 0) NOT NULL, 
  description varchar2(255) NOT NULL, 
  PRIMARY KEY (id));
  
CREATE TABLE OPENINGS (
  id        number(10) NOT NULL, 
  name      varchar2(255) NOT NULL, 
  movements varchar2(1999) NOT NULL, 
  PRIMARY KEY (id));
  
CREATE TABLE GAMES (
  id               number(10, 0) NOT NULL, 
  movements        varchar2(1999) NOT NULL, 
  game_result      char(1) NOT NULL, 
  started_at       timestamp(6) NOT NULL, 
  first_player_id  number(10, 0) NOT NULL, 
  second_player_id number(10, 0) NOT NULL, 
  PRIMARY KEY (id));
  
CREATE TABLE STATUS (
  id          number(10, 0) NOT NULL, 
  description varchar2(255) NOT NULL, 
  PRIMARY KEY (id));
  
CREATE TABLE POST (
  id         number(10, 0) NOT NULL, 
  content    varchar2(1023) NOT NULL, 
  created_at timestamp(6) NOT NULL, 
  thread_id  number(10, 0) NOT NULL, 
  user_id    number(10, 0) NOT NULL, 
  status_id  number(10, 0) NOT NULL, 
  PRIMARY KEY (id));
  
CREATE TABLE THREAD (
  id          number(10, 0) NOT NULL, 
  name        varchar2(255) NOT NULL, 
  description varchar2(1023) NOT NULL, 
  created_at  timestamp(6) NOT NULL, 
  user_id     number(10, 0) NOT NULL, 
  status_id   number(10, 0) NOT NULL, 
  category_id number(10, 0) NOT NULL, 
  PRIMARY KEY (id));
  
CREATE TABLE CATEGORY (
  id          number(10, 0) NOT NULL, 
  name        varchar2(255) NOT NULL, 
  description varchar2(511) NOT NULL, 
  created_at  timestamp(6) NOT NULL, 
  PRIMARY KEY (id));
  
CREATE TABLE CLUBS (
  id     number(10, 0) NOT NULL, 
  name   varchar2(255) NOT NULL, 
  rating number(10) NOT NULL, 
  PRIMARY KEY (id));
  
CREATE TABLE FRIENDS (
  first_user_id  number(10, 0) NOT NULL, 
  second_user_id number(10, 0) NOT NULL, 
  PRIMARY KEY (first_user_id, 
  second_user_id));
  
CREATE TABLE USERS (
  id         number(10, 0) NOT NULL, 
  name       varchar2(255) NOT NULL, 
  email      varchar2(255) NOT NULL, 
  nickname   varchar2(255) NOT NULL, 
  password   varchar2(50) NOT NULL, 
  wins       number(10, 0) NOT NULL, 
  looses     number(10, 0) NOT NULL, 
  draws      number(10, 0) NOT NULL, 
  created_at timestamp(6) NOT NULL, 
  status_id  number(10, 0) NOT NULL, 
  club_id    number(10, 0), 
  PRIMARY KEY (id));
  
ALTER TABLE USERS ADD CONSTRAINT USER_STATUS_ID_FK FOREIGN KEY (status_id) REFERENCES USER_STATUS (id);
ALTER TABLE POST ADD CONSTRAINT POST_THREAD_ID_FK FOREIGN KEY (thread_id) REFERENCES THREAD (id);
ALTER TABLE THREAD ADD CONSTRAINT THREAD_STATUS_ID_FK FOREIGN KEY (status_id) REFERENCES STATUS (id);
ALTER TABLE POST ADD CONSTRAINT POST_USER_ID_FK FOREIGN KEY (user_id) REFERENCES USERS (id);
ALTER TABLE THREAD ADD CONSTRAINT THREAD_USER_ID_FK FOREIGN KEY (user_id) REFERENCES USERS (id);
ALTER TABLE THREAD ADD CONSTRAINT THREAD_CATEGORY_ID_FK FOREIGN KEY (category_id) REFERENCES CATEGORY (id);
ALTER TABLE USERS ADD CONSTRAINT USERS_CLUB_ID_FK FOREIGN KEY (club_id) REFERENCES CLUBS (id);
ALTER TABLE GAMES ADD CONSTRAINT GAMES_SECOND_PLAYER_ID_FK FOREIGN KEY (second_player_id) REFERENCES USERS (id);
ALTER TABLE GAMES ADD CONSTRAINT GAMES_FIRST_PLAYER_ID_FK FOREIGN KEY (first_player_id) REFERENCES USERS (id);
ALTER TABLE POST ADD CONSTRAINT POST_STATUS_ID_FK FOREIGN KEY (status_id) REFERENCES STATUS (id);
ALTER TABLE FRIENDS ADD CONSTRAINT FRIENDS_FIRST_USER_ID_FK FOREIGN KEY (second_user_id) REFERENCES USERS (id);
ALTER TABLE FRIENDS ADD CONSTRAINT FRIENDS_SECOND_USER_ID_FK FOREIGN KEY (first_user_id) REFERENCES USERS (id);

-- 10K entrie in some tables
BEGIN
  -- add entries for user_status table
  DECLARE
     v_description user_status.description%type;
  BEGIN
    FOR v_cont in 1..100 LOOP
      v_description :=  initcap(DBMS_RANDOM.string('l', DBMS_RANDOM.value(10,20)));
      INSERT INTO USER_STATUS(id, description) VALUES (USER_STATUS_ID.NEXTVAL, v_description);
    END LOOP;
  END;
  -- add entries in users table
  DECLARE
    v_name users.name%type;
    v_email users.email%type;
    v_nickname users.nickname%type;
    v_password users.password%type;
    v_wins users.wins%type;
    v_looses users.looses%type;
    v_draws users.draws%type;
    v_created_at users.created_at%type;
    v_status_id users.status_id%type;
  BEGIN
    v_wins:= USER_ID.NEXTVAL; -- doar ca sa pot apela mai jos, inainte sa fac vreun insert USER_ID.currval
  
    FOR v_cont in 1..100 LOOP
      v_name := initcap(DBMS_RANDOM.string('l', dbms_random.value(10,20)));
      v_email := v_name||'@info.uaic.ro';
      v_nickname := DBMS_RANDOM.string('l', DBMS_RANDOM.value(5,10));
      v_password :=  DBMS_RANDOM.string('p', DBMS_RANDOM.value(7,10));
      v_wins := DBMS_RANDOM.value(10,50);
      v_looses := DBMS_RANDOM.value(5,20);
      v_draws := DBMS_RANDOM.value(6,10);
      v_created_at := CURRENT_TIMESTAMP();
      v_status_id := DBMS_RANDOM.value(1,USER_ID.currval);
      INSERT INTO USERS(id, name, email, nickname, password, wins, looses, draws, created_at, status_id, club_id) VALUES (USER_ID.NEXTVAL, v_name, v_email, v_nickname, v_password, v_wins, v_looses, v_draws, v_created_at, v_status_id, NULL);
    END LOOP;
  END;
  -- add entries in friends table
  DECLARE
    v_first_user_id friends.first_user_id%type;
    v_second_user_id friends.second_user_id%type;
  BEGIN
    FOR v_cont in 1..50 LOOP
      v_first_user_id := TRUNC(DBMS_RANDOM.value(1,USER_ID.currval));
      v_second_user_id :=  TRUNC(DBMS_RANDOM.VALUE(1,USER_ID.currval));
      INSERT INTO FRIENDS(first_user_id, second_user_id) VALUES (v_first_user_id,v_second_user_id);
    END LOOP;
  END;
END;