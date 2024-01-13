-- Active: 1705141631806@@127.0.0.1@3306@vinkun
-- 1 -- 
-- SQL procedure to show available services at a hotel
DELIMITER //
DROP PROCEDURE IF EXISTS ShowAvailableServices;
CREATE PROCEDURE ShowAvailableServices(IN guest_booking_id INT)
BEGIN
    DECLARE guest_hotel_id INT;

    -- Retrieve the hotel ID from the guest's booking
    SELECT HotelID INTO guest_hotel_id
    FROM Booking
    WHERE BookingID = guest_booking_id;

    -- Check if the booking ID is valid
    IF guest_hotel_id IS NOT NULL THEN
        -- Select all available services for the hotel associated with the booking
        SELECT s.ServiceID, s.Name, s.Description, s.Price
        FROM Service s
        JOIN HotelService hs ON s.ServiceID = hs.ServiceID
        WHERE hs.HotelID = guest_hotel_id;
    ELSE
        -- Handle the case where the booking ID is not valid or does not exist
        SELECT 'Error: Invalid booking ID or no services available for this hotel.' AS ErrorMessage;
    END IF;
END //

DELIMITER ;

-- 2 --
-- SQL procedure to saves service requests and returns service booking id

DELIMITER //
DROP PROCEDURE IF EXISTS SaveServiceRequest;

CREATE PROCEDURE SaveServiceRequest(
    IN booking_id INT,
    IN selected_service_id INT,
    IN service_units INT,
    IN service_notes VARCHAR(1023),
    OUT booking_service_id INT
)
BEGIN
    DECLARE service_status_ordered INT DEFAULT 1; -- Assuming 'Ordered' status ID
    DECLARE current_price DECIMAL(10,2);

    -- Retrieve the price of the selected service
    SELECT Price INTO current_price FROM Service WHERE ServiceID = selected_service_id;

    -- Insert the new service request into BookingService table
    INSERT INTO BookingService (BookingID, ServiceID, ServiceStatusID, Unit, Note)
    VALUES (booking_id, selected_service_id, service_status_ordered, service_units, service_notes);

    -- Get the last auto-incremented ID which is the service booking ID
    SET booking_service_id = LAST_INSERT_ID();
END //

DELIMITER ;

-- 3 --
--  SQL procedure to uses service booking id to retrieve service booking detail.
DELIMITER //

DROP PROCEDURE IF EXISTS GetBookingServiceDetails;
CREATE PROCEDURE GetBookingServiceDetails(IN booking_service_id INT)
BEGIN
    SELECT
        bs.BookingServiceID,
        bs.BookingID,
        b.GuestID,
        g.FirstName,
        g.LastName,
        g.Phone,
        g.Email,
        r.RoomNumber,
        s.Name AS ServiceName,
        bs.Unit,
        bs.Note,
        ss.Name AS ServiceStatus
    FROM
        BookingService bs
    JOIN Service s ON bs.ServiceID = s.ServiceID
    JOIN Booking b ON bs.BookingID = b.BookingID
    JOIN Guest g ON b.GuestID = g.GuestID
    JOIN BookingRoom br ON b.BookingID = br.BookingID
    JOIN Room r ON br.RoomID = r.RoomID
    JOIN ServiceStatus ss ON bs.ServiceStatusID = ss.ServiceStatusID
    WHERE
        bs.BookingServiceID = booking_service_id;
END //

DELIMITER ;


-- 4 --
-- SQL procedure to update the booking_serive 
DELIMITER //

DROP PROCEDURE IF EXISTS UpdateBookingService;
CREATE PROCEDURE UpdateBookingService(
    IN service_booking_id INT,
    IN new_service_id INT,
    IN new_service_units INT,
    IN new_service_status_id INT
)
BEGIN
    -- Check if a new service ID has been provided and update if necessary
    IF new_service_id IS NOT NULL THEN
        UPDATE BookingService
        SET ServiceID = new_service_id
        WHERE BookingServiceID = service_booking_id;
    END IF;

    -- Check if new service units have been provided and update if necessary
    IF new_service_units IS NOT NULL THEN
        UPDATE BookingService
        SET Unit = new_service_units
        WHERE BookingServiceID = service_booking_id;
    END IF;

    -- Check if a new service status ID has been provided and update if necessary
    IF new_service_status_id IS NOT NULL THEN
        UPDATE BookingService
        SET ServiceStatusID = new_service_status_id
        WHERE BookingServiceID = service_booking_id;
    END IF;
END //

DELIMITER ;




-- 1 --
-- Call stored procedure ShowAvailableServices with a booking ID
-- This displays the digital service menu for the hotel associated with the booking ID 1
CALL ShowAvailableServices(1);


-- 2 --
-- Call stored procedure SaveServiceRequest with details of the service requested by the guest
-- This saves a service request for booking ID 5, service ID 5, with 2 units and notes for a room setup
-- The service booking ID generated is stored in @service_booking_id
CALL SaveServiceRequest(5, 5, 2, 'Please set up the room for an anniversary celebration.', @booking_service_id);
SELECT @booking_service_id AS BookingServiceID;

-- 3 --
-- Call stored procedure GetBookingServiceDetails with a service booking ID
-- This retrieves the details of the guest's service request with service booking ID 12
CALL GetBookingServiceDetails(12); -- Replace 12 with the actual BookingServiceID

-- 4 --
-- Call stored procedure UpdateBookingService to update the service status for a specific booking service
-- This updates the service status to '2' (e.g., 'Processing') for the service booking ID 1
-- Note: The ServiceID and Unit are not updated in this call
CALL UpdateBookingService(1, NULL, NULL, 2); 
