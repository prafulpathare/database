set serveroutput on
set feedback off
set verify off

accept dept_num number prompt 'Enter Sal : '
declare
	cursor c1(dept_num number) is select * from employee where deptno = dept_num;
	x c1%rowtype;
begin
	open c1(&dept_num);
	loop
		fetch c1 into x;
		exit when c1%notfound;
		dbms_output.put_line(x.ename||' '||x.sal||' '||x.hiredate);
	end loop;
	close c1;
end;
/

declare
	cursor c1 is select * from employee FOR UPDATE;
	x c1%rowtype;
	updated_sal number(7,2);
begin
	open c1;
	loop
		fetch c1 into x;
		exit when c1%notfound;

		if x.deptno = 10 then
			updated_sal := x.deptno * 1.1;
		elsif x.deptno = 20 then
			updated_sal := x.deptno * 1.2;
		elsif x.deptno = 30 then
			updated_sal := x.deptno * 1.3;
		else
			updated_sal := x.deptno * 1.25;
		end if;
		update employee set sal = updated_sal WHERE CURRENT OF c1;
	end loop;
	commit;
	close c1;
end;
/
