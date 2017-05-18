CREATE OR REPLACE PACKAGE package_FORUM AS
  FUNCTION DUMMY RETURN INTEGER;
  Function checkThreadExists(p_id integer) return integer;
  FUNCTION get_threads RETURN SYS_REFCURSOR;
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

END;
/

commit;