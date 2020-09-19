set serveroutput on;
set feedback off;
set verify off;

declare
	i number(4) := 1;
begin
	for i in 1..1000
	loop
		if REMAINDER(i, 100) = 0 then
			dbms_output.put_line(i);
		end if;
	end loop;
	dbms_output.put_line('-------------------------');
end;
/

declare
	i number(3) := 235;
	scn number(8) := 0;
begin
	for num in 1..999
	loop
		scn := 0;
		for x in reverse 1..LENGTH(num)
		loop
			scn := scn + mod(num, 10)**3;
			i := trunc(num / 10);
		end loop;
		if scn = num then
			dbms_output.put_line(num);
		end if;
	end loop;
	dbms_output.put_line('-------------------------');
end;
/

accept iminrad number prompt 'Min. Radius : '
accept imaxrad number prompt 'Max. Radius : '
accept iincfact number prompt 'Incremental factor : '
declare
	minrad number(4);
	maxrad number(4);
	incfact number(2);
begin
	minrad := &iminrad;
	maxrad := &imaxrad;
	incfact := &iincfact;
	if maxrad < minrad then
		minrad := minrad+maxrad;
		maxrad := minrad-maxrad;
		minrad := minrad-maxrad;
	end if;

	while minrad <= maxrad
	loop
		dbms_output.put_line('*********************************');
		dbms_output.put_line('For Radius = '||minrad);
		dbms_output.put_line('     Circumference : '||ROUND((6.2832*minrad), 2));
		dbms_output.put_line('     Area          : '||ROUND((4*minrad**2), 2));
		dbms_output.put_line('     Volume        : '||ROUND(((4/3*3.14)*minrad**3), 2));
		minrad := minrad+incfact;
	end loop;
	dbms_output.put_line('-------------------------');
end;
/

accept intg number prompt 'Enter no. '
declare
	ntg number(10);
	cntr number(4) := 0;
begin
	ntg := &intg;

	while ntg <= 1000000
	loop
		ntg := ntg*2;
		cntr := cntr + 1;
	end loop;
	dbms_output.put_line(cntr||' times numbers needs to be doubled to reach 1 Million');
end;
/

accept istr char prompt 'String : '
declare
	strr varchar2(30);
	tmp varchar(30) := '';
	revstr varchar2(30) := '';
begin
	strr := '&istr';

	for i in reverse 1..length(strr)
	loop
		tmp := substr('&istr', i, 1);
		revstr := revstr||''||tmp;
	end loop;

	if strr = revstr then
		dbms_output.put_line(strr||' is a Palindrome.');
	else
		dbms_output.put_line(strr||' is not a Palindrome.');
	end if;
end;
/

accept inum number prompt 'Number : '
declare
	num1 number(10);
	rr number(10);
	outnum varchar2(50) := '';
begin
	num1 := &inum;
	
	while num1 <> 0 loop
		rr := mod(num1, 10);
		dbms_output.put_line(num1||' '||rr);
		num1 := trunc(num1/10);
	end loop;
	
		dbms_output.put_line('-----------------------------------------');
end;
/
