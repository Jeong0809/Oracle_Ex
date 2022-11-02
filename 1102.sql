SELECT *
FROM EMPLOYEES e
WHERE DEPARTMENT_ID = 50;

create or replace view emp_v1 as
select *
from employees e
where department_id = 50;

select * 
from emp_v1;

select * from emp_v1
where salary > 2500;

create or replace view emp_v2 as
select e.employee_id, e.first_name,
        e.last_name, e.salary
from employees e
where department_id = 10
UNION
select e.employee_id, e.first_name,
        e.last_name, e.salary
from employees e
where department_id = 20;

SELECT *
FROM emp_v2;

select * 
from employees e
where e.department_id IN (10, 20);

SET AUTOTRACE TRACEONLY EXPLAIN;

SELECT A.EMPLOYEE_ID, A.FIRST_NAME, B.DEPARTMENT_ID
FROM EMPLOYEES A, DEPARTMENTS B
WHERE A.DEPARTMENT_ID = b.department_id;

SELECT /*+ use_merge(E, D) */ 
        e.employee_id, e.first_name, d.department_name
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = d.department_id;







