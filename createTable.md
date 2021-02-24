# Team06
create table board(
no int primary key auto_increment,
title varchar(20) not null,
name varchar(20) not null,
textarea varchar(2048) not null,
writer varchar(20) not null references user(userID),
date Timestamp default now(),
selector varchar(20) not null default '식당',
countCom int not null,
picUrl varchar(50) default 'noPic.jpg'
);

create table user(
userID varchar(20) primary key,
userPassword varchar(20) not null,
userName varchar(20) not null,
userEmail varchar(50) not null,
profileUrl varchar(50) default 'noPic.jpg'
);

create table comment(
no int primary key auto_increment,
userID varchar(20)  not null references user(userID),
boardNo int not null references board(no),
content varchar(1024) not null,
date Timestamp default now()
);
