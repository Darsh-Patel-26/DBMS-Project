CREATE OR REPLACE PACKAGE employee_pkg AS
  -- Functions
  FUNCTION employee_login (
    username IN VARCHAR2,
    password IN VARCHAR2
  ) RETURN BOOLEAN;

  FUNCTION get_employee_details (
    p_empno IN VARCHAR2
  ) RETURN CURSOR;

  FUNCTION get_job_information (
    p_empno IN VARCHAR2
  ) RETURN CURSOR;

  FUNCTION get_assigned_complaints (
    p_empno IN VARCHAR2
  ) RETURN CURSOR;

  -- Procedures
  PROCEDURE new_employee_registration (
    p_empno    IN VARCHAR2,
    p_ename    IN VARCHAR2,
    p_ephoneno IN VARCHAR2,
    p_eaddress IN VARCHAR2,
    p_gender   IN VARCHAR2,
    p_edob     IN DATE,
    p_epass    IN VARCHAR2
  );

  PROCEDURE terminate_employee (
    p_empno IN VARCHAR2
  );

  PROCEDURE assign_job (
    p_empno IN VARCHAR2,
    p_ejob  IN VARCHAR2
  );

END employee_pkg;


CREATE OR REPLACE PACKAGE BODY employee_pkg AS
  -- Functions
  FUNCTION employee_login (
    username IN VARCHAR2,
    password IN VARCHAR2
  ) RETURN BOOLEAN IS
    count NUMBER;
  BEGIN
    -- Check if the provided username and password match any employee record
    SELECT COUNT(*) INTO count
    FROM Emp_Info
    WHERE eemail = username
    AND epass = password;

    -- Return TRUE if a matching record is found, FALSE otherwise
    RETURN count > 0;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN FALSE;
  END employee_login;

  FUNCTION get_employee_details (
    p_empno IN VARCHAR2
  ) RETURN CURSOR IS
    v_cur CURSOR;
  BEGIN
    OPEN v_cur FOR
      SELECT *
      FROM Emp_Info
      WHERE empno = p_empno;

    RETURN v_cur;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN NULL;
  END get_employee_details;

  FUNCTION get_job_information (
    p_empno IN VARCHAR2
  ) RETURN CURSOR IS
    v_cur CURSOR;
  BEGIN
    OPEN v_cur FOR
      SELECT *
      FROM Emp_Job_Info
      WHERE empno = p_empno;

    RETURN v_cur;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN NULL;
  END get_job_information;

  FUNCTION get_assigned_complaints (
    p_empno IN VARCHAR2
  ) RETURN CURSOR IS
    v_cur CURSOR;
  BEGIN
    OPEN v_cur FOR
      SELECT *
      FROM Complaints
      WHERE assigned_empno = p_empno;

    RETURN v_cur;
  EXCEPTION
    WHEN OTHERS THEN
      RETURN NULL;
  END get_assigned_complaints;

  -- Procedures
  PROCEDURE new_employee_registration (
    p_ename    IN VARCHAR2,
    p_ephoneno IN VARCHAR2,
    p_eaddress IN VARCHAR2,
    p_gender   IN VARCHAR2,
    p_edob     IN DATE,
    p_epass    IN VARCHAR2
  ) IS
  BEGIN
    INSERT INTO Emp_Info (ename, ephoneno, eaddress, gender, edob, epass)
    VALUES (p_empno, p_ename, p_ephoneno, p_eaddress, p_gender, p_edob, p_epass);

    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
      ROLLBACK;
  END new_employee_registration;

  PROCEDURE terminate_employee (
    p_empno IN VARCHAR2
  ) IS
  BEGIN
    DELETE FROM Emp_Info WHERE empno = p_empno;
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
      ROLLBACK;
  END terminate_employee;

  PROCEDURE assign_job (
    p_empno IN VARCHAR2,
    p_ejob  IN VARCHAR2
  ) IS
  BEGIN
    INSERT INTO Emp_Job_Info (empno, ejob)
    VALUES (p_empno, p_ejob);
    COMMIT;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
      ROLLBACK;
  END assign_job;

END employee_pkg;

