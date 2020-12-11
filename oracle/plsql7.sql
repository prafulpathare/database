
set SERVEROUTPUT ON
set feedback off
set verify off
-- Question 1
accept sal number prompt 'Enter Sal : '
declare
	empv emp%rowtype;
begin
	select * into empv from emp where sal = &sal;
	dbms_output.put_line('Employee name : '||empv.ename);

exception
	when no_data_found then
		dbms_output.put_line('No Data Found');
	when too_many_rows then
		dbms_output.put_line('More than one record found.');
end;
/

-- Question 2
declare
	cursor c1 is select * from emp;
begin
	for empv in c1 loop
		if empv.sal > 9999.99 then
			raise VALUE_ERROR;
		end if;
	end loop;
exception
	when value_error then
		dbms_output.put_line('VALUE ERR');
end;
/

-- Question 3
declare
	cursor c1 is select ename, hiredate from emp;
	experience date;
begin
	for x in c1 loop
		select to_date((sysdate - x.hiredate)) into experience from dual;
		dbms_output.put_line(to_char(experience), 'dd-mon-yyyy');
	end loop;
exception
	when EXP_CHECK then
		dbms_output.put_line('LESS THAN 2 YRS OF EXPERIENCE');
end;
/

-- Questio 4
create or replace function is_triangle(s1 in number, s2 in number, s3 in number)
return number is
begin
        if s1 < (s2 + s3) and s2 < (s1+s3) and s3 < (s1+s2) then
                return 1;
        else
                return 0;
        end if;
end is_triangle;
/

accept s1 number prompt 'Side 1 : '
accept s2 number prompt 'Side 2 : '
accept s3 number prompt 'Side 3 : '
declare
begin
        if is_triangle(&s1, &s2, &s3) = 1 then
                dbms_output.put_line('Valid Traingle');
         else
             dbms_output.put_line('Invalid Traingle');
         end if;
end;
/

-- Question 5
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

-- Question 6
declare
        type len is record(
                yard number,
                feet number,
                inch number
        );
        len_1 len;
        len_2 len;
        len_1_1 number;
        len_1_2 number;
        len1 number := &ln1;
        len2 number := &ln2;
begin
        len_1.yard := len1/36;
        len_1.feet := len1 - len1/36*12;
        len_1.inch := len1 - (len_1.yard*36 + len_1.feet*36*12);

        len_2.yard := len2/36;
        len_2.feet := len2 - len1/36*12;
        len_2.inch := len2 - (len_2.yard*36 - len_2.feet*36*12);

        len_1_2 := len_2.yard*36 + len_2.feet*12 + len_2.inch;
        len_1_1 := len_1.yard*36 + len_1.feet*12 + len_1.inch;

        if len_1_1 > len_1_2 then
        	len_1.yard := (len_1_1 - len_1_2)/36;
		len_1.feet := (len_1_1 - len_1_2)/36*12;
		len_1.inch := len_1_1 - ((len_1_1 - len_1_2).yard - (len_1_1 - len_1_2).feet);

                dbms_output.put_line("Difference: "||len_1.yard||" yards, "||len_1.feet||" feet, "||len_1.inch||" inches");
        else
        	len_1.yard := (len_1_2 - len_1_1)/36;
		len_1.feet := (len_1_2 - len_1_1)/36*12;
		len_1.inch := len_1_2 - ((len_1_2 - len_1_1).yard - (len_1_2 - len_1_1).feet);

                dbms_output.put_line("Difference: "||len_1.yard||" yards, "||len_1.feet||" feet, "||len_1.inch||" inches");
        end if;
end;
/

-- Question 7

create or replace function revstr(str IN OUT varchar2)
return number as
len number:=length(str);
begin
for j in 1..len loop
	str := str||substr(str,len-j,1);
end loop;
str := substr(str,len);
str := substr(str,1,len-1);
dbms_output.put_line('Reverse: '||str);
return 1;
end;
/
declare
	vv number;
	str varchar2(20) := 'latin';

begin
	vv := revstr(str);
end;
/
