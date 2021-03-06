
create database quanlysinhvien;
use quanlysinhvien;

create table Classs(
                      ClassID int auto_increment primary key,
                      ClassName varchar(10),
                      StartDate date,
                      Status boolean
);
create table Students(
                        StudentID int auto_increment primary key,
                        StudentName varchar(30),
                        Address varchar(50),
                        Phone varchar(12),
                        Status boolean,
                        ClassID int,
                        foreign key (ClassID) references Classs (ClassID)
);
create table Subject(
                        SubID int auto_increment primary key,
                        SubName varchar(20),
                        Credit int,
                        Status boolean
);
create table Mark(
                     MarkID int auto_increment primary key,
                     SubID int,
                     StudentID int,
                     Mark int,
                     ExamTimes time,
                     foreign key (SubID) references Subject (SubID),
                     foreign key (StudentID) references  Students (StudentID)
);
insert into Classs (ClassName, StartDate, Status) value ('A1', '2021-10-23', true);
insert into Classs (ClassName, StartDate, Status) value ('A2', '2020-10-23', true);
insert into Classs (ClassName, StartDate, Status) value ('A3', '2019-10-23', false);

insert into Students (StudentName, Address, Phone, Status, ClassID) VALUE ('Tuan','Hai Phong', '012345567', true,1);
insert into Students (StudentName, Address, Phone, Status, ClassID) VALUE ('Thao','Phu Tho', '0123455678', true,1);
insert into Students (StudentName, Address, Phone, Status, ClassID) VALUE ('Duy','Ha Noi', '01234556789', true,2);

insert into Subject (SubName, Credit, Status) VALUE ('Tieng Anh', 5, true);
insert into Subject (SubName, Credit, Status) VALUE ('My Thuat', 6, true);
insert into Subject (SubName, Credit, Status) VALUE ('Am Nhac', 5, true);
insert into Subject (SubName, Credit, Status) VALUE ('Ngu Van', 10, true);

insert into Mark (SubID, StudentID, Mark, ExamTimes) VALUE (1, 1, 8, '01:00');
insert into Mark (SubID, StudentID, Mark, ExamTimes) VALUE (1, 2, 10, '02:00');
insert into Mark (SubID, StudentID, Mark, ExamTimes) VALUE (2, 1, 12, '01:00');
use quanlysinhvien;
# S??? d???ng h??m count ????? hi???n th??? s??? l?????ng sinh vi??n ??? t???ng n??i
select Address ,count(StudentID)
from Students group by Address;

#     T??nh ??i???m trung b??nh c??c m??n h???c c???a m???i h???c vi??n b???ng c??ch s??? d???ng h??m AVG
select  s.StudentID,s.StudentName, avg(Mark) as 'diem trung binh' from students s join mark m on s.StudentID = m.StudentID
group by s.StudentID, s.StudentName;

# Hi???n th??? nh???ng b???n h???c vi??n co ??i???m trung b??nh c??c m??n h???c l???n h??n 5
select s.StudentID,s.StudentName, avg(Mark) as ' diem trung binh > 5'
from students s join Mark M on s.StudentID = M.StudentID
group by s.StudentID, s.StudentName having avg(Mark)>5;

# Hi???n th??? th??ng tin c??c h???c vi??n c?? ??i???m trung b??nh l???n nh???t.
select s.StudentID,s.StudentName, avg(Mark) as ' diem trung binh max'
from students s join Mark M on s.StudentID = M.StudentID
group by s.StudentID,s.StudentName HAVING AVG(Mark) >= ALL (SELECT AVG(Mark) FROM Mark GROUP BY Mark.StudentId);

# Hi???n th??? t???t c??? c??c th??ng tin m??n h???c (b???ng subject) c?? credit l???n nh???t.
select max(Credit) from subject  group by SubID,SubName having max(Credit) >= all (select max(Credit)from subject);

# Hi???n th??? c??c th??ng tin m??n h???c c?? ??i???m thi l???n nh???t.
select max(Mark) from subject join Mark M on Subject.SubID = M.SubID group by Subject.
SubID,Subject.SubName having max(Mark) >= all (select max(Mark) from Mark group by Mark.SubID);

# Hi???n th??? c??c th??ng tin sinh vi??n v?? ??i???m trung b??nh c???a m???i sinh vi??n, x???p h???ng theo th??? t??? ??i???m gi???m d???n
select s.StudentID,s.StudentName,avg(Mark) as 'DTB gia??m d????n' from students s join mark m on s.StudentID = m.StudentID
group by s.StudentID, s.StudentName order by  avg(Mark) desc ;