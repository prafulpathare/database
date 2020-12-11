set serveroutput on
set feedback off
set verify off
truncate table tempp;
declare
	len number(2) := 2;
	bdt number(2) := 3;
begin
	dbms_output.put_line('Area       : '||2*len*bdt);
	dbms_output.put_line('------------------------------------------------');
end;
/

declare
	num number(2);
begin
	num := 6;
	insert into tempp(fir, sec) values(num, 'VAR');
	insert into tempp(fir, sec) values(num*num, 'SQUARE');
	insert into tempp(fir, sec) values(num*num*num, 'CUBE');
	dbms_output.put_line('------------------------------------------------');
end;
/

declare
	far number(4);
	far2 number(4);
	celc number(4);
begin
	far := 19;
	celc := (far-32)*(5/9);
	far2 := (9/5)*celc + 32;
	dbms_output.put_line('Fahrenheit : '||far);
	dbms_output.put_line('Celcius    : '||celc);
	dbms_output.put_line('Fahrenheit : '||far2);
	dbms_output.put_line('------------------------------------------------');
end;
/

accept x number prompt 'Enter Inches     : '
declare
	num NUMBER(4);
	yard NUMBER(4);
	foot NUMBER(4);
	inches NUMBER(4);
begin	
	num := &x;
	yard := floor(num / 36);
	foot := floor((num - yard*36)/12);
	inches := (num - yard*36 - foot*12);
	dbms_output.put_line('Yard       : '||yard);
	dbms_output.put_line('Foot       : '||foot);
	dbms_output.put_line('Inches     : '||inches);
	dbms_output.put_line('------------------------------------------------');
end;
/

accept x number prompt 'Enter number     : '
declare
	num NUMBER(4);
	msg varchar2(20);
begin
	num := &x;

	select decode(mod(num,5), 0, 'Divisible by 5', 'Not divible by 5') res into msg from dual;
	dbms_output.put_line(msg);
	dbms_output.put_line('------------------------------------------------');
end;
/

accept x number prompt 'Enter 1st no.    : '
accept y number prompt 'Enter 2nd no.    : '
declare
	num1 number(4);
	num2 number(4);
	msg varchar2(20);
begin
	num1 := &x;
	num2 := &y;

	select decode(sign(num1*num2 - 100), -1, 'LESS than 100', 0, 'EQUAL to 100', 1, 'GREATER than 100') res into msg from dual;
	dbms_output.put_line(msg);
	dbms_output.put_line('------------------------------------------------');
end;
/
