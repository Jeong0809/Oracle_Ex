select * from employees;

select first_name from employees;

SELECT * FROM DEPARTMENTS D;

SELECT employee_id, first_name FROM employees;

SELECT first_name, last_name, salary, phone_number, email, hire_date FROM employees;

SELECT e.first_name "이름",
       e.last_name as 성
FROM EMPLOYEES e;

--안녕?

SELECT first_name || ' ' || last_name as 이름
FROM employees;

select first_name || ' hire date is ' || hire_date
from employees;

select first_name, salary, salary*12, (salary+300)*12
from employees;

SELECT e.first_name || '-' || e.last_name "성명",
       e.salary "급여",
       e.salary*12 "연봉",
       e.salary*12 + 5000 "연봉2",
       e.phone_number "전화번호"
FROM employees e;

SELECT *
FROM employees
WHERE department_id = 30;

SELECT last_name, salary "급여", salary*12 "연봉"
FROM employees
WHERE salary >= 15000;

SELECT last_name, hire_date
FROM employees
WHERE hire_date > '2007-01-01';

SELECT TO_CHAR(e.HIRE_DATE, 'yy/dd/mm')
FROM employees e;

SELECT first_name, salary
FROM employees
WHERE salary >= 14000
AND salary <= 17000;

select first_name, last_name, salary
from employees
where salary in (2100, 3100, 4100, 5100);

select first_name, last_name, salary
from employees
where first_name like '%is%';

--SELECT salary
--FROM employees
--WHERE salary between 13000 and 15000;

select first_name, salary, commission_pct
from employees
where commission_pct is null;

SELECT first_name, salary
from employees
--WHERE salary >= 9000
order by 2 desc;

SELECT department_id, salary, first_name
FROM employees
ORDER BY department_id asc;

SELECT first_name, salary 
FROM employees
WHERE salary >= 5000
ORDER BY salary desc;

SELECT department_id, salary, first_name
FROM employees
ORDER BY 1 asc, 2 desc;

SELECT email, initcap(email), department_id
FROM employees
WHERE department_id = 100;

select first_name, 
lpad(first_name,10,'*'), 
rpad(first_name,10,'*')
from employees;

select first_name, 
replace(first_name, 'e', '*') 
from employees
where department_id =100;

SELECT round(123.346, 2) "r2",
          round(123.646, 0) "r0"          
FROM dual;

SELECT sysdate FROM dual;

select sysdate
from employees;

SELECT hire_date, months_between(sysdate, hire_date)
FROM employees
WHERE department_id = 110;

SELECT months_between(sysdate, '2022/01/01') FROM dual;

SELECT first_name, to_char(salary*12, '$999,999.99') "SAL"
FROM employees
WHERE department_id = 110;

SELECT sysdate,
        to_char(sysdate, 'YYYY"년"MM"월"DD"일" HH24"시"MI"분"SS"초"')
FROM dual;


SELECT first_name || ' ' || last_name "이름", salary "월급", phone_number "전화번호", hire_date "입사일"
FROM employees e
ORDER BY hire_date ASC;


SELECT job_id, salary
FROM employees
ORDER BY 2 desc;


SELECT last_name, manager_id, commission_pct, salary
FROM employees
WHERE salary > 3000 and
manager_id is not null and
commission_pct is null
ORDER BY 4 asc;


SELECT job_title, max_salary
FROM jobs
WHERE max_salary >= 10000
ORDER BY max_salary DESC;


SELECT first_name, salary, nvl(commission_pct, 0)
FROM employees
WHERE salary < 14000 and salary >= 10000
ORDER BY 2 DESC;


SELECT last_name, salary, to_char(hire_date, 'yyyy-mm'), department_id
FROM employees
WHERE department_id IN(10, 90, 100);

SELECT first_name, salary
FROM employees
WHERE  first_name like '%s%' or  first_name like '%S%';

SELECT department_name
FROM departments
ORDER BY length(department_name) desc;

SELECT UPPER(country_name)
FROM countries
WHERE length(country_name) > 0;

SELECT last_name, salary, replace(phone_number, '.', '-'), hire_date
FROM employees
WHERE hire_date <= '2003-12-31';







