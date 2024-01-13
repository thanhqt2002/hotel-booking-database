-- Procedure to Present a List of Hotels with Filter Options:

DELIMITER //

CREATE PROCEDURE ListHotelsWithFilters(
    IN filter_city VARCHAR(100),
    IN filter_country VARCHAR(100),
    IN filter_rating INT,
    IN filter_facility VARCHAR(100)
)
BEGIN
    SELECT
        h.HotelID,
        h.Name,
        h.Address,
        h.City,
        h.Country,
        h.Rating,
        h.Phone,
        h.Email,
        GROUP_CONCAT(DISTINCT f.Name SEPARATOR ', ') AS Facilities
    FROM
        Hotel h
    LEFT JOIN
        HotelFacility hf ON h.HotelID = hf.HotelID
    LEFT JOIN
        Facility f ON hf.FacilityID = f.FacilityID
    WHERE
        (h.City = filter_city OR filter_city IS NULL) AND
        (h.Country = filter_country OR filter_country IS NULL) AND
        (h.Rating = filter_rating OR filter_rating IS NULL) AND
        (filter_facility IS NULL OR EXISTS (
            SELECT 1
            FROM HotelFacility hf2
            JOIN Facility f2 ON hf2.FacilityID = f2.FacilityID
            WHERE hf2.HotelID = h.HotelID AND f2.Name = filter_facility
        ))
    GROUP BY
        h.HotelID;
END //

DELIMITER ;

-- Example -- 

-- System shows list of hotels to Guest
CALL ListHotelsWithFilters(NULL, NULL, NULL, NULL);

-- Guest can filter with city, country, rating, and facilities
CALL ListHotelsWithFilters('Springfield', NULL, NULL, 'pool');

-- Procedure to Show Available Rooms Based on Dates with Sorting and Filtering Options:

DELIMITER //

CREATE PROCEDURE ListAvailableRooms(
    IN hotel_id INT,
    IN filter_amenity VARCHAR(100),
    IN sort_by_price BOOLEAN
)
BEGIN
    SELECT
        rt.RoomTypeID,
        rt.Name,
        rt.Description,
        rt.Price,
        rt.Capacity,
        GROUP_CONCAT(DISTINCT a.Name SEPARATOR ', ') AS Amenities,
        COUNT(DISTINCT r.RoomID) as TotalRooms
    FROM
        RoomType rt
    LEFT JOIN
        RoomTypeAmenity rta ON rt.RoomTypeID = rta.RoomTypeID
    LEFT JOIN
        Amenity a ON rta.AmenityID = a.AmenityID
	LEFT JOIN
		Room r on r.RoomTypeID = rt.RoomTypeID
	WHERE 
		r.HotelID = hotel_id         AND (
            filter_amenity IS NULL
            OR rt.RoomTypeID IN (
                SELECT DISTINCT rt2.RoomTypeID
                FROM RoomType rt2
                LEFT JOIN RoomTypeAmenity rta2 ON rt2.RoomTypeID = rta2.RoomTypeID
                LEFT JOIN Amenity a2 ON rta2.AmenityID = a2.AmenityID
                WHERE a2.Name = filter_amenity
            )
        )
	GROUP BY rt.RoomTypeID

	ORDER BY 
		CASE WHEN sort_by_price THEN rt.Price END ASC,
		CASE WHEN sort_by_price  = 0 THEN rt.Price END DESC;
END //

DELIMITER ;

-- Example --
CALL ListAvailableRooms(3, NULL, NULL)
CALL ListAvailableRooms(3, 'Mini Bar', True)


DELIMITER //

CREATE PROCEDURE GetNotAvailableNumberOfRooms(
    IN hotel_id INT,
    IN checkin_date Date,
    IN checkout_date Date
)
BEGIN
    SELECT 
	rt.RoomTypeID, 
    rt.Name, 
    rt.Description, 
    rt.Capacity, 
    temp.TotalUnits as TotalBookedRooms
FROM RoomType rt
LEFT JOIN (
    SELECT brt.RoomTypeID, SUM(brt.Unit) as TotalUnits
    FROM Booking b
    LEFT JOIN BookingRoomType brt on brt.BookingID = b.BookingID 
    WHERE b.CheckinDate >= checkin_date AND b.CheckoutDate <= checkout_date AND b.HotelID = hotel_id
    GROUP BY brt.RoomTypeID
) temp on rt.RoomTypeID = temp.RoomTypeID;
END //

DELIMITER ;

-- Example --
CALL GetNotAvailableNumberOfRooms(3, '2024-01-01', '2024-02-05')


-- Insert Guest information
DELIMITER //

CREATE PROCEDURE EnterGuestInformation(
    IN first_name VARCHAR(50),
    IN last_name VARCHAR(50),
    IN date_of_birth DATE,
    IN address VARCHAR(255),
    IN email VARCHAR(255),
    IN phone VARCHAR(15)
)
BEGIN
    INSERT INTO Guest (FirstName, LastName, DateOfBirth, Address, Email, Phone) 
    VALUES (first_name, last_name, date_of_birth, address, email, phone);
END //

DELIMITER ;

-- Example --
CALL EnterGuestInformation('Phuc', 'Vu', NULL, NULL, 'phuc.vh@example.com', '0123456789');
SET @guest_id := (SELECT GuestID FROM Guest WHERE Email = 'phuc.vh@example.com');

-- Create new Booking
DELIMITER //

CREATE PROCEDURE CreateBooking(
    IN hotel_id INT,
    IN guest_id INT,
    IN checkin_date DATE,
    IN checkout_date DATE,
    IN price DECIMAL(10,2),
    OUT new_booking_id INT
)
BEGIN
    -- A Booking is saved when it is confirmed. 
    SET @defaultBookingStatusID = 1; 

    -- Insert into Booking table
    INSERT INTO Booking (HotelID, GuestID, BookingStatusID, CheckinDate, CheckoutDate, Price)
    VALUES (hotel_id, guest_id, @defaultBookingStatusID, checkin_date, checkout_date, price); 

    -- Get the last inserted booking ID
    SET new_booking_id = LAST_INSERT_ID();
END //

DELIMITER ;

-- Example --
CALL CreateBooking(3, @guest_id, '2024-01-01', '2024-02-05', 500.00, @new_booking_id)

-- Booking Room Type
DELIMITER //

CREATE PROCEDURE SelectRoomTypes(
    IN booking_id INT,
    IN room_type_id INT,
    IN number_of_rooms INT
)
BEGIN
    INSERT INTO BookingRoomType (BookingID, RoomTypeID, Unit) 
    VALUES (booking_id, room_type_id, number_of_rooms);
END //

DELIMITER ;

-- Example -- 
CALL SelectRoomTypes(@new_booking_id, 1, 1);
CALL SelectRoomTypes(@new_booking_id, 2, 2);

-- When the payment is confirmed, the information about guest, booking, and payment are saved. 

DELIMITER //
CREATE PROCEDURE ProcessPayment(
    IN booking_id INT,
    IN payment_method_id INT,
    IN amount DECIMAL(10,2)
)
BEGIN
    INSERT INTO Payment (BookingID, PaymentMethodID, Amount) 
    VALUES (booking_id, payment_method_id, amount);
END //

DELIMITER ;
CALL ProcessPayment(@new_booking_id, 1, 100);

-- Procedure to show billing summary
-- This procedure is in the checkin.sql



