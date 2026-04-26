PRAGMA foreign_keys = ON;

CREATE TABLE Hostel (
    hostel_id INTEGER PRIMARY KEY,
    hostel_name TEXT NOT NULL
);

CREATE TABLE Room (
    room_id INTEGER PRIMARY KEY,
    hostel_id INTEGER,
    capacity INTEGER,
    FOREIGN KEY (hostel_id) REFERENCES Hostel(hostel_id)
);

CREATE TABLE Student (
    student_id INTEGER PRIMARY KEY,
    name TEXT,
    email TEXT UNIQUE
);

CREATE TABLE Allocation (
    allocation_id INTEGER PRIMARY KEY,
    student_id INTEGER,
    room_id INTEGER,
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (room_id) REFERENCES Room(room_id)
);

CREATE TABLE Complaint (
    complaint_id INTEGER PRIMARY KEY,
    student_id INTEGER,
    description TEXT,
    status TEXT,
    created_at TEXT,
    FOREIGN KEY (student_id) REFERENCES Student(student_id)
);

CREATE TABLE Maintenance_Staff (
    staff_id INTEGER PRIMARY KEY,
    name TEXT
);

CREATE TABLE Complaint_Assignment (
    complaint_id INTEGER,
    staff_id INTEGER,
    PRIMARY KEY (complaint_id, staff_id),
    FOREIGN KEY (complaint_id) REFERENCES Complaint(complaint_id),
    FOREIGN KEY (staff_id) REFERENCES Maintenance_Staff(staff_id)
);


INSERT INTO Hostel VALUES
(1,'A Block'), (2,'B Block');

INSERT INTO Room VALUES
(101,1,3),(102,1,2),(201,2,3),(202,2,2),(203,2,4),
(104,1,2),(105,1,3),(204,2,2),(205,2,3),(106,1,2);

INSERT INTO Student VALUES
(1,'Asha','a@gmail.com'),
(2,'Ravi','r@gmail.com'),
(3,'Kiran','k@gmail.com'),
(4,'Meena','m@gmail.com'),
(5,'Arjun','a2@gmail.com'),
(6,'Neha','n@gmail.com'),
(7,'Rahul','r2@gmail.com'),
(8,'Sneha','s@gmail.com'),
(9,'Vikram','v@gmail.com'),
(10,'Pooja','p@gmail.com');

INSERT INTO Allocation VALUES
(1,1,101),(2,2,101),(3,3,102),(4,4,201),(5,5,202),
(6,6,203),(7,7,104),(8,8,105),(9,9,204),(10,10,205);

INSERT INTO Complaint VALUES
(1,1,'Fan not working','Pending','2026-01-01'),
(2,2,'Light issue','Resolved','2026-01-02'),
(3,3,'Water leakage','Pending','2026-01-03'),
(4,4,'Bed broken','Resolved','2026-01-04'),
(5,5,'No wifi','Pending','2026-01-05'),
(6,6,'Dirty room','Pending','2026-01-06'),
(7,7,'AC issue','Resolved','2026-01-07'),
(8,8,'Door lock broken','Pending','2026-01-08'),
(9,9,'Noise issue','Pending','2026-01-09'),
(10,10,'Window broken','Resolved','2026-01-10');

INSERT INTO Maintenance_Staff VALUES
(1,'John'),(2,'David'),(3,'Kumar'),(4,'Ali'),(5,'Ramesh');

INSERT INTO Complaint_Assignment VALUES
(1,1),(2,2),(3,3),(4,1),(5,2),
(6,3),(7,4),(8,5),(9,1),(10,2);

SELECT s.name, r.room_id
FROM Student s
JOIN Allocation a ON s.student_id = a.student_id
JOIN Room r ON a.room_id = r.room_id;

SELECT s.name, c.description, c.status
FROM Student s
JOIN Complaint c ON s.student_id = c.student_id;

SELECT status, COUNT(*) FROM Complaint GROUP BY status;

SELECT * FROM Complaint WHERE status = 'Pending';

SELECT c.complaint_id, m.name
FROM Complaint_Assignment ca
JOIN Complaint c ON ca.complaint_id = c.complaint_id
JOIN Maintenance_Staff m ON ca.staff_id = m.staff_id;

SELECT hostel_id, COUNT(*) FROM Room GROUP BY hostel_id;

SELECT s.name, c.description
FROM Student s
JOIN Complaint c ON s.student_id = c.student_id
WHERE c.status = 'Pending';