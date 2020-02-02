create table person(
  id integer not null,
  FirstName varchar(20),
  LastName varchar(20),
  gender varchar(10),
  birthday date,
  primary key (id)
);

create table phoneNum(
  num real not null,
  type varchar(15),
  id integer not null,
  primary key (id, num),
  foreign key (id)
    references person (id)
    on delete cascade
);

create table address(
  postcode char(6) not null,
  street varchar(60),
  city varchar(60),
  province varchar(20),
  id integer not null,
  primary key (postcode),
  foreign key person (id)
    references person (id)
    on delete cascade
);

create table hospital(
  
  name varchar(60) not null primary key,
  annBud real
  
);

create table department(
  depName varchar(40) not null,
  annBud real,
  hospitalName varchar(60) not null,
  foreign key (hospitalName) references hospital (name) on delete cascade,
  primary key (hospitalName, depName)
);

create table nurse(
  nid integer not null,
  foreign key (nid) references person (id) on delete cascade,
  yearPractice integer,
  sal real,
  primary key (nid)
);

create table patient(
  pid integer not null,
  foreign key (pid) references person (id) on delete cascade,
  insurance varchar(20),
  primary key (pid)
);

create table care(
  pid integer not null,
  nid integer not null,
  foreign key (pid) references patient (pid) on delete cascade,
  foreign key (nid) references nurse (nid) on delete cascade, 
  primary key (pid, nid)
);

create table physician(
  did integer not null,
  yearPractice integer,
  medicalSpe varchar(20),
  sal real,
  foreign key (did) references person (id) on delete cascade,
  primary key (did)
);

create table medicalTest(
  numID integer not null,
  pid integer not null,
  foreign key (pid) references patient (pid) on delete cascade,
  fee real,
  testDate date,
  result varchar(255),
  primary key (pid, numID)
);

create table goto(
  pat integer not null,
  hos varchar(60) not null,
  foreign key (hos) references hospital (name),
  admdata date,
  admPriority varchar(60),
  foreign key (pat) references patient (pid) on delete cascade,
  primary key (pat, hos)
);

create table drug(
  drugID integer not null primary key,
  name varchar(60),
  unitCost real,
  catagory varchar(20),
  dosage varchar(60),
  used integer,
  foreign key (used) references patient (pid) on delete cascade,
  prescriptionBy int,
  foreign key (prescriptionBy) references physician (did) on delete cascade
);

create table diagnosis(
  prognosis varchar(40) not null,
  disease varchar(30),
  diaDate date,
  pid integer not null,
  foreign key (pid) references patient (pid) on delete cascade,
  did integer not null,
  foreign key (did) references physician (did) on delete cascade,
  primary key (pid, prognosis)
);



  