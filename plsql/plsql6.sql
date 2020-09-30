SET SERVEROUTPUT ON
SET VERIFY OFF
SET FEEDBACK OFF

DECLARE
	amt number(15);
	amt_str varchar(100) := '';
BEGIN
	amt := &amount;
	dbms_output.put_line(to_char(amt));
	select to_char(to_date(amt, 'j'), 'jsp') into amt_str from dual;
	dbms_output.put_line(amt_str);
END;
/

