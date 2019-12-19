create table User(
user_id varchar(5) primary key,
user_name varchar(30),
user_added_date datetime,
user_password varchar(15),
user_mobile varchar(10));

create table Note(
note_id int(5) primary key,
note_title varchar(30),
note_content varchar(50),
note_status varchar(15),
note_creation_date datetime);

create table Category(
category_id int(5) primary key,
category_name varchar(30) NOT NULL,
category_descr varchar(50),
category_creation_date datetime NOT NULL,
category_creator varchar(15) NOT NULL);

create table Reminder(
reminder_id int(5) primary key,
reminder_name varchar(30) NOT NULL,
reminder_descr varchar(50),
reminder_type varchar(15) NOT NULL,
reminder_creation_date datetime NOT NULL,
reminder_creator varchar(15) NOT NULL);

create table NoteCategory(
notecategory_id int(5) primary key,
note_id int NOT NULL,
category_id int NOT NULL);

create table NoteReminder(
notereminder_id int(5) primary key,
note_id int(5) NOT NULL,
reminder_id int(5) NOT NULL);

create table UserNote(
usernote_id int(5) primary key,
user_id varchar(5) NOT NULL,
note_id int(5) NOT NULL);



insert into Note values(001,'Java','Java is Object oriented language','completed','2019-11-04');
insert into Note values(002,'HTML','Used for static pages','completed','2019-11-18');
insert into Note values(003,'JS','Used for dynamic pages','completed','2019-11-23');
insert into Note values(004,'Angular','used for singlepage applications','completed','2019-11-25');
insert into Note values(005,'Spring','its a MVC framework','started','2019-12-16');

insert into User values('001','Iswarya','2019-11-04','Dama@123','8015051170');
insert into User values('002','Amith','2019-11-05','Amith@cts','1236547891');
insert into User values('003','Rajashree','2019-11-04','raja@fse','7896541236');
insert into User values('004','Rupa','2019-10-26','rupa@20','7412589636');
insert into User values('005','Arun','2019-10-28','Arun@fse','7419632580');

insert into Category values(001,'Retail','Flipkart is the retail head in India','2019-11-04','Sachin');
insert into Category values(002,'Travel','Redbus is very useful travel app','2015-11-05','Amith');
insert into Category values(003,'Banking','Had loan in Sbi bank','1996-11-04','Arundathi');
insert into Category values(004,'Finance','Mutualfunds good for finance','2011-10-26','rupa');
insert into Category values(005,'HealthCare','Abbot is Healthcare partner in CTS','2000-10-28','Arun');

insert into NoteCategory values(1000,001,002);
insert into NoteCategory values(1001,002,001);
insert into NoteCategory values(1002,003,004);
insert into NoteCategory values(1003,004,005);
insert into NoteCategory values(1004,005,003);

insert into NoteReminder values(101,001,1000);
insert into NoteReminder values(102,002,1001);
insert into NoteReminder values(103,003,1002);
insert into NoteReminder values(104,004,1003);
insert into NoteReminder values(105,005,1004);

insert into Reminder values(1000,'Java_rem','Java8 reminder','daily','2019-11-04','Sun');
insert into Reminder values(1001,'HTML_rem','HTML&CSS reminder','weekly','2019-11-11','Amith');
insert into Reminder values(1002,'JS_rem','JS reminder','twodays','2019-11-20','Arundathi');
insert into Reminder values(1003,'Angular_rem','Angular reminder','biweekly','2019-12-10','Google');
insert into Reminder values(1004,'Spring_rem','Spring Boot reminder','monthly','2019-12-16','Arun');

insert into UserNote values(1011,'001',002);
insert into UserNote values(1012,'002',001);
insert into UserNote values(1013,'003',004);
insert into UserNote values(1014,'004',005);
insert into UserNote values(1015,'005',003);
insert into UserNote values(1016,'002',004);

select * from User where user_id='001' and user_password = 'Dama@123';
select * from Note where note_creation_date = '2019-11-04';
select category_name from Category where category_creation_date > '2019-10-04';
select note_id from UserNote,User where UserNote.user_id = User.user_id and User.user_name ='Amith';
update Note set note_status = 'In progress' where note_id=005;
select * from Note,UserNote where Note.note_id = UserNote.note_id and UserNote.user_id = '002';
select * from Note,NoteCategory where Note.note_id=NoteCategory.note_id and NoteCategory.category_id=005;
select * from reminder,NoteReminder where NoteReminder.reminder_id=reminder.reminder_id and NoteReminder.note_id=005;
select * from Reminder where reminder_id=001;
insert into Note values(006,'MySQL','Database query language','completed','2019-12-16');
insert into UserNote values(1017,'001',006); 
insert into NoteCategory values(1005,006,003);
Alter table UserNote add constraint usernote_fk foreign key(note_id) references Note(note_id) on update cascade on delete cascade;
Alter table UserNote add constraint usernote_userid_fk foreign key(user_id) references User(user_id) on update cascade on delete cascade;

delete n from Note n join UserNote un on n.note_id = un.note_id where un.user_id='002';
alter table NoteCategory add constraint notecategory_fk foreign key(category_id) references Category(category_id) on update cascade on delete cascade;

delete c from Category c join NoteCategory nc on nc.category_id = c.category_id where c.category_id=003;
delete n from Note n where n.note_id=003;
delete nc from NoteCategory where nc.notecategory_id=1002;

delimiter $$
create trigger first_trigger1 after delete on Note
for each row
begin
delete un from UserNote un where un.note_id = old.note_id;
Delete nr from Notereminder nr where nr.note_id = old.note_id;
delete nc from NoteCategory nc where nc.note_id = old.note_id;
end$$


delimiter ;
delete from Note where note_id=003;

delimiter ##
create trigger user_trigger after delete on User
for each row
begin
delete un from UserNote un where un.user_id = old.user_id;
end##

delimiter ;
delete from User where user_id=005;
