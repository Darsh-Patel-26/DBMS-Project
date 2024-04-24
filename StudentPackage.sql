-- Specification
CREATE OR REPLACE PACKAGE student_pkg AS
  -- Functions
  FUNCTION student_login 
  RETURN BOOLEAN;

  FUNCTION get_student_details 
  RETURN CURSOR;

  FUNCTION get_student_leave_details 
  RETURN CURSOR;

  FUNCTION get_room_details 
  RETURN CURSOR;

  FUNCTION get_feedback_details 
  RETURN CURSOR;

  FUNCTION get_complain_details 
  RETURN CURSOR;

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
    username Stud_Password.semail%TYPE;
    password Stud_Password.spass%TYPE;
  BEGIN
    -- Prompt the user to enter username
    DBMS_OUTPUT.PUT_LINE('Enter your username(email):');
    username := '&username';

    -- Prompt the user to enter password
    DBMS_OUTPUT.PUT_LINE('Enter your password:');
    password := '&password';

    -- Check if the provided username and password match any student record
    SELECT COUNT(*) INTO count
    FROM Student_Info
    WHERE semail = '&username'
    AND spass = '&password';

    -- Return TRUE if a matching record is found, FALSE otherwise
    RETURN count > 0;

  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('An error occurred');
      RETURN FALSE;

  END student_login;

  FUNCTION get_student_details_by_rollno
  RETURN CURSOR IS
  DECLARE
    v_rollno Stud_Info.rollno%TYPE;
    v_cur CURSOR;
  BEGIN
    DBMS_OUTPUT.PUT_LINE('Enter Roll No. :');
    v_rollno := '&v_rollno';

    -- Open the cursor for the specified roll number
    OPEN v_cur FOR
      SELECT si.*, se.semail, sr.rm_no
      FROM Stud_Info si
      LEFT JOIN Stud_Email se ON si.rollno = se.rollno
      LEFT JOIN Stud_Rooms sr ON si.rollno = sr.rollno
      WHERE si.rollno = v_rollno;

    RETURN v_cur;
  EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred');
        RETURN NULL;
  END get_student_details_by_rollno;

  FUNCTION get_student_leave_details 
  RETURN CURSOR IS
  DECLARE
    cur CURSOR;
    v_rollno Stud_Info.rollno%TYPE;
  BEGIN
    -- Implementation for getting student leave details
    DBMS_OUTPUT.PUT_LINE('Enter Roll No. :');
    v_rollno := '&v_rollno';

    OPEN cur FOR
    SELECT * FROM Leave
    WHERE rollno = v_rollno;

    RETURN cur;

  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('An error occurred');
      RETURN NULL;
  END get_student_leave_details;

  FUNCTION get_room_details 
  RETURN CURSOR IS
  DECLARE
    cur CURSOR;
    v_rollno Stud_Info.rollno%TYPE;
    v_rm_no Rooms.rm_no%TYPE;
  BEGIN
    -- Implementation for getting room details
    DBMS_OUTPUT.PUT_LINE('Enter Roll No. :');
    v_rollno := '&v_rollno';

    SELECT rm_no INTO v_rm_no
    FROM Stud_Rooms
    WHERE rollno = v_rollno;

    OPEN cur FOR
    SELECT * FROM Rooms
    WHERE rm_no = v_rm_no;
    RETURN cur;
  
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('An error occurred');
      RETURN NULL;
  END get_room_details;

  FUNCTION get_feedback_details 
  RETURN CURSOR IS
  DECLARE
    cur CURSOR;
    v_rollno Stud_Info.rollno%TYPE;
  BEGIN
    -- Implementation for getting feedback details
    DBMS_OUTPUT.PUT_LINE('Enter Roll No. :');
    v_rollno := '&v_rollno';

    OPEN cur FOR
    SELECT * FROM Feedback
    WHERE rollno = v_rollno;

    RETURN cur;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('An error occurred');
      RETURN NULL;
  END get_feedback_details;

  FUNCTION get_complain_details 
  RETURN CURSOR IS
  DECLARE
    cur CURSOR;
    v_rollno Stud_Info.rollno%TYPE;
  BEGIN
    -- Implementation for getting complain details
    DBMS_OUTPUT.PUT_LINE('Enter Roll No. :');
    v_rollno := '&v_rollno';

    OPEN cur FOR
    SELECT * FROM Complain
    WHERE rollno = v_rollno;

    RETURN cur;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('An error occurred');
      RETURN NULL;
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
