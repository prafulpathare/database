set serveroutput on
set verify on
set feedback on

create or replace function get_random_number
return number is
begin
	return round(dbms_random.value(0.5, 10.5), 0);
end get_random_number;
/


begin
	dbms_output.put_line('Random No.: '||get_random_number);
end;
/
