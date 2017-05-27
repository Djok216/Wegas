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
  
  FUNCTION GET_GENERAL_STATISTICS RETURN SYS_REFCURSOR;
  FUNCTION GET_CLUB_MEMBERS(p_club_name CLUBS.NAME%TYPE) RETURN SYS_REFCURSOR;
  FUNCTION GET_CLUBS_BY_POPULARITY(p_top_x integer) RETURN SYS_REFCURSOR;
  FUNCTION GET_CLUBS_BY_RATING(p_top_x integer) RETURN SYS_REFCURSOR;
  
  PROCEDURE UPDATE_CLUBS_RATINGS;
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
    UPDATE users set club_id = (select id from clubs where lower(name) like 
    lower(p_club_name)) where lower(name) = lower(p_user_name);
  END;

  PROCEDURE DELETE_MEMBER(p_user_name USERS.NAME%TYPE) AS
  BEGIN
    -- CHECKED USER FROM JAVA, PACKAGE_USERS.EXISTS_USER
    -- CHECKED CLUB_NAME FROM JAVA, PACKAGE_CLUBS.EXISTS_CLUB
    UPDATE users set club_id = NULL where lower(name) = lower(p_user_name);
  END;
  
  FUNCTION GET_GENERAL_STATISTICS RETURN SYS_REFCURSOR IS
    v_cursor SYS_REFCURSOR;
  BEGIN
    OPEN v_cursor FOR select c.name club_name, count(u.id) members from users u
    join clubs c on c.id = u.club_id group by c.name;
    RETURN v_cursor;
  END;
  
  FUNCTION GET_CLUB_MEMBERS(p_club_name CLUBS.NAME%TYPE) RETURN SYS_REFCURSOR IS
    v_cursor SYS_REFCURSOR;
  BEGIN
    OPEN v_cursor FOR select name from users where club_id = (select id from 
    clubs where lower(name) = lower(p_club_name));
    RETURN v_cursor;
  END;
  
  FUNCTION GET_CLUBS_BY_POPULARITY(p_top_x integer) RETURN SYS_REFCURSOR IS
    v_cursor SYS_REFCURSOR;
  BEGIN
    OPEN v_cursor FOR select * from
    (select c.name club_name, count(u.id) members from users u join clubs c
    on c.id = u.club_id group by c.name order by count(u.id) desc, club_name)
    where rownum <= p_top_x;
    return v_cursor;
  END;
  
  FUNCTION GET_CLUBS_BY_RATING(p_top_x integer) RETURN SYS_REFCURSOR IS
    v_cursor SYS_REFCURSOR;
  BEGIN
      OPEN v_cursor FOR select * from
      (select name, rating from clubs order by rating desc)
      where rownum <= p_top_x;
    return v_cursor;
  END;
  
  PROCEDURE UPDATE_CLUBS_RATINGS IS
    v_cursor SYS_REFCURSOR;
    v_club_name CLUBS.NAME%TYPE;
  BEGIN
    OPEN v_cursor FOR SELECT NAME FROM CLUBS;
    LOOP
      FETCH v_cursor INTO v_club_name;
      EXIT WHEN v_cursor%NOTFOUND;
      DECLARE
        v_cursor_members SYS_REFCURSOR;
        v_current_user USERS.NAME%TYPE;
        v_club_rating INTEGER := 0;
        v_nr_of_users INTEGER := 1;
      BEGIN
        OPEN v_cursor_members FOR select name from users where club_id = (select id from 
        clubs where lower(name) = lower(v_club_name));
        LOOP
          FETCH v_cursor_members INTO v_current_user;
          EXIT WHEN v_cursor_members%NOTFOUND;
          v_club_rating := v_club_rating + PACKAGE_USERS.COMPUTE_RATING(v_current_user);
          v_nr_of_users := v_nr_of_users + 1;
        END LOOP;
        CLOSE v_cursor_members;
        v_club_rating := v_club_rating / v_nr_of_users;
        UPDATE CLUBS SET RATING = v_club_rating where lower(name) = lower(v_club_name);
      END;
    END LOOP;
    CLOSE v_cursor;
  END;
END;
/
commit;
/*
EXPLAIN PLAN FOR select count(u.id), c.id from users u join clubs c on c.id = u.club_id group by c.id;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
-- inainte de index
----------------------------------------------------------------------------
| Id  | Operation          | Name  | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------
|   0 | SELECT STATEMENT   |       |   640 |  1280 |    18   (6)| 00:00:01 |
|   1 |  HASH GROUP BY     |       |   640 |  1280 |    18   (6)| 00:00:01 |
|*  2 |   TABLE ACCESS FULL| USERS |  1258 |  2516 |    17   (0)| 00:00:01 |
----------------------------------------------------------------------------
-- dupa index
--------------------------------------------------------------------------------------------
| Id  | Operation            | Name                | Rows  | Bytes | Cost (%CPU)| Time     |
--------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT     |                     |   640 |  1280 |     4   (0)| 00:00:01 |
|   1 |  SORT GROUP BY NOSORT|                     |   640 |  1280 |     4   (0)| 00:00:01 |
|*  2 |   INDEX FULL SCAN    | USERS_CLUB_ID_INDEX |  1258 |  2516 |     4   (0)| 00:00:01 |
--------------------------------------------------------------------------------------------
*/
/*
DECLARE
  v_cursor SYS_REFCURSOR;
BEGIN
  PACKAGE_CLUBS.UPDATE_CLUBS_RATINGS;
END;

EXPLAIN PLAN FOR select name from users where club_id = (select id from clubs where lower(name) = lower('Jessicabaker'));
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

select c.name club_name, count(u.id) members from users u join clubs c on c.id = u.club_id group by c.name;

-- get clubs by rating
select * from
(select name, rating from clubs order by rating desc)
where rownum <= 10;

select * from
    (select c.name club_name, count(u.id) members from users u join clubs c
    on c.id = u.club_id group by c.name order by count(u.id) desc, club_name)
    where rownum <= 10;
    
select * from users;
select * from clubs where name like '%icusori%';*/