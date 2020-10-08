-- 1. Create a view for the employees belonging to department 20.
create or replace view emp_dept20 as
	select * from emp where deptno = 20;

-- 2. List all the employees from department 20.
select * from praful.emp_dept20;

/*
3. CREATE VIEW empview AS SELECT empno, count(*) Total_Increments FROM incr GROUP BY empno;
   (Whenever increment is given to an employee details of  employee and increment amount is
    stored in incr table, Structure of incr table is as under: Eno  number, Incramt number)
*/
create or replace view as
	select empno, count(*) Total_Increments from incr group by empno;

/*
4. CREATE VIEW empdept30 AS SELECT empno, ename, deptno FROM emp WHERE deptno = 30;
*/
create or replace view empdept30 as
	select empno, ename, deptno from emp where deptno = 30;

-- 5. Add an employee with empno (1234),  ename (JOHN), deptno (20) using the View from EX4.
insert into empdept30(empno, ename, deptno) values (1234, 'JOHN', 20);


/*
6. Is it possible to view this record using View in ex4?
   YES, its possible.
*/
select * from empdept20;

/*
7. Is it possible to restrict such update operations? If Yes, then How?
with check option it is possible to update 
create or replace view empdept30 as
	select empno, ename, deptno from emp where deptno = 30
	with check option;
*/
create or replace view empdept30 as
        select empno, ename, deptno from emp where deptno = 30
        with check option;

/*
8. Can a view be created on join? Give Example. Can this view be updated.
	We can create a view based on join.
	We cannot update the records using views as NO DML operations are allowed on views created with JOIN
*/
