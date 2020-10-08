set serveroutput on
set linesize 350

create or replace package hrpkg as
	function MaxSalDept(vdno number) return number;
	procedure PrintEmployee(veno in number);
	function SimpleInterest(p number, r number, n number) return number;
end hrpkg;
/


create or replace package body hrpkg as
	function MaxSalDept(vdno in number) return number is
		sl number(8,2);
	begin
		select max(sal) into sl from emp where deptno = vdno;
		return sl;
	end MaxSalDept;

	procedure PrintEmployee(veno in number) is
		x emp%rowtype;
	begin
		select * into x from emp where empno = veno;
		dbms_output.put_line('+++++++++++++++++++++++++++');
		dbms_output.put_line('Emp No.      : '||x.empno);
		dbms_output.put_line('Name         : '||x.ename);
		dbms_output.put_line('Salary       : '||x.sal);
		dbms_output.put_line('Hire Date    : '||x.hiredate);
		dbms_output.put_line('+++++++++++++++++++++++++++');
	end PrintEmployee;

	function SimpleInterest(p number, r number, n number) return number is
		intr number(4,2);
	begin
		return p * (1 + r * n);
	end SimpleInterest;
end hrpkg;
/


declare
	inte number(8,2);
begin
	dbms_output.put_line('Max Sal in Department no. 20 is '||hrpkg.MaxSalDept(20));
	hrpkg.PrintEmployee(7788);
	dbms_output.put_line('Simple Interest : '||hrpkg.SimpleInterest(10000, 0.8, 20));
end;
/
