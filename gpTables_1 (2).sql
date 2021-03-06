-- For error 1452. Create new sql file and type in SET FOREIGN_KEY_CHECKS=0;
DROP DATABASE IF EXISTS gp_tables;

CREATE DATABASE gp_tables;

USE gp_tables;

CREATE TABLE EMPLOYEE (
	EmployyeeID	       	Integer 	    	NOT NULL,
	EmployyeeName       Varchar	(255) 	    NOT NULL,	-- Name to EmployyeeName
	EmpPosition	        Varchar (255)       NOT NULL,	-- Position to EmpPosition
	Manager    	  		Varchar (255) 	    NOT NULL,   
	YearsOfService     	Datetime 	    	NOT NULL,   -- I entered the starting date.
	SocialSecurity   	Varchar (9)    		NOT NULL,
    Salary				Float				NOT NULL,
    Bonus				Float				NULL,
	CONSTRAINT 		    EMPLOYYEE_PK 		PRIMARY KEY (EmployyeeID)
	);
    
CREATE TABLE BADGE (
	BadgeID	       	Integer 	    	NOT NULL,
    EmployyeeID		Integer				NOT NULL,
    Clearance		Varchar (45)		NOT NULL,
    CONSTRAINT		BADGE_PK			PRIMARY KEY (EmployyeeID, BadgeID),
    CONSTRAINT 		BADGE_EMP_FK 		FOREIGN KEY (EmployyeeID)
							REFERENCES  EMPLOYEE (EmployyeeID)
	);
    

CREATE TABLE CAR (
	Vin       			Varchar (17) 	    NOT NULL,	-- Int to Varchar (17)
	Model       		Varchar (255) 	    NOT NULL,
	Make          		Varchar (255)       NOT NULL,
	Color    	  		Varchar (255) 	    NOT NULL,
	LicenseNumber     	Varchar (255) 	    NOT NULL,
	SizeType  	    	Varchar (255)    	NOT NULL,
    InsuranceNo			Integer     		NOT NULL,
    DateReserved		Datetime			NOT NULL,
	Availabe 			Tinyint (1)			NULL,
	CONSTRAINT 		    CAR_PK 				PRIMARY KEY (Vin),
	CONSTRAINT			CAR_INS_FK			FOREIGN KEY (Vin, InsuranceNo)
 								REFERENCES INSURANCE (Vin, InsuranceNo)
);

CREATE TABLE INVENTORY (
	ParkingSpaceNo	       	Integer 	    	NOT NULL,
    Vin						Varchar (17)		NOT NULL,
    DateUse					Datetime			NOT NULL,
    DateReturn				Datetime			NOT NULL,
    Available				Tinyint(1)			NOT NULL,
    CONSTRAINT 				INVENTORY_PK		PRIMARY KEY (Vin, ParkingSpaceNo),
    CONSTRAINT				INVENTORY_VIN_FK	FOREIGN KEY	(Vin)
									REFERENCES CAR (Vin)
);

CREATE TABLE RENTALPRICE (
		SizeorType 		Integer  			NOT NULL,
        Price			Float				NULL,
        Vin				Varchar (17)		NOT NULL,
        CONSTRAINT 		RENTAL_PK			PRIMARY KEY (Vin),
        CONSTRAINT		RENTAL_VIN_FK		FOREIGN KEY (Vin)
									REFERENCES CAR (Vin)
);

CREATE TABLE MAINTENANCE (
	MaintenanceNo 		Integer  			NOT NULL,
    DateOfService		Datetime			NOT NULL,
    Vin					Varchar (17) 		NOT NULL,
    Mileage				Integer			 	NULL,
    TypeOfService 		Varchar (255)		NOT NULL,
    MaintComment		Varchar (255)		NOT NULL,
    CONSTRAINT			MAINTENANCE_PK		PRIMARY KEY (Vin, MaintenanceNo),
	CONSTRAINT			MAINTENANCE_VIN_FK	FOREIGN KEY (Vin)
									REFERENCES CAR (Vin)
);

CREATE TABLE CUSTOMER (
	CustomerID			Integer 			NOT NULL,
    CustomerName		Varchar (255)		NOT NULL,	-- Name to customer
    Address 			Varchar (255)		NOT NULL,
    DriverLicense		Varchar (255)		NOT NULL,
    Phone				Varchar (12) 		NOT NULL,
    CONSTRAINT			CUSTOMER_PK			PRIMARY KEY (CustomerID)
);

CREATE TABLE INSURANCE (
	InsuranceNo	       	Integer 	    	NOT NULL,
    Vin					Varchar (17)		NOT NULL,
    InvoiceNo			Integer 			NOT NULL, -- There is no primary key for InvoiceNO?
    CarCondition		Varchar (255) 		NOT NULL, 
    RepairType			Varchar (255) 		NOT NULL,
    CONSTRAINT			INSURANCE_PK		PRIMARY KEY (Vin, InsuranceNo)
);

CREATE TABLE INVOICE (
	InvoiceNo			Integer				NOT NULL,
    Price				Float				NULL,        -- int to float
    DateCheckout		Datetime			NOT NULL,
    Gas					Decimal				NULL,
    CustomerID			Integer				NOT NULL,
    InsuranceNo			Integer				NOT NULL,
    Vin					Varchar (17)		NOT NULL,
    EmployeeID			Integer				NOT NULL,
    CONSTRAINT			INVOICE_PK			PRIMARY KEY (InvoiceNo, CustomerID, InsuranceNo, Vin, EmployeeID),
    CONSTRAINT			INVOICE_CUS_FK		FOREIGN KEY (CustomerID)
									REFERENCES CUSTOMER (CustomerID),
    CONSTRAINT			INVOICE_INS_FK		FOREIGN KEY (InsuranceNo)
									REFERENCES INSURANCE (InsuranceNo),
	CONSTRAINT			INVOICE_VIN_FK		FOREIGN KEY (Vin)
									REFERENCES CAR (Vin),
	CONSTRAINT			INVOICE_EMP_FK		FOREIGN KEY (EmployeeID)
									REFERENCES EMPLOYEE (EmployeeID)
);


INSERT INTO CAR VALUES (
	'5XYKWDA74EG536509', 'GT-R', 'NISSAN', 'WHITE', '7BZV628', 'Sedan', 123, '2018-01-14 09:30:00
',1);

INSERT INTO CAR VALUES (
	'5XYKWDA74EG536501', 'ACURA', 'Tsx', 'Silver', '7BZV690', 'Sedan', 12, '2018-01-14 09:35:00
',1);

INSERT INTO CAR VALUES (
	'5XYKWDA74EG536510', 'Toyota', 'Tundra', 'Silver', '7BZV610', 'Truck', 69, '2018-01-14 09:35:00
',1);

INSERT INTO EMPLOYEE VALUES (
	123, 'Arthur Morgan', 'Agent', 'No', '2015-01-14 09:30:00','558515277', 35000.00, null);
    
INSERT INTO BADGE VALUES (
	1, 123, 'No clearance required'
);

INSERT INTO INVENTORY VALUES ( 
	45, '5XYKWDA74EG536509', '2018-01-14 09:30:00', '2018-01-15 09:28:00', 2
);

INSERT INTO INSURANCE VALUES (
	1, '5XYKWDA74EG536509', 2, 'Flawless', 'No repairment required' 
);

INSERT INTO MAINTENANCE VALUES (
	1, '2018-01-14 09:30:00', '5XYKWDA74EG536509', 4232, 'No service required', 'No comment'
);

INSERT INTO CUSTOMER VALUES (
	1, 'Jason Bourne', '212 Castle St, Anaheim CA 92833', 'X9570908', '202-555-0153');
    
INSERT INTO INVOICE VALUES (
	1, 29.99, '2018-01-14 09:45:00', 35, 1, 1, '5XYKWDA74EG536509', 123
);
-- For error 1452. Create new sql file and type in SET FOREIGN_KEY_CHECKS=0;



