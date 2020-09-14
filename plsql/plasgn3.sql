set serveroutput on
set feedback off
set verify off

accept maxv number prompt 'Max : '
accept minv number prompt 'Min : '
accept numv number prompt 'Number : '

declare
	minval number(4);
	maxval number(4);
	numval number(4);
begin
	minval := &minv;
	maxval := &maxv;
	numval := &numv;

	if minval <= numval and maxval >= numval then
		dbms_output.put_line('Within Range');
	else
		if minval > numval then
			dbms_output.put_line('Less than MINVAL');
		else
			dbms_output.put_line('Greater than MAXVAL');
		end if;
	end if;
	dbms_output.put_line('---------------------------------------');
end;
/

accept side1 number prompt 'Side 1 : '
accept side2 number prompt 'Side 2 : '
accept side3 number prompt 'Side 3 : '
DECLARE
	sideOne number(4);
	sideTwo number(4);
	sideThree number(4);
BEGIN
	sideOne := &side1;
	sideTwo := &side2;
	sideThree := &side3;

	if (sideOne + sideTwo) > sideThree or (sideTwo + sideThree) > sideOne or (sideOne + sideThree) > sideTwo then
		dbms_output.put_line('VALID TRIANGLE');
	else
		dbms_output.put_line('INVALID TRIANGLE');
	end if;
	dbms_output.put_line('---------------------------------------');
END;
/

accept iyear number prompt 'Year   : '
declare
	year number(4);
begin

	year := &iyear;
	if REMAINDER(year, 4) = 0 and (REMAINDER(year, 400) = 0 or REMAINDER(year, 100) != 0) then
		dbms_output.put_line('LEAP YEAR');
	else
		dbms_output.put_line('NOT A LEAP YEAR');
	end if;
	dbms_output.put_line('---------------------------------------');
end;
/

accept iweight number prompt 'Weight : '
declare
	rate number(4);
begin
	if &iweight >= 10 then
		rate := &iweight * 5;
	else
		rate := &iweight * 7;
	end if;
	dbms_output.put_line('Rate :  Rs. '||rate);
	dbms_output.put_line('---------------------------------------');
end;
/

accept iage number prompt 'Age : '
declare
	tpe varchar2(5);
begin
	if &iage < 18 then tpe := 'CHILD'; end if;
	if &iage between 18 and 20 then tpe := 'MAJOR'; end if;
	if &iage >=21 then tpe := 'ADULT'; end if;
	dbms_output.put_line(tpe);
	dbms_output.put_line('---------------------------------------');
end;
/

accept istr1 char prompt 'String 1 : '
accept istr2 char prompt 'String 2 : '
declare
	
begin
	if '&istr1' like concat(concat('%','&istr2'), '%') then 
		dbms_output.put_line('EXISTS');
	else
		dbms_output.put_line('NOT EXISTS');
	end if;
	dbms_output.put_line('---------------------------------------');
end;
/

accept marks number prompt 'Marks : '
declare
	grade char(1);
begin
	CASE
		when &marks between 95 and 100 then grade := 'A';
		when &marks between 85 and 94 then grade := 'B';
		when &marks between 70 and 84 then grade := 'C';
		when &marks between 60 and 69 then grade := 'D';
		else grade := 'E';	
	END CASE;
	dbms_output.put_line('GRADE : '||grade);
	dbms_output.put_line('---------------------------------------');
end;
/

accept icode number prompt 'Product Code : '
accept order_amt prompt 'Order Amount : '
declare
	amount number(8,2);
begin
	case
		when &icode = 1 and &order_amt >= 5000 then amount := &order_amt * .88;
		when &icode = 1 and &order_amt between 3000 and 4999 then amount := &order_amt * .92;
		when &icode = 1 and &order_amt < 3000 then amount := &order_amt * .98;

		when &icode = 2 and &order_amt >= 20000 then amount := &order_amt * .90;
		when &icode = 2 and &order_amt between 15000 and 19999 then amount := &order_amt * .95;

		when &icode = 3 and &order_amt >= 50000 then amount := &order_amt * .90;
		when &icode = 3 and &order_amt between 25000 and 49999 then amount := &order_amt * .95;
	end case;

	dbms_output.put_line('Net Amount : Rs. '||amount);
	dbms_output.put_line('---------------------------------------');
end;
/
