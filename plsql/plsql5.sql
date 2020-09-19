SET SERVEROUTPUT ON
SET FEEDBACK off
SET VERIFY off

-- QUESTION 1
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
		dbms_output.put_line(X.name||' '||total||' '||perc||' '||grade);
		insert into school_test values(X.roll_no, total, perc, grade);
	END LOOP;
	close C1;
END;
/

-- QUESTION 2
DECLARE
	CURSOR C1 IS SELECT * FROM PLSQLFIVE_CUSTOMER;
	used_units plsqlfive_customer.current_read%type;
	rate number(3,2);
	amount number(8,2);
	surcharge number(3,2);
	excise number(8,2);
	net number(10,2);
BEGIN
	for x in C1 LOOP
		used_units := x.current_read - x.prev_read;
		select decode(x.customer_type,
			'A', 1, 'I', 1.25, 'C', 1.5,'R', 1.3
		) into rate from dual;
		amount := rate * used_units;

		if x.meter_type = 'T' then	surcharge := 0.05;
		elsif x.meter_type = 'S' then	surcharge := 0.1;
		end if;

		excise := (amount + surcharge) * 0.3;
		net := amount + surcharge + excise;

		insert into plsqlfive_two_output values (x.meter_no, used_units, amount, surcharge, excise, net);
		DBMS_OUTPUT.PUT_LINE(x.meter_no||' '||used_units||' '||amount||' '||surcharge||' '||excise||' '||net);
	END LOOP;
END;
/

-- QUESTION 3
declare
	cursor c1 is select * from pl_5_3_main;
	cursor c2 is select prd_code, sum(qty) summ from pl_5_3_main group by prd_code order by prd_code;
	rate number(2);
	total number(8);
begin
	-- total purchase for each cx
	for x in c1 loop
		-- pl_5_3_main
		total := 0;
		select decode(x.prd_code, 0, 15, 1, 35, 2, 42, 3, 51, 4, 60) into rate from dual;
		total := rate * x.qty;
		dbms_output.put_line('Total of Customer '||x.cx_code||'      Rs.'||total);
		insert into pl_5_3_out_1 values (x.cx_code, total);
	end loop;

	-- total sales per product
	for y in c2 loop	
		select decode(y.prd_code, 0, 15, 1, 35, 2, 42, 3, 51, 4, 60) into rate from dual;
		total := rate * y.summ;
		dbms_output.put_line('Total sale of Product '||y.prd_code||' is Rs.'||total);
		insert into pl_5_3_out_2 values (y.prd_code, total);
	end loop;
end;
/

-- QUESTION 4
declare
	cursor C1 is select * from pl_5_4_employee;
	DA number(6,2);
	HRA number(6,2) := 0;
	GROSS number(7,2);
begin
	for x in C1 loop
		DA := x.basic * 0.35;

		hra := 0;
		if x.category = 'W' then
			if (x.basic*0.15) < 250 then hra := x.basic*0.15; end if;
		elsif x.category = 'J' then
			if(x.basic*0.15) < 1000 then hra := x.basic*0.15; end if;
		elsif x.category = 'S' then
			if(x.basic*0.15) < 3000 then hra := x.basic*0.15; end if;
		end if;

		GROSS := x.basic + DA + hra;
		dbms_output.put_line(x.empno||'   '||GROSS);
		insert into pl_5_4_output values (x.empno, GROSS);
	end loop;
end;
/
