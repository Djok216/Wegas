-- daca aveti probleme cu "ORA-01000: maximum open cursors exceeded"
-- ALTER SYSTEM SET open_cursors = 800 SCOPE=BOTH;

@".\BitChess_creation_script.sql"
@".\indexes_triggers.sql"
@".\package_user_status.sql"
@".\package_status.sql"
@".\package_category.sql"
@".\package_users.sql"
@".\package_clubs.sql"
@".\package_forum.sql"
/ -- update clubs rating
commit;

/*
DECLARE
  v_cursor SYS_REFCURSOR;
BEGIN
  PACKAGE_CLUBS.UPDATE_CLUBS_RATINGS;
END;
/
*/
/*
SELECT * FROM USER_STATUS;
SELECT * FROM STATUS;
SELECT * FROM CATEGORY;
SELECT * FROM USERS;
SELECT * FROM CLUBS;
SELECT * FROM THREAD;
*/
