DROP TABLE IF EXISTS TeamMemberLogin_T ;
DROP TABLE IF EXISTS Invoice_T ;
DROP TABLE IF EXISTS Orders_T ;
DROP TABLE IF EXISTS Client_T ;
DROP TABLE IF EXISTS ClientLogin_T ;
DROP TABLE IF EXISTS Services_T ;
DROP TABLE IF EXISTS TeamMembers_T ;

CREATE TABLE TeamMember_T (
        FName             VARCHAR(15)         NOT NULL,
        MInit             CHAR, 
        LName             VARCHAR(15)         NOT NULL,
        SSN               NUMERIC(9,0)        NOT NULL,
        BDATE             DATE,
        City              VARCHAR(30), 
        ST                CHAR(200),
        Street            CHAR(200),
        ZipCode           NUMERIC(9,0),
        Phone_number      NUMERIC(15),
		Pay          	  DECIMAL(10,2),                 
		TM_ID 	  		  CHAR(4)		  	  NOT NULL,
    CONSTRAINT TeamMember_PK PRIMARY KEY (SSN),
	UNIQUE (TM_ID)
) ;

CREATE TABLE Client_T (
        Business_Name     VARCHAR(15)         NOT NULL,
        Point_contact     CHAR(200)           NOT NULL,
        Initiation_DATE   DATE,
        City              VARCHAR(30), 
        ST                CHAR(200),
        Street            CHAR(200),
        ZipCode           NUMERIC(9,0),
        Email             VARCHAR(200),          
		Phone_number      NUMERIC(15)        NOT NULL,        
		TM_ID 	  		  CHAR(4)		  	 NOT NULL,
        Client_ID         CHAR(20)           NOT NULL,
        S_Type            VARCHAR(200)       NOT NULL,
    CONSTRAINT Client_PK PRIMARY KEY (Client_ID),
    CONSTRAINT Client_FK1 FOREIGN KEY (S_Type) REFERENCES Services_T(SName),
	UNIQUE (TM_ID)
) ;

CREATE TABLE Service_T (
        SName            VARCHAR(200)   NOT NULL,
        SNumber          INT(20)        NOT NULL,
    CONSTRAINT Service_PK PRIMARY KEY (SNumber)
) ;


CREATE TABLE Invoice_T (
        INumber             VARCHAR(8)    NOT NULL,
        CNum            	VARCHAR(20)   NOT NULL,
		TotalCost			DECIMAL(3,1)  NOT NULL,
        Paid                BOOLEAN       NOT NULL,
        LastPaymentDATE     DATE,
		NextPaymentDATE     DATE,
		Team_member_assigned  VARCHAR(200)  NOT NULL,
    CONSTRAINT Invoice_PK PRIMARY KEY (INumber),
    CONSTRAINT Invoice_FK1 FOREIGN KEY (Team_member_assigned) REFERENCES TeamMember_T(TM_ID),
	CONSTRAINT Invoice_FK2 FOREIGN KEY (CNum) REFERENCES Client_T(Client_ID)        
) ;

CREATE TABLE TeamMemberLogin_T(
		UserName		VARCHAR(16),
		UserPwd			VARCHAR(8),
		PwdHash			VARCHAR(255),
		UserID			CHAR(4),
	CONSTRAINT TeamMemberLogin_PK PRIMARY KEY (Username),
	CONSTRAINT TeamMemberLogin_FK FOREIGN KEY (UserID) REFERENCES TeamMember_T(TM_ID),
	UNIQUE (UserID)
);

CREATE TABLE ClientLogin_T(
		UserName		VARCHAR(16),
		UserPwd			VARCHAR(8),
		PwdHash			VARCHAR(255),
		UserID			CHAR(4),
	CONSTRAINT ClientLogin_PK PRIMARY KEY (Username),
	CONSTRAINT ClientLogin_FK FOREIGN KEY (UserID) REFERENCES Client_T(Client_ID),
	UNIQUE (UserID)
);

