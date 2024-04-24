-- Student tables
CREATE TABLE Stud_Info (
    rollno VARCHAR2(20) PRIMARY KEY,
    sname VARCHAR2(100),
    sphoneno VARCHAR2(20),
    saddress VARCHAR2(200),
    sdob DATE,
    course VARCHAR2(100),
    institute VARCHAR2(100)
);

CREATE TABLE Stud_Email (
    rollno VARCHAR2(20),
    semail VARCHAR2(100),
    CONSTRAINT fk_stud_email FOREIGN KEY (rollno) REFERENCES Stud_Info(rollno),
    CONSTRAINT pk_stud_email PRIMARY KEY (rollno, semail)
);

CREATE TABLE Stud_Password (
    semail VARCHAR2(100),
    spass VARCHAR2(100),
    CONSTRAINT fk_stud_password FOREIGN KEY (semail) REFERENCES Stud_Email(semail),
    CONSTRAINT pk_stud_password PRIMARY KEY (semail)
);

CREATE TABLE Stud_Rooms (
    rollno VARCHAR2(20),
    rm_no VARCHAR2(20),
    CONSTRAINT fk_stud_rooms_rollno FOREIGN KEY (rollno) REFERENCES Stud_Info(rollno),
    CONSTRAINT fk_stud_rooms FOREIGN KEY (rm_no) REFERENCES Rooms(rm_no),
    CONSTRAINT pk_stud_rooms PRIMARY KEY (rollno, rm_no)
);

-- Employee tables
CREATE TABLE Emp_Info (
    empno VARCHAR2(20) PRIMARY KEY,
    ename VARCHAR2(100),
    ephoneno VARCHAR2(20),
    eaddress VARCHAR2(200),
    gender VARCHAR2(10),
    marital_st VARCHAR2(20),
    edob DATE
);

CREATE TABLE Emp_Email (
    empno VARCHAR2(20),
    e_email VARCHAR2(100),
    CONSTRAINT fk_emp_email FOREIGN KEY (empno) REFERENCES Emp_Info(empno),
    CONSTRAINT pk_emp_email PRIMARY KEY (empno, e_email)
);

CREATE TABLE Emp_Password (
    e_email VARCHAR2(100),
    epass VARCHAR2(100),
    CONSTRAINT fk_emp_password FOREIGN KEY (e_email) REFERENCES Emp_Email(e_email),
    CONSTRAINT pk_emp_password PRIMARY KEY (e_email)
);

CREATE TABLE Emp_Job_Info (
    empno VARCHAR2(20),
    ejob VARCHAR2(100),
    CONSTRAINT fk_emp_job_info FOREIGN KEY (empno) REFERENCES Emp_Info(empno),
    CONSTRAINT pk_emp_job_info PRIMARY KEY (empno)
);

CREATE TABLE Job (
    job_id VARCHAR2(20) PRIMARY KEY,
    sal NUMBER
);

CREATE TABLE Emp_Comp_Junc (
    rollno VARCHAR2(20),
    com_dt DATE,
    empno VARCHAR2(20),
    CONSTRAINT fk_emp_comp_junc_rollno FOREIGN KEY (rollno) REFERENCES Stud_Info(rollno),
    CONSTRAINT fk_emp_comp_junc_empno FOREIGN KEY (empno) REFERENCES Emp_Info(empno),
    CONSTRAINT pk_emp_comp_junc PRIMARY KEY (rollno, com_dt, empno)
);

-- Vehicle table
CREATE TABLE Vehicle (
    vl_id VARCHAR2(20) PRIMARY KEY,
    rollno VARCHAR2(20),
    reg_no VARCHAR2(50),
    vl_type VARCHAR2(50),
    CONSTRAINT fk_vehicle_rollno FOREIGN KEY (rollno) REFERENCES Stud_Info(rollno)
);

-- Leave table
CREATE TABLE Leave (
    rollno VARCHAR2(20),
    leave_dt DATE,
    address VARCHAR2(200),
    reason VARCHAR2(200),
    no_of_day NUMBER,
    CONSTRAINT fk_leave_rollno FOREIGN KEY (rollno) REFERENCES Stud_Info(rollno),
    CONSTRAINT pk_leave PRIMARY KEY (rollno, leave_dt)
);

-- Mess-Menu table
CREATE TABLE Mess (
    mess_id VARCHAR2(20) PRIMARY KEY,
    monday VARCHAR2(100),
    tuesday VARCHAR2(100),
    wednesday VARCHAR2(100),
    thursday VARCHAR2(100),
    friday VARCHAR2(100),
    saturday VARCHAR2(100),
    sunday VARCHAR2(100)
);

CREATE TABLE Mess_Fb_Junc (
    rollno VARCHAR2(20),
    fb_dt DATE,
    mess_id VARCHAR2(20),
    CONSTRAINT fk_mess_fb_junc_rollno FOREIGN KEY (rollno) REFERENCES Stud_Info(rollno),
    CONSTRAINT fk_mess_fb_junc_mess_id FOREIGN KEY (mess_id) REFERENCES Mess(mess_id),
    CONSTRAINT pk_mess_fb_junc PRIMARY KEY (rollno, fb_dt)
);

-- Feedback table
CREATE TABLE Feedback (
    rollno VARCHAR2(20),
    fb_dt DATE,
    day VARCHAR2(20),
    feedback VARCHAR2(200),
    CONSTRAINT fk_feedback_rollno FOREIGN KEY (rollno) REFERENCES Stud_Info(rollno),
    CONSTRAINT pk_feedback PRIMARY KEY (rollno, fb_dt, day)
);

-- Rooms table
CREATE TABLE Rooms (
    rm_no VARCHAR2(20) PRIMARY KEY,
    capacity NUMBER,
    occupancy NUMBER
);

-- Complain table
CREATE TABLE Complain (
    rollno VARCHAR2(20),
    com_dt DATE,
    com_type VARCHAR2(50),
    is_done VARCHAR2(5),
    CONSTRAINT fk_complain_rollno FOREIGN KEY (rollno) REFERENCES Stud_Info(rollno),
    CONSTRAINT pk_complain PRIMARY KEY (rollno, com_dt)
);

-- Entry-Exit table
CREATE TABLE Entry_Exit (
    rollno VARCHAR2(20),
    ee_time VARCHAR2(20),
    ee_date DATE,
    place VARCHAR2(100),
    ee_type VARCHAR2(20),
    CONSTRAINT fk_entry_exit_rollno FOREIGN KEY (rollno) REFERENCES Stud_Info(rollno),
    CONSTRAINT pk_entry_exit PRIMARY KEY (rollno, ee_date, ee_time)
);
