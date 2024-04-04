-- Specification
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

-- Body
CREATE OR REPLACE PACKAGE BODY student_pkg AS
  -- Functions
  FUNCTION student_login 
  RETURN BOOLEAN IS
  DECLARE
    count NUMBER;
  BEGIN
    -- Prompt the user to enter username
    DBMS_OUTPUT.PUT_LINE('Enter your username:');
    &username VARCHAR2(100);

    -- Prompt the user to enter password
    DBMS_OUTPUT.PUT_LINE('Enter your password:');
    &password VARCHAR2(100);

    -- Check if the provided username and password match any student record
    SELECT COUNT(*) INTO count
    FROM Student_Info
    WHERE semail = '&username'
    AND spass = '&password';

    -- Return TRUE if a matching record is found, FALSE otherwise
    RETURN count > 0;

  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
      RETURN FALSE;

  END student_login;

  FUNCTION get_student_details 
  RETURN SYS_REFCURSOR IS
    cur SYS_REFCURSOR;
  BEGIN
    -- Implementation for getting student details
    OPEN cur FOR
    SELECT * FROM Student; -- Placeholder, replace with actual query
    RETURN cur;
  END get_student_details;

  FUNCTION get_student_leave_details 
  RETURN SYS_REFCURSOR IS
    cur SYS_REFCURSOR;
  BEGIN
    -- Implementation for getting student leave details
    OPEN cur FOR
    SELECT * FROM Student_Leave; -- Placeholder, replace with actual query
    RETURN cur;
  END get_student_leave_details;

  FUNCTION get_room_details 
  RETURN SYS_REFCURSOR IS
    cur SYS_REFCURSOR;
  BEGIN
    -- Implementation for getting room details
    OPEN cur FOR
    SELECT * FROM Rooms; -- Placeholder, replace with actual query
    RETURN cur;
  END get_room_details;

  FUNCTION get_feedback_details 
  RETURN SYS_REFCURSOR IS
    cur SYS_REFCURSOR;
  BEGIN
    -- Implementation for getting feedback details
    OPEN cur FOR
    SELECT * FROM Feedback; -- Placeholder, replace with actual query
    RETURN cur;
  END get_feedback_details;

  FUNCTION get_complain_details 
  RETURN SYS_REFCURSOR IS
    cur SYS_REFCURSOR;
  BEGIN
    -- Implementation for getting complain details
    OPEN cur FOR
    SELECT * FROM Complain; -- Placeholder, replace with actual query
    RETURN cur;
  END get_complain_details;

  -- Procedures
  PROCEDURE new_student_registration IS
  BEGIN
    -- Implementation for new student registration
    NULL; -- Placeholder, replace with actual logic
  END new_student_registration;

  PROCEDURE cancel_admission IS
  BEGIN
    -- Implementation for cancelling admission
    NULL; -- Placeholder, replace with actual logic
  END cancel_admission;

  PROCEDURE lodge_complain IS
  BEGIN
    -- Implementation for lodging a complaint
    NULL; -- Placeholder, replace with actual logic
  END lodge_complain;

  PROCEDURE submit_feedback IS
  BEGIN
    -- Implementation for submitting feedback
    NULL; -- Placeholder, replace with actual logic
  END submit_feedback;

  PROCEDURE apply_for_leave IS
  BEGIN
    -- Implementation for applying for leave
    NULL; -- Placeholder, replace with actual logic
  END apply_for_leave;

END student_pkg;
/
