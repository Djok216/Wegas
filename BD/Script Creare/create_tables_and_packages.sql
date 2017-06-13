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
@".\package_games.sql"
@".\package_friends.sql"
@".\package_stats_functions.sql"

INSERT INTO USERS(NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES,
    DRAWS, CREATED_AT, STATUS_ID, CLUB_ID, TOKEN) VALUES('COMPUTER', 'COMPUTER@EMAIL.COM', 'COMPUTER',
    NULL, null, 0, 0, 0, CURRENT_TIMESTAMP, 2, NULL, NULL);

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

/* -- index pentru numarul de utilizatori in functie de status
-- NU ESTE APLICABIL NICAIERI, DE ACEEA L-AM PUS AICI
drop index user_status_id;
create index user_status_id on users(status_id);
-- inainte de index
----------------------------------------------------------------------------------------------
| Id  | Operation                     | Name         | Rows  | Bytes | Cost (%CPU)| Time     |
----------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT              |              |     1 |    29 |    20  (10)| 00:00:01 |
|   1 |  HASH GROUP BY                |              |     1 |    29 |    20  (10)| 00:00:01 |
|   2 |   NESTED LOOPS                |              |       |       |            |          |
|   3 |    NESTED LOOPS               |              |     1 |    29 |    19   (6)| 00:00:01 |
|   4 |     VIEW                      | VW_GBF_9     |     1 |    16 |    18   (6)| 00:00:01 |
|   5 |      HASH GROUP BY            |              |     1 |     3 |    18   (6)| 00:00:01 |
|   6 |       TABLE ACCESS FULL       | USERS        |  4001 | 12003 |    17   (0)| 00:00:01 |
|*  7 |     INDEX UNIQUE SCAN         | SYS_C0020232 |     1 |       |     0   (0)| 00:00:01 |
|   8 |    TABLE ACCESS BY INDEX ROWID| USER_STATUS  |     1 |    13 |     1   (0)| 00:00:01 |
----------------------------------------------------------------------------------------------
-- dupa index
------------------------------------------------------------------------------------------------
| Id  | Operation                     | Name           | Rows  | Bytes | Cost (%CPU)| Time     |
------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT              |                |     1 |    29 |     7  (29)| 00:00:01 |
|   1 |  HASH GROUP BY                |                |     1 |    29 |     7  (29)| 00:00:01 |
|   2 |   NESTED LOOPS                |                |       |       |            |          |
|   3 |    NESTED LOOPS               |                |     1 |    29 |     6  (17)| 00:00:01 |
|   4 |     VIEW                      | VW_GBF_9       |     1 |    16 |     5  (20)| 00:00:01 |
|   5 |      HASH GROUP BY            |                |     1 |     3 |     5  (20)| 00:00:01 |
|   6 |       INDEX FAST FULL SCAN    | USER_STATUS_ID |  4001 | 12003 |     4   (0)| 00:00:01 |
|*  7 |     INDEX UNIQUE SCAN         | SYS_C0020232   |     1 |       |     0   (0)| 00:00:01 |
|   8 |    TABLE ACCESS BY INDEX ROWID| USER_STATUS    |     1 |    13 |     1   (0)| 00:00:01 |
------------------------------------------------------------------------------------------------
-- select
EXPLAIN PLAN FOR select us.description, count(u.id) from user_status us join users u
on us.id = u.status_id group by us.description;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
*/
select * from clubs;
select * from users;