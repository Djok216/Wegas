CREATE OR REPLACE PACKAGE PACKAGE_USERS AS

  --top 5 threaduri cu cele mai multe commentarii
  FUNCTION top_discussed_threads return sys_refcursor;
  --nr de jocuri in ultimele n zile
  FUNCTION nr_of_latest_games(p_days integer) return integer;
  --nr de postari pe categorii
  FUNCTION nr_posts_by_category return sys_refcursor;
  --nr total de utilizatori la moment
  FUNCTION nr_of_users return integer;
  --cei mai activi utilizatori(cu cele mai multe postari/comentarii)
  FUNCTION top_active_users return sys_refcursor;
  
END;
/
CREATE OR REPLACE PACKAGE BODY PACKAGE_USERS AS
  
    FUNCTION top_discussed_threads return sys_refcursor AS
        v_cursor sys_refcursor;
    BEGIN
        open v_cursor for select * from NR_OF_POST_ON_THREAD_ID where rownum <= 10;
        return v_cursor;
    END;
    
    FUNCTION nr_of_latest_games(p_days integer) return integer AS
        v_nr integer;
    BEGIN
        select count(*) into v_nr from games where trunc(sysdate) - trunc(started_at) <= p_days;
    END;
    
    FUNCTION nr_posts_by_category return sys_refcursor AS
        v_cursor sys_refcursor;
    BEGIN
        open v_cursor for select c.name, count(*) "nr_of_threads" from category c join thread th on c.id = th.category_id group by c.name, c.id;
        return v_cursor;
    END;
    
    FUNCTION nr_of_users return integer AS
        v_nr integer;
    BEGIN
        select count(*) into v_nr from users;
        return v_nr;
    END;
    
    FUNCTION top_active_users return sys_refcursor AS
        v_cursor sys_refcursor;
    BEGIN
        open v_cursor for select * from NR_OF_THREADS_BY_USER where rownum <= 10;
        return v_cursor;
    END;
        
END;
  