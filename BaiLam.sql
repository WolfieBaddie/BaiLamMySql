create database QuanLySinhVien;
use QuanLySinhVien;


--Create table

create table Teacher(
	TeacherId int primary key IDENTITY(1, 1),
	FirstName varchar(255),
	LastName varchar(255),
	Subject varchar(255)
);

create table Classes(
	ClassId int primary key IDENTITY(1,1),
	ClassName varchar(255),
	TeacherId int constraint fk_teacher_id foreign key (TeacherId) references Teacher(TeacherId)

);

create table Students(
	StudentId int primary key IDENTITY(1,1),
	FirstName varchar(255),
	LastName varchar(255),
	ClassId int constraint fk_class_id foreign key (ClassId) references Classes(ClassId),
	BirthDate date
);



--2. More Data:
-- Add at least 5 classes and 10 students to the database.
-- Add at least 3 teachers with information related to the subject.INSERT INTO Teacher ( FirstName, LastName, Subject)
VALUES
  ( 'John', 'Thompson', 'Mathematics'),
  ( 'Alex', 'Anderson', 'English'),
  ( 'Bruce', 'Lee', 'Computer Science');

  INSERT INTO Classes ( ClassName, TeacherId)
VALUES
  ( 'Math 101', 1),
  ( 'English Literature', 2),
  ( 'Computer Science', 3),
  ( 'Advanced Math', 1),
  ( 'Advanced English', 2);

  INSERT INTO Students ( FirstName, LastName, ClassID, BirthDate)
VALUES
  ( 'Alice', 'Smith', 1, '2000-01-01'),
  ( 'Bob', 'Johnson', 2, '1999-05-23'),
  ( 'Charlie', 'Brown', 3, '2003-06-17'),
  ( 'David','Miller', 4, '2004-01-25'),
  ( 'Emily','Garcia', 5, '2002-03-03'),
  ( 'Felix','Hernandez', 1, '2001-08-19'),
  ( 'Isabella','Jones', 2, '2001-05-05'),
  ('Jacob','Williams', 3, '1998-09-02'),
  ('Katherine', 'Moore', 4, '1996-09-06'),
  ('Liam', 'Davis', 5, '1990-01-01');

 -- 3. Data Query:
-- Write a SQL query to display a list of all students with class name and teacher in charge
select StudentId, s.FirstName +' '+ s.LastName as 'StudentName',s.BirthDate, c.ClassName
, t.FirstName + ' ' + t.LastName as 'TeacherName' from Students s 
join Classes c on s.ClassId = c.ClassId
join Teacher t on c.TeacherId = t.TeacherId


--4. Query Conditions:
-- Write a SQL query to display students with birth dates from 2000 onwards

select StudentId, s.FirstName +' '+ s.LastName as 'StudentName',s.BirthDate from Students as s
where year(s.birthdate) > 2000;

--5. JOIN Query:
-- Write an SQL query to display all students with class name and teacher in charge, sorted by student name.

select StudentId, s.FirstName +' '+ s.LastName as 'StudentName',s.BirthDate, c.ClassName
, t.FirstName + ' ' + t.LastName as 'TeacherName' from Students s 
inner join Classes c on s.ClassId = c.ClassId
inner join Teacher t on c.TeacherId = t.TeacherId
order by 'StudentName';

--6. Updating data:
-- Update the name of the student whose StudentID is 3 to "John Doe".
update Students set FirstName = 'John', LastName = 'Doe' where StudentId = 3;

--7. Delete data:
-- Delete students whose StudentID is 7
delete from Students where StudentId  = 7;

--8. Procedure:
--Create a stored procedure named GetStudentsByClassAndSubject that takes ClassID and 
--Subject, and returns a list of students belonging to that class and subject
select * from Students;
select * from Classes;


create procedure GetStudentByClassAndSubject as 
select StudentId, s.FirstName +' '+ s.LastName as 'StudentName',s.BirthDate 
,c.ClassId, c.ClassName from Students s inner join Classes c on s.ClassId = c.ClassId 
go;

exec GetStudentByClassAndSubject;

--9. View:
--Create a view named StudentsWithClassAndTeacher that displays information about 
--students along with the class name and teacher in charge.create view StudentsWithClassAndTeacher asselect StudentId, s.FirstName +' '+ s.LastName as 'StudentName',s.BirthDate, c.ClassName
, t.FirstName + ' ' + t.LastName as 'TeacherName' from Students s 
join Classes c on s.ClassId = c.ClassId
join Teacher t on c.TeacherId = t.TeacherId

select * from StudentsWithClassAndTeacher;

--Bonus
--Add constraint to the table
alter table Students add constraint fk_Class_Id foreign key (ClassId) references Classes(ClassId); 
--ClassId foreign key for Students table

alter table Classes add constraint fk_Teacher_Id foreign key (TeacherId) references Teacher(TeacherId);
--TeacherId foregin key for Classes table

-- Create indexes for important fields.
create index Idx_TeacherId on Classes (TeacherId);
create index Idx_ClassId on Students (ClassId);


--Test StoredProcedure and Views
exec GetStudentByClassAndSubject;
select * from StudentsWithClassAndTeacher;

