create user semestral identified by 12345;
grant resource to semestral;
grant connect to semestral;
ALTER SESSION SET CURRENT_SCHEMA = SEMESTRAL;

CREATE TABLE major_stats
(
    major          VARCHAR2(30) UNIQUE NOT NULL,
    total_credits  NUMBER              NOT NULL,
    total_students NUMBER              NOT NULL
);

CREATE TABLE Students
(
    id_students     NUMBER PRIMARY KEY,
    major           VARCHAR2(30) NOT NULL,
    current_credits NUMBER       NOT NULL
);

CREATE OR REPLACE TRIGGER trg_Students
    AFTER INSERT OR UPDATE OR DELETE
    ON Students
DECLARE
    v_major major_stats.major%TYPE;
    v_total_credits major_stats.total_credits%TYPE;
    v_total_students major_stats.total_students%TYPE;

    CURSOR c_registries IS
        SELECT major, SUM(current_credits), COUNT(*)
        FROM Students
        GROUP BY major;
BEGIN
    OPEN c_registries;
    LOOP
        FETCH c_registries INTO v_major, v_total_credits, v_total_students;
        EXIT WHEN c_registries%NOTFOUND;

        UPDATE major_stats
        SET total_credits  = v_total_credits,
            total_students = v_total_students
        WHERE major = v_major;

        IF SQL%NOTFOUND THEN
            INSERT INTO major_stats
            VALUES (v_major, v_total_credits, v_total_students);
        END IF;
    END LOOP;
    CLOSE c_registries;
END;

insert into STUDENTS
VALUES (10001, 'Computer Science', 11);

insert into STUDENTS
VALUES (10002, 'History', 4);

insert into STUDENTS
VALUES (10003, 'Computer Science', 8);

insert into STUDENTS
VALUES (10004, 'Economics', 8);

insert into STUDENTS
VALUES (10005, 'History', 4);

select * from Students;
select * from major_stats;