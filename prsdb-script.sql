use sys;

drop database if exists prsdb1;

create database prsdb1;

use prsdb1;

create table Users (
	id int not null primary key auto_increment, 
    username varchar(30) not null unique,
	password varchar(30) not null,
    firstname varchar(30) not null,
    lastname varchar(30) not null,
    phone varchar(12) null,
    email varchar(255),
    isReviewer tinyint not null default 0,
    isAdmin tinyint not null default 0
);

insert into Users ( username, password, firstname, lastname, isReviewer, isAdmin)
			values ( 'sa', 'sa', 'System', 'Admin', 1, 1);
            
Create table Vendors (
	id int not null primary key auto_increment,
    code varchar(10) not null unique,
    name varchar(30) not null,
    address varchar(30) not null,
    city varchar(30) not null,
    state varchar(2) not null,
    zip varchar(5) not null,
    phoneNumber varchar(12),
    email varchar(255)
);

insert into Vendors (code, name, address, city, state, zip)
			values ('AMAZ', 'Amazon', '1 Amazon Way', 'Seattle', 'WA', '84744'),
					('TARG', 'Target', '1 Target Way', 'Minneapolis', 'MN', '47464'),
                    ('MEIJ', 'Meijer', '1 Meijer Way', 'Atlanta', 'MI', '87532');
                    
create table Requests (
	id int not null primary key auto_increment,
	description varchar(80) not null,
    justification varchar(80) not null,
    rejectionReason varchar(80),
    deliveryMode varchar(80) not null default 'PickUp',
    status varchar(80) not null default 'NEW',
    total decimal(11,2) not null default 0,
    dateNeeded date not null,
    submittedDate datetime not null default current_timestamp,
    userId int not null, 
	foreign key (userId) references Users(id)
);

insert into Requests (description, justification, dateNeeded, userId)
				values ('1st request', 'Just because', '2021-03-01', 
							(select id from Users where username = 'sa') );

create table Products (
	id int not null primary key auto_increment,
    partNumber varchar(30) not null unique,
    name varchar(30) not null,
    price decimal(11,2) not null,
    unit varchar(30) not null,
    photoPath varchar(255),
    vendorId int not null,
    foreign key (vendorId) references Vendors(id)
);

insert into Products (partNumber, name, price, unit, vendorId)
			values 	('ECHO', 'Echo', 100, 'Each', (select id from vendors where code = 'AMAZ')),
					('ECHODOT', 'Echo Dot', 40, 'Each', (select id from vendors where code = 'AMAZ')),
					('ECHOSHOW5', 'Echo Show 5', 120, 'Each', (select id from vendors where code = 'AMAZ')),
					('ECHOSHOW8', 'Echo Show 8', 150, 'Each', (select id from vendors where code = 'AMAZ')),
					('FIRETVSTK', 'Fire TV Stick', 50, 'Each', (select id from vendors where code = 'AMAZ')),
					('FIRETVCBE', 'Fire TV Cube', 150, 'Each', (select id from vendors where code = 'AMAZ'));

create table Lineitems (
	id int not null primary key auto_increment,
    requestId int not null,
    productId int not null,
    quantity int not null default 1,
    foreign key (requestId) references Requests(id),
    foreign key (productId) references Products(id),
    constraint requestId_productId unique (requestId, productId)
);

insert into Lineitems (requestId, productId, quantity)
	values ( (select id from requests where id = 1), (select id from products where partNumber = 'ECHO'), 3),
			( (select id from requests where id = 1), (select id from products where partNumber = 'ECHODOT'), 2);

