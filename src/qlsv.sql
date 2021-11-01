
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
# Sử dụng hàm count để hiển thị số lượng sinh viên ở từng nơi
select Address ,count(StudentID)
from Students group by Address;

#     Tính điểm trung bình các môn học của mỗi học viên bằng cách sử dụng hàm AVG
select  s.StudentID,s.StudentName, avg(Mark) as 'diem trung binh' from students s join mark m on s.StudentID = m.StudentID
group by s.StudentID, s.StudentName;

# Hiển thị những bạn học viên co điểm trung bình các môn học lớn hơn 5
select s.StudentID,s.StudentName, avg(Mark) as ' diem trung binh > 5'
from students s join Mark M on s.StudentID = M.StudentID
group by s.StudentID, s.StudentName having avg(Mark)>5;

# Hiển thị thông tin các học viên có điểm trung bình lớn nhất.
select s.StudentID,s.StudentName, avg(Mark) as ' diem trung binh max'
from students s join Mark M on s.StudentID = M.StudentID
group by s.StudentID,s.StudentName HAVING AVG(Mark) >= ALL (SELECT AVG(Mark) FROM Mark GROUP BY Mark.StudentId);