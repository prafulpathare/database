SET SERVEROUTPUT ON
SET VERIFY OFF
SET FEEDBACK OFF

DECLARE
	x EMP%rowtype;
	incr number(4);
	high_sal exception;
BEGIN
	select * into x from emp where empno = &EMP_ID;
	if x.sal >= 4000 then
		raise high_sal;
	else
		incr := &INCREMENT_SAL;
		dbms_output.put_line('Previous Sal   '||x.sal);
		
		update emp set sal = sal + incr where empno = x.empno;
		commit;
		select * into x from emp where empno = x.empno;
		dbms_output.put_line('Sal Updated to '||x.sal);
	end if;
EXCEPTION
	when high_sal then dbms_output.put_line('Sal is already >= 4000 i.e. '||x.sal);
END;
/
