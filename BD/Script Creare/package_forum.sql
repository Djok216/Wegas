CREATE OR REPLACE TRIGGER THREAD_ID_TRG
  BEFORE INSERT ON thread
  FOR EACH ROW
BEGIN
  :new.id := THREAD_ID.nextval;
END;
/
CREATE OR REPLACE PACKAGE package_FORUM AS
  FUNCTION DUMMY RETURN INTEGER;
  Function checkThreadExists(p_id integer) return integer;
  FUNCTION get_threads RETURN SYS_REFCURSOR;
  FUNCTION GET_THREADS_BY_CATEGORY(p_category integer) RETURN SYS_REFCURSOR;
  FUNCTION GET_THREADS_BY_USER(p_nickname varchar2) RETURN SYS_REFCURSOR;
  PROCEDURE INSERT_THREAD(p_name THREAD.NAME%TYPE, p_description THREAD.DESCRIPTION%TYPE, 
                            p_user_id THREAD.USER_ID%TYPE,
                                p_status_id THREAD.STATUS_ID%TYPE, p_category_id THREAD.CATEGORY_ID%TYPE);
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
END;
/

commit;