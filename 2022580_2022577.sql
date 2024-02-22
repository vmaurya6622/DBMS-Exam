
-- ====================================================
-- ========= Vishal Kumar Maurya (2022580) ============
-- =========    Vipul Verma (2022577)      ============
-- ====================================================

DROP DATABASE IF EXISTS MCM_Sangeet_Company;
CREATE DATABASE MCM_Sangeet_Company;
USE MCM_Sangeet_Company;

-- Initialisation of Creation of the Tables.

CREATE TABLE Company (
    Company_id INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255) NOT NULL,
    Address VARCHAR(255),
    Phone_Num VARCHAR(50),
    Email_id VARCHAR(255) not null,
    NumOfEmployee INT unsigned,
    Since DATE
);

CREATE TABLE Director (
    director_id INT PRIMARY KEY AUTO_INCREMENT,
    director_name VARCHAR(255)
);

CREATE TABLE Music_Group (
    group_id INT PRIMARY KEY AUTO_INCREMENT,
    group_name VARCHAR(255) NOT NULL,
    director_id INT,
    FOREIGN KEY (director_id) REFERENCES Director(director_id)
);

CREATE TABLE Member (
    member_ID INT PRIMARY KEY AUTO_INCREMENT,
    Show_ID INT,
    role VARCHAR(50)
);

CREATE TABLE MusicGroup_Members (
    group_id INT,
    member_id INT,
    FOREIGN KEY (group_id) REFERENCES Music_Group(group_id),
    FOREIGN KEY (member_id) REFERENCES Member(member_id),
    PRIMARY KEY (group_id, member_id)
);



CREATE TABLE Candidate (
    candidate_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    email VARCHAR(255) NOT NULL,
    dob DATE NOT NULL,
    password VARCHAR(255) NOT NULL,
    selected BOOL DEFAULT FALSE,
    experience TINYINT UNSIGNED,
    media_type ENUM('audio', 'video')
);

CREATE TABLE PhoneNumbers_candidate (
    phone_id INT PRIMARY KEY AUTO_INCREMENT,
    candidate_id INT,
    phone_number VARCHAR(50) NOT NULL,
    FOREIGN KEY (candidate_id) REFERENCES Candidate(candidate_id)
);

CREATE TABLE MusicFile (
    file_id INT PRIMARY KEY AUTO_INCREMENT,
    candidate_id INT,
    file_name VARCHAR(255),
    file_type ENUM('audio', 'video'),
    file_duration INT, -- Duration in seconds
    FOREIGN KEY (candidate_id) REFERENCES Candidate(candidate_id)
);

CREATE TABLE Album (
    album_id INT PRIMARY KEY AUTO_INCREMENT,
    group_id INT,
    name VARCHAR(255) NOT NULL,
    added_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    approved BOOL DEFAULT FALSE,
    FOREIGN KEY (group_id) REFERENCES Music_Group(group_id)
);

CREATE TABLE Application (
    application_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30),
    date_of_birth DATE,
    file_type ENUM('audio', 'video'),
    group_id INT,
    show_id INT,
    experience TINYINT UNSIGNED,
    submitted_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    acceptance BOOL DEFAULT FALSE,
    FOREIGN KEY (group_id) REFERENCES Music_Group(group_id)
);
CREATE TABLE LiveShow (
    SHOW_ID INT PRIMARY KEY AUTO_INCREMENT,
    SUBMISSION_ID INT,
    PREFOR_DATE DATE,
    RESULT VARCHAR(200),
    FOREIGN KEY (SUBMISSION_ID) REFERENCES Application(application_id)
);

CREATE TABLE PhoneNumbers_for_Applications (
    phone_id INT PRIMARY KEY AUTO_INCREMENT,
    candidate_id INT,
    phone_number VARCHAR(50) NOT NULL,
    FOREIGN KEY (candidate_id) REFERENCES Candidate(candidate_id)
);


CREATE TABLE Panelist (
    panelist_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    AGE INT UNSIGNED NOT NULL,
    Industry_experience VARCHAR(255),
    association VARCHAR(255)
);

CREATE TABLE Panelist_Application (
    panelist_id INT,
    application_id INT,
    file_type ENUM('audio', 'video'),
    accepted_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (panelist_id, application_id),
    FOREIGN KEY (panelist_id) REFERENCES Panelist(panelist_id),
    FOREIGN KEY (application_id) REFERENCES Application(application_id)
);

CREATE TABLE MusicAlbum (
    album_id INT PRIMARY KEY AUTO_INCREMENT,
    member_id INT,
    group_id INT,
    genre_type ENUM('audio', 'video'),
    album_name VARCHAR(255),
    approved BOOL DEFAULT FALSE,
    date_of_release TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Admin (
    admin_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL
);

CREATE TABLE Trailer (
    trailer_id INT PRIMARY KEY AUTO_INCREMENT,
    album_id INT,
    name VARCHAR(255),
    date_of_release DATE,
    number_of_visits INT,
    number_of_likes INT,
    number_of_dislikes INT,
    FOREIGN KEY (album_id) REFERENCES MusicAlbum(album_id),
    group_id INT,
    approved BOOL DEFAULT FALSE,
    FOREIGN KEY (group_id) REFERENCES Music_Group(group_id)
);

CREATE TABLE Advertisement (
    Advertisement_id INT PRIMARY KEY AUTO_INCREMENT,
    Company_id INT,
    website_name VARCHAR(225) NOT NULL,
    URL VARCHAR(255) NOT NULL,
    Media VARCHAR(50) NOT NULL,
    views BIGINT UNSIGNED NOT NULL,
    likes BIGINT UNSIGNED NOT NULL,
    dislikes BIGINT UNSIGNED NOT NULL,
    Description VARCHAR(250) NOT NULL,
    FOREIGN KEY (Company_id) REFERENCES Company(Company_id)
);

CREATE TABLE Trailer_Approval (    -- approved trailers
    trailer_id INT PRIMARY KEY,
    admin_id INT,
    approval_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (trailer_id) REFERENCES Trailer(trailer_id),
    FOREIGN KEY (admin_id) REFERENCES Admin(admin_id)
);

CREATE TABLE Distributor (
    distributor_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    phone_no VARCHAR(50),
    distributor_name VARCHAR(255)
);

CREATE TABLE Distributor_Deals (
    deal_id INT PRIMARY KEY AUTO_INCREMENT,
    album_id INT,
    distributor_id INT,
    price FLOAT,
    deal_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (album_id) REFERENCES MusicAlbum(album_id),
    FOREIGN KEY (distributor_id) REFERENCES Distributor(distributor_id)
);

CREATE TABLE Download (
    download_id INT PRIMARY KEY AUTO_INCREMENT,
    distributor_id INT,
    album_id INT,
    download_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    download_status ENUM('success', 'failure'),
    download_count BIGINT UNSIGNED,
    FOREIGN KEY (distributor_id) REFERENCES Distributor(distributor_id),
    FOREIGN KEY (album_id) REFERENCES MusicAlbum(album_id)
);


-- ____________________________________________________
-- =============== Value Insert Commands ==============
-- ____________________________________________________ 

INSERT INTO Company (Name, Address, Phone_Num, Email_id, NumOfEmployee, Since) VALUES
('ABC Corporation', '123 Main St, Anytown, USA', '+1234567890', 'info@abccorp.com', 100, '2000-01-01'),
('XYZ Industries', '456 Elm St, Othertown, USA', '+0987654321', 'info@xyzindustries.com', 200, '1995-05-10'),
('LMN Enterprises', '789 Oak St, Somewhere, USA', '+1357924680', 'info@lmnent.com', 75, '2010-11-15'),
('PQR Limited', '321 Pine St, Nowhere, USA', '+2468135790', 'info@pqrltd.com', 150, '2005-03-20'),
('EFG Inc.', '987 Cedar St, Anytown, USA', '+3692581470', 'info@efginc.com', 50, '2015-08-25'),
('RST Corporation', '654 Maple St, Othertown, USA', '+9753186420', 'info@rstcorp.com', 300, '1990-07-30'),
('UVW Holdings', '852 Birch St, Somewhere, USA', '+7418529630', 'info@uvwholdings.com', 225, '2008-09-05'),
('GHI Group', '159 Spruce St, Nowhere, USA', '+8529631470', 'info@ghigroup.com', 180, '2003-12-12'),
('JKL Enterprises', '456 Oak St, Anytown, USA', '+3691472580', 'info@jklent.com', 80, '2012-06-18'),
('MNO Limited', '753 Elm St, Othertown, USA', '+2583691470', 'info@mnoltd.com', 120, '1998-04-02');

INSERT INTO Director (director_name) VALUES
('John Smith'),
('Alice Johnson'),
('Michael Lee'),
('Emily Brown'),
('Daniel Wilson'),
('Olivia Martinez'),
('David Anderson'),
('Sophia Garcia'),
('Matthew Taylor'),
('Emma Rodriguez');

INSERT INTO Music_Group (group_name, director_id) VALUES
('Pop Stars', 1),
('Rock Band', 2),
('Classical Ensemble', 3),
('Jazz Orchestra', 4),
('Folk Group', 5),
('Hip Hop Crew', 6),
('Country Band', 7),
('Electronic DJs', 8),
('Indie Artists', 9),
('Metal Band', 10);

INSERT INTO Advertisement (Company_id, website_name, URL, Media, views, likes, dislikes, Description) VALUES
(1, 'Example Website 1', 'https://www.example.com/1', 'Social Media', 10000, 500, 20, 'Description of advertisement 1'),
(2, 'Example Website 2', 'https://www.example.com/2', 'Banner Ad', 8000, 600, 30, 'Description of advertisement 2'),
(3, 'Example Website 3', 'https://www.example.com/3', 'Video Ad', 12000, 7000, 40, 'Description of advertisement 3'),
(4, 'Example Website 4', 'https://www.example.com/4', 'Social Media', 15000, 800, 50, 'Description of advertisement 4'),
(5, 'Example Website 5', 'https://www.example.com/5', 'Banner Ad', 9000, 400, 25, 'Description of advertisement 5'),
(6, 'Example Website 6', 'https://www.example.com/6', 'Video Ad', 11000, 750, 35, 'Description of advertisement 6'),
(7, 'Example Website 7', 'https://www.example.com/7', 'Social Media', 13000, 550, 28, 'Description of advertisement 7'),
(8, 'Example Website 8', 'https://www.example.com/8', 'Banner Ad', 10000, 650, 32, 'Description of advertisement 8'),
(9, 'Example Website 9', 'https://www.example.com/9', 'Video Ad', 14000, 850, 45, 'Description of advertisement 9'),
(10, 'Example Website 10', 'https://www.example.com/10', 'Social Media', 16000, 700, 38, 'Description of advertisement 10');


INSERT INTO Member (member_ID, Show_ID, role) VALUES
(1, 101, 'Lead Vocalist'),
(2, 102, 'Lead Guitarist'),
(3, 103, 'Drummer'),
(4, 104, 'Bassist'),
(5, 105, 'Keyboardist'),
(6, 106, 'Violinist'),
(7, 107, 'Flutist'),
(8, 108, 'Saxophonist'),
(9, 109, 'Cellist'),
(10, 110, 'Trumpeter');

INSERT INTO MusicGroup_Members (group_id, member_id) VALUES
(1, 1), (2, 1), 
(2, 2) ,
(6, 6), (7, 6), 
(7, 7), (8, 7),
(8, 8), (9, 8),
(9, 9), (10, 9),
(10, 10),
(1, 2),
(1, 3),
(1, 4),
(1, 5);      



INSERT INTO Candidate (name, email, dob, password, selected, experience, media_type) VALUES
('John Doe', 'john@example.com', '1990-01-15', 'password1', TRUE, 5, 'audio'),
('Alice Johnson', 'alice@example.com', '1995-03-20', 'password2', FALSE, 3, 'video'),
('Michael Lee', 'michael@example.com', '1992-07-10', 'password3', TRUE, 4, 'audio'),
('Emily Brown', 'emily@example.com', '1998-09-05', 'password4', FALSE, 2, 'video'),
('Daniel Wilson', 'daniel@example.com', '1993-11-12', 'password5', TRUE, 6, 'audio'),
('Olivia Martinez', 'olivia@example.com', '1994-04-25', 'password6', FALSE, 1, 'audio'),
('David Anderson', 'david@example.com', '1996-06-30', 'password7', TRUE, 3, 'video'),
('Sophia Garcia', 'sophia@example.com', '1991-02-18', 'password8', FALSE, 5, 'audio'),
('Matthew Taylor', 'matthew@example.com', '1997-08-22', 'password9', TRUE, 2, 'video'),
('Emma Rodriguez', 'emma@example.com', '1999-12-08', 'password10', TRUE, 4, 'audio'),
('John Doe', 'john@example.com', '1990-01-15', 'password1', TRUE, 5, 'video'),
('Alice Johnson', 'alice@example.com', '1995-03-20', 'password2', FALSE, 3, 'video'),
('Michael Lee', 'michael@example.com', '1992-07-10', 'password3', TRUE, 4, 'audio'),
('Emily Brown', 'emily@example.com', '1998-09-05', 'password4', FALSE, 2, 'video');

INSERT INTO PhoneNumbers_candidate (candidate_id, phone_number) VALUES
(1, '123-456-7890'),
(2, '234-567-8901'),
(3, '345-678-9012'),
(4, '456-789-0123'),
(5, '567-890-1234'),
(6, '678-901-2345'),
(7, '789-012-3456'),
(8, '890-123-4567'),
(9, '901-234-5678'),
(10, '012-345-6789');

INSERT INTO MusicFile (candidate_id, file_name, file_type, file_duration) VALUES
(1, 'song1.mp3', 'audio', 240),
(2, 'video1.mp4', 'video', 180),
(3, 'song2.mp3', 'audio', 300),
(4, 'video2.mp4', 'video', 210),
(5, 'song3.mp3', 'audio', 270),
(6, 'video3.mp4', 'video', 190),
(7, 'song4.mp3', 'audio', 320),
(8, 'video4.mp4', 'video', 220),
(9, 'song5.mp3', 'audio', 280),
(1, 'song1.mp3', 'video', 240),
(2, 'video1.mp4', 'video', 180),
(3, 'song2.mp3', 'audio', 300),
(4, 'video2.mp4', 'audio', 210),
(10, 'video5.mp4', 'video', 230);

INSERT INTO Admin (username, password, full_name, email) VALUES
('admin1', 'password1', 'Admin One', 'admin1@example.com'),
('admin2', 'password2', 'Admin Two', 'admin2@example.com'),
('admin3', 'password3', 'Admin Three', 'admin3@example.com'),
('admin4', 'password4', 'Admin Four', 'admin4@example.com'),
('admin5', 'password5', 'Admin Five', 'admin5@example.com'),
('admin6', 'password6', 'Admin Six', 'admin6@example.com'),
('admin7', 'password7', 'Admin Seven', 'admin7@example.com'),
('admin8', 'password8', 'Admin Eight', 'admin8@example.com'),
('admin9', 'password9', 'Admin Nine', 'admin9@example.com'),
('admin10', 'password10', 'Admin Ten', 'admin10@example.com');

INSERT INTO Album (group_id, name, approved) VALUES
(1, 'Pop Hits 2024', TRUE),
(2, 'Rock Anthems 2024', FALSE),
(3, 'Classical Masterpieces 2024', TRUE),
(4, 'Jazz Standards 2024', FALSE),
(5, 'Folk Favorites 2024', TRUE),
(6, 'Hip Hop Jams 2024', FALSE),
(7, 'Country Classics 2024', TRUE),
(8, 'Electronic Beats 2024', FALSE),
(9, 'Indie Highlights 2024', TRUE),
(10, 'Metal Mayhem 2024', FALSE);

INSERT INTO Application (name, date_of_birth, file_type, group_id, experience) VALUES
('John Doe', '1990-01-15', 'audio', 1, 5),
('Alice Johnson', '1995-03-20', 'video', 2, 3),
('Michael Lee', '1992-07-10', 'audio', 3, 4),
('Emily Brown', '1998-09-05', 'video', 4, 2),
('Daniel Wilson', '1993-11-12', 'audio', 5, 6),
('Olivia Martinez', '1994-04-25', 'audio', 6, 1),
('David Anderson', '1996-06-30', 'video', 7, 3),
('Sophia Garcia', '1991-02-18', 'audio', 8, 5),
('Matthew Taylor', '1997-08-22', 'video', 9, 2),
('Emma Rodriguez', '1999-12-08', 'audio', 10, 4);

INSERT INTO LiveShow (SHOW_ID, PREFOR_DATE, RESULT, SUBMISSION_ID) VALUES
(101, '2024-02-20', 'Successful', 1),
(102, '2024-03-15', 'Pending', 2),
(103, '2024-04-10', 'Rejected', 3),
(104, '2024-05-05', 'Successful', 4),
(105, '2024-06-20', 'Pending', 5),
(106, '2024-07-15', 'Successful', 6),
(107, '2024-08-10', 'Pending', 7),
(108, '2024-09-05', 'Successful', 8),
(109, '2024-10-20', 'Pending', 9),
(110, '2024-11-15', 'Successful', 10);

INSERT INTO PhoneNumbers_for_Applications (candidate_id, phone_number) VALUES
(1, '123-456-7890'),
(2, '234-567-8901'),
(3, '345-678-9012'),
(4, '456-789-0123'),
(5, '567-890-1234'),
(6, '678-901-2345'),
(7, '789-012-3456'),
(8, '890-123-4567'),
(9, '901-234-5678'),
(10, '012-345-6789');

INSERT INTO Panelist (name, AGE, Industry_experience, association) VALUES
('John Smith', 45, 'Music Production', 'Music Association'),
('Alice Johnson', 50, 'Live Performance', 'Concert Association'),
('Michael Lee', 55, 'Music Education', 'Music Education Board'),
('Emily Brown', 60, 'Music Composition', 'Composer Guild'),
('Daniel Wilson', 40, 'Music Marketing', 'Music Marketing Agency'),
('Olivia Martinez', 35, 'Music Journalism', 'Music Journalists Union'),
('David Anderson', 48, 'Music Technology', 'Music Tech Consortium'),
('Sophia Garcia', 52, 'Music Management', 'Music Management Group'),
('Matthew Taylor', 58, 'Music Licensing', 'Music Licensing Firm'),
('Emma Rodriguez', 38, 'Music Therapy', 'Music Therapy Association');

INSERT INTO Panelist_Application (panelist_id, application_id, file_type) VALUES
(1, 1, 'audio'),
(2, 2, 'video'),
(3, 3, 'audio'),
(4, 4, 'video'),
(5, 5, 'audio'),
(6, 6, 'audio'),
(7, 7, 'video'),
(8, 8, 'audio'),
(9, 9, 'video'),
(10, 10, 'audio');

INSERT INTO MusicAlbum (member_id, group_id, genre_type, album_name, approved, date_of_release) VALUES
(1, 1, 'audio', 'Pop Hits 2024', TRUE, '2024-01-01 00:00:00'),
(2, 2, 'audio', 'Rock Anthems 2024', TRUE, '2024-02-01 00:00:00'),
(3, 3, 'video', 'Classical Masterpieces 2024', FALSE, '2020-03-01 00:00:00'),
(4, 4, 'audio', 'Jazz Standards 2024', TRUE, '2024-04-01 00:00:00'),
(5, 5, 'video', 'Folk Favorites 2024', TRUE, '2024-05-01 00:00:00'),
(6, 6, 'audio', 'Hip Hop Jams 2024', FALSE, '2020-06-01 00:00:00'),
(7, 7, 'audio', 'Country Classics 2024', TRUE, '2024-07-01 00:00:00'),
(8, 8, 'video', 'Electronic Beats 2024', TRUE, '2024-08-01 00:00:00'),
(9, 9, 'audio', 'Indie Highlights 2024', FALSE, '2020-09-01 00:00:00'),
(10, 10, 'video', 'Metal Mayhem 2024', TRUE, '2024-10-01 00:00:00');


INSERT INTO Trailer (album_id, name, date_of_release, number_of_visits, number_of_likes, number_of_dislikes, approved)
VALUES
(1, 'Pop Hits Trailer', '2024-01-15', 1000, 800, 200, TRUE),
(2, 'Rock Anthems Trailer', '2024-02-15', 900, 700, 200, TRUE),
(3, 'Classical Masterpieces Trailer', '2024-03-15', 800, 600, 200, FALSE),
(4, 'Jazz Standards Trailer', '2024-04-15', 700, 500, 200, FALSE),
(5, 'Folk Favorites Trailer', '2024-05-15', 600, 400, 200, TRUE),
(6, 'Hip Hop Jams Trailer', '2024-06-15', 500, 300, 200, TRUE),
(7, 'Country Classics Trailer', '2024-07-15', 400, 200, 200, FALSE),
(8, 'Electronic Beats Trailer', '2024-08-15', 300, 100, 200, TRUE),
(9, 'Indie Highlights Trailer', '2024-09-15', 200, 50, 150, FALSE),
(10, 'Metal Mayhem Trailer', '2024-10-15', 100, 25, 75, TRUE);

INSERT INTO Distributor (name, phone_no, distributor_name) VALUES
('ABC Distributors', '123-456-7890', 'ABC'),
('XYZ Distributors', '234-567-8901', 'XYZ'),
('123 Distributors', '345-678-9012', '123'),
('456 Distributors', '456-789-0123', '456'),
('789 Distributors', '567-890-1234', '789'),
('890 Distributors', '678-901-2345', '890'),
('111 Distributors', '789-012-3456', '111'),
('222 Distributors', '890-123-4567', '222'),
('333 Distributors', '901-234-5678', '333'),
('444 Distributors', '012-345-6789', '444');

-- INSERT statements for Distributor_Deals
INSERT INTO Distributor_Deals (album_id, distributor_id, price) VALUES
(1, 1, 9.99),
(2, 2, 12.99),
(3, 3, 8.99),
(4, 4, 10.99),
(5, 5, 11.99),
(6, 6, 9.49),
(7, 7, 13.99),
(8, 8, 10.49),
(9, 9, 11.49),
(10, 10, 14.99);

INSERT INTO Download (distributor_id, album_id, download_status, download_count) VALUES
(1, 1, 'success', 100),
(2, 2, 'success', 150),
(3, 3, 'failure', 50),
(4, 4, 'success', 200),
(5, 5, 'success', 120),
(6, 6, 'success', 180),
(7, 7, 'failure', 80),
(8, 8, 'success', 220),
(9, 9, 'success', 130),
(10, 10, 'failure', 70);

INSERT INTO Trailer_Approval (trailer_id, admin_id)
VALUES
(1, 1),
(2, 2),
(3, 1),
(4, 3),
(5, 2),
(6, 1),
(7, 3),
(8, 1),
(9, 2),
(10, 3);

-- SELECT * FROM Director;
-- SELECT * FROM Music_Group;
-- SELECT * FROM Member;
-- SELECT * FROM MusicGroup_Members;
-- SELECT * FROM LiveShow;
-- SELECT * FROM Candidate;
-- SELECT * FROM PhoneNumbers_candidate;
-- SELECT * FROM MusicFile;
-- SELECT * FROM Album;
-- SELECT * FROM Application;
-- SELECT * FROM PhoneNumbers_for_Applications;
-- SELECT * FROM Panelist;
-- SELECT * FROM Panelist_Application;
-- SELECT * FROM MusicAlbum;
-- SELECT * FROM Trailer;
-- SELECT * FROM Distributor;
-- SELECT * FROM Distributor_Deals;
-- SELECT * FROM Download;
-- SELECT * FROM Admin;
-- SELECT * FROM Advertisement ;
-- SELECT * FROM Company ;
