SET SERVEROUTPUT ON;

--PL/SQL
DECLARE
vno varchar2(20);
BEGIN 
        SELECT TO_CHAR(sysdate, 'YYYY/MM/DD') INTO vno
        FROM dual;
        DBMS_OUTPUT.PUT_LINE(VNO);
END;
/
--��������
--��� ���̺��� ����Ͽ� ����� �Է¹޾� 
--�ش� ����� ���, �̸�(fist_name), ������ ����ϼ���

DECLARE
v_empno employees.employee_id%TYPE;
v_name employees.first_name%TYPE;
v_sal  employees.salary%TYPE;
v_hire_date employees.hire_date%TYPE;

BEGIN
SELECT employee_id, first_name, salary, hire_date
INTO v_empno, v_name, v_sal, v_hire_date
FROM employees
WHERE employee_id = '&v_empno';
DBMS_OUTPUT.PUT_LINE(v_empno|| ' ' || v_name || ' ' || v_sal || ' ' ||v_hire_date);
END;
/

--�������� ) �ΰ��� ���ڸ� �Է¹޾� �հ踦 ����ϼ���
SET VERIFY OFF --�ÿ��ϴ� ������ �������� �ʴ´�.
DECLARE
v_no1 NUMBER := &no1;
v_no2 NUMBER := &no2;
v_sum NUMBER;

BEGIN
v_sum := v_no1 + v_no2;
DBMS_OUTPUT.PUT_LINE('ù��° ��: ' || v_no1||', �ι�° �� : '||v_no2||' , ���� : '||v_sum||' �Դϴ�');
END;
/

CREATE OR REPLACE PROCEDURE UPDATE_SALARY
( v_empno IN NUMBER )

IS

BEGIN
    UPDATE employees
    SET salary = salary * 1.1
    WHERE employee_id = v_empno;
    commit;
END UPDATE_SALARY;
/

SELECT e.EMPLOYEE_ID, e.FIRST_NAME, e.SALARY
FROM employees e
WHERE e.EMPLOYEE_ID = 114;

EXECUTE UPDATE_SALARY(114);
/

--Function
CREATE OR REPLACE FUNCTION FC_UPDATE_SALARY
(v_empno IN NUMBER)
RETURN NUMBER

IS

v_salary employees.salary%TYPE;

BEGIN

UPDATE EMPLOYEES
SET SALARY = 7800
WHERE EMPLOYEE_ID = v_empno;

COMMIT;

SELECT SALARY 
INTO v_salary
FROM EMPLOYEES
WHERE EMPLOYEE_ID = v_empno;

RETURN v_salary;

END;
/

SELECT first_name, salary
FROM EMPLOYEES
WHERE employee_id = 112;

VAR salary NUMBER;

EXECUTE :salary := FC_UPDATE_SALARY(112);

PRINT salary;


--�������� ) ��� ���̺��� ����Ͽ� ����� �Է¹޾� �ش� ����� ���, �̸�(fist_name), ������ ����ϼ���
--ROWTYPE ������ ����Ұ� !
create or replace PROCEDURE PRINT_EMP
( v_input employees.EMPLOYEE_ID%TYPE )

IS
v_row employees%ROWTYPE;

BEGIN

SELECT employee_id, first_name, salary, department_id
INTO v_row.employee_id, v_row.first_name, v_row.salary, v_row.department_id
FROM EMPLOYEES
WHERE EMPLOYEE_ID = v_input;
dbms_output.put_line
( v_row.employee_id||' '||v_row.first_name||' '||v_row.salary||' '||v_row.department_id);

END PRINT_EMP;
/

--Composite DataTypes : PL/SQL ���̺�
CREATE OR REPLACE PROCEDURE HR.TABLE_TEST
(v_deptno IN employees.DEPARTMENT_ID %TYPE)
IS
	-- ���̺��� ����
	TYPE empno_table IS TABLE OF employees.employee_id%TYPE INDEX BY BINARY_INTEGER;
	TYPE ename_table IS TABLE OF employees.first_name%TYPE INDEX BY BINARY_INTEGER;
	TYPE sal_table      IS TABLE OF employees.salary%TYPE INDEX BY BINARY_INTEGER;

	-- ���̺�Ÿ������ ���� ����
	empno_tab empno_table ; 
	ename_tab ename_table ; 
	sal_tab   sal_table;
	i BINARY_INTEGER := 0;
BEGIN   
	DBMS_OUTPUT.ENABLE;

	-- FOR ���� ���
                 -- ���⼭ emp_list�� ( BINARY_INTEGER�� ������) 1�� ����
	FOR emp_list IN ( SELECT employee_id, first_name, salary
		        FROM employees 
		      WHERE department_id = v_deptno ) LOOP
	      i := i + 1;
	      -- ���̺� ������ �˻��� ����� �ִ´�
		empno_tab(i) := emp_list.employee_id ;
		ename_tab(i) := emp_list.first_name ;
		sal_tab(i) := emp_list.salary ;
	END LOOP;
	
	-- 1���� i���� FOR ���� ����
	FOR cnt IN 1..i LOOP
		-- TABLE������ ���� ���� �ѷ���
		DBMS_OUTPUT.PUT_LINE( '�����ȣ : ' || empno_tab(cnt) ); 
		DBMS_OUTPUT.PUT_LINE( '����̸� : ' || ename_tab(cnt) ); 
		DBMS_OUTPUT.PUT_LINE( '����޿� : ' || sal_tab(cnt));
	END LOOP; 
END TABLE_TEST;
/
EXECUTE TABLE_TEST(100);

CREATE OR REPLACE PROCEDURE HR.RECORD_TEST(
p_eno IN employees.EMPLOYEE_ID%TYPE )
IS
	TYPE emp_record IS RECORD
	( v_eno NUMBER, 
	  v_nm  varchar2(30),
	  v_hdate DATE );
	
	emp_rec emp_record;
BEGIN
	DBMS_OUTPUT.ENABLE;
	
	SELECT e.EMPLOYEE_ID , 
	       e.FIRST_NAME||' '||e.LAST_NAME,
	       e.HIRE_DATE 
	INTO emp_rec.v_eno,
		 emp_rec.v_nm,
		 emp_rec.v_hdate
	FROM EMPLOYEES e 
	WHERE e.EMPLOYEE_ID = p_eno;

	DBMS_OUTPUT.PUT_LINE('��� ��ȣ :'|| emp_rec.v_eno);
	DBMS_OUTPUT.PUT_LINE('��� �̸� :'|| emp_rec.v_nm);
	DBMS_OUTPUT.PUT_LINE('�� �� �� :'|| emp_rec.v_hdate);

END RECORD_TEST;
/
EXECUTE RECORD_TEST(100);


--UPDATE
CREATE OR REPLACE PROCEDURE UPDATE_TEST
( v_empno IN employees.employee_id%TYPE,
  v_sal       IN employees.salary%TYPE )
  
IS
    v_emp employees%ROWTYPE;

BEGIN DBMS_OUTPUT.ENABLE;

    UPDATE employees
    SET salary = v_sal
    WHERE employee_id = v_empno;
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE( 'Data Update Success');
    
    SELECT employee_id, last_name, salary
    INTO v_emp.employee_id, v_emp.last_name, v_emp.salary
    FROM employees
    WHERE employee_id = v_empno;
    DBMS_OUTPUT.PUT_LINE(' ***Confirm Update Data***');
    DBMS_OUTPUT.PUT_LINE('EMP NO : ' || v_emp.employee_id);
    DBMS_OUTPUT.PUT_LINE('EMP NAME : ' || v_emp.last_name);
    DBMS_OUTPUT.PUT_LINE('EMP SALARY : ' || v_emp.salary);
END;
/
CALL HR.UPDATE_TEST(100, 50000);
    

--INSERT 
CREATE OR REPLACE PROCEDURE INSERT_TEST
( v_empno IN employees.employee_id%TYPE,
  v_ename IN employees.last_name%TYPE,
  v_email  IN employees.email%TYPE,
  v_job     IN employees.job_id%TYPE,
  v_deptno IN employees.department_id%TYPE )
  
IS

BEGIN DBMS_OUTPUT.ENABLE;

    INSERT INTO employees
    ( employee_id, last_name, email, job_id, hire_date, department_id)
    VALUES (v_empno, v_ename, v_email, v_job, sysdate, v_deptno);  
    COMMIT;    
   
    DBMS_OUTPUT.PUT_LINE('EMP NO : ' || v_empno);
    DBMS_OUTPUT.PUT_LINE('EMP NAME : ' || v_ename);
    DBMS_OUTPUT.PUT_LINE('EMP EMAIL : ' || v_email);
    DBMS_OUTPUT.PUT_LINE('EMP JOB : ' || v_job);
    DBMS_OUTPUT.PUT_LINE('EMP DEPT : ' || v_deptno);
    DBMS_OUTPUT.PUT_LINE('EMP DATA INSERT SUCCESS!');
END;
/
CALL HR.INSERT_TEST(500, 'BATMAN', 'batman@disney.com', 'MK_MAN', 20);








