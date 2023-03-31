-- DDL for Cocktails Database

-- initial master database use statement
USE master;
GO
Alter database FireEmblem SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO

-- initalize database
DROP DATABASE IF EXISTS FireEmblem;
GO
CREATE DATABASE FireEmblem;
GO
USE FireEmblem;
GO

-- Reset Schema
DROP TABLE IF EXISTS [Character];
GO

DROP TABLE IF EXISTS Class;
GO

DROP TABLE IF EXISTS Stats;
GO

DROP TABLE IF EXISTS Stats_to_Character;
GO

CREATE TABLE [Character](
    Character_ID int primary key identity(1,1),
    Character_Name varchar(250) not null
);
GO

CREATE TABLE [Class](
    Class_ID int primary key identity(1,1),
    Class_Name varchar(250) not null
);
GO

CREATE TABLE [Stats](
    Stats_ID int primary key identity(1,1),
    HP int not null,
    Str int not null,
    Mag int not null,
    Dex int not null,
    Spd int not null,
    Def int not null,
    Res int not null,
    Lck int not null,
    Bld int not null,
    Rating int not null,
);
GO

CREATE TABLE [Stats_to_Character](
    Stats_to_Character_ID int primary key identity(1,1),
    Stats_ID int not null, 
        constraint fk_Stats foreign key (Stats_ID) references [Stats](Stats_ID),
    Class_ID int not null, 
        constraint fk_Class foreign key (Class_ID) references [Class](Class_ID),
    Character_ID int not null, 
        constraint fk_Character foreign key (Character_ID) references [Character](Character_ID)
);
GO