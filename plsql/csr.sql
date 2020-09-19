set serveroutput on
set verify off
set feedback off

declare
	cursor c1 is select * from emp;
	rowdata emp%rowtype;
begin
	open c1;
	loop
		fetch c1 into rowdata;
		if c1%notfound then exit; end if;
		dbms_output.put_line(rowdata.ENAME||' '||rowdata.EMPNO);
	end loop;
	close c1;
end;
/
