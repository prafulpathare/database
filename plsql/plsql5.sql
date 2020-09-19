SET SERVEROUTPUT ON
SET FEEDBACK off
SET VERIFY off
truncate table school_test;

DECLARE
	CURSOR C1 IS SELECT * FROM SCHOOL;
	X SCHOOL%rowtype;
	perc school_test.percent%type;
	total school_test.total%type;
	grade school_test.grade%type;
BEGIN
	open C1;
	LOOP
		FETCH C1 INTO X;
		exit when C1%notfound;
		
		total := X.DEV_2000 + X.ORACLE;
		perc := total/2;
		if X.class = 'Working' and perc >=50 then grade := 'PASS'; else grade := 'FAIL'; end if;
		if X.class = 'Student' then
		select decode(floor(perc/10),
			9, 'HONOURS',
			8, 'HONOURS',
			7, 'A',
			6, 'A',
			5, 'B',
			4, 'C',
			'FAIL') into grade from dual;
		end if;
--	dbms_output.put_line(X.name||' '||total||' '||perc||' '||grade);
		insert into school_test values(X.roll_no, total, perc, grade);
	END LOOP;
	close C1;
END;
/

DECLARE
	CURSOR C1 IS SELECT * FROM PLSQLFIVE_CUSTOMER;
	X C1%ROWTYPE;
BEGIN
	FOR X IN C1 LOOP
	--	DBMS_OUTPUT.PUT_LINE(X.meter_type||' '||X.meter||' '||X.current_read||' '||X.customer_type);
		
	END LOOP;
END;
/
