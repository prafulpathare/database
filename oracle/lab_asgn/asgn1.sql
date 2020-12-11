set serveroutput on
/*
1) Static cursor / Dynamic cursor
Dynamic cursor is a cursor with parameters.

Write a PL/SQL  block which displays the information
of all employees belonging to a particular dept no. 10

Input will be deptno
Output will be Details of All Employee belonging to 
that deptno

Use Cursors with parameters
*/
accept dptnum number prompt 'Enter Department No.: '
declare
	cursor c1(dptno number) is select * from emp where deptno = dptno;
begin
	for x in c1(&dptnum) loop
		dbms_output.put_line('EMP NO.     : '||x.empno);
		dbms_output.put_line('NAME        : '||x.ename);
		dbms_output.put_line('JOB         : '||x.job);
		dbms_output.put_line('MGR         : '||x.mgr);
		dbms_output.put_line('HIREDATE    : '||x.hiredate);
		dbms_output.put_line('SALARY.     : '||x.sal);
		dbms_output.put_line('****************************');
	end loop;
end;
/


/*
2) Write a cursor based PL/SQL block which increases the salary 
   of the employee based on his deptno.
   for deptno 10, increase to be 10% 
   for deptno 20, increase to be 20% 
   for deptno 30, increase to be 30%
   others increase must be 25%
*/

declare
	cursor c1 is select * from emp FOR UPDATE;
	newsal number(8,2);
begin
	for x in c1 loop
		if x.deptno = 10 then
			newsal := x.sal * 1.1;
		elsif x.deptno = 20 then
			newsal := x.sal  * 1.2;
		elsif x.deptno = 30 then
			newsal := x.sal * 1.3;
		end if;

		update emp set sal = newsal where empno = x.empno;
	end loop;
end;
/
