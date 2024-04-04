CREATE OR REPLACE PACKAGE student_pkg AS
  -- Functions
  FUNCTION student_login 
  RETURN BOOLEAN;

  FUNCTION get_student_details 
  RETURN SYS_REFCURSOR;

  FUNCTION get_student_leave_details 
  RETURN SYS_REFCURSOR;

  FUNCTION get_room_details 
  RETURN SYS_REFCURSOR;

  FUNCTION get_feedback_details 
  RETURN SYS_REFCURSOR;

  FUNCTION get_complain_details 
  RETURN SYS_REFCURSOR;

  -- Procedures
  PROCEDURE new_student_registration;
  PROCEDURE cancel_admission;
  PROCEDURE lodge_complain;
  PROCEDURE submit_feedback;
  PROCEDURE apply_for_leave;

END student_pkg;
/