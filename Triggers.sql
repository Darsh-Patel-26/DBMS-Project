-- Room Allocator Trigger
CREATE OR REPLACE TRIGGER room_allocator_trigger
BEFORE INSERT ON Stud_Info
FOR EACH ROW
DECLARE
    v_room_no Rooms.rm_no%TYPE;
BEGIN
    -- Find the room with the smallest difference between capacity and occupancy
    SELECT rm_no INTO v_room_no
    FROM (
        SELECT rm_no, capacity - NVL(occupancy, 0) AS diff
        FROM Rooms
        ORDER BY diff
    )
    WHERE ROWNUM = 1;

    -- Allocate the room to the student in Stud_Rooms table
    INSERT INTO Stud_Rooms (rollno, rm_no)
    VALUES (:NEW.rollno, v_room_no);
    
    -- Increase occupancy of the allocated room
    UPDATE Rooms
    SET occupancy = NVL(occupancy, 0) + 1
    WHERE rm_no = v_room_no;
END;
/

-- Entry-Exit Time and Date Noter
CREATE OR REPLACE TRIGGER entry_exit_time_noter_trigger
BEFORE INSERT ON Entry_Exit
FOR EACH ROW
BEGIN
    -- Set the entry/exit date to the current system date
    IF :NEW.ee_date IS NULL THEN
        :NEW.ee_date := TRUNC(SYSDATE);
    END IF;
    
    -- Set the entry/exit time to the current system timestamp
    IF :NEW.ee_time IS NULL THEN
        :NEW.ee_time := SYSTIMESTAMP;
    END IF;
END;
/

-- Feedback Date Noter
CREATE OR REPLACE TRIGGER feedback_date_noter_trigger
BEFORE INSERT ON Feedback
FOR EACH ROW
BEGIN
    -- Set the feedback date to the current system date
    IF :NEW.fb_dt IS NULL THEN
        :NEW.fb_dt := SYSDATE;
    END IF;
    
    -- Set the day of the week
    :NEW.day := TO_CHAR(SYSDATE, 'DAY');
END;
/

-- Complain Date Noter
CREATE OR REPLACE TRIGGER complain_date_noter_trigger
BEFORE INSERT ON Complain
FOR EACH ROW
BEGIN
    -- Set the complain date to the current system date
    IF :NEW.com_dt IS NULL THEN
        :NEW.com_dt := SYSDATE;
    END IF;
END;
/

-- Roll No Allocator
CREATE OR REPLACE TRIGGER student_before_insert
BEFORE INSERT ON Stud_Info
FOR EACH ROW
DECLARE
    max_rollno NUMBER;
BEGIN
    SELECT NVL(MAX(rollno), 0) INTO max_rollno FROM Student;
    :NEW.rollno := max_rollno + 1;
END;
/

-- Emp No Allocator
CREATE OR REPLACE TRIGGER employee_before_insert
BEFORE INSERT ON Emp_Info
FOR EACH ROW
DECLARE
    max_empno NUMBER;
BEGIN
    SELECT NVL(MAX(empno), 0) INTO max_empno FROM Employee;
    :NEW.empno := max_empno + 1;
END;
/