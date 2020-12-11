--1]

CREATE OR REPLACE TRIGGER TGR BEFORE INSERT OR UPDATE OR DELETE ON EMP
DECLARE
	ITS_THU EXCEPTION;
BEGIN
	if TO_CHAR(sysdate, 'DAY') = 'THURSDAY' THEN
		RAISE ITS_THU;
	END IF;
EXCEPTION
	WHEN ITS_THU THEN
               	DBMS_OUTPUT.PUT_LINE('INSIDE EXCEPTION');
		RAISE_APPLICATION_ERROR(-20000, 'NO INSERT/UPDATE/DELETE OPERATION ON THURSDAY');
END;
/

-- 2]
CREATE OR REPLACE TRIGGER log_tgr AFTER UPDATE OR DELETE OR INSERT ON EMP
FOR EACH ROW
BEGIN
	IF updating THEN
		INSERT INTO my_log(table_name, operation_type, description) VALUES ('EMP', 'UPDATE', :new.empno||' -> '||:old.empno||' updated ');
	ELSIF deleting THEN
		INSERT INTO my_log(table_name, operation_type, description) VALUES ('EMP', 'DELETE', :old.empno||' deleted.');
	ELSIF inserting THEN
		INSERT INTO my_log(table_name, operation_type, description) VALUES ('EMP', 'INSERT', :new.empno||' inserted.');
	END IF;
END;
/
