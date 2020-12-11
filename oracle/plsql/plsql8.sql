set serveroutput on
set verify off
set feedback off

-- Question 1

create or replace procedure Comp_intr(p in number, r in number, y in number)
as
	interest number(12,4);
	total number(16,4);
begin
	interest := (p*power((1+r), y)) - p;
	total := p * (1 + r * y);
	-- insert into tempp (interest, total) values (interest, total);
end;
/

execute Comp_intr(15450, 0.3, 5);

-- Question 2
create or replace function Age_calc(bdate in date, months out number, days out number)
return number
is
	age number(4,2);
begin
	select floor(months_between(sysdate, bdate)/12) into age from dual;
	select floor(months_between(sysdate, bdate)  - (floor(months_between(sysdate, bdate)/12)*12)) into months from dual;
	select floor((months_between(sysdate, bdate) - floor(months_between(sysdate, bdate)))*30) into days from dual;
return age;
end;
/

accept bdate char prompt 'Birth day (dd-mm-yyyy) : '
declare
	age number(2);
	months number(2);
	days number(2);
begin
	age := AGE_CALC(to_date('&bdate', 'DD-MM-YYYY'), months, days);
	dbms_output.put_line(age||' years, '||months||' months, '||days||' days');
end;
/

-- Question 3
create or replace package Payroll_calc as
	procedure get_da(sal in number, jobtype in char, da out number);
	procedure GET_HRA(sal in number, deptno in number, hra out number);
	procedure GET_GROSS(sal in number, da in number, hra in number, gross out number);
	procedure GET_NET(gross in number, tax out number, net out number);
end payroll_calc;
/
create or replace package body Payroll_calc as
	procedure GET_DA(sal in number, jobtype in char,  da out number) is
	begin
		if jobtype = 'MANAGER' then
			select sal * 0.1 into da from dual;
		else
			select sal * 0.05 into da from dual;
		end if;
	end GET_DA;

	procedure GET_HRA(sal in number, deptno in number, hra out number) is
        begin
		if deptno = 10 then
			hra := sal * 0.2;
		else
			hra := sal * 0.07;
		end if;
        end GET_HRA;

	procedure GET_GROSS(sal in number, da in number, hra in number, gross out number) is
        begin
		gross := sal + da + hra;
        end GET_GROSS;

	procedure GET_NET(gross in number, tax out number, net out number) is
	begin
		if gross > 4000 then
			tax := 0.05;
		end if;
		if gross > 5000 then
			tax := tax + 0.02;
		end if;
		net := gross - gross*tax;
		dbms_output.put_line(net||' '||tax);
	end GET_NET;

end Payroll_calc;
/

declare
	cursor c1 is select * from emp;
	da number(8,2);
	hra number(8,2);
	gross number(10,2);
	net number(12,2);
	tax number(10,2);
begin
	for x in c1 loop
		Payroll_calc.GET_DA(x.sal, x.job, da);
		Payroll_calc.GET_HRA(x.sal, x.deptno, hra);
		Payroll_calc.GET_GROSS(x.sal, da, hra, gross);
		Payroll_calc.GET_NET(gross, tax, net);
		dbms_output.put_line('****************************************************');
		dbms_output.put_line('Name: '||x.ename||'     Designation: '||x.job||'       Dept.: '||x.deptno);
		dbms_output.put_line('Sal: '||x.sal||'     DA: '||da||'     HRA: '||hra||'     Gross: '||gross||'     Tax: '||tax||'     Net: '||net);
		dbms_output.put_line('****************************************************');
	end loop;
end;
/
