CREATE OR REPLACE TRIGGER THREAD_ID_TRG
  BEFORE INSERT ON thread
  FOR EACH ROW
BEGIN
  :new.id := THREAD_ID.nextval;
END;
/
CREATE OR REPLACE TRIGGER POST_ID_TRG
  BEFORE INSERT ON post
  FOR EACH ROW
BEGIN
  :new.id := COMMENT_ID.nextval;
END;
/
CREATE OR REPLACE PACKAGE package_FORUM AS
  FUNCTION DUMMY RETURN INTEGER;
  Function checkThreadExists(p_id integer) return integer;
  Function checkPostExists(p_id integer) return integer;
  FUNCTION get_threads RETURN SYS_REFCURSOR;
  FUNCTION GET_THREADS_BY_CATEGORY(p_category integer) RETURN SYS_REFCURSOR;
  FUNCTION GET_THREADS_BY_USER(p_nickname varchar2) RETURN SYS_REFCURSOR;
  FUNCTION GET_POSTS_BY_THREADS(p_thread number) RETURN SYS_REFCURSOR;
  PROCEDURE INSERT_THREAD(p_name THREAD.NAME%TYPE, p_description THREAD.DESCRIPTION%TYPE, 
                            p_user_id THREAD.USER_ID%TYPE,
                                p_status_id THREAD.STATUS_ID%TYPE, p_category_id THREAD.CATEGORY_ID%TYPE);
  
  PROCEDURE INSERT_POST(p_content POST.CONTENT%TYPE, p_status_id POST.STATUS_ID%TYPE, 
                            p_thread_id POST.THREAD_ID%TYPE, p_user_id POST.USER_ID%TYPE);
  PROCEDURE DELETE_POST(p_id number);
  PROCEDURE DELETE_THREAD(p_id number);  
END;
/
CREATE OR REPLACE PACKAGE BODY package_FORUM AS
  FUNCTION DUMMY RETURN INTEGER AS
  BEGIN
    RETURN 2991;
  END;
  function checkThreadExists(p_id integer) return integer is
    v_res integer;
  begin
    select count(*) into v_res from thread where id=p_id;
    return v_res;
  end; 
  function checkPostExists(p_id integer) return integer is
    v_res integer;
  begin
    select count(*) into v_res from post where id=p_id;
    return v_res;
  end; 
  
  FUNCTION GET_THREADS RETURN SYS_REFCURSOR IS
    v_thread SYS_REFCURSOR;
  BEGIN
    OPEN v_thread FOR SELECT ID, user_id, status_id, category_id, NAME, DESCRIPTION, created_at FROM thread ORDER BY ID;
    RETURN v_thread;
  END;

  
  FUNCTION GET_THREADS_BY_CATEGORY(p_category integer) RETURN SYS_REFCURSOR IS
    v_thread SYS_REFCURSOR;
  BEGIN
    OPEN v_thread FOR SELECT ID, user_id, status_id, category_id, NAME, DESCRIPTION, created_at FROM thread where category_id=p_category ORDER BY ID;
    RETURN v_thread;
  END;
  
  FUNCTION GET_POSTS_BY_THREADS(p_thread number) RETURN SYS_REFCURSOR is
    v_post SYS_REFCURSOR;
  BEGIN
    OPEN v_post FOR SELECT ID, content, user_id, status_id, thread_id, created_at FROM post where thread_id=p_thread ORDER BY ID;
    RETURN v_post;
  END;
  
  FUNCTION GET_THREADS_BY_USER(p_nickname varchar2) RETURN SYS_REFCURSOR IS
    v_user_id integer;
    v_thread SYS_REFCURSOR;
  BEGIN
    select id into v_user_id from users where nickname like p_nickname;  
    OPEN v_thread FOR SELECT ID, user_id, status_id, category_id, NAME, DESCRIPTION, created_at FROM thread where user_id=v_user_id ORDER BY ID;
    RETURN v_thread;
  END;
  
  procedure INSERT_THREAD(p_name THREAD.NAME%TYPE, p_description THREAD.DESCRIPTION%TYPE, 
                             p_user_id THREAD.USER_ID%TYPE,
                                p_status_id THREAD.STATUS_ID%TYPE, p_category_id THREAD.CATEGORY_ID%TYPE) AS
  BEGIN
    INSERT INTO THREAD(NAME, description, created_at, user_id, status_id, category_id) 
    VALUES(p_name, p_description,CURRENT_TIMESTAMP, p_user_id, p_status_id, p_category_id);
  END;
  
  procedure INSERT_POST(p_content POST.CONTENT%TYPE, p_status_id POST.STATUS_ID%TYPE, 
                            p_thread_id POST.THREAD_ID%TYPE, p_user_id POST.USER_ID%TYPE) AS
  BEGIN
    INSERT INTO POST(content, status_id, thread_id, user_id, created_at) 
    VALUES(p_content, p_status_id, p_thread_id, p_user_id, CURRENT_TIMESTAMP);
  END;
  
  procedure DELETE_POST(p_id number) is
  begin
    delete post where id=p_id;
  end;
  
  procedure DELETE_thread(p_id number) is
  begin
    for v_x in (select id from post where thread_id=p_id) loop
        delete post where id=v_x.id;
    end loop;
    delete thread where id=p_id;
  end;
END;
/

commit;