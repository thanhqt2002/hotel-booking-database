USE vinkun;

-- Verifying guest identity is the same as check-in


-- 1 --
-- SQL procedure to retrieve billing information given booking id

DELIMITER //

DROP PROCEDURE IF EXISTS `GetBillingInformation`;

CREATE PROCEDURE GetBillingInformation(IN p_BookingID INT)
BEGIN
    DECLARE completedStatusID INT DEFAULT 0;
    
    -- Fetch the ServiceStatusID for 'Completed' status
    SELECT ServiceStatusID INTO completedStatusID FROM ServiceStatus WHERE Name = 'Completed' LIMIT 1;

    -- Ensure that there is only one 'Completed' status
    IF (SELECT COUNT(*) FROM ServiceStatus WHERE Name = 'Completed') != 1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: Ambiguous status for Completed';
    END IF;

    -- Retrieve billing information
    SELECT
        b.BookingID,
        b.Price AS BookingPrice,
        (b.Price + COALESCE((SELECT SUM(s.Price * bs.Unit)
                             FROM BookingService bs
                             JOIN Service s ON bs.ServiceID = s.ServiceID
                             WHERE bs.BookingID = p_BookingID AND bs.ServiceStatusID = completedStatusID), 0)) AS TotalPrice,
        (SELECT GROUP_CONCAT(CONCAT(r.RoomNumber, ' - ', rt.Name) SEPARATOR ', ')
         FROM BookingRoom br
         JOIN Room r ON br.RoomID = r.RoomID
         JOIN RoomType rt ON r.RoomTypeID = rt.RoomTypeID
         WHERE br.BookingID = b.BookingID) AS RoomsUsed,
        DATEDIFF(b.CheckoutDate, b.CheckinDate) AS DurationOfStay,
        (SELECT GROUP_CONCAT(CONCAT(s.Name, ' (', bs.Unit, ' units @ ', s.Price, '/unit) on ', DATE_FORMAT(bs.CreatedAt, '%Y-%m-%d')) SEPARATOR ', ')
         FROM BookingService bs
         JOIN Service s ON bs.ServiceID = s.ServiceID
         WHERE bs.BookingID = p_BookingID AND bs.ServiceStatusID = completedStatusID) AS ServicesUsed
        FROM Booking b
        WHERE b.BookingID = p_BookingID;
END //

DELIMITER ;

-- SQL procedure to retrieve all payment method name and id

DELIMITER //

DROP PROCEDURE IF EXISTS `GetAllPaymentMethods`;

CREATE PROCEDURE GetAllPaymentMethods()
BEGIN
    SELECT 
        PaymentMethodID,
        MethodName
    FROM 
        PaymentMethod;
END //

DELIMITER ;


-- 3 --
-- SQL procedure to submit feedback based on booking id --

DELIMITER //

DROP PROCEDURE IF EXISTS `SubmitFeedback`;

CREATE PROCEDURE SubmitFeedback(
    IN p_BookingID INT, 
    IN p_Rating INT, 
    IN p_Comment VARCHAR(1024)
)
BEGIN
    -- Check if a feedback already exists for the given BookingID
    IF EXISTS (SELECT 1 FROM Feedback WHERE BookingID = p_BookingID) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Error: Feedback already exists for this booking ID';
    ELSE
        -- Insert new feedback record
        INSERT INTO Feedback (BookingID, Rating, Comment) 
        VALUES (p_BookingID, p_Rating, p_Comment);
    END IF;
END //

DELIMITER ;

-- 4 --
-- Mark the booking status as complete and room status as available after checkout given booking id

DELIMITER //

DROP PROCEDURE IF EXISTS `CompleteBookingAndFreeRooms`;

CREATE PROCEDURE CompleteBookingAndFreeRooms(IN p_BookingID INT)
BEGIN
    DECLARE completeStatusID INT;
    DECLARE availableStatusID INT;

    -- Fetch the BookingStatusID for 'Complete' status
    SELECT BookingStatusID INTO completeStatusID FROM BookingStatus WHERE BookingStatus.Name = 'CheckedOut' LIMIT 1;

    -- Fetch the RoomStatusID for 'Available' status
    SELECT RoomStatusID INTO availableStatusID FROM RoomStatus WHERE RoomStatus.Name = 'Available' LIMIT 1;

    -- Update the booking status to 'Complete'
    UPDATE Booking SET BookingStatusID = completeStatusID WHERE BookingID = p_BookingID;

    -- Update the room status to 'Available' for all rooms associated with this booking
    UPDATE Room r
    JOIN BookingRoom br ON r.RoomID = br.RoomID
    SET r.RoomStatusID = availableStatusID
    WHERE br.BookingID = p_BookingID;
END //

DELIMITER ;


-- Example --

CALL GetBillingInformation(1);


CALL GetAllPaymentMethods();


-- Submit feedback for booking ID 1 with a rating of 4 and a comment
CALL SubmitFeedback(1, 4, 'Excellent service and comfortable stay.');

CALL CompleteBookingAndFreeRooms(1);
