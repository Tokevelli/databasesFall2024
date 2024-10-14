-- 1. Create the PayType Table (Supertype)
CREATE TABLE PayType (
    PayTypeID INT PRIMARY KEY,
    PayScale ENUM('Hourly', 'Salary', 'Per Diem') NOT NULL
);

-- 2. Create the Specialization Table
CREATE TABLE Specialization (
    SpecializationID INT AUTO_INCREMENT PRIMARY KEY,
    SpecializationType VARCHAR(100) NOT NULL
);

-- 3. Create the Biome Table
CREATE TABLE Biome (
    BiomeID INT AUTO_INCREMENT PRIMARY KEY,
    BiomeType VARCHAR(50) NOT NULL
);

-- 4. Create the JobRank Table (renamed from Rank to avoid reserved word conflicts)
CREATE TABLE JobRank (
    RankID INT AUTO_INCREMENT PRIMARY KEY,
    RankName VARCHAR(100) NOT NULL,
    PayTypeID INT,
    FOREIGN KEY (PayTypeID) REFERENCES PayType(PayTypeID)
);

-- 5. Create the Person Table
CREATE TABLE Person (
    PersonID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Age INT,
    RankID INT,
    SpecializationID INT,
    FOREIGN KEY (RankID) REFERENCES JobRank(RankID),
    FOREIGN KEY (SpecializationID) REFERENCES Specialization(SpecializationID)
);

-- 6. Create the Location Table
CREATE TABLE Location (
    LocationID INT AUTO_INCREMENT PRIMARY KEY,
    PlanetName VARCHAR(100) NOT NULL,
    BiomeID INT,
    FOREIGN KEY (BiomeID) REFERENCES Biome(BiomeID)
);

-- 7. Create the Hourly Table (Subtype)
CREATE TABLE Hourly (
    PersonID INT PRIMARY KEY,
    PayTypeID INT,
    HourlyRate DECIMAL(10, 2) NOT NULL,
    HoursWorked INT,
    OvertimeEligibility BOOLEAN,
    FOREIGN KEY (PayTypeID) REFERENCES PayType(PayTypeID),
    FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
);

-- 8. Create the Salary Table (Subtype)
CREATE TABLE Salary (
    PersonID INT PRIMARY KEY,
    PayTypeID INT,
    AnnualSalary DECIMAL(10, 2) NOT NULL,
    BonusEligibility BOOLEAN,
    FOREIGN KEY (PayTypeID) REFERENCES PayType(PayTypeID),
    FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
);

-- 9. Create the Per Diem Table (Subtype)
CREATE TABLE PerDiem (
    PersonID INT PRIMARY KEY,
    PayTypeID INT,
    DailyRate DECIMAL(10, 2) NOT NULL,
    ExpenseAllowance DECIMAL(10, 2),
    FOREIGN KEY (PayTypeID) REFERENCES PayType(PayTypeID),
    FOREIGN KEY (PersonID) REFERENCES Person(PersonID)
);

-- 10. Create the Assignment Table (Many-to-Many Bridge Table)
CREATE TABLE Assignment (
    AssignmentID INT AUTO_INCREMENT PRIMARY KEY,
    PersonID INT,
    LocationID INT,
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (PersonID) REFERENCES Person(PersonID),
    FOREIGN KEY (LocationID) REFERENCES Location(LocationID)
);
