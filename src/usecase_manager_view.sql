-- 1 --
-- SQL procedure to retrieve payment details for manager

DELIMITER //

CREATE PROCEDURE GetPaymentDetails(IN start_date DATE, IN end_date DATE)
BEGIN
    -- Ensure start_date is less than or equal to end_date
    IF start_date <= end_date THEN
        -- Fetch payment details for bookings within the specified date range
        SELECT
            p.PaymentID,
            b.BookingID,
            pm.MethodName AS PaymentMethod,
            p.Amount,
            p.PaymentTime
        FROM
            Payment p
        JOIN
            Booking b ON p.BookingID = b.BookingID
        JOIN
            PaymentMethod pm ON p.PaymentMethodID = pm.PaymentMethodID
        WHERE
            p.PaymentTime BETWEEN start_date AND end_date;
    ELSE
        -- Handle the case where start_date is greater than end_date
        SELECT 'Error: start_date should be less than or equal to end_date.' AS ErrorMessage;
    END IF;
END //

DELIMITER ;

-- 2 --
-- SQL procedure to retrieve total revenue for manager

DELIMITER //

CREATE PROCEDURE GetTotalPaymentAmount(IN start_date DATE, IN end_date DATE, OUT total_amount DECIMAL(10,2))
BEGIN
    -- Check if start_date is less than or equal to end_date
    IF start_date <= end_date THEN
        -- Calculate total amount of payments within the specified date range
        SELECT SUM(p.Amount) INTO total_amount
        FROM Payment p
        WHERE p.PaymentTime BETWEEN start_date AND end_date;
    ELSE
        SELECT 'Error: start_date should be less than or equal to end_date.' AS ErrorMessage;
    END IF;
END //

DELIMITER ;


-- 3 --
-- SQL procedure to fetch reviews, ratings, and review times for a given date range.

DELIMITER //

CREATE PROCEDURE GetCustomerFeedback(IN start_date DATE, IN end_date DATE)
BEGIN
    IF start_date <= end_date THEN
        SELECT
            f.Comment AS Review,
            f.Rating,
            f.FeedbackTime
        FROM
            Feedback f
        WHERE
            f.FeedbackTime BETWEEN start_date AND end_date;
    ELSE
        SELECT 'Error: start_date should be less than or equal to end_date.' AS ErrorMessage;
    END IF;
END //

DELIMITER ;

DELIMITER //


-- 4 --
-- SQL procedure to calculate the average rating within a specified time range.

CREATE PROCEDURE GetAverageRating(IN start_date DATE, IN end_date DATE, OUT average_rating DECIMAL(3,2))
BEGIN
    IF start_date <= end_date THEN
        SELECT AVG(f.Rating) INTO average_rating
        FROM Feedback f
        WHERE f.FeedbackTime BETWEEN start_date AND end_date;
    ELSE
        SELECT 'Error: start_date should be less than or equal to end_date.' AS ErrorMessage;
    END IF;
END //

DELIMITER ;


-- Examples --

-- Call stored procedure GetPaymentDetails with a specified date range
-- This retrieves details of payments made between January 1, 2024, and January 31, 2024
CALL GetPaymentDetails('2024-01-01', '2024-01-31');

-- Call stored procedure GetTotalPaymentAmount with a specified date range
-- This calculates the total amount of payments made between January 1, 2024, and January 31, 2024
-- The result is stored in the variable @total
CALL GetTotalPaymentAmount('2024-01-01', '2024-01-31', @total);

-- Retrieve and display the total payment amount calculated by the previous procedure
SELECT @total AS TotalAmount;

-- Call stored procedure GetCustomerFeedback with a specified date range
-- This fetches customer feedback (reviews, ratings, review times) made between January 1, 2024, and January 31, 2024
CALL GetCustomerFeedback('2024-01-01', '2024-01-31');

-- Call stored procedure GetAverageRating with a specified date range
-- This calculates the average rating of feedback given between January 1, 2024, and January 31, 2024
-- The result is stored in the variable @average
CALL GetAverageRating('2024-01-01', '2024-01-31', @average);

-- Retrieve and display the average rating calculated by the previous procedure
SELECT @average AS AverageRating;
