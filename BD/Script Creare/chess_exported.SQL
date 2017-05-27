/* ================================================= START TABLE  =================================================*/

  CREATE TABLE "THREAD" 
   (	"ID" NUMBER(10,0), 
	"NAME" VARCHAR2(255), 
	"DESCRIPTION" VARCHAR2(1023), 
	"CREATED_AT" TIMESTAMP (6), 
	"USER_ID" NUMBER(10,0), 
	"STATUS_ID" NUMBER(10,0), 
	"CATEGORY_ID" NUMBER(10,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  TABLESPACE "CHESS" 
/

  CREATE TABLE "CATEGORY" 
   (	"ID" NUMBER(10,0), 
	"NAME" VARCHAR2(255), 
	"DESCRIPTION" VARCHAR2(511)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  TABLESPACE "CHESS" 
/

  CREATE TABLE "CLUBS" 
   (	"ID" NUMBER(10,0), 
	"NAME" VARCHAR2(255), 
	"RATING" NUMBER(10,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  TABLESPACE "CHESS" 
/

  CREATE TABLE "FRIENDS" 
   (	"FIRST_USER_ID" NUMBER(10,0), 
	"SECOND_USER_ID" NUMBER(10,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  TABLESPACE "CHESS" 
/

  CREATE TABLE "USERS" 
   (	"ID" NUMBER(10,0), 
	"NAME" VARCHAR2(255), 
	"EMAIL" VARCHAR2(255), 
	"NICKNAME" VARCHAR2(255), 
	"PASSWORD" VARCHAR2(50), 
	"FACEBOOK_ID" VARCHAR2(100), 
	"WINS" NUMBER(10,0), 
	"LOOSES" NUMBER(10,0), 
	"DRAWS" NUMBER(10,0), 
	"CREATED_AT" TIMESTAMP (6), 
	"STATUS_ID" NUMBER(10,0), 
	"CLUB_ID" NUMBER(10,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  TABLESPACE "CHESS" 
/

  CREATE TABLE "USER_STATUS" 
   (	"ID" NUMBER(10,0), 
	"DESCRIPTION" VARCHAR2(255)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  TABLESPACE "CHESS" 
/

  CREATE TABLE "OPENINGS" 
   (	"ID" NUMBER(10,0), 
	"NAME" VARCHAR2(255), 
	"MOVEMENTS" VARCHAR2(1999)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  TABLESPACE "CHESS" 
/

  CREATE TABLE "GAMES" 
   (	"ID" NUMBER(10,0), 
	"MOVEMENTS" VARCHAR2(1999), 
	"GAME_RESULT" CHAR(1), 
	"STARTED_AT" TIMESTAMP (6), 
	"FIRST_PLAYER_ID" NUMBER(10,0), 
	"SECOND_PLAYER_ID" NUMBER(10,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  TABLESPACE "CHESS" 
/

  CREATE TABLE "STATUS" 
   (	"ID" NUMBER(10,0), 
	"DESCRIPTION" VARCHAR2(255)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  TABLESPACE "CHESS" 
/

  CREATE TABLE "POST" 
   (	"ID" NUMBER(10,0), 
	"CONTENT" VARCHAR2(1023), 
	"CREATED_AT" TIMESTAMP (6), 
	"THREAD_ID" NUMBER(10,0), 
	"USER_ID" NUMBER(10,0), 
	"STATUS_ID" NUMBER(10,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  TABLESPACE "CHESS" 
/
/* ================================================= END TABLE  =================================================*/
/
/* ================================================= START FUNCTION  =================================================*/

  CREATE OR REPLACE FUNCTION "MODIFY_DATA" (p_data varchar2, p_type NUMBER) RETURN VARCHAR2 as
v_data_result varchar2(9786);
BEGIN
  v_data_result := replace(p_data, '"', ' ');
  v_data_result := replace(v_data_result, '''', '''''');
  IF(p_type = 1 or p_type = 96 or p_type = 112) THEN  -- varchar2, nchar, nclob
    v_data_result := '''' || v_data_result || '''';
  ELSIF (p_type = 180) THEN --TIMESTAMP
    v_data_result := 'TO_TIMESTAMP(''' || v_data_result || ''')';
  ELSIF (p_type = 2) then -- integer/number
    DECLARE
      v_nr number;
    BEGIN
      v_nr := v_data_result;
      if v_nr is null then
        v_data_result := 'NULL';
      end if;
    END;
  ELSE DBMS_OUTPUT.PUT_LINE(p_type); 
  END IF;
  return v_data_result;
END;
/
/* ================================================= END FUNCTION  =================================================*/
/
/* ================================================= START SEQUENCE  =================================================*/

   CREATE SEQUENCE  "USER_ID"  MINVALUE 1 MAXVALUE 100000 INCREMENT BY 1 START WITH 4021 CACHE 20 NOORDER  NOCYCLE 
/

   CREATE SEQUENCE  "USER_STATUS_ID"  MINVALUE 1 MAXVALUE 100000 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE 
/

   CREATE SEQUENCE  "CLUB_ID"  MINVALUE 1 MAXVALUE 100000 INCREMENT BY 1 START WITH 1001 CACHE 20 NOORDER  NOCYCLE 
/

   CREATE SEQUENCE  "CATEGORY_ID"  MINVALUE 1 MAXVALUE 100000 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE 
/

   CREATE SEQUENCE  "THREAD_ID"  MINVALUE 1 MAXVALUE 100000 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE 
/

   CREATE SEQUENCE  "GAMES_ID"  MINVALUE 1 MAXVALUE 100000 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE 
/

   CREATE SEQUENCE  "OPENING_ID"  MINVALUE 1 MAXVALUE 100000 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE 
/

   CREATE SEQUENCE  "STATUS_ID"  MINVALUE 1 MAXVALUE 100000 INCREMENT BY 1 START WITH 21 CACHE 20 NOORDER  NOCYCLE 
/

   CREATE SEQUENCE  "COMMENT_ID"  MINVALUE 1 MAXVALUE 100000 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE 
/
/* ================================================= END SEQUENCE  =================================================*/
/
/* ================================================= START PROCEDURE  =================================================*/

  CREATE OR REPLACE PROCEDURE "WRITE_TABLE_DATA" (p_file UTL_FILE.FILE_TYPE, p_table_name VARCHAR2) AS
  v_cursor_id NUMBER := DBMS_SQL.OPEN_CURSOR;
  v_desc DBMS_SQL.DESC_TAB;
  v_column_count NUMBER;
  v_column_definition VARCHAR2(9786);
  v_row_data VARCHAR2(9786);
  v_data VARCHAR2(9786);
  v_sql VARCHAR2(9786);
  v_ign NUMBER;
BEGIN
  v_cursor_id := DBMS_SQL.OPEN_CURSOR;
  UTL_FILE.PUT_LINE(p_file, '/*' || RPAD(' ',50,'<') || ' Data for '  || p_table_name || ' ' || RPAD(' ',50,'>') ||'*/');
  v_sql := 'select * from ' || lower(p_table_name) || ' where rownum<200';
  DBMS_SQL.PARSE(v_cursor_id, v_sql, DBMS_SQL.NATIVE);
  DBMS_SQL.DESCRIBE_COLUMNS(v_cursor_id, v_column_count, v_desc);
  
  v_column_definition := v_column_definition || '(';
  FOR i IN 1.. v_column_count-1 LOOP
    v_column_definition := v_column_definition || v_desc(i).col_name || ', ';
  END LOOP;
  v_column_definition := v_column_definition || v_desc(v_column_count).col_name || ')';
  
  FOR i in 1..v_column_count LOOP
    DBMS_SQL.DEFINE_COLUMN(v_cursor_id, i, v_data, 30000);
  END LOOP;
  v_ign := DBMS_SQL.EXECUTE(v_cursor_id);
  LOOP
    IF DBMS_SQL.FETCH_ROWS(v_cursor_id)=0 THEN
      EXIT;
    ELSE
      v_row_data := '(';
      FOR i in 1..v_column_count-1 LOOP
        DBMS_SQL.COLUMN_VALUE(v_cursor_id, i, v_data);
        v_row_data := v_row_data || MODIFY_DATA(substr(v_data,1,256),v_desc(i).col_type) || ', ';
      END LOOP;
      DBMS_SQL.COLUMN_VALUE(v_cursor_id, v_column_count, v_data);
      v_row_data := v_row_data || MODIFY_DATA(substr(v_data,1,256),v_desc(v_column_count).col_type) || ')';
      
      UTL_FILE.PUT_LINE(p_file, 'INSERT INTO ' || p_table_name || ' ' || v_column_definition || ' VALUES ' || v_row_data ||';');
      UTL_FILE.PUT_LINE(p_file,'/');
    END IF;
  END LOOP;
  
  DBMS_SQL.CLOSE_CURSOR(v_cursor_id);
  UTL_FILE.PUT_LINE(p_file, '/*' ||RPAD(' ',50,'<') || ' Data for '  || p_table_name || ' ' || RPAD(' ',50,'>') || '*/');
END;
/

  CREATE OR REPLACE PROCEDURE "EXPORT_DATABASE" AS
  v_file UTL_FILE.FILE_TYPE;
  CURSOR TABLE_NAMES_CURSOR IS SELECT OBJECT_NAME FROM user_objects WHERE OBJECT_TYPE LIKE 'TABLE';
  v_table_name VARCHAR(100);
BEGIN
    v_file := UTL_FILE.FOPEN('EXPORT_DIRECTORY','chess_exported.SQL','W');
    
    WRITE_SPECIFIC_METADATA(v_file,'TABLE');
    WRITE_SPECIFIC_METADATA(v_file,'FUNCTION');
    WRITE_SPECIFIC_METADATA(v_file,'SEQUENCE');
    WRITE_SPECIFIC_METADATA(v_file,'PROCEDURE');
    WRITE_SPECIFIC_METADATA(v_file,'VIEW');
    WRITE_SPECIFIC_METADATA(v_file,'TRIGGER');
    
    OPEN TABLE_NAMES_CURSOR;
    LOOP
      FETCH TABLE_NAMES_CURSOR INTO v_table_name;
      EXIT WHEN TABLE_NAMES_CURSOR%NOTFOUND;
      WRITE_TABLE_DATA(v_file,v_table_name);
    END LOOP;
    CLOSE TABLE_NAMES_CURSOR;

    UTL_FILE.FCLOSE(v_file);
    EXCEPTION
      WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('A aparut o eroare: ' || SQLERRM);
END;
/

  CREATE OR REPLACE PROCEDURE "WRITE_SPECIFIC_METADATA" (p_file UTL_FILE.FILE_TYPE,
  p_metadata_type VARCHAR2) AS
  CURSOR SPECIFIC_METADATA_CURSOR IS SELECT DBMS_METADATA.get_ddl(object_type, object_name)
  FROM ALL_OBJECTS WHERE owner = 'USER_CHESS' AND object_type = p_metadata_type;
  v_metadata varchar2(9786);
BEGIN
  UTL_FILE.PUT_LINE(p_file, '/*' || RPAD(' ',50,'=') || ' START '  ||
  p_metadata_type || ' ' || RPAD(' ',50,'=') || '*/');
  OPEN SPECIFIC_METADATA_CURSOR;
  LOOP
    FETCH SPECIFIC_METADATA_CURSOR INTO v_metadata;
    EXIT WHEN SPECIFIC_METADATA_CURSOR%NOTFOUND;
    UTL_FILE.PUT_LINE(p_file, v_metadata);
    UTL_FILE.PUT_LINE(p_file, '/');
  END LOOP;
  CLOSE SPECIFIC_METADATA_CURSOR;
  UTL_FILE.PUT_LINE(p_file, '/*' || RPAD(' ',50,'=') || ' END ' ||
  p_metadata_type || ' ' || RPAD(' ',50,'=') || '*/');
  UTL_FILE.PUT_LINE(p_file, '/');
END;
/
/* ================================================= END PROCEDURE  =================================================*/
/
/* ================================================= START VIEW  =================================================*/
/* ================================================= END VIEW  =================================================*/
/
/* ================================================= START TRIGGER  =================================================*/

  CREATE OR REPLACE TRIGGER "CLUB_DELETE_TRG" 
  BEFORE DELETE ON CLUBS
  FOR EACH ROW
BEGIN
  UPDATE USERS SET CLUB_ID = NULL WHERE CLUB_ID = :old.id;
END;
ALTER TRIGGER "CLUB_DELETE_TRG" ENABLE
/

  CREATE OR REPLACE TRIGGER "CLUBS_ID_TRG" 
  BEFORE INSERT ON CLUBS
  FOR EACH ROW
BEGIN
  :new.id := CLUB_ID.nextval;
END;
ALTER TRIGGER "CLUBS_ID_TRG" ENABLE
/

  CREATE OR REPLACE TRIGGER "USER_ID_TRG" 
  BEFORE INSERT ON USERS
  FOR EACH ROW
BEGIN
  :new.id := USER_ID.nextval;
END;
ALTER TRIGGER "USER_ID_TRG" ENABLE
/
/* ================================================= END TRIGGER  =================================================*/
/
/* <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Data for THREAD  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
/* <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Data for THREAD  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
/* <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Data for CATEGORY  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
INSERT INTO CATEGORY (ID, NAME, DESCRIPTION) VALUES (1, 'General Chess Discussion', 'The place to discuss general chess topics');
/
INSERT INTO CATEGORY (ID, NAME, DESCRIPTION) VALUES (2, 'Game analysis', 'Show us your game and let the community analyse it');
/
INSERT INTO CATEGORY (ID, NAME, DESCRIPTION) VALUES (3, 'Openings', 'Openings discussions');
/
INSERT INTO CATEGORY (ID, NAME, DESCRIPTION) VALUES (4, 'BitChess Feedback', 'Bug reports, feature requests, suggestions');
/
INSERT INTO CATEGORY (ID, NAME, DESCRIPTION) VALUES (5, 'Off-Topic Discussion', 'Everything that is not related to chess');
/
/* <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Data for CATEGORY  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
/* <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Data for CLUBS  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (619, 'Victorspringer', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (620, 'Ellawalsh', 138);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (621, 'Wendyharris', 213);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (622, 'Johntucker', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (623, 'Michaelpaige', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (624, 'Traceyrandall', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (625, 'Williamgraham', 59);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (626, 'Mattglover', 188);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (627, 'Laurenmacleod', 191);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (628, 'Traceybrown', 119);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (629, 'Joshuajones', 163);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (630, 'Nicholasedmunds', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (631, 'Steventhomson', 150);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (632, 'Zoeunderwood', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (633, 'Heatherspringer', 7);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (634, 'Davidmartin', 89);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (635, 'Dominicshort', 152);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (636, 'Samantharobertson', 147);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (637, 'Leahharris', 167);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (638, 'Daviddickens', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (639, 'Angelahill', 110);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (640, 'Donnarussell', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (641, 'Brianglover', 38);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (642, 'Avamanning', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (643, 'Gracepowell', 153);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (644, 'Alanpullman', 206);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (645, 'Dianarutherford', 79);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (646, 'Trevorcoleman', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (647, 'Victoriahamilton', 91);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (648, 'Josephreid', 169);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (649, 'Jasonturner', 47);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (650, 'Faithforsyth', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (651, 'Michaelduncan', 106);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (652, 'Vanessalangdon', 130);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (653, 'Johngibson', 68);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (654, 'Warrenallan', 121);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (655, 'Colinmorgan', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (656, 'Samanthawhite', 152);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (657, 'Gavinrobertson', 151);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (658, 'Jacobberry', 105);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (659, 'Faithgreene', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (660, 'Isaaccornish', 100);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (661, 'Jacobdowd', 140);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (662, 'Karengray', 124);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (663, 'Isaacmiller', 63);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (664, 'Austingill', 88);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (665, 'Nicholasburgess', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (666, 'Abigailwallace', 121);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (667, 'Jacobclarkson', 90);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (668, 'Dorothykerr', 9);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (669, 'Danbailey', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (670, 'Juliaunderwood', 43);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (671, 'Alanmcgrath', 198);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (672, 'Jacobscott', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (673, 'Vanessawalker', 134);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (674, 'Neillewis', 120);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (675, 'Traceynewman', -12);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (676, 'Frankrutherford', 21);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (677, 'Isaacross', 3);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (678, 'Nathanbond', 239);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (679, 'Faithhamilton', 167);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (680, 'Michaellee', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (681, 'Irenemorgan', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (682, 'Olivialambert', 161);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (683, 'Blakerandall', 108);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (684, 'Richardhoward', 184);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (685, 'Bernadettemarshall', 157);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (686, 'Avawhite', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (687, 'Mariamartin', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (688, 'Sarahjohnston', 118);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (689, 'Audreygreene', 40);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (690, 'Janfraser', 207);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (691, 'Dominicgraham', 67);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (692, 'Stephanieellison', 161);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (693, 'Adamwalker', 31);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (694, 'Rachelbond', 173);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (695, 'Virginiajames', 145);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (696, 'Mariamcgrath', 74);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (697, 'Williammcgrath', 61);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (698, 'Marykelly', 214);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (699, 'Alisondavies', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (700, 'Carolavery', 49);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (701, 'Clairerampling', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (702, 'Sallyspringer', 171);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (703, 'Heatherbell', 147);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (704, 'Williambutler', 205);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (705, 'Joannepullman', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (706, 'Gracechapman', 52);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (707, 'Suecampbell', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (708, 'Emilyince', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (709, 'Ericgill', 147);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (710, 'Faithbuckland', 192);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (711, 'Rachelball', 166);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (712, 'Laurenarnold', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (713, 'Annalawrence', 198);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (714, 'Bellapullman', 67);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (715, 'Owenwilkins', 11);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (716, 'Ericlawrence', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (717, 'Lisawallace', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (718, 'Olivermarshall', 111);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (719, 'Trevorvance', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (720, 'Cameronmackenzie', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (721, 'Richardglover', 63);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (722, 'Leahcarr', -14);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (723, 'Isaacglover', 137);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (724, 'Charleskelly', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (725, 'Michellepiper', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (726, 'Claireduncan', 193);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (727, 'Karennorth', 157);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (728, 'Faithmcdonald', 65);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (729, 'Lucasabraham', 111);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (730, 'Sebastianlewis', 158);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (731, 'Alexandershort', 60);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (732, 'Gabriellewatson', 103);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (733, 'Ryannorth', 220);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (734, 'Felicitychurchill', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (735, 'Bernadetteclarkson', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (736, 'Samanthajones', 90);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (737, 'Austinglover', 59);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (738, 'Dominiclyman', 128);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (739, 'Rebeccabond', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (740, 'Elizabethquinn', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (741, 'Michaelhoward', 50);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (742, 'Joannepiper', 91);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (743, 'Chloestewart', 96);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (744, 'Amandacameron', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (745, 'Oliviabuckland', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (746, 'Michaelball', 120);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (747, 'Adrianpullman', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (748, 'Roseallan', -15);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (749, 'Kevinmorgan', 193);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (750, 'Fionaclark', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (751, 'Avabower', 221);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (752, 'Michellewelch', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (753, 'Liamgrant', 64);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (754, 'Zoepayne', 52);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (755, 'Carolchapman', 130);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (756, 'Melaniewilson', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (757, 'Bernadettenolan', 235);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (758, 'Joeclark', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (759, 'Andreanolan', 106);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (760, 'Ameliawelch', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (761, 'Richardyoung', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (762, 'Owenberry', 67);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (763, 'Wendyunderwood', 171);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (764, 'Clairejames', 84);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (765, 'Robertskinner', 160);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (766, 'Nicholasfisher', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (767, 'Dorothyferguson', 117);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (768, 'Oliviaknox', 142);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (769, 'Stevenclark', 176);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (770, 'Johnlewis', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (771, 'Amandahardacre', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (772, 'Madeleinebaker', 159);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (773, 'Christopherchapman', 66);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (774, 'Paulhodges', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (775, 'Lucasburgess', 58);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (776, 'Trevormackenzie', 58);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (777, 'Karenbrown', 96);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (778, 'Janhunter', 117);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (779, 'Janespringer', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (780, 'Keithcornish', 152);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (781, 'Rachelmorgan', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (782, 'Lisahart', -16);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (783, 'Caroljackson', 82);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (784, 'Chloelewis', 27);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (785, 'Peterwalsh', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (786, 'Philstewart', 96);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (787, 'Amypoole', 138);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (788, 'Nathanbrown', 143);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (789, 'Carlrutherford', 107);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (790, 'Avahunter', 190);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (791, 'Lillianpoole', 144);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (792, 'Madeleinemacdonald', 25);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (793, 'Petercarr', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (794, 'Gabriellechapman', 83);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (795, 'Dangrant', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (796, 'Amandamurray', 66);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (797, 'Stephenjohnston', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (798, 'Johnmurray', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (799, 'Natalienash', 73);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (800, 'Leahunderwood', 60);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (801, 'Charleswilkins', 134);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (802, 'Blakebower', 72);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (803, 'Carolinepayne', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (804, 'Meganmathis', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (805, 'Mariapoole', 151);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (806, 'Nataliemartin', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (807, 'Yvonnecameron', 188);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (808, 'Avataylor', 112);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (809, 'Neilball', -36);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (810, 'Jasonpiper', 95);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (811, 'Colinbrown', 167);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (812, 'Alexanderroberts', 169);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (813, 'Katherineroberts', 265);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (814, 'Christiancarr', 14);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (815, 'Robertmurray', 0);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (816, 'Samanthawalker', 118);
/
INSERT INTO CLUBS (ID, NAME, RATING) VALUES (817, 'Mattabraham', 21);
/
/* <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Data for CLUBS  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
/* <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Data for FRIENDS  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
/* <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Data for FRIENDS  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
/* <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Data for USERS  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (151, 'SimonPaterson', 'simon.paterson@gmail.com', 'SimonPaterson', 'SimonPaterson', '', 41, 35, 39, TO_TIMESTAMP('27-MAY-17 11.04.21.193000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (152, 'MollyMurray', 'molly.murray@gmail.com', 'MollyMurray', 'MollyMurray', '', 50, 30, 50, TO_TIMESTAMP('27-MAY-17 11.04.21.201000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (153, 'AdamRobertson', 'adam.robertson@gmail.com', 'AdamRobertson', 'AdamRobertson', '', 29, 34, 11, TO_TIMESTAMP('27-MAY-17 11.04.21.206000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (154, 'LilyPeters', 'lily.peters@gmail.com', 'LilyPeters', 'LilyPeters', '', 43, 43, 93, TO_TIMESTAMP('27-MAY-17 11.04.21.212000 AM'), 2, 788);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (155, 'RachelCornish', 'rachel.cornish@gmail.com', 'RachelCornish', 'RachelCornish', '', 17, 14, 42, TO_TIMESTAMP('27-MAY-17 11.04.21.218000 AM'), 2, 203);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (156, 'KimberlyKnox', 'kimberly.knox@gmail.com', 'KimberlyKnox', 'KimberlyKnox', '', 45, 28, 56, TO_TIMESTAMP('27-MAY-17 11.04.21.223000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (157, 'StephenSharp', 'stephen.sharp@gmail.com', 'StephenSharp', 'StephenSharp', '', 32, 47, 73, TO_TIMESTAMP('27-MAY-17 11.04.21.229000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (158, 'AlexandraWhite', 'alexandra.white@gmail.com', 'AlexandraWhite', 'AlexandraWhite', '', 31, 44, 18, TO_TIMESTAMP('27-MAY-17 11.04.21.235000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (159, 'JaneSutherland', 'jane.sutherland@gmail.com', 'JaneSutherland', 'JaneSutherland', '', 38, 21, 41, TO_TIMESTAMP('27-MAY-17 11.04.21.240000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (160, 'NathanBuckland', 'nathan.buckland@gmail.com', 'NathanBuckland', 'NathanBuckland', '', 38, 18, 74, TO_TIMESTAMP('27-MAY-17 11.04.21.246000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (161, 'HarryInce', 'harry.ince@gmail.com', 'HarryInce', 'HarryInce', '', 39, 18, 24, TO_TIMESTAMP('27-MAY-17 11.04.21.252000 AM'), 2, 51);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (162, 'JoeMathis', 'joe.mathis@gmail.com', 'JoeMathis', 'JoeMathis', '', 36, 12, 41, TO_TIMESTAMP('27-MAY-17 11.04.21.259000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (163, 'RyanRees', 'ryan.rees@gmail.com', 'RyanRees', 'RyanRees', '', 44, 41, 53, TO_TIMESTAMP('27-MAY-17 11.04.21.265000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (164, 'JoanArnold', 'joan.arnold@gmail.com', 'JoanArnold', 'JoanArnold', '', 48, 13, 84, TO_TIMESTAMP('27-MAY-17 11.04.21.271000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (165, 'EmilyBaker', 'emily.baker@gmail.com', 'EmilyBaker', 'EmilyBaker', '', 10, 43, 68, TO_TIMESTAMP('27-MAY-17 11.04.21.277000 AM'), 2, 784);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (166, 'VictoriaCornish', 'victoria.cornish@gmail.com', 'VictoriaCornish', 'VictoriaCornish', '', 39, 21, 11, TO_TIMESTAMP('27-MAY-17 11.04.21.282000 AM'), 2, 948);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (167, 'DeirdrePullman', 'deirdre.pullman@gmail.com', 'DeirdrePullman', 'DeirdrePullman', '', 45, 29, 98, TO_TIMESTAMP('27-MAY-17 11.04.21.287000 AM'), 2, 935);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (168, 'JohnMitchell', 'john.mitchell@gmail.com', 'JohnMitchell', 'JohnMitchell', '', 42, 31, 24, TO_TIMESTAMP('27-MAY-17 11.04.21.293000 AM'), 2, 312);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (169, 'MaxForsyth', 'max.forsyth@gmail.com', 'MaxForsyth', 'MaxForsyth', '', 48, 29, 91, TO_TIMESTAMP('27-MAY-17 11.04.21.300000 AM'), 2, 166);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (170, 'JonathanEllison', 'jonathan.ellison@gmail.com', 'JonathanEllison', 'JonathanEllison', '', 37, 38, 74, TO_TIMESTAMP('27-MAY-17 11.04.21.305000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (171, 'AlexanderGrant', 'alexander.grant@gmail.com', 'AlexanderGrant', 'AlexanderGrant', '', 16, 18, 83, TO_TIMESTAMP('27-MAY-17 11.04.21.311000 AM'), 2, 826);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (172, 'WilliamGill', 'william.gill@gmail.com', 'WilliamGill', 'WilliamGill', '', 17, 28, 90, TO_TIMESTAMP('27-MAY-17 11.04.21.319000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (173, 'FrankStewart', 'frank.stewart@gmail.com', 'FrankStewart', 'FrankStewart', '', 20, 11, 88, TO_TIMESTAMP('27-MAY-17 11.04.21.324000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (174, 'LucasWelch', 'lucas.welch@gmail.com', 'LucasWelch', 'LucasWelch', '', 43, 43, 58, TO_TIMESTAMP('27-MAY-17 11.04.21.330000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (175, 'RyanMiller', 'ryan.miller@gmail.com', 'RyanMiller', 'RyanMiller', '', 24, 32, 79, TO_TIMESTAMP('27-MAY-17 11.04.21.337000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (176, 'NatalieBell', 'natalie.bell@gmail.com', 'NatalieBell', 'NatalieBell', '', 24, 19, 22, TO_TIMESTAMP('27-MAY-17 11.04.21.343000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (177, 'JamesOliver', 'james.oliver@gmail.com', 'JamesOliver', 'JamesOliver', '', 14, 33, 76, TO_TIMESTAMP('27-MAY-17 11.04.21.348000 AM'), 2, 489);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (178, 'EvanBell', 'evan.bell@gmail.com', 'EvanBell', 'EvanBell', '', 23, 31, 77, TO_TIMESTAMP('27-MAY-17 11.04.21.354000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (179, 'MadeleineMay', 'madeleine.may@gmail.com', 'MadeleineMay', 'MadeleineMay', '', 45, 37, 71, TO_TIMESTAMP('27-MAY-17 11.04.21.359000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (180, 'PippaCarr', 'pippa.carr@gmail.com', 'PippaCarr', 'PippaCarr', '', 12, 22, 79, TO_TIMESTAMP('27-MAY-17 11.04.21.366000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (181, 'NathanDyer', 'nathan.dyer@gmail.com', 'NathanDyer', 'NathanDyer', '', 12, 10, 98, TO_TIMESTAMP('27-MAY-17 11.04.21.372000 AM'), 2, 612);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (182, 'WandaMackay', 'wanda.mackay@gmail.com', 'WandaMackay', 'WandaMackay', '', 21, 14, 58, TO_TIMESTAMP('27-MAY-17 11.04.21.378000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (183, 'JoanMackay', 'joan.mackay@gmail.com', 'JoanMackay', 'JoanMackay', '', 39, 20, 87, TO_TIMESTAMP('27-MAY-17 11.04.21.384000 AM'), 2, 172);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (184, 'VanessaRutherford', 'vanessa.rutherford@gmail.com', 'VanessaRutherford', 'VanessaRutherford', '', 30, 32, 18, TO_TIMESTAMP('27-MAY-17 11.04.21.390000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (185, 'TimBall', 'tim.ball@gmail.com', 'TimBall', 'TimBall', '', 31, 18, 10, TO_TIMESTAMP('27-MAY-17 11.04.21.399000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (186, 'VirginiaManning', 'virginia.manning@gmail.com', 'VirginiaManning', 'VirginiaManning', '', 40, 16, 79, TO_TIMESTAMP('27-MAY-17 11.04.21.408000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (187, 'DanRussell', 'dan.russell@gmail.com', 'DanRussell', 'DanRussell', '', 22, 12, 14, TO_TIMESTAMP('27-MAY-17 11.04.21.417000 AM'), 2, 685);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (188, 'CameronNolan', 'cameron.nolan@gmail.com', 'CameronNolan', 'CameronNolan', '', 35, 49, 30, TO_TIMESTAMP('27-MAY-17 11.04.21.423000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (189, 'FelicityVaughan', 'felicity.vaughan@gmail.com', 'FelicityVaughan', 'FelicityVaughan', '', 28, 11, 89, TO_TIMESTAMP('27-MAY-17 11.04.21.429000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (190, 'YvonneWhite', 'yvonne.white@gmail.com', 'YvonneWhite', 'YvonneWhite', '', 29, 19, 79, TO_TIMESTAMP('27-MAY-17 11.04.21.437000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (191, 'MarySkinner', 'mary.skinner@gmail.com', 'MarySkinner', 'MarySkinner', '', 36, 22, 12, TO_TIMESTAMP('27-MAY-17 11.04.21.443000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (192, 'DominicWallace', 'dominic.wallace@gmail.com', 'DominicWallace', 'DominicWallace', '', 44, 15, 93, TO_TIMESTAMP('27-MAY-17 11.04.21.450000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (193, 'FrankMacLeod', 'frank.macleod@gmail.com', 'FrankMacLeod', 'FrankMacLeod', '', 13, 12, 82, TO_TIMESTAMP('27-MAY-17 11.04.21.455000 AM'), 2, 528);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (194, 'EricSanderson', 'eric.sanderson@gmail.com', 'EricSanderson', 'EricSanderson', '', 35, 44, 80, TO_TIMESTAMP('27-MAY-17 11.04.21.461000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (195, 'JoshuaHardacre', 'joshua.hardacre@gmail.com', 'JoshuaHardacre', 'JoshuaHardacre', '', 19, 35, 80, TO_TIMESTAMP('27-MAY-17 11.04.21.466000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (196, 'ThomasHughes', 'thomas.hughes@gmail.com', 'ThomasHughes', 'ThomasHughes', '', 40, 12, 70, TO_TIMESTAMP('27-MAY-17 11.04.21.471000 AM'), 2, 488);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (197, 'CameronDowd', 'cameron.dowd@gmail.com', 'CameronDowd', 'CameronDowd', '', 31, 17, 75, TO_TIMESTAMP('27-MAY-17 11.04.21.476000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (198, 'HannahWatson', 'hannah.watson@gmail.com', 'HannahWatson', 'HannahWatson', '', 38, 38, 37, TO_TIMESTAMP('27-MAY-17 11.04.21.482000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (199, 'JoanPeters', 'joan.peters@gmail.com', 'JoanPeters', 'JoanPeters', '', 49, 30, 13, TO_TIMESTAMP('27-MAY-17 11.04.21.487000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (200, 'TheresaWalker', 'theresa.walker@gmail.com', 'TheresaWalker', 'TheresaWalker', '', 44, 40, 40, TO_TIMESTAMP('27-MAY-17 11.04.21.492000 AM'), 2, 194);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (201, 'EdwardFerguson', 'edward.ferguson@gmail.com', 'EdwardFerguson', 'EdwardFerguson', '', 22, 25, 61, TO_TIMESTAMP('27-MAY-17 11.04.21.498000 AM'), 2, 372);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (202, 'VirginiaMcLean', 'virginia.mclean@gmail.com', 'VirginiaMcLean', 'VirginiaMcLean', '', 45, 24, 70, TO_TIMESTAMP('27-MAY-17 11.04.21.503000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (203, 'AmeliaCarr', 'amelia.carr@gmail.com', 'AmeliaCarr', 'AmeliaCarr', '', 11, 34, 34, TO_TIMESTAMP('27-MAY-17 11.04.21.508000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (204, 'CarolineBlake', 'caroline.blake@gmail.com', 'CarolineBlake', 'CarolineBlake', '', 42, 25, 100, TO_TIMESTAMP('27-MAY-17 11.04.21.513000 AM'), 2, 709);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (205, 'AlanScott', 'alan.scott@gmail.com', 'AlanScott', 'AlanScott', '', 32, 30, 71, TO_TIMESTAMP('27-MAY-17 11.04.21.519000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (206, 'JoanDavies', 'joan.davies@gmail.com', 'JoanDavies', 'JoanDavies', '', 43, 25, 14, TO_TIMESTAMP('27-MAY-17 11.04.21.524000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (207, 'AnthonyEdmunds', 'anthony.edmunds@gmail.com', 'AnthonyEdmunds', 'AnthonyEdmunds', '', 45, 49, 28, TO_TIMESTAMP('27-MAY-17 11.04.21.530000 AM'), 2, 264);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (208, 'ChristopherChurchill', 'christopher.churchill@gmail.com', 'ChristopherChurchill', 'ChristopherChurchill', '', 34, 18, 92, TO_TIMESTAMP('27-MAY-17 11.04.21.535000 AM'), 2, 196);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (209, 'BorisParsons', 'boris.parsons@gmail.com', 'BorisParsons', 'BorisParsons', '', 13, 35, 83, TO_TIMESTAMP('27-MAY-17 11.04.21.540000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (210, 'JoePowell', 'joe.powell@gmail.com', 'JoePowell', 'JoePowell', '', 12, 38, 89, TO_TIMESTAMP('27-MAY-17 11.04.21.546000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (211, 'StevenBerry', 'steven.berry@gmail.com', 'StevenBerry', 'StevenBerry', '', 20, 25, 48, TO_TIMESTAMP('27-MAY-17 11.04.21.552000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (212, 'FaithHamilton', 'faith.hamilton@gmail.com', 'FaithHamilton', 'FaithHamilton', '', 25, 30, 29, TO_TIMESTAMP('27-MAY-17 11.04.21.558000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (213, 'ChloeWalsh', 'chloe.walsh@gmail.com', 'ChloeWalsh', 'ChloeWalsh', '', 28, 20, 31, TO_TIMESTAMP('27-MAY-17 11.04.21.563000 AM'), 2, 508);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (214, 'EricMills', 'eric.mills@gmail.com', 'EricMills', 'EricMills', '', 12, 32, 48, TO_TIMESTAMP('27-MAY-17 11.04.21.568000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (215, 'TimHenderson', 'tim.henderson@gmail.com', 'TimHenderson', 'TimHenderson', '', 36, 13, 71, TO_TIMESTAMP('27-MAY-17 11.04.21.574000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (216, 'EmilyBailey', 'emily.bailey@gmail.com', 'EmilyBailey', 'EmilyBailey', '', 26, 31, 15, TO_TIMESTAMP('27-MAY-17 11.04.21.579000 AM'), 2, 855);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (217, 'JustinSimpson', 'justin.simpson@gmail.com', 'JustinSimpson', 'JustinSimpson', '', 24, 44, 53, TO_TIMESTAMP('27-MAY-17 11.04.21.585000 AM'), 2, 738);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (218, 'DorothyFisher', 'dorothy.fisher@gmail.com', 'DorothyFisher', 'DorothyFisher', '', 19, 28, 96, TO_TIMESTAMP('27-MAY-17 11.04.21.590000 AM'), 2, 634);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (219, 'DavidDavies', 'david.davies@gmail.com', 'DavidDavies', 'DavidDavies', '', 20, 25, 100, TO_TIMESTAMP('27-MAY-17 11.04.21.596000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (220, 'AmeliaRees', 'amelia.rees@gmail.com', 'AmeliaRees', 'AmeliaRees', '', 25, 48, 15, TO_TIMESTAMP('27-MAY-17 11.04.21.602000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (221, 'JasmineThomson', 'jasmine.thomson@gmail.com', 'JasmineThomson', 'JasmineThomson', '', 32, 21, 98, TO_TIMESTAMP('27-MAY-17 11.04.21.607000 AM'), 2, 234);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (222, 'LilySpringer', 'lily.springer@gmail.com', 'LilySpringer', 'LilySpringer', '', 37, 17, 89, TO_TIMESTAMP('27-MAY-17 11.04.21.613000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (223, 'AbigailBailey', 'abigail.bailey@gmail.com', 'AbigailBailey', 'AbigailBailey', '', 18, 50, 77, TO_TIMESTAMP('27-MAY-17 11.04.21.619000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (224, 'JoshuaRampling', 'joshua.rampling@gmail.com', 'JoshuaRampling', 'JoshuaRampling', '', 47, 44, 92, TO_TIMESTAMP('27-MAY-17 11.04.21.624000 AM'), 2, 79);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (225, 'CarolinePullman', 'caroline.pullman@gmail.com', 'CarolinePullman', 'CarolinePullman', '', 29, 31, 14, TO_TIMESTAMP('27-MAY-17 11.04.21.629000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (226, 'OliviaBuckland', 'olivia.buckland@gmail.com', 'OliviaBuckland', 'OliviaBuckland', '', 45, 10, 75, TO_TIMESTAMP('27-MAY-17 11.04.21.635000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (227, 'MaxNewman', 'max.newman@gmail.com', 'MaxNewman', 'MaxNewman', '', 49, 26, 54, TO_TIMESTAMP('27-MAY-17 11.04.21.640000 AM'), 2, 79);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (228, 'NathanAbraham', 'nathan.abraham@gmail.com', 'NathanAbraham', 'NathanAbraham', '', 22, 21, 24, TO_TIMESTAMP('27-MAY-17 11.04.21.648000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (229, 'PhilRoberts', 'phil.roberts@gmail.com', 'PhilRoberts', 'PhilRoberts', '', 43, 30, 78, TO_TIMESTAMP('27-MAY-17 11.04.21.655000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (230, 'SueKelly', 'sue.kelly@gmail.com', 'SueKelly', 'SueKelly', '', 27, 40, 51, TO_TIMESTAMP('27-MAY-17 11.04.21.660000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (231, 'SeanGraham', 'sean.graham@gmail.com', 'SeanGraham', 'SeanGraham', '', 20, 50, 56, TO_TIMESTAMP('27-MAY-17 11.04.21.666000 AM'), 2, 677);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (232, 'SueCarr', 'sue.carr@gmail.com', 'SueCarr', 'SueCarr', '', 19, 39, 75, TO_TIMESTAMP('27-MAY-17 11.04.21.671000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (233, 'HannahRoberts', 'hannah.roberts@gmail.com', 'HannahRoberts', 'HannahRoberts', '', 22, 44, 16, TO_TIMESTAMP('27-MAY-17 11.04.21.676000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (234, 'JuliaJackson', 'julia.jackson@gmail.com', 'JuliaJackson', 'JuliaJackson', '', 27, 23, 45, TO_TIMESTAMP('27-MAY-17 11.04.21.681000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (235, 'TimSharp', 'tim.sharp@gmail.com', 'TimSharp', 'TimSharp', '', 49, 42, 46, TO_TIMESTAMP('27-MAY-17 11.04.21.687000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (236, 'GordonHamilton', 'gordon.hamilton@gmail.com', 'GordonHamilton', 'GordonHamilton', '', 31, 14, 52, TO_TIMESTAMP('27-MAY-17 11.04.21.692000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (237, 'MichellePaige', 'michelle.paige@gmail.com', 'MichellePaige', 'MichellePaige', '', 37, 18, 81, TO_TIMESTAMP('27-MAY-17 11.04.21.698000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (238, 'SarahParr', 'sarah.parr@gmail.com', 'SarahParr', 'SarahParr', '', 30, 37, 31, TO_TIMESTAMP('27-MAY-17 11.04.21.703000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (239, 'AmandaSharp', 'amanda.sharp@gmail.com', 'AmandaSharp', 'AmandaSharp', '', 19, 25, 79, TO_TIMESTAMP('27-MAY-17 11.04.21.709000 AM'), 2, 892);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (240, 'OliverMcDonald', 'oliver.mcdonald@gmail.com', 'OliverMcDonald', 'OliverMcDonald', '', 39, 14, 94, TO_TIMESTAMP('27-MAY-17 11.04.21.714000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (241, 'AustinRobertson', 'austin.robertson@gmail.com', 'AustinRobertson', 'AustinRobertson', '', 23, 29, 99, TO_TIMESTAMP('27-MAY-17 11.04.21.719000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (242, 'JoanBuckland', 'joan.buckland@gmail.com', 'JoanBuckland', 'JoanBuckland', '', 20, 16, 62, TO_TIMESTAMP('27-MAY-17 11.04.21.725000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (243, 'RachelBlake', 'rachel.blake@gmail.com', 'RachelBlake', 'RachelBlake', '', 35, 40, 46, TO_TIMESTAMP('27-MAY-17 11.04.21.731000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (244, 'JohnForsyth', 'john.forsyth@gmail.com', 'JohnForsyth', 'JohnForsyth', '', 14, 22, 40, TO_TIMESTAMP('27-MAY-17 11.04.21.737000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (245, 'AlanLambert', 'alan.lambert@gmail.com', 'AlanLambert', 'AlanLambert', '', 14, 48, 29, TO_TIMESTAMP('27-MAY-17 11.04.21.743000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (246, 'RachelHarris', 'rachel.harris@gmail.com', 'RachelHarris', 'RachelHarris', '', 46, 42, 45, TO_TIMESTAMP('27-MAY-17 11.04.21.748000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (247, 'JuliaRoberts', 'julia.roberts@gmail.com', 'JuliaRoberts', 'JuliaRoberts', '', 35, 30, 73, TO_TIMESTAMP('27-MAY-17 11.04.21.754000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (248, 'ClaireRussell', 'claire.russell@gmail.com', 'ClaireRussell', 'ClaireRussell', '', 32, 46, 49, TO_TIMESTAMP('27-MAY-17 11.04.21.760000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (249, 'EmilyTurner', 'emily.turner@gmail.com', 'EmilyTurner', 'EmilyTurner', '', 37, 29, 43, TO_TIMESTAMP('27-MAY-17 11.04.21.766000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (250, 'EllaManning', 'ella.manning@gmail.com', 'EllaManning', 'EllaManning', '', 21, 48, 84, TO_TIMESTAMP('27-MAY-17 11.04.21.772000 AM'), 2, 125);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (251, 'WarrenWhite', 'warren.white@gmail.com', 'WarrenWhite', 'WarrenWhite', '', 36, 35, 39, TO_TIMESTAMP('27-MAY-17 11.04.21.778000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (252, 'MariaLawrence', 'maria.lawrence@gmail.com', 'MariaLawrence', 'MariaLawrence', '', 12, 37, 52, TO_TIMESTAMP('27-MAY-17 11.04.21.785000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (253, 'SallyHamilton', 'sally.hamilton@gmail.com', 'SallyHamilton', 'SallyHamilton', '', 48, 34, 61, TO_TIMESTAMP('27-MAY-17 11.04.21.791000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (254, 'TraceyLewis', 'tracey.lewis@gmail.com', 'TraceyLewis', 'TraceyLewis', '', 42, 35, 45, TO_TIMESTAMP('27-MAY-17 11.04.21.798000 AM'), 2, 98);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (255, 'AlexandraHudson', 'alexandra.hudson@gmail.com', 'AlexandraHudson', 'AlexandraHudson', '', 42, 41, 24, TO_TIMESTAMP('27-MAY-17 11.04.21.804000 AM'), 2, 895);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (256, 'DeirdrePeters', 'deirdre.peters@gmail.com', 'DeirdrePeters', 'DeirdrePeters', '', 50, 25, 54, TO_TIMESTAMP('27-MAY-17 11.04.21.811000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (257, 'HeatherDowd', 'heather.dowd@gmail.com', 'HeatherDowd', 'HeatherDowd', '', 35, 44, 89, TO_TIMESTAMP('27-MAY-17 11.04.21.817000 AM'), 2, 547);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (258, 'NeilTucker', 'neil.tucker@gmail.com', 'NeilTucker', 'NeilTucker', '', 29, 21, 11, TO_TIMESTAMP('27-MAY-17 11.04.21.824000 AM'), 2, 133);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (259, 'LucasGray', 'lucas.gray@gmail.com', 'LucasGray', 'LucasGray', '', 25, 10, 95, TO_TIMESTAMP('27-MAY-17 11.04.21.830000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (260, 'SimonJones', 'simon.jones@gmail.com', 'SimonJones', 'SimonJones', '', 24, 32, 18, TO_TIMESTAMP('27-MAY-17 11.04.21.836000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (261, 'BorisBaker', 'boris.baker@gmail.com', 'BorisBaker', 'BorisBaker', '', 26, 21, 44, TO_TIMESTAMP('27-MAY-17 11.04.21.841000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (262, 'IreneUnderwood', 'irene.underwood@gmail.com', 'IreneUnderwood', 'IreneUnderwood', '', 39, 16, 98, TO_TIMESTAMP('27-MAY-17 11.04.21.847000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (263, 'DylanTucker', 'dylan.tucker@gmail.com', 'DylanTucker', 'DylanTucker', '', 42, 13, 60, TO_TIMESTAMP('27-MAY-17 11.04.21.853000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (264, 'VanessaRandall', 'vanessa.randall@gmail.com', 'VanessaRandall', 'VanessaRandall', '', 41, 37, 49, TO_TIMESTAMP('27-MAY-17 11.04.21.858000 AM'), 2, 723);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (265, 'LeahBurgess', 'leah.burgess@gmail.com', 'LeahBurgess', 'LeahBurgess', '', 41, 27, 36, TO_TIMESTAMP('27-MAY-17 11.04.21.864000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (266, 'AustinVaughan', 'austin.vaughan@gmail.com', 'AustinVaughan', 'AustinVaughan', '', 44, 31, 36, TO_TIMESTAMP('27-MAY-17 11.04.21.870000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (267, 'JasonOgden', 'jason.ogden@gmail.com', 'JasonOgden', 'JasonOgden', '', 47, 22, 39, TO_TIMESTAMP('27-MAY-17 11.04.21.876000 AM'), 2, 89);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (268, 'FelicityVance', 'felicity.vance@gmail.com', 'FelicityVance', 'FelicityVance', '', 20, 40, 30, TO_TIMESTAMP('27-MAY-17 11.04.21.881000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (269, 'LucasMitchell', 'lucas.mitchell@gmail.com', 'LucasMitchell', 'LucasMitchell', '', 43, 11, 66, TO_TIMESTAMP('27-MAY-17 11.04.21.888000 AM'), 2, 494);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (270, 'RobertMurray', 'robert.murray@gmail.com', 'RobertMurray', 'RobertMurray', '', 21, 26, 30, TO_TIMESTAMP('27-MAY-17 11.04.21.894000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (271, 'JoeBurgess', 'joe.burgess@gmail.com', 'JoeBurgess', 'JoeBurgess', '', 32, 24, 91, TO_TIMESTAMP('27-MAY-17 11.04.21.903000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (272, 'DanKnox', 'dan.knox@gmail.com', 'DanKnox', 'DanKnox', '', 48, 31, 81, TO_TIMESTAMP('27-MAY-17 11.04.21.911000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (273, 'EvanWelch', 'evan.welch@gmail.com', 'EvanWelch', 'EvanWelch', '', 25, 34, 87, TO_TIMESTAMP('27-MAY-17 11.04.21.917000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (274, 'YvonneFraser', 'yvonne.fraser@gmail.com', 'YvonneFraser', 'YvonneFraser', '', 38, 41, 16, TO_TIMESTAMP('27-MAY-17 11.04.21.922000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (275, 'JasonTaylor', 'jason.taylor@gmail.com', 'JasonTaylor', 'JasonTaylor', '', 47, 26, 35, TO_TIMESTAMP('27-MAY-17 11.04.21.928000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (276, 'MariaMetcalfe', 'maria.metcalfe@gmail.com', 'MariaMetcalfe', 'MariaMetcalfe', '', 17, 23, 83, TO_TIMESTAMP('27-MAY-17 11.04.21.936000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (277, 'AnthonyMathis', 'anthony.mathis@gmail.com', 'AnthonyMathis', 'AnthonyMathis', '', 22, 21, 37, TO_TIMESTAMP('27-MAY-17 11.04.21.942000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (278, 'KatherineGill', 'katherine.gill@gmail.com', 'KatherineGill', 'KatherineGill', '', 21, 34, 36, TO_TIMESTAMP('27-MAY-17 11.04.21.949000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (279, 'OwenSharp', 'owen.sharp@gmail.com', 'OwenSharp', 'OwenSharp', '', 22, 19, 37, TO_TIMESTAMP('27-MAY-17 11.04.21.957000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (280, 'GabrielleTurner', 'gabrielle.turner@gmail.com', 'GabrielleTurner', 'GabrielleTurner', '', 10, 50, 62, TO_TIMESTAMP('27-MAY-17 11.04.21.964000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (281, 'AbigailLambert', 'abigail.lambert@gmail.com', 'AbigailLambert', 'AbigailLambert', '', 18, 24, 48, TO_TIMESTAMP('27-MAY-17 11.04.21.971000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (282, 'LilyAlsop', 'lily.alsop@gmail.com', 'LilyAlsop', 'LilyAlsop', '', 28, 39, 29, TO_TIMESTAMP('27-MAY-17 11.04.21.977000 AM'), 2, 189);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (283, 'DylanMiller', 'dylan.miller@gmail.com', 'DylanMiller', 'DylanMiller', '', 19, 16, 13, TO_TIMESTAMP('27-MAY-17 11.04.21.983000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (284, 'IsaacHill', 'isaac.hill@gmail.com', 'IsaacHill', 'IsaacHill', '', 16, 32, 38, TO_TIMESTAMP('27-MAY-17 11.04.21.989000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (285, 'PeterNash', 'peter.nash@gmail.com', 'PeterNash', 'PeterNash', '', 24, 44, 72, TO_TIMESTAMP('27-MAY-17 11.04.21.995000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (286, 'HarryRutherford', 'harry.rutherford@gmail.com', 'HarryRutherford', 'HarryRutherford', '', 34, 27, 16, TO_TIMESTAMP('27-MAY-17 11.04.22.001000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (287, 'LucasHardacre', 'lucas.hardacre@gmail.com', 'LucasHardacre', 'LucasHardacre', '', 11, 15, 37, TO_TIMESTAMP('27-MAY-17 11.04.22.007000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (288, 'DanGray', 'dan.gray@gmail.com', 'DanGray', 'DanGray', '', 47, 31, 11, TO_TIMESTAMP('27-MAY-17 11.04.22.012000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (289, 'EdwardDowd', 'edward.dowd@gmail.com', 'EdwardDowd', 'EdwardDowd', '', 30, 44, 61, TO_TIMESTAMP('27-MAY-17 11.04.22.018000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (290, 'DeirdreFisher', 'deirdre.fisher@gmail.com', 'DeirdreFisher', 'DeirdreFisher', '', 18, 48, 57, TO_TIMESTAMP('27-MAY-17 11.04.22.024000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (291, 'RoseOliver', 'rose.oliver@gmail.com', 'RoseOliver', 'RoseOliver', '', 24, 33, 96, TO_TIMESTAMP('27-MAY-17 11.04.22.029000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (292, 'PiersAvery', 'piers.avery@gmail.com', 'PiersAvery', 'PiersAvery', '', 21, 16, 55, TO_TIMESTAMP('27-MAY-17 11.04.22.035000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (293, 'BorisDavies', 'boris.davies@gmail.com', 'BorisDavies', 'BorisDavies', '', 21, 16, 59, TO_TIMESTAMP('27-MAY-17 11.04.22.043000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (294, 'AmeliaRobertson', 'amelia.robertson@gmail.com', 'AmeliaRobertson', 'AmeliaRobertson', '', 22, 23, 89, TO_TIMESTAMP('27-MAY-17 11.04.22.049000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (295, 'MelanieWallace', 'melanie.wallace@gmail.com', 'MelanieWallace', 'MelanieWallace', '', 15, 36, 22, TO_TIMESTAMP('27-MAY-17 11.04.22.056000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (296, 'BorisInce', 'boris.ince@gmail.com', 'BorisInce', 'BorisInce', '', 50, 45, 12, TO_TIMESTAMP('27-MAY-17 11.04.22.062000 AM'), 2, 368);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (297, 'NatalieEdmunds', 'natalie.edmunds@gmail.com', 'NatalieEdmunds', 'NatalieEdmunds', '', 24, 24, 40, TO_TIMESTAMP('27-MAY-17 11.04.22.067000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (298, 'SophieLangdon', 'sophie.langdon@gmail.com', 'SophieLangdon', 'SophieLangdon', '', 34, 47, 58, TO_TIMESTAMP('27-MAY-17 11.04.22.073000 AM'), 2, 783);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (299, 'KatherinePullman', 'katherine.pullman@gmail.com', 'KatherinePullman', 'KatherinePullman', '', 33, 38, 29, TO_TIMESTAMP('27-MAY-17 11.04.22.079000 AM'), 2, 573);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (300, 'TrevorPowell', 'trevor.powell@gmail.com', 'TrevorPowell', 'TrevorPowell', '', 50, 36, 71, TO_TIMESTAMP('27-MAY-17 11.04.22.084000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (301, 'AudreyReid', 'audrey.reid@gmail.com', 'AudreyReid', 'AudreyReid', '', 39, 33, 75, TO_TIMESTAMP('27-MAY-17 11.04.22.090000 AM'), 2, 131);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (302, 'MaryAnderson', 'mary.anderson@gmail.com', 'MaryAnderson', 'MaryAnderson', '', 50, 27, 74, TO_TIMESTAMP('27-MAY-17 11.04.22.096000 AM'), 2, 679);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (303, 'SoniaManning', 'sonia.manning@gmail.com', 'SoniaManning', 'SoniaManning', '', 43, 35, 99, TO_TIMESTAMP('27-MAY-17 11.04.22.103000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (304, 'VictorArnold', 'victor.arnold@gmail.com', 'VictorArnold', 'VictorArnold', '', 20, 46, 77, TO_TIMESTAMP('27-MAY-17 11.04.22.108000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (305, 'AlisonJackson', 'alison.jackson@gmail.com', 'AlisonJackson', 'AlisonJackson', '', 48, 16, 79, TO_TIMESTAMP('27-MAY-17 11.04.22.115000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (306, 'KylieCarr', 'kylie.carr@gmail.com', 'KylieCarr', 'KylieCarr', '', 27, 47, 46, TO_TIMESTAMP('27-MAY-17 11.04.22.120000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (307, 'EllaPowell', 'ella.powell@gmail.com', 'EllaPowell', 'EllaPowell', '', 12, 44, 28, TO_TIMESTAMP('27-MAY-17 11.04.22.126000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (308, 'LeonardHoward', 'leonard.howard@gmail.com', 'LeonardHoward', 'LeonardHoward', '', 46, 42, 90, TO_TIMESTAMP('27-MAY-17 11.04.22.132000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (309, 'RichardLyman', 'richard.lyman@gmail.com', 'RichardLyman', 'RichardLyman', '', 12, 48, 35, TO_TIMESTAMP('27-MAY-17 11.04.22.138000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (310, 'UnaAnderson', 'una.anderson@gmail.com', 'UnaAnderson', 'UnaAnderson', '', 17, 21, 82, TO_TIMESTAMP('27-MAY-17 11.04.22.144000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (311, 'LiamOliver', 'liam.oliver@gmail.com', 'LiamOliver', 'LiamOliver', '', 17, 10, 75, TO_TIMESTAMP('27-MAY-17 11.04.22.152000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (312, 'AdamJames', 'adam.james@gmail.com', 'AdamJames', 'AdamJames', '', 21, 22, 78, TO_TIMESTAMP('27-MAY-17 11.04.22.160000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (313, 'ChloeBlake', 'chloe.blake@gmail.com', 'ChloeBlake', 'ChloeBlake', '', 34, 47, 35, TO_TIMESTAMP('27-MAY-17 11.04.22.167000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (314, 'EricParsons', 'eric.parsons@gmail.com', 'EricParsons', 'EricParsons', '', 15, 20, 80, TO_TIMESTAMP('27-MAY-17 11.04.22.173000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (315, 'DianaClarkson', 'diana.clarkson@gmail.com', 'DianaClarkson', 'DianaClarkson', '', 41, 22, 54, TO_TIMESTAMP('27-MAY-17 11.04.22.178000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (316, 'MattDavidson', 'matt.davidson@gmail.com', 'MattDavidson', 'MattDavidson', '', 14, 11, 87, TO_TIMESTAMP('27-MAY-17 11.04.22.185000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (317, 'KarenSpringer', 'karen.springer@gmail.com', 'KarenSpringer', 'KarenSpringer', '', 47, 35, 61, TO_TIMESTAMP('27-MAY-17 11.04.22.191000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (318, 'JoanneMacDonald', 'joanne.macdonald@gmail.com', 'JoanneMacDonald', 'JoanneMacDonald', '', 26, 46, 49, TO_TIMESTAMP('27-MAY-17 11.04.22.199000 AM'), 2, 258);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (319, 'MariaPaige', 'maria.paige@gmail.com', 'MariaPaige', 'MariaPaige', '', 33, 41, 57, TO_TIMESTAMP('27-MAY-17 11.04.22.207000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (320, 'ChristopherShort', 'christopher.short@gmail.com', 'ChristopherShort', 'ChristopherShort', '', 10, 16, 73, TO_TIMESTAMP('27-MAY-17 11.04.22.214000 AM'), 2, 331);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (321, 'JohnPaterson', 'john.paterson@gmail.com', 'JohnPaterson', 'JohnPaterson', '', 31, 50, 67, TO_TIMESTAMP('27-MAY-17 11.04.22.220000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (322, 'JacobBall', 'jacob.ball@gmail.com', 'JacobBall', 'JacobBall', '', 39, 31, 29, TO_TIMESTAMP('27-MAY-17 11.04.22.226000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (323, 'JanBlake', 'jan.blake@gmail.com', 'JanBlake', 'JanBlake', '', 30, 32, 18, TO_TIMESTAMP('27-MAY-17 11.04.22.231000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (324, 'CarolineTerry', 'caroline.terry@gmail.com', 'CarolineTerry', 'CarolineTerry', '', 12, 32, 25, TO_TIMESTAMP('27-MAY-17 11.04.22.236000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (325, 'SueGray', 'sue.gray@gmail.com', 'SueGray', 'SueGray', '', 17, 42, 24, TO_TIMESTAMP('27-MAY-17 11.04.22.241000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (326, 'MattPullman', 'matt.pullman@gmail.com', 'MattPullman', 'MattPullman', '', 38, 50, 83, TO_TIMESTAMP('27-MAY-17 11.04.22.246000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (327, 'CarlPiper', 'carl.piper@gmail.com', 'CarlPiper', 'CarlPiper', '', 40, 49, 61, TO_TIMESTAMP('27-MAY-17 11.04.22.252000 AM'), 2, 683);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (328, 'KevinJones', 'kevin.jones@gmail.com', 'KevinJones', 'KevinJones', '', 44, 33, 25, TO_TIMESTAMP('27-MAY-17 11.04.22.257000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (329, 'HarryKerr', 'harry.kerr@gmail.com', 'HarryKerr', 'HarryKerr', '', 19, 40, 81, TO_TIMESTAMP('27-MAY-17 11.04.22.262000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (330, 'RebeccaTaylor', 'rebecca.taylor@gmail.com', 'RebeccaTaylor', 'RebeccaTaylor', '', 20, 21, 51, TO_TIMESTAMP('27-MAY-17 11.04.22.267000 AM'), 2, 742);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (331, 'FaithMathis', 'faith.mathis@gmail.com', 'FaithMathis', 'FaithMathis', '', 28, 14, 93, TO_TIMESTAMP('27-MAY-17 11.04.22.272000 AM'), 2, 811);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (332, 'BrandonForsyth', 'brandon.forsyth@gmail.com', 'BrandonForsyth', 'BrandonForsyth', '', 46, 44, 78, TO_TIMESTAMP('27-MAY-17 11.04.22.277000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (333, 'PaulSimpson', 'paul.simpson@gmail.com', 'PaulSimpson', 'PaulSimpson', '', 50, 21, 85, TO_TIMESTAMP('27-MAY-17 11.04.22.282000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (334, 'DonnaFisher', 'donna.fisher@gmail.com', 'DonnaFisher', 'DonnaFisher', '', 33, 16, 63, TO_TIMESTAMP('27-MAY-17 11.04.22.287000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (335, 'HarryUnderwood', 'harry.underwood@gmail.com', 'HarryUnderwood', 'HarryUnderwood', '', 11, 14, 49, TO_TIMESTAMP('27-MAY-17 11.04.22.292000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (336, 'LeahMay', 'leah.may@gmail.com', 'LeahMay', 'LeahMay', '', 39, 14, 91, TO_TIMESTAMP('27-MAY-17 11.04.22.298000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (337, 'AnnaJohnston', 'anna.johnston@gmail.com', 'AnnaJohnston', 'AnnaJohnston', '', 20, 23, 79, TO_TIMESTAMP('27-MAY-17 11.04.22.303000 AM'), 2, 590);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (338, 'FrankOliver', 'frank.oliver@gmail.com', 'FrankOliver', 'FrankOliver', '', 14, 44, 75, TO_TIMESTAMP('27-MAY-17 11.04.22.308000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (339, 'ConnorGreene', 'connor.greene@gmail.com', 'ConnorGreene', 'ConnorGreene', '', 45, 40, 76, TO_TIMESTAMP('27-MAY-17 11.04.22.313000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (340, 'DianeMcLean', 'diane.mclean@gmail.com', 'DianeMcLean', 'DianeMcLean', '', 27, 48, 81, TO_TIMESTAMP('27-MAY-17 11.04.22.319000 AM'), 2, 181);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (341, 'JacobSkinner', 'jacob.skinner@gmail.com', 'JacobSkinner', 'JacobSkinner', '', 37, 48, 69, TO_TIMESTAMP('27-MAY-17 11.04.22.324000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (342, 'DominicUnderwood', 'dominic.underwood@gmail.com', 'DominicUnderwood', 'DominicUnderwood', '', 11, 48, 46, TO_TIMESTAMP('27-MAY-17 11.04.22.329000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (343, 'YvonneMarshall', 'yvonne.marshall@gmail.com', 'YvonneMarshall', 'YvonneMarshall', '', 47, 17, 17, TO_TIMESTAMP('27-MAY-17 11.04.22.335000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (344, 'AlisonRandall', 'alison.randall@gmail.com', 'AlisonRandall', 'AlisonRandall', '', 50, 21, 23, TO_TIMESTAMP('27-MAY-17 11.04.22.340000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (345, 'IreneDickens', 'irene.dickens@gmail.com', 'IreneDickens', 'IreneDickens', '', 26, 41, 19, TO_TIMESTAMP('27-MAY-17 11.04.22.346000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (346, 'SophieWilson', 'sophie.wilson@gmail.com', 'SophieWilson', 'SophieWilson', '', 10, 32, 70, TO_TIMESTAMP('27-MAY-17 11.04.22.353000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (347, 'NicolaAnderson', 'nicola.anderson@gmail.com', 'NicolaAnderson', 'NicolaAnderson', '', 13, 29, 15, TO_TIMESTAMP('27-MAY-17 11.04.22.358000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (348, 'FionaAnderson', 'fiona.anderson@gmail.com', 'FionaAnderson', 'FionaAnderson', '', 32, 23, 20, TO_TIMESTAMP('27-MAY-17 11.04.22.364000 AM'), 2, NULL);
/
INSERT INTO USERS (ID, NAME, EMAIL, NICKNAME, PASSWORD, FACEBOOK_ID, WINS, LOOSES, DRAWS, CREATED_AT, STATUS_ID, CLUB_ID) VALUES (349, 'JamesYoung', 'james.young@gmail.com', 'JamesYoung', 'JamesYoung', '', 17, 23, 87, TO_TIMESTAMP('27-MAY-17 11.04.22.370000 AM'), 2, NULL);
/
/* <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Data for USERS  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
/* <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Data for USER_STATUS  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
INSERT INTO USER_STATUS (ID, DESCRIPTION) VALUES (1, 'Admin');
/
INSERT INTO USER_STATUS (ID, DESCRIPTION) VALUES (2, 'Regular User');
/
INSERT INTO USER_STATUS (ID, DESCRIPTION) VALUES (3, 'Block');
/
INSERT INTO USER_STATUS (ID, DESCRIPTION) VALUES (4, 'BitChess Master');
/
/* <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Data for USER_STATUS  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
/* <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Data for OPENINGS  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
/* <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Data for OPENINGS  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
/* <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Data for GAMES  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
/* <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Data for GAMES  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
/* <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Data for STATUS  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
INSERT INTO STATUS (ID, DESCRIPTION) VALUES (1, 'Public');
/
INSERT INTO STATUS (ID, DESCRIPTION) VALUES (2, 'Admins');
/
INSERT INTO STATUS (ID, DESCRIPTION) VALUES (3, 'Private');
/
INSERT INTO STATUS (ID, DESCRIPTION) VALUES (4, 'Blocked');
/
/* <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Data for STATUS  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
/* <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Data for POST  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
/* <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Data for POST  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
