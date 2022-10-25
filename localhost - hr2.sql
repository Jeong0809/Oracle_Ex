SELECT count(*), sum(salary), avg(salary)
FROM employees;

select count(*), sum(salary), avg(nvl(salary,0))
from employees;

select department_id, avg(salary)
from employees
group by department_id
order by department_id asc;


select department_id, count(*), sum(salary)
from employees
group by department_id;

select department_id, job_id, count(*), sum(salary)
from employees
group by department_id, job_id;


--문제 1. 
--직원중에 최고임금(salary)과  최저임금을 “최고임금, “최저임금”프로젝션 타이틀로 
--함께 출력해 보세요. 두 임금의 차이는 얼마인가요?  
--“최고임금 ? 최저임금”이란 타이틀로 함께 출력해 보세요.

select max(salary) "최고임금", min(salary) "최저임금", max(salary)-min(salary) "최고임금-최저임금"
from employees;

--문제2.
--마지막으로 신입사원이 들어온 날은 언제 입니까? 다음 형식으로 출력해주세요.

select to_char(max(hire_date), 'yyyy"년" mm"월" dd"일"')
from employees;

--문제3.
--부서별로 평균임금, 최고임금, 최저임금을 부서(department_id)와 함께 출력하고 정렬순서는
--부서번호(department_id) 내림차순입니다.

select avg(salary), max(salary), min(salary), department_id
from employees
group by department_id
order by department_id desc;

--문제4.
--업무(job_id)별로 평균임금, 최고임금, 최저임금을 업무(job_id)와 함께 출력하고 
--정렬순서는 업무(job_id) 내림차순입니다.

select avg(salary), max(salary), min(salary)
from employees
group by job_id
order by job_id;

--문제5.
--가장 오래 근속한 직원의 입사일은 언제인가요? 다음 형식으로 출력해주세요.
select to_char(min(hire_date), 'yyyy"년" mm"월" dd"일"') 
from employees;

--문제6.
--평균임금과 최저임금의 차이가 2000 미만인 부서(department_id), 평균임금, 최저임금
--그리고 (평균임금 ? 최저임금)를 (평균임금 ? 최저임금)의 
--내림차순으로 정렬해서 출력하세요.
select department_id "부서", avg(salary) "평균", min(salary) "최저", avg(salary) - min(salary)
from employees
group by department_id
having  avg(salary) - min(salary) < 2000
order by avg(salary) - min(salary) desc;

--문제7.
--업무(Job_id)별로 최고임금과 최저임금의 차이를 출력해보세요.
--차이를 확인할 수 있도록 내림차순으로 정렬하세요

select max(salary)-min(salary)
from employees
group by job_id
order by max(salary)-min(salary) desc;

--직원의 이름, 부서, 팀을 출력하세요
--팀은 부서코드로 결정하며 부서코드가 10~50 이면 ‘A-TEAM’
--60~100이면 ‘B-TEAM’ 110~150이면 ‘C-TEAM’ 나머지는 ‘팀없음’ 으로 출력하세요

select last_name "이름",
        department_id "부서",
        case when department_id between 10 and 50 then 'A-TEAM'
               when department_id between 60 and 100 then 'B-TEAM'
               when department_id between 110 and 150 then 'C-TEAM'
               else '팀없음'
        end "팀"
from employees;


select first_name, em.department_id,
        department_name, de.department_id
from employees em, departments de
where em.department_id = de.department_id;

select e.first_name, j.job_title
from employees e, jobs j
where e.job_id = j.job_id;


select e.first_name, d.department_name, j.job_title
from employees e, departments d, jobs j
where e.department_id = d.department_id
and e.job_id = j.job_id;


select e.department_id, e.first_name, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+) ; 

select e.department_id, e.first_name, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id ;


select e.department_id, e.first_name, d.department_name
from employees e full outer join departments d
on e.department_id = d.department_id ; 

--각 사원에 대해서 사번(employee_id), 이름(first_name), 부서명(department_name), 
--매니저(manager)의 이름(first_name)을 조회하세요.
select e.employee_id, e.first_name, 
        d.department_name, e2.first_name
from employees e, departments d, employees e2
where e.manager_id = e2.employee_id
and e.department_id = d.department_id;

--문제2.
--지역(regions)에 속한 나라들을 지역이름(region_name), 나라이름(country_name)으로 
--출력하되 지역이름, 나라이름 순서대로 내림차순으로 정렬하세요.
select r.region_name, c.country_name
from regions r, countries c
where r.region_id =  c.region_id
order by 1 desc, 2 desc;

--문제3.
--각 부서(department)에 대해서 부서번호(department_id), 부서이름(department_name), 
--매니저(manager)의 이름(first_name), 위치(locations)한 도시(city), 나라(countries)의 
--이름(countries_name) 그리고 지역구분(regions)의 이름(region_name)까지 전부 출력해 보세요.


--문제4.
--‘Public Accountant’의 직책(job_title)으로 과거에 근무한 적이 있는 모든 사원의 사번과 이름을 출력하세요. 
--(현재 ‘Public Accountant’의 직책(job_title)으로 근무하는 사원은 고려하지 않습니다.) 
--이름은 first_name과 last_name을 합쳐 출력합니다.
select e.employee_id, e.first_name || ' ' || e.last_name
from employees e, jobs j, job_history h
where h.job_id = j.job_id
and e.employee_id = h.employee_id
and j.job_title = 'Public Accountant';


select e.employee_id, e.last_name, e.hire_date
from employees e, employees m
where e.manager_id = m.employee_id
and e.hire_date < m.hire_date
order by employee_id;












