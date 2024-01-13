-- Active: 1705131855147@@127.0.0.1@3306@vinkun
USE vinkun;

-- 1 --
-- SQL procedure to retrieve booking information given guest First Name

DELIMITER //

DROP PROCEDURE IF EXISTS `GetDetailedBookingInfoByFirstName`;

CREATE PROCEDURE GetDetailedBookingInfoByFirstName(IN guestFirstName VARCHAR(255))
BEGIN
    -- Retrieving booking and guest details
    SELECT 
        b.BookingID,
        CONCAT(g.FirstName, ' ', g.LastName) AS GuestName,
        g.Email,
        g.Phone,
        g.Address,
        b.CheckinDate,
        b.CheckoutDate,
        (SELECT GROUP_CONCAT(CONCAT(rt.Name, ' (', brt.Unit, ' units)') SEPARATOR ', ')
         FROM BookingRoomType brt
         JOIN RoomType rt ON brt.RoomTypeID = rt.RoomTypeID
         WHERE brt.BookingID = b.BookingID) AS RoomTypes,
        (SELECT GROUP_CONCAT(CONCAT(s.Name, ' - ', bs.Note) SEPARATOR ', ')
         FROM BookingService bs
         JOIN Service s ON bs.ServiceID = s.ServiceID
         WHERE bs.BookingID = b.BookingID) AS Services
    FROM 
        Booking b
    JOIN 
        Guest g ON b.GuestID = g.GuestID
    WHERE 
        g.FirstName = guestFirstName;
END //

DELIMITER ;



-- 2 --
-- SQL procedure to retrieve booking information given guest Last Name

DELIMITER //

DROP PROCEDURE IF EXISTS `GetDetailedBookingInfoByLastName`;

CREATE PROCEDURE GetDetailedBookingInfoByLastName(IN guestLastName VARCHAR(255))
BEGIN
    -- Retrieving booking and guest details
    SELECT 
        b.BookingID,
        CONCAT(g.FirstName, ' ', g.LastName) AS GuestName,
        g.Email,
        g.Phone,
        g.Address,
        b.CheckinDate,
        b.CheckoutDate,
        (SELECT GROUP_CONCAT(CONCAT(rt.Name, ' (', brt.Unit, ' units)') SEPARATOR ', ')
         FROM BookingRoomType brt
         JOIN RoomType rt ON brt.RoomTypeID = rt.RoomTypeID
         WHERE brt.BookingID = b.BookingID) AS RoomTypes,
        (SELECT GROUP_CONCAT(CONCAT(s.Name, ' - ', bs.Note) SEPARATOR ', ')
         FROM BookingService bs
         JOIN Service s ON bs.ServiceID = s.ServiceID
         WHERE bs.BookingID = b.BookingID) AS Services
    FROM 
        Booking b
    JOIN 
        Guest g ON b.GuestID = g.GuestID
    WHERE 
        g.`LastName` = guestLastName;
END //

DELIMITER ;

-- 3 --
-- SQL procedure to retrieve booking information given guest Phone

DELIMITER //

DROP PROCEDURE IF EXISTS `GetDetailedBookingInfoByPhone`;

CREATE PROCEDURE GetDetailedBookingInfoByPhone(IN guestPhone VARCHAR(255))
BEGIN
    SELECT 
        b.BookingID,
        CONCAT(g.FirstName, ' ', g.LastName) AS GuestName,
        g.Email,
        g.Phone,
        g.Address,
        b.CheckinDate,
        b.CheckoutDate,
        (SELECT GROUP_CONCAT(CONCAT(rt.Name, ' (', brt.Unit, ' units)') SEPARATOR ', ')
         FROM BookingRoomType brt
         JOIN RoomType rt ON brt.RoomTypeID = rt.RoomTypeID
         WHERE brt.BookingID = b.BookingID) AS RoomTypes,
        (SELECT GROUP_CONCAT(CONCAT(s.Name, ' - ', bs.Note) SEPARATOR ', ')
         FROM BookingService bs
         JOIN Service s ON bs.ServiceID = s.ServiceID
         WHERE bs.BookingID = b.BookingID) AS Services
    FROM 
        Booking b
    JOIN 
        Guest g ON b.GuestID = g.GuestID
    WHERE 
        g.Phone = guestPhone;
END //

DELIMITER ;

-- 4 --
-- SQL procedure to retrieve booking information given guest Email

DELIMITER //

DROP PROCEDURE IF EXISTS `GetDetailedBookingInfoByEmail`;

CREATE PROCEDURE GetDetailedBookingInfoByEmail(IN guestEmail VARCHAR(255))
BEGIN
    SELECT 
        b.BookingID,
        CONCAT(g.FirstName, ' ', g.LastName) AS GuestName,
        g.Email,
        g.Phone,
        g.Address,
        b.CheckinDate,
        b.CheckoutDate,
        (SELECT GROUP_CONCAT(CONCAT(rt.Name, ' (', brt.Unit, ' units)') SEPARATOR ', ')
         FROM BookingRoomType brt
         JOIN RoomType rt ON brt.RoomTypeID = rt.RoomTypeID
         WHERE brt.BookingID = b.BookingID) AS RoomTypes,
        (SELECT GROUP_CONCAT(CONCAT(s.Name, ' - ', bs.Note) SEPARATOR ', ')
         FROM BookingService bs
         JOIN Service s ON bs.ServiceID = s.ServiceID
         WHERE bs.BookingID = b.BookingID) AS Services
    FROM 
        Booking b
    JOIN 
        Guest g ON b.GuestID = g.GuestID
    WHERE 
        g.Email = guestEmail;
END //

DELIMITER ;



-- 5 --
-- SQL procedure to retrieve booking information given guest Check-in date

DELIMITER //

DROP PROCEDURE IF EXISTS `GetDetailedBookingInfoByCheckinDate`;

CREATE PROCEDURE GetDetailedBookingInfoByCheckinDate(IN checkinDate DATE)
BEGIN
    SELECT 
        b.BookingID,
        CONCAT(g.FirstName, ' ', g.LastName) AS GuestName,
        g.Email,
        g.Phone,
        g.Address,
        b.CheckinDate,
        b.CheckoutDate,
        (SELECT GROUP_CONCAT(CONCAT(rt.Name, ' (', brt.Unit, ' units)') SEPARATOR ', ')
         FROM BookingRoomType brt
         JOIN RoomType rt ON brt.RoomTypeID = rt.RoomTypeID
         WHERE brt.BookingID = b.BookingID) AS RoomTypes,
        (SELECT GROUP_CONCAT(CONCAT(s.Name, ' - ', bs.Note) SEPARATOR ', ')
         FROM BookingService bs
         JOIN Service s ON bs.ServiceID = s.ServiceID
         WHERE bs.BookingID = b.BookingID) AS Services
    FROM 
        Booking b
    JOIN 
        Guest g ON b.GuestID = g.GuestID
    WHERE 
        b.CheckinDate = checkinDate;
END //

DELIMITER ;



-- 6 --
-- SQL procedure to retrieve booking information given guest Booking ID

DELIMITER //

DROP PROCEDURE IF EXISTS `GetDetailedBookingInfoByBookingID`;

CREATE PROCEDURE GetDetailedBookingInfoByBookingID(IN bookingID INT)
BEGIN
    SELECT 
        b.BookingID,
        CONCAT(g.FirstName, ' ', g.LastName) AS GuestName,
        g.Email,
        g.Phone,
        g.Address,
        b.CheckinDate,
        b.CheckoutDate,
        (SELECT GROUP_CONCAT(CONCAT(rt.Name, ' (', brt.Unit, ' units)') SEPARATOR ', ')
         FROM BookingRoomType brt
         JOIN RoomType rt ON brt.RoomTypeID = rt.RoomTypeID
         WHERE brt.BookingID = b.BookingID) AS RoomTypes,
        (SELECT GROUP_CONCAT(CONCAT(s.Name, ' - ', bs.Note) SEPARATOR ', ')
         FROM BookingService bs
         JOIN Service s ON bs.ServiceID = s.ServiceID
         WHERE bs.BookingID = b.BookingID) AS Services
    FROM 
        Booking b
    JOIN 
        Guest g ON b.GuestID = g.GuestID
    WHERE 
        b.BookingID = bookingID;
END //

DELIMITER ;

-- 7 --
-- SQL procedure to retrieve available rooms

DELIMITER //

DROP PROCEDURE IF EXISTS `GetAvailableRooms`;

CREATE PROCEDURE GetAvailableRooms(IN selectedHotelID INT, IN selectedRoomTypeID INT)
BEGIN
    SELECT 
        r.`RoomID`, r.RoomNumber
    FROM 
        Room r
    WHERE 
        r.HotelID = selectedHotelID AND 
        r.RoomTypeID = selectedRoomTypeID AND 
        r.RoomStatusID = (SELECT RoomStatusID FROM RoomStatus WHERE Name = 'Available');
END //

DELIMITER ;

-- 8 --
-- SQL procedure to assigns a room to a booking and updates the room status to "Occupied"
DELIMITER //

DROP PROCEDURE IF EXISTS `AssignRoomToBooking`;

CREATE PROCEDURE AssignRoomToBooking(IN bookingID INT, IN roomID INT, OUT roomNumber VARCHAR(50))
BEGIN
    DECLARE availableStatusID INT DEFAULT 0;
    DECLARE occupiedStatusID INT DEFAULT 0;
    DECLARE currentStatusID INT DEFAULT 0;

    -- Ensuring unique status IDs for 'Available' and 'Occupied'
    IF (SELECT COUNT(*) FROM RoomStatus WHERE Name = 'Available') != 1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Ambiguous status for Available';
    END IF;
    IF (SELECT COUNT(*) FROM RoomStatus WHERE Name = 'Occupied') != 1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Ambiguous status for Occupied';
    END IF;

    --  -- Get the status IDs for 'Available' and 'Occupied'
    SELECT RoomStatusID INTO availableStatusID FROM RoomStatus WHERE Name = 'Available';
    SELECT RoomStatusID INTO occupiedStatusID FROM RoomStatus WHERE Name = 'Occupied';

    -- -- Check the current status of the room
    SELECT RoomStatusID INTO currentStatusID FROM Room WHERE Room.`RoomID` = roomID;

    -- Check if the room is available
    IF currentStatusID = availableStatusID THEN
        -- Assign room to booking
        INSERT INTO BookingRoom (BookingID, RoomID) VALUES (bookingID, roomID);

        -- -- Update room status to 'Occupied'
        UPDATE Room SET RoomStatusID = occupiedStatusID WHERE Room.`RoomID` = roomID;

        -- -- Retrieve the room number for the output
        SELECT Room.`RoomNumber` INTO roomNumber FROM Room WHERE Room.`RoomID` = roomID;
    ELSE
        -- Return an error if the room is not available
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: The selected room is not available';
    END IF;
END //

DELIMITER ;

-- Examples --

CALL GetDetailedBookingInfoByFirstName('Alice');


CALL GetDetailedBookingInfoByLastName('Johnson');


CALL GetDetailedBookingInfoByPhone('123-456-7890');


CALL GetDetailedBookingInfoByEmail('alice.johnson@example.com');


CALL GetDetailedBookingInfoByBookingID(1);

CALL GetDetailedBookingInfoByCheckinDate('2024-01-10');

CALL GetAvailableRooms(1, 1);

CALL AssignRoomToBooking(1, 10, @roomNumber);
SELECT @roomNumber AS RoomNumber;
