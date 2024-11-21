-- File: assignment2.sql

-- 1. Create the database and user
CREATE DATABASE aparaty;

CREATE USER '279783'@'localhost' IDENTIFIED BY 'Kulakowski83';
GRANT SELECT, INSERT, UPDATE ON aparaty.* TO '279783'@'localhost';
FLUSH PRIVILEGES;

-- Switch to the created database
USE aparaty;

-- 2. Create tables
CREATE TABLE Producent (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    nazwa VARCHAR(50) NOT NULL,
    kraj VARCHAR(20) DEFAULT 'nieznany',
    adresKorespondencyjny VARCHAR(100) DEFAULT 'nieznany'
) AUTO_INCREMENT = 1;

CREATE TABLE Matryca (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    przekatna DECIMAL(4,2) CHECK (przekatna > 0),
    rozdzielczosc DECIMAL(3,1) CHECK (rozdzielczosc > 0),
    typ VARCHAR(10)
) AUTO_INCREMENT=100;

CREATE TABLE Obiektyw (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    model VARCHAR(30),
    minPrzeslona FLOAT CHECK (minPrzeslona > 0),
    maxPrzeslona FLOAT CHECK (maxPrzeslona > minPrzeslona)
) AUTO_INCREMENT = 1;

CREATE TABLE Aparat (
    model VARCHAR(30),
    producent INT,
    matryca INT,
    obiektyw INT,
    waga FLOAT CHECK (waga > 0),
    typ ENUM('kompaktowy', 'lustrzanka', 'profesjonalny', 'inny'),
    PRIMARY KEY (model),
    FOREIGN KEY (producent) REFERENCES Producent(ID),
    FOREIGN KEY (matryca) REFERENCES Matryca(ID),
    FOREIGN KEY (obiektyw) REFERENCES Obiektyw(ID)
);

-- 3. Insert records into tables

-- Switch to the correct database
USE aparaty;

-- Insert valid records into the `Producent` table
INSERT INTO Producent (nazwa, kraj, adresKorespondencyjny) VALUES
('Canon', 'Japonia', 'Tokyo, Japan'),
('Nikon', 'Japonia', 'Tokyo, Japan'),
('Sony', 'Japonia', 'Osaka, Japan'),
('DJI', 'Chiny', 'Shenzhen, China'),
('Huawei', 'Chiny', 'Shenzhen, China'),
('Leica', 'Niemcy', 'Wetzlar, Germany'),
('Fujifilm', 'Japonia', 'Tokyo, Japan'),
('Olympus', 'Japonia', 'Tokyo, Japan'),
('Kodak', 'USA', 'Rochester, NY'),
('Panasonic', 'Japonia', 'Osaka, Japan'),
('Sigma', 'Japonia', 'Aizu, Japan'),
('Pentax', 'Japonia', 'Tokyo, Japan'),
('GoPro', 'USA', 'San Mateo, CA'),
('Xiaomi', 'Chiny', 'Beijing, China'),
('Zhiyun', 'Chiny', 'Guangdong, China');

-- Insert valid records into the `Matryca` table
INSERT INTO Matryca (przekatna, rozdzielczosc, typ) VALUES
(1.5, 12.3, 'CMOS'),
(2.0, 20.1, 'CMOS'),
(1.7, 16.0, 'CCD'),
(1.0, 10.5, 'CMOS'),
(1.3, 14.2, 'CCD'),
(2.5, 24.0, 'CMOS'),
(3.0, 36.5, 'CMOS'),
(1.4, 18.1, 'CMOS'),
(2.2, 22.5, 'CMOS'),
(1.8, 15.6, 'CCD'),
(1.1, 13.3, 'CCD'),
(2.7, 30.2, 'CMOS'),
(2.3, 25.5, 'CMOS'),
(1.6, 17.4, 'CCD'),
(2.8, 28.0, 'CMOS');

-- Insert valid records into the `Obiektyw` table
INSERT INTO Obiektyw (model, minPrzeslona, maxPrzeslona) VALUES
('EF 50mm', 1.2, 16.0),
('Nikkor 24-70mm', 2.8, 22.0),
('Sony 85mm', 1.4, 16.0),
('Sigma 35mm', 1.4, 16.0),
('Tamron 70-200mm', 2.8, 22.0),
('Zeiss 50mm', 1.8, 22.0),
('Canon RF 85mm', 2.0, 22.0),
('Sony FE 24mm', 2.0, 22.0),
('Fujinon XF 18mm', 1.4, 16.0),
('Olympus M.Zuiko', 1.8, 22.0),
('Panasonic Lumix', 1.4, 16.0),
('Pentax DA 50mm', 2.8, 22.0),
('Leica Summicron', 2.0, 16.0),
('GoPro Lens', 2.8, 16.0),
('Xiaomi Lens', 3.5, 22.0);

-- Insert valid records into the `Aparat` table
INSERT INTO Aparat (model, producent, matryca, obiektyw, waga, typ) VALUES
('Canon EOS R6', 1, 100, 1, 680, 'lustrzanka'),
('Nikon D850', 2, 101, 2, 915, 'profesjonalny'),
('Sony Alpha 7C', 3, 102, 3, 509, 'kompaktowy'),
('DJI Mavic 3', 4, 103, 4, 895, 'inny'),
('Huawei P40 Pro', 5, 104, 5, 226, 'kompaktowy'),
('Leica Q2', 6, 105, 6, 734, 'profesjonalny'),
('Fujifilm X-T4', 7, 106, 7, 607, 'lustrzanka'),
('Olympus OM-D E-M1', 8, 107, 8, 500, 'kompaktowy'),
('Kodak PIXPRO', 9, 108, 9, 445, 'inny'),
('Panasonic Lumix S5', 10, 109, 10, 630, 'profesjonalny'),
('Sigma fp L', 11, 110, 11, 422, 'inny'),
('Pentax K-1', 12, 111, 12, 1010, 'profesjonalny'),
('GoPro HERO10', 13, 112, 13, 158, 'inny'),
('Xiaomi Mi 11 Ultra', 14, 113, 14, 234, 'kompaktowy'),
('Zhiyun Smooth', 15, 114, 15, 450, 'inny');

-- Attempt to insert invalid records (to test constraints)
-- Negative weight (should fail)
INSERT INTO Aparat (model, producent, matryca, obiektyw, waga, typ)
VALUES ('InvalidWeight', 1, 100, 1, -5, 'kompaktowy');

-- Invalid aperture range (min >= max) (should fail)
INSERT INTO Obiektyw (model, minPrzeslona, maxPrzeslona)
VALUES ('InvalidAperture', 2.8, 2.8);

-- Invalid foreign key (nonexistent producer) (should fail)
INSERT INTO Aparat (model, producent, matryca, obiektyw, waga, typ)
VALUES ('InvalidProducer', 99, 100, 1, 500, 'kompaktowy');

-- Invalid matryca ID (nonexistent sensor) (should fail)
INSERT INTO Aparat (model, producent, matryca, obiektyw, waga, typ)
VALUES ('InvalidMatryca', 1, 999, 1, 500, 'kompaktowy');

-- use root 
docker exec -it mariadb-container mariadb -D aparaty -u root -prootpassword
-- 4. Procedure to generate camera models
DELIMITER //

CREATE PROCEDURE DodajModeleAparatow()
BEGIN
    DECLARE i INT DEFAULT 0;
    DECLARE losowyModel VARCHAR(30);
    DECLARE matrycaID INT;
    DECLARE obiektywID INT;
    DECLARE producentID INT;
    DECLARE typ ENUM('kompaktowy', 'lustrzanka', 'profesjonalny', 'inny');

    -- Pętla generująca 100 nowych modeli aparatów
    WHILE i < 100 DO
        -- Losowanie danych z tabel
        SELECT ID INTO matrycaID FROM Matryca ORDER BY RAND() LIMIT 1;
        SELECT ID INTO obiektywID FROM Obiektyw ORDER BY RAND() LIMIT 1;
        SELECT ID INTO producentID FROM Producent ORDER BY RAND() LIMIT 1;

        -- Generowanie losowego modelu aparatu
        SET losowyModel = CONCAT('Model_', i + 1);  -- Tworzenie nazwy modelu jak "Model_1", "Model_2", itd.
        
        -- Losowanie typu aparatu
        SET typ = (SELECT typ FROM Aparat ORDER BY RAND() LIMIT 1);
        
        -- Wstawienie nowego modelu aparatu do tabeli
        INSERT INTO Aparat (model, producent, matryca, obiektyw, waga, typ)
        VALUES (losowyModel, producentID, matrycaID, obiektywID, ROUND(RAND() * 1000, 2), typ);
        
        SET i = i + 1;  -- Zwiększanie licznika
    END WHILE;
END;
//

DELIMITER ;
--call
CALL DodajModeleAparatow();

-- 5. Function for smallest sensor diagonal by producer
DELIMITER //
CREATE FUNCTION NajmniejszaPrzekatna(IDProducenta INT)
RETURNS VARCHAR(30)
BEGIN
    RETURN (
        SELECT model
        FROM Aparat
        JOIN Matryca ON Aparat.matryca = Matryca.ID
        WHERE Aparat.producent = IDProducenta
        ORDER BY Matryca.przekatna ASC
        LIMIT 1
    );
END;
//
DELIMITER ;
--call
CALL NajmniejszaPrzekatna(1);


-- 6. Trigger to add missing producer
DELIMITER //
CREATE TRIGGER DodajProducenta
BEFORE INSERT ON Aparat
FOR EACH ROW
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Producent WHERE ID = NEW.producent) THEN
        INSERT INTO Producent (ID, nazwa) VALUES (NEW.producent, 'Nowy');
    END IF;
END;
//
DELIMITER ;

-- 7. Function to count models for a given sensor
DELIMITER //
CREATE FUNCTION LiczbaModeliMatrycy(IDMatrycy INT)
RETURNS INT
BEGIN
    RETURN (SELECT COUNT(*) FROM Aparat WHERE matryca = IDMatrycy);
END;
//
DELIMITER ;

--command
SELECT LiczbaModeliMatrycy(1);

-- 8. Trigger to delete unused sensors
DELIMITER //
CREATE TRIGGER UsunMatryce
AFTER DELETE ON Aparat
FOR EACH ROW
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Aparat WHERE matryca = OLD.matryca) THEN
        DELETE FROM Matryca WHERE ID = OLD.matryca;
    END IF;
END;
//
DELIMITER ;


-- 9. 
CREATE VIEW WidokLustrzanek AS
SELECT Aparat.model, Aparat.waga, Producent.nazwa AS producent,
       Matryca.przekatna, Matryca.rozdzielczosc,
       Obiektyw.minPrzeslona, Obiektyw.maxPrzeslona
FROM Aparat
JOIN Producent ON Aparat.producent = Producent.ID
JOIN Matryca ON Aparat.matryca = Matryca.ID
JOIN Obiektyw ON Aparat.obiektyw = Obiektyw.ID
WHERE Aparat.typ = 'lustrzanka' AND Producent.kraj != 'Chiny';

-- 10. View for producer models and deletion operation
CREATE VIEW WidokProducentow AS
SELECT Producent.nazwa, Producent.kraj, Aparat.model
FROM Producent
JOIN Aparat ON Aparat.producent = Producent.ID;

DELETE FROM Aparat
WHERE producent IN (SELECT ID FROM Producent WHERE kraj = 'Chiny');

--command
SELECT * FROM WidokLustrzanek;

-- 11. Column for model count and trigger
ALTER TABLE Producent ADD liczbaModeli INT DEFAULT 0 NOT NULL;

UPDATE Producent SET liczbaModeli = (
    SELECT COUNT(*) FROM Aparat WHERE Aparat.producent = Producent.ID
);

DELIMITER //
CREATE TRIGGER AktualizujLiczbeModeli
AFTER INSERT OR DELETE ON Aparat
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM Producent WHERE ID = NEW.producent) THEN
        UPDATE Producent
        SET liczbaModeli = (SELECT COUNT(*) FROM Aparat WHERE producent = NEW.producent)
        WHERE ID = NEW.producent;
    END IF;
END;
//
DELIMITER ;

