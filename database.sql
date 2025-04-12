CREATE DATABASE HospitalDB;
USE HospitalDB;

CREATE TABLE Patient (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255),
    Age INT,
    Gender VARCHAR(10),
    Contact VARCHAR(20),
    Address TEXT
);

CREATE TABLE Doctor (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255),
    Specialization VARCHAR(255),
    Contact VARCHAR(20)
);

CREATE TABLE Appointment (
    AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    Date DATE,
    Time TIME,
    Status VARCHAR(50),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID)
);

CREATE TABLE Bill (
    BillID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    Amount DECIMAL(10,2),
    Date DATE,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);

CREATE TABLE Medicine (
    MedicineID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255),
    Price DECIMAL(10,2),
    Stock INT
);

CREATE TABLE Prescription (
    PrescriptionID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    MedicineID INT,
    Dosage VARCHAR(50),
    Instructions TEXT,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID),
    FOREIGN KEY (MedicineID) REFERENCES Medicine(MedicineID)
);

CREATE TABLE DiseaseMedicine (
    DiseaseID INT AUTO_INCREMENT PRIMARY KEY,
    DiseaseName VARCHAR(255),
    MedicineName VARCHAR(255)
);

DELIMITER //

CREATE FUNCTION GetTotalBill(p_PatientID INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);

    SELECT SUM(Amount) INTO total 
    FROM Bill 
    WHERE PatientID = p_PatientID;

    RETURN IFNULL(total, 0.00);
END //

DELIMITER ;



