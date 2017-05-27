/*
--ACEASTA COMANDA TREBUIE RULATA DE UTILIZATORUL SYS.
GRANT EXECUTE ON SYS.UTL_FILE TO user_chess;
*/
DROP DIRECTORY EXPORT_DIRECTORY;
/
CREATE OR REPLACE DIRECTORY EXPORT_DIRECTORY AS 'C:\Users\BlackDeathM8\Desktop\About\Semestru II\TW\Wegas\BD\Script Creare\';
/
CREATE OR REPLACE PROCEDURE WRITE_SPECIFIC_METADATA(p_file UTL_FILE.FILE_TYPE,
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
CREATE OR REPLACE FUNCTION MODIFY_DATA(p_data varchar2, p_type NUMBER) RETURN VARCHAR2 as
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
CREATE OR REPLACE PROCEDURE WRITE_TABLE_DATA(p_file UTL_FILE.FILE_TYPE, p_table_name VARCHAR2) AS
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
CREATE OR REPLACE PROCEDURE EXPORT_DATABASE AS
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
BEGIN
  EXPORT_DATABASE;
END;
/*
SET SERVEROUTPUT ON;
declare
  v_club_id integer;
begin
  SELECT club_id into v_club_id from users where id = 44;
  DBMS_OUTPUT.PUT_LINE('|' || v_club_id || '|');
  IF v_club_id is null then
    DBMS_OUTPUT.PUT_LINE('yes');
  end if;
  v_club_id := '44';
  IF v_club_id is null then
    DBMS_OUTPUT.PUT_LINE('yes');
  end if;
end;
select club_id from users where id = 44;
*/