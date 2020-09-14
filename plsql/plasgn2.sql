set serveroutput on
set feedback off
set verify off

accept name varchar2 prompt 'Name :       '
accept street varchar2 prompt 'Street :     '
accept city varchar2 prompt 'City   :     '
accept state varchar2 prompt 'State  :     '

declare
	type addr_type is record(
		name varchar2(20),
		street varchar2(30),
		city varchar2(20),
		state varchar2(15)
	);
	addr1 addr_type;
	addr2 addr_type;
	addr3 addr_type;
	addr4 addr_type;
begin
	for x in 1..4
	loop
		addr1 := '&name';
		addr1.street := '&street';
		addr1.city := '&city';
		addr1.state := '&state';
		dbms_output.put_line('***************************');
		dbms_output.put_line('Name      : '||addr1.name);
		dbms_output.put_line('Street    : '||addr1.street);
		dbms_output.put_line('City      : '||addr1.city);
		dbms_output.put_line('State     : '||addr1.state);
		dbms_output.put_line('***************************');
	end loop;	
end;
/
