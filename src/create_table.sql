USE vinkun;

CREATE TABLE `Facility` (
  `FacilityID` int PRIMARY KEY AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `Description` varchar(255)
);

CREATE TABLE `Hotel` (
  `HotelID` int PRIMARY KEY AUTO_INCREMENT,
  `Name` varchar(255) UNIQUE NOT NULL,
  `Address` varchar(255) NOT NULL,
  `City` varchar(100) NOT NULL,
  `Country` varchar(100) NOT NULL,
  `Rating` int NOT NULL,
  `Phone` varchar(15) UNIQUE NOT NULL,
  `Email` varchar(255) UNIQUE NOT NULL,
  `Deposit` decimal(10,2) NOT NULL CHECK (`Deposit` >= 0)
);

CREATE TABLE `HotelFacility` (
  `HotelID` int NOT NULL,
  `FacilityID` int NOT NULL,
  PRIMARY KEY (`HotelID`, `FacilityID`)
);

CREATE TABLE `Amenity` (
  `AmenityID` int PRIMARY KEY AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `Description` varchar(255)
);

CREATE TABLE `RoomType` (
  `RoomTypeID` int PRIMARY KEY AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL,
  `Description` varchar(255),
  `Price` decimal(10,2) NOT NULL CHECK (`Price` > 0),
  `Capacity` int NOT NULL CHECK (`Capacity` >= 1)
);

CREATE TABLE `RoomTypeAmenity` (
  `RoomTypeID` int NOT NULL,
  `AmenityID` int NOT NULL,
  PRIMARY KEY (`RoomTypeID`, `AmenityID`)
);

CREATE TABLE `RoomStatus` (
  `RoomStatusID` int PRIMARY KEY AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `Description` varchar(255)
);

CREATE TABLE `Room` (
  `RoomID` int PRIMARY KEY AUTO_INCREMENT,
  `HotelID` int NOT NULL,
  `RoomTypeID` int NOT NULL,
  `RoomStatusID` int NOT NULL,
  `RoomNumber` varchar(50)
);

CREATE TABLE `Service` (
  `ServiceID` int PRIMARY KEY AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `Description` varchar(255),
  `Price` decimal(10,2) NOT NULL CHECK (`Price` > 0)
);

CREATE TABLE `HotelService` (
  `HotelID` int NOT NULL,
  `ServiceID` int NOT NULL,
  PRIMARY KEY (`HotelID`, `ServiceID`)
);

CREATE TABLE `Guest` (
  `GuestID` int PRIMARY KEY AUTO_INCREMENT,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `DateOfBirth` date,
  `Address` varchar(255),
  `Phone` varchar(15) NOT NULL,
  `Email` varchar(255) NOT NULL
);

CREATE TABLE `BookingStatus` (
  `BookingStatusID` int PRIMARY KEY AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `Description` varchar(255)
);

CREATE TABLE `Booking` (
  `BookingID` int PRIMARY KEY AUTO_INCREMENT,
  `HotelID` int NOT NULL,
  `GuestID` int NOT NULL,
  `BookingStatusID` int NOT NULL,
  `CheckinDate` date NOT NULL,
  `CheckoutDate` date NOT NULL,
  `Price` decimal(10,2) NOT NULL CHECK (`Price` > 0),
  `CreatedAt` timestamp default CURRENT_TIMESTAMP NOT NULL COMMENT 'create time',
  `UpdatedAt` timestamp default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL COMMENT 'update time'
);

CREATE TABLE `BookingRoomType` (
  `BookingID` int AUTO_INCREMENT,
  `RoomTypeID` int NOT NULL,
  `Unit` int NOT NULL CHECK (`Unit` >= 1),
  PRIMARY KEY (`BookingID`, `RoomTypeID`)
);

CREATE TABLE `BookingRoom` (
  `BookingID` int NOT NULL,
  `RoomID` int NOT NULL,
  PRIMARY KEY (`BookingID`, `RoomID`)
);

CREATE TABLE `ServiceStatus` (
  `ServiceStatusID` int PRIMARY KEY AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `Description` varchar(255)
);

CREATE TABLE `BookingService` (
  `BookingServiceID` int PRIMARY KEY AUTO_INCREMENT,
  `BookingID` int NOT NULL,
  `ServiceID` int NOT NULL,
  `ServiceStatusID` int NOT NULL,
  `Unit` int NOT NULL CHECK (`Unit` >= 1),
  `Note` varchar(1024),
  `CreatedAt` timestamp default CURRENT_TIMESTAMP NOT NULL COMMENT 'create time',
  `UpdatedAt` timestamp default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL COMMENT 'update time'
);


CREATE TABLE `Feedback` (
  `BookingID` int PRIMARY KEY NOT NULL,
  `Rating` int NOT NULL CHECK (`Rating` >= 1 AND `Rating` <= 5),
  `Comment` varchar(1024),
  `FeedbackTime` timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL COMMENT 'create time'
);


CREATE TABLE `PaymentMethod` (
  `PaymentMethodID` int PRIMARY KEY AUTO_INCREMENT,
  `MethodName` varchar(100) NOT NULL,
  `Description` varchar(255)
);

CREATE TABLE `Payment` (
  `PaymentID` int PRIMARY KEY AUTO_INCREMENT,
  `BookingID` int NOT NULL,
  `PaymentMethodID` int NOT NULL,
  `Amount` decimal(10,2) NOT NULL CHECK (`Amount` > 0),
  `PaymentTime` timestamp default CURRENT_TIMESTAMP NOT NULL COMMENT 'create time'
);

CREATE INDEX `idx_hotel_name` ON `Hotel` (`Name`);

CREATE INDEX `idx_room_status` ON `Room` (`RoomStatusID`);

CREATE INDEX `idx_guest_email` ON `Guest` (`Email`);

CREATE INDEX `idx_booking_dates` ON `Booking` (`CheckinDate`, `CheckoutDate`);

CREATE INDEX `idx_feedback_rating` ON `Feedback` (`Rating`);

CREATE INDEX `idx_payment_time` ON `Payment` (`PaymentTime`);

ALTER TABLE `HotelFacility` ADD FOREIGN KEY (`HotelID`) REFERENCES `Hotel` (`HotelID`) ON DELETE CASCADE;

ALTER TABLE `HotelFacility` ADD FOREIGN KEY (`FacilityID`) REFERENCES `Facility` (`FacilityID`) ON DELETE CASCADE;

ALTER TABLE `RoomTypeAmenity` ADD FOREIGN KEY (`RoomTypeID`) REFERENCES `RoomType` (`RoomTypeID`) ON DELETE CASCADE;

ALTER TABLE `RoomTypeAmenity` ADD FOREIGN KEY (`AmenityID`) REFERENCES `Amenity` (`AmenityID`) ON DELETE CASCADE;

ALTER TABLE `Room` ADD FOREIGN KEY (`HotelID`) REFERENCES `Hotel` (`HotelID`) ON DELETE CASCADE;

ALTER TABLE `Room` ADD FOREIGN KEY (`RoomTypeID`) REFERENCES `RoomType` (`RoomTypeID`) ON DELETE RESTRICT;

ALTER TABLE `Room` ADD FOREIGN KEY (`RoomStatusID`) REFERENCES `RoomStatus` (`RoomStatusID`);

ALTER TABLE `HotelService` ADD FOREIGN KEY (`HotelID`) REFERENCES `Hotel` (`HotelID`) ON DELETE CASCADE;

ALTER TABLE `HotelService` ADD FOREIGN KEY (`ServiceID`) REFERENCES `Service` (`ServiceID`) ON DELETE CASCADE;

ALTER TABLE `Booking` ADD FOREIGN KEY (`HotelID`) REFERENCES `Hotel` (`HotelID`) ON DELETE CASCADE;

ALTER TABLE `Booking` ADD FOREIGN KEY (`BookingStatusID`) REFERENCES `BookingStatus` (`BookingStatusID`) ON DELETE CASCADE;

ALTER TABLE `Booking` ADD FOREIGN KEY (`GuestID`) REFERENCES `Guest` (`GuestID`) ON DELETE CASCADE;

ALTER TABLE `BookingRoomType` ADD FOREIGN KEY (`BookingID`) REFERENCES `Booking` (`BookingID`);

ALTER TABLE `BookingRoomType` ADD FOREIGN KEY (`RoomTypeID`) REFERENCES `RoomType` (`RoomTypeID`);

ALTER TABLE `BookingRoom` ADD FOREIGN KEY (`BookingID`) REFERENCES `Booking` (`BookingID`);

ALTER TABLE `BookingRoom` ADD FOREIGN KEY (`RoomID`) REFERENCES `Room` (`RoomID`);

ALTER TABLE `BookingService` ADD FOREIGN KEY (`BookingID`) REFERENCES `Booking` (`BookingID`);

ALTER TABLE `BookingService` ADD FOREIGN KEY (`ServiceID`) REFERENCES `Service` (`ServiceID`);

ALTER TABLE `BookingService` ADD FOREIGN KEY (`ServiceStatusID`) REFERENCES `ServiceStatus` (`ServiceStatusID`);

ALTER TABLE `Feedback` ADD FOREIGN KEY (`BookingID`) REFERENCES `Booking` (`BookingID`);

ALTER TABLE `Payment` ADD FOREIGN KEY (`BookingID`) REFERENCES `Booking` (`BookingID`) ON DELETE CASCADE;

ALTER TABLE `Payment` ADD FOREIGN KEY (`PaymentMethodID`) REFERENCES `PaymentMethod` (`PaymentMethodID`);
