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


--���� 1. 
--�����߿� �ְ��ӱ�(salary)��  �����ӱ��� ���ְ��ӱ�, �������ӱݡ��������� Ÿ��Ʋ�� 
--�Բ� ����� ������. �� �ӱ��� ���̴� ���ΰ���?  
--���ְ��ӱ� ? �����ӱݡ��̶� Ÿ��Ʋ�� �Բ� ����� ������.

select max(salary) "�ְ��ӱ�", min(salary) "�����ӱ�", max(salary)-min(salary) "�ְ��ӱ�-�����ӱ�"
from employees;

--����2.
--���������� ���Ի���� ���� ���� ���� �Դϱ�? ���� �������� ������ּ���.

select to_char(max(hire_date), 'yyyy"��" mm"��" dd"��"')
from employees;

--����3.
--�μ����� ����ӱ�, �ְ��ӱ�, �����ӱ��� �μ�(department_id)�� �Բ� ����ϰ� ���ļ�����
--�μ���ȣ(department_id) ���������Դϴ�.

select avg(salary), max(salary), min(salary), department_id
from employees
group by department_id
order by department_id desc;

--����4.
--����(job_id)���� ����ӱ�, �ְ��ӱ�, �����ӱ��� ����(job_id)�� �Բ� ����ϰ� 
--���ļ����� ����(job_id) ���������Դϴ�.

select avg(salary), max(salary), min(salary)
from employees
group by job_id
order by job_id;

--����5.
--���� ���� �ټ��� ������ �Ի����� �����ΰ���? ���� �������� ������ּ���.
select to_char(min(hire_date), 'yyyy"��" mm"��" dd"��"') 
from employees;

--����6.
--����ӱݰ� �����ӱ��� ���̰� 2000 �̸��� �μ�(department_id), ����ӱ�, �����ӱ�
--�׸��� (����ӱ� ? �����ӱ�)�� (����ӱ� ? �����ӱ�)�� 
--������������ �����ؼ� ����ϼ���.
select department_id "�μ�", avg(salary) "���", min(salary) "����", avg(salary) - min(salary)
from employees
group by department_id
having  avg(salary) - min(salary) < 2000
order by avg(salary) - min(salary) desc;

--����7.
--����(Job_id)���� �ְ��ӱݰ� �����ӱ��� ���̸� ����غ�����.
--���̸� Ȯ���� �� �ֵ��� ������������ �����ϼ���

select max(salary)-min(salary)
from employees
group by job_id
order by max(salary)-min(salary) desc;

--������ �̸�, �μ�, ���� ����ϼ���
--���� �μ��ڵ�� �����ϸ� �μ��ڵ尡 10~50 �̸� ��A-TEAM��
--60~100�̸� ��B-TEAM�� 110~150�̸� ��C-TEAM�� �������� ���������� ���� ����ϼ���

select last_name "�̸�",
        department_id "�μ�",
        case when department_id between 10 and 50 then 'A-TEAM'
               when department_id between 60 and 100 then 'B-TEAM'
               when department_id between 110 and 150 then 'C-TEAM'
               else '������'
        end "��"
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

--�� ����� ���ؼ� ���(employee_id), �̸�(first_name), �μ���(department_name), 
--�Ŵ���(manager)�� �̸�(first_name)�� ��ȸ�ϼ���.
select e.employee_id, e.first_name, 
        d.department_name, e2.first_name
from employees e, departments d, employees e2
where e.manager_id = e2.employee_id
and e.department_id = d.department_id;

--����2.
--����(regions)�� ���� ������� �����̸�(region_name), �����̸�(country_name)���� 
--����ϵ� �����̸�, �����̸� ������� ������������ �����ϼ���.
select r.region_name, c.country_name
from regions r, countries c
where r.region_id =  c.region_id
order by 1 desc, 2 desc;

--����3.
--�� �μ�(department)�� ���ؼ� �μ���ȣ(department_id), �μ��̸�(department_name), 
--�Ŵ���(manager)�� �̸�(first_name), ��ġ(locations)�� ����(city), ����(countries)�� 
--�̸�(countries_name) �׸��� ��������(regions)�� �̸�(region_name)���� ���� ����� ������.


--����4.
--��Public Accountant���� ��å(job_title)���� ���ſ� �ٹ��� ���� �ִ� ��� ����� ����� �̸��� ����ϼ���. 
--(���� ��Public Accountant���� ��å(job_title)���� �ٹ��ϴ� ����� ������� �ʽ��ϴ�.) 
--�̸��� first_name�� last_name�� ���� ����մϴ�.
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












