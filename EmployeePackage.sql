CREATE OR REPLACE PACKAGE employee_pkg AS
  -- Functions
  FUNCTION employee_login 
  RETURN BOOLEAN;

  FUNCTION get_employee_details 
  RETURN CURSOR;

  FUNCTION get_job_information 
  RETURN CURSOR;

  FUNCTION get_assigned_complaints 
  RETURN CURSOR;

  -- Procedures
  PROCEDURE new_employee_registration;
  PROCEDURE terminate_employee;
  PROCEDURE assign_job;

END employee_pkg;
/
