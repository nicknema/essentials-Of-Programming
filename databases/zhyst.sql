create table BUILDINGS (
    ID NUMBER(8) NOT NULL,
    NAME VARCHAR2(20),
    SQUARE NUMBER(4) NOT NULL,
    FOUND_YEAR NUMBER(4),
    ID_STREET NUMBER(8) NOT NULL,
    STREET_NUM VARCHAR2(5) NOT NULL
);
ALTER TABLE BUILDINGS ADD CONSTRAINT BUILDINGS_PK PRIMARY KEY(ID);

create table STREETS (
    ID NUMBER(8) NOT NULL,
    NAME VARCHAR2(50) NOT NULL,
    WIDTH NUMBER(2),
    LENGTH NUMBER(4)
);
ALTER TABLE STREETS ADD CONSTRAINT STREETS_PK PRIMARY KEY(ID);

create table MUNICIPAL_OBJECTS (
    ID NUMBER(8) NOT NULL,
    SQUARE VARCHAR2(5) NOT NULL,
    ID_TYPE NUMBER(8) NOT NULL,
    ID_STREET NUMBER(8) NOT NULL,
    LOCATION_DESCR VARCHAR2(50)
);
ALTER TABLE MUNICIPAL_OBJECTS ADD CONSTRAINT MUNINCIPALOBJ_PK PRIMARY KEY(ID);

create table OBJ_TYPES (
    ID NUMBER(8) NOT NULL,
    NAME VARCHAR2(25) NOT NULL
);
ALTER TABLE OBJ_TYPES ADD CONSTRAINT OBJTYPES_PK PRIMARY KEY(ID);

ALTER TABLE BUILDINGS ADD CONSTRAINT FK_BUILDS_IDSTREET_STREETS
    FOREIGN KEY (ID_STREET) REFERENCES STREETS;

ALTER TABLE MUNICIPAL_OBJECTS ADD CONSTRAINT FK_MUNOBJS_IDTYPE_OBJTYPES
    FOREIGN KEY (ID_TYPE) REFERENCES OBJ_TYPES;
ALTER TABLE MUNICIPAL_OBJECTS ADD CONSTRAINT FK_MUNOBJS_IDSTREET_STREETS
    FOREIGN KEY (ID_STREET) REFERENCES STREETS;











