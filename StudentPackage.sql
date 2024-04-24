-- Specification
CREATE OR REPLACE PACKAGE student_pkg AS
  FUNCTION student_login (
    username IN VARCHAR2,
    password IN VARCHAR2
  ) RETURN BOOLEAN;

  FUNCTION get_student_details (
    v_rollno IN Stud_Info.rollno%TYPE
  ) RETURN CURSOR;

  FUNCTION get_student_leave_details (
    v_rollno IN Stud_Info.rollno%TYPE
  ) RETURN CURSOR;

  FUNCTION get_room_details (
    v_rollno IN Stud_Info.rollno%TYPE
  ) RETURN CURSOR;

  FUNCTION get_feedback_details (
    v_rollno IN Stud_Info.rollno%TYPE
  ) RETURN CURSOR;

  FUNCTION get_complain_details (
    v_rollno IN Stud_Info.rollno%TYPE
  ) RETURN CURSOR;

  -- Procedures
  PROCEDURE new_student_registration;

  PROCEDURE cancel_admission (
    p_roll_number IN NUMBER
  );

  PROCEDURE lodge_complain (
    p_rollno         IN VARCHAR2,
    p_complaint_type IN VARCHAR2
  );

  PROCEDURE submit_feedback (
    p_rollno   IN VARCHAR2,
    p_feedback IN VARCHAR2,
    p_rating   IN NUMBER
  );

  PROCEDURE apply_for_leave (
    p_rollno      IN VARCHAR2,
    p_leave_dt    IN DATE,
    p_address     IN VARCHAR2,
    p_reason      IN VARCHAR2,
    p_no_of_day   IN NUM
  );
END student_pkg;
/

-- Body
CREATE OR REPLACE PACKAGE BODY student_pkg AS
  -- Functions
  FUNCTION student_login  (
    username IN VARCHAR2,
    password IN VARCHAR2
  ) RETURN BOOLEAN IS
  DECLARE
    count NUMBER;
  BEGIN
    -- Check if the provided username and password match any student record
    SELECT COUNT(*) INTO count
    FROM Student_Info
    WHERE semail = username
    AND spass = password;

    -- Return TRUE if a matching record is found, FALSE otherwise
    RETURN count > 0;

  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('An error occurred : ' || SQLERRM);
      RETURN FALSE;

  END student_login;

  FUNCTION get_student_details_by_rollno (
    v_rollno IN Stud_Info.rollno%TYPE
  ) RETURN CURSOR IS
  DECLARE
    v_cur CURSOR;
  BEGIN
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
        DBMS_OUTPUT.PUT_LINE('An error occurred : ' || SQLERRM);
        RETURN NULL;
  END get_student_details_by_rollno;

  FUNCTION get_student_leave_details (
    v_rollno IN Stud_Info.rollno%TYPE
  ) RETURN CURSOR IS
  DECLARE
    cur CURSOR;
  BEGIN

    OPEN cur FOR
    SELECT * FROM Leave
    WHERE rollno = v_rollno;

    RETURN cur;

  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('An error occurred : ' || SQLERRM);
      RETURN NULL;
  END get_student_leave_details;

  FUNCTION get_room_details (
    v_rollno IN Stud_Info.rollno%TYPE
  ) RETURN CURSOR IS
  DECLARE
    cur CURSOR;
  BEGIN
    SELECT rm_no INTO v_rm_no
    FROM Stud_Rooms
    WHERE rollno = v_rollno;

    OPEN cur FOR
    SELECT * FROM Rooms
    WHERE rm_no = v_rm_no;
    RETURN cur;
  
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('An error occurred : ' || SQLERRM);
      RETURN NULL;
  END get_room_details;

  FUNCTION get_feedback_details (
    v_rollno IN Stud_Info.rollno%TYPE
  ) RETURN CURSOR IS
  DECLARE
    cur CURSOR;
  BEGIN
    OPEN cur FOR
    SELECT * FROM Feedback
    WHERE rollno = v_rollno;

    RETURN cur;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('An error occurred : ' || SQLERRM);
      RETURN NULL;
  END get_feedback_details;

  FUNCTION get_complain_details (
    v_rollno IN Stud_Info.rollno%TYPE
  ) RETURN CURSOR IS
  DECLARE
    cur CURSOR;
  BEGIN
    OPEN cur FOR
    SELECT * FROM Complain
    WHERE rollno = v_rollno;

    RETURN cur;
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('An error occurred : ' || SQLERRM);
      RETURN NULL;
  END get_complain_details;

  -- Procedures

  PROCEDURE new_student_registration IS
  BEGIN
    -- Implementation for new student registration
    NULL; -- Placeholder, replace with actual logic
  END new_student_registration;

  PROCEDURE cancel_admission (
    p_roll_number IN NUMBER
    ) IS
  BEGIN
    -- Attempt to delete the student from the student table
    DELETE FROM Stud_Info WHERE rollno = p_roll_number;

    -- Commit the transaction
    COMMIT;
    
    EXCEPTION
    -- Handle exceptions
    WHEN NO_DATA_FOUND THEN
      -- Handle the case where no student with the provided roll number is found
      DBMS_OUTPUT.PUT_LINE('No student found with roll number ' || p_roll_number);
    WHEN OTHERS THEN
        -- Handle any other exceptions
      DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
      ROLLBACK; -- Rollback the transaction to maintain data consistency
  END cancel_admission;

  PROCEDURE lodge_complain (
    p_rollno          IN VARCHAR2,
    p_complaint_type  IN VARCHAR2
  ) IS
    BEGIN
    -- Step 1: Input Validation (if necessary)
    -- This could include checking if the provided roll number exists in the Stud_Info table

    -- Step 2: Insert into Database
      INSERT INTO Complain (rollno, com_type, is_done)
      VALUES (p_rollno, p_complaint_type, NULL);

    -- Step 3: Logging (Optional)
    -- Add logging logic here if needed

    COMMIT; -- Commit the transaction

    EXCEPTION
    WHEN OTHERS THEN
        -- Handle any exceptions that might occur
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
        ROLLBACK; -- Rollback the transaction to maintain data consistency
  END lodge_complain;

  PROCEDURE submit_feedback (
    p_rollno        IN VARCHAR2,
    p_feedback      IN VARCHAR2,
    p_rating IN NUMBER  -- Added parameter for feedback rating
  ) IS
    BEGIN
      -- Step 1: Input Validation (if necessary)
      -- This could include checking if the provided roll number exists in the Stud_Info table

      -- Step 2: Insert into Database
      INSERT INTO HR.Feedback (rollno, feedback, rating)
      VALUES (p_rollno, p_feedback, p_rating);


    -- Step 3: Logging (Optional)
    -- Add logging logic here if needed

      COMMIT; -- Commit the transaction

    EXCEPTION
      WHEN OTHERS THEN
        -- Handle any exceptions that might occur
          DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
          ROLLBACK; -- Rollback the transaction to maintain data consistency
  END submit_feedback;

  PROCEDURE apply_for_leave (
    p_rollno        IN VARCHAR2,
    p_leave_dt      IN DATE,
    p_address       IN VARCHAR2,
    p_reason        IN VARCHAR2,
    p_no_of_day     IN NUMBER
  ) IS
    BEGIN
    -- Step 1: Input Validation (if necessary)
    -- This could include checking if the provided roll number exists in the Stud_Info table
    -- Also, validate other parameters as needed
    
    -- Step 2: Insert into Database
      INSERT INTO Leave (rollno, leave_dt, address, reason, no_of_day)
      VALUES (p_rollno, p_leave_dt, p_address, p_reason, p_no_of_day);
    
    -- Step 3: Notification (if necessary)
    -- Add notification logic here if needed
    
    -- Step 4: Logging
    -- Add logging logic here if needed

      COMMIT; -- Commit the transaction
    EXCEPTION
      WHEN OTHERS THEN
        -- Handle any exceptions that might occur
          DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
          ROLLBACK; -- Rollback the transaction to maintain data consistency
  END apply_for_leave;

END student_pkg;
/
