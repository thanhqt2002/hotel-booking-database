USE vinkun;

-- Populate Hotel Data
INSERT INTO `Hotel` (`Name`, `Address`, `City`, `Country`, `Rating`, `Phone`, `Email`, `Deposit`) VALUES
('The Grand Seasons', '1234 Grand Avenue', 'Springfield', 'USA', 5, '555-0123', 'info@grandseasons.com', 200.00),
('Oceanview Retreat', '25 Ocean Road', 'Beachville', 'USA', 4, '555-0456', 'contact@oceanviewretreat.com', 150.00),
('Mountain Escape', '9 Summit Way', 'Hilltop', 'USA', 4, '555-0789', 'booking@mountainescape.com', 100.00);

-- Populate Facility Data
INSERT INTO `Facility` (`Name`, `Description`) VALUES
('Pool', 'An outdoor swimming pool with lounge chairs and poolside service'),
('Gym', 'A fully equipped fitness center open 24/7'),
('Spa', 'A luxurious spa offering a variety of treatments and massages'),
('Conference Room', 'A well-equipped conference room suitable for business meetings and events'),
('Restaurant', 'An on-site restaurant offering a range of international cuisines'),
('Bar', 'A stylish bar serving a variety of cocktails and beverages'),
('Rooftop Terrace', 'A panoramic rooftop terrace offering stunning city views'),
('Parking', 'Secure on-site parking for guests and visitors'),
('Garden', 'A beautifully landscaped garden providing a tranquil space for relaxation'),
('Kids Area', 'A fun and safe play area for children with various activities');


-- Facilities for The Grand Seasons
INSERT INTO `HotelFacility` (`HotelID`, `FacilityID`) VALUES
(1, 1), -- Pool
(1, 2), -- Gym
(1, 3), -- Spa
(1, 4), -- Conference Room
(1, 5), -- Restaurant
(1, 6), -- Bar
(1, 7), -- Rooftop Terrace
(1, 9); -- Garden

-- Facilities for Oceanview Retreat
INSERT INTO `HotelFacility` (`HotelID`, `FacilityID`) VALUES
(2, 1), -- Pool
(2, 2), -- Gym
(2, 3), -- Spa
(2, 5), -- Restaurant
(2, 6), -- Bar
(2, 8), -- Parking
(2, 9); -- Garden

-- Facilities for Mountain Escape
INSERT INTO `HotelFacility` (`HotelID`, `FacilityID`) VALUES
(3, 1), -- Pool
(3, 2), -- Gym
(3, 4), -- Conference Room
(3, 5), -- Restaurant
(3, 7), -- Rooftop Terrace
(3, 8), -- Parking
(3, 10); -- Kids Area


-- Populate Room Type Data
INSERT INTO `RoomType` (`Name`, `Description`, `Price`, `Capacity`) VALUES
('Standard Single', 'A cozy and comfortable room perfect for solo travelers, featuring essential amenities like a comfortable bed, a work desk, and a private bathroom.', 100.00, 1),
('Standard Double', 'Ideal for couples or friends, this room offers two beds, essential amenities, and a warm, inviting atmosphere.', 120.00, 2),
('Deluxe Single', 'A spacious and elegantly furnished room for solo travelers, offering additional amenities such as a larger bed, a seating area, and enhanced room service.', 150.00, 1),
('Deluxe Double', 'Perfect for those seeking extra comfort, this room features two large beds, a seating area, and upgraded amenities for a relaxing stay.', 180.00, 2),
('Suite', 'A luxurious suite with premium amenities, offering a separate living area, king-sized bed, and top-notch services, ideal for those desiring the finest accommodations.', 250.00, 2),
('Executive Suite', 'An exquisite suite with high-end furnishings, a spacious living area, a king-sized bed, and exclusive services, tailored for business travelers and luxury seekers.', 300.00, 2),
('Presidential Suite', 'The epitome of luxury, this expansive suite features the most exclusive amenities, including a large living area, a luxurious bathroom, and unparalleled services.', 500.00, 3),
('Family Room', 'Designed for family stays, this room offers multiple beds, a comfortable seating area, and amenities to accommodate up to three guests comfortably.', 200.00, 3);


-- Populate Amenity Data
INSERT INTO `Amenity` (`Name`, `Description`) VALUES 
('WiFi', 'High-speed wireless internet access'),
('Air Conditioning', 'Adjustable air conditioning system'),
('Mini Bar', 'Stocked mini bar with snacks and drinks'),
('Safe', 'Secure in-room safe for valuables'),
('Tea and Coffee Maker', 'In-room facilities to make tea and coffee'),
('Spa Access', 'Access to wellness and spa area'),
('Gym Access', 'Access to a fitness center'),
('Room Service', 'Ability to order food and drinks to the room'),
('Concierge Service', 'Personalized assistance for various guest inquiries'),
('Premium TV Channels', 'Access to a wide range of TV channels, including premium content'),
('Complimentary Breakfast', 'Free breakfast included with the room'),
('Balcony', 'Rooms equipped with a private balcony'),
('Jacuzzi', 'Rooms equipped with a private Jacuzzi');


-- Assign amenities to room types in RoomTypeAmenity table
INSERT INTO `RoomTypeAmenity` (`RoomTypeID`, `AmenityID`) VALUES
-- Standard Single (TypeID = 1)
(1, 1), (1, 2), -- Basic amenities: WiFi, Air Conditioning
-- Standard Double (TypeID = 2)
(2, 1), (2, 2), (2, 6), (2, 10), -- Additional: Complimentary Breakfast, Tea and Coffee Maker
-- Deluxe Single (TypeID = 3)
(3, 1), (3, 2), (3, 3), (3, 4), (3, 5), (3, 6), (3, 10), -- Additional: Mini Bar, Safe, Room Service
-- Deluxe Double (TypeID = 4)
(4, 1), (4, 2), (4, 3), (4, 4), (4, 5), (4, 6), (4, 7), (4, 10), -- Additional: Balcony
-- Suite (TypeID = 5)
(5, 1), (5, 2), (5, 3), (5, 4), (5, 5), (5, 6), (5, 7), (5, 8), (5, 9), (5, 10), -- Additional: Premium TV Channels, Gym Access
-- Executive Suite (TypeID = 6)
(6, 1), (6, 2), (6, 3), (6, 4), (6, 5), (6, 6), (6, 7), (6, 8), (6, 9), (6, 10), (6, 11), (6, 12), -- Additional: Spa Access, Concierge Service
-- Presidential Suite (TypeID = 7)
(7, 1), (7, 2), (7, 3), (7, 4), (7, 5), (7, 6), (7, 7), (7, 8), (7, 9), (7, 10), (7, 11), (7, 12), (7, 13), -- All amenities
-- Family Room (TypeID = 8)
(8, 1), (8, 2), (8, 3), (8, 6), (8, 7), (8, 10); -- Family-friendly amenities

-- Populate Room Status Data
INSERT INTO `RoomStatus` (`Name`, `Description`) VALUES
('Available', 'Room is available for booking'),
('Occupied', 'Room is currently occupied'),
('Maintenance', 'Room is under maintenance or cleaning');


-- Insert rooms for Sunset Resort (SR), excluding status 4
INSERT INTO `Room` (`HotelID`, `RoomTypeID`, `RoomStatusID`, `RoomNumber`) VALUES
(1, 1, 1, 'SR101'), (1, 1, 2, 'SR102'), (1, 1, 3, 'SR103'), -- Standard Single
(1, 2, 1, 'SR105'), (1, 2, 2, 'SR106'), (1, 2, 3, 'SR107'), -- Standard Double
(1, 3, 1, 'SR201'), (1, 3, 2, 'SR202'), (1, 3, 3, 'SR203'), -- Deluxe Single
(1, 4, 1, 'SR301'), (1, 4, 2, 'SR302'), (1, 4, 3, 'SR303'), -- Deluxe Double
(1, 5, 1, 'SR401'), (1, 5, 2, 'SR402'), (1, 5, 3, 'SR403'), -- Suite
(1, 6, 1, 'SR501'), (1, 6, 2, 'SR502'), (1, 6, 3, 'SR503'), -- Executive Suite
(1, 7, 1, 'SR601'), (1, 7, 2, 'SR602'), (1, 7, 3, 'SR603'), -- Presidential Suite
(1, 8, 1, 'SR701'), (1, 8, 2, 'SR702'), (1, 8, 3, 'SR703'), -- Family Room
(1, 1, 1, 'SR105'), (1, 1, 2, 'SR106'), (1, 1, 3, 'SR107'), -- Additional Standard Single
(1, 2, 1, 'SR109'), (1, 2, 2, 'SR110'), (1, 2, 3, 'SR111'), -- Additional Standard Double
(1, 3, 1, 'SR205'), (1, 3, 2, 'SR206'), (1, 3, 3, 'SR207'), -- Additional Deluxe Single
(1, 4, 1, 'SR305'), (1, 4, 2, 'SR306'), (1, 4, 3, 'SR307'), -- Additional Deluxe Double
(1, 5, 1, 'SR405'), (1, 5, 2, 'SR406'), (1, 5, 3, 'SR407'), -- Additional Suite
(1, 6, 1, 'SR505'), (1, 6, 2, 'SR506'), (1, 6, 3, 'SR507'), -- Additional Executive Suite
(1, 7, 1, 'SR605'), (1, 7, 2, 'SR606'), (1, 7, 3, 'SR607'), -- Additional Presidential Suite
(1, 8, 1, 'SR705'), (1, 8, 2, 'SR706'), (1, 8, 3, 'SR707'); -- Additional Family Room


-- Insert rooms for Mountain Escape (ME)
INSERT INTO `Room` (`HotelID`, `RoomTypeID`, `RoomStatusID`, `RoomNumber`) VALUES
(2, 1, 1, 'ME101'), (2, 1, 2, 'ME102'), (2, 1, 3, 'ME103'), -- Standard Single
(2, 2, 1, 'ME105'), (2, 2, 2, 'ME106'), (2, 2, 3, 'ME107'), -- Standard Double
(2, 3, 1, 'ME201'), (2, 3, 2, 'ME202'), (2, 3, 3, 'ME203'), -- Deluxe Single
(2, 4, 1, 'ME301'), (2, 4, 2, 'ME302'), (2, 4, 3, 'ME303'), -- Deluxe Double
(2, 5, 1, 'ME401'), (2, 5, 2, 'ME402'), (2, 5, 3, 'ME403'), -- Suite
(2, 6, 1, 'ME501'), (2, 6, 2, 'ME502'), (2, 6, 3, 'ME503'), -- Executive Suite
(2, 7, 1, 'ME601'), (2, 7, 2, 'ME602'), (2, 7, 3, 'ME603'), -- Presidential Suite
(2, 8, 1, 'ME701'), (2, 8, 2, 'ME702'), (2, 8, 3, 'ME703'), -- Family Room
(2, 1, 1, 'ME105'), (2, 1, 2, 'ME106'), (2, 1, 3, 'ME107'), -- Additional Standard Single
(2, 2, 1, 'ME109'), (2, 2, 2, 'ME110'), (2, 2, 3, 'ME111'), -- Additional Standard Double
(2, 3, 1, 'ME205'), (2, 3, 2, 'ME206'), (2, 3, 3, 'ME207'), -- Additional Deluxe Single
(2, 4, 1, 'ME305'), (2, 4, 2, 'ME306'), (2, 4, 3, 'ME307'), -- Additional Deluxe Double
(2, 5, 1, 'ME405'), (2, 5, 2, 'ME406'), (2, 5, 3, 'ME407'), -- Additional Suite
(2, 6, 1, 'ME505'), (2, 6, 2, 'ME506'), (2, 6, 3, 'ME507'), -- Additional Executive Suite
(2, 7, 1, 'ME605'), (2, 7, 2, 'ME606'), (2, 7, 3, 'ME607'), -- Additional Presidential Suite
(2, 8, 1, 'ME705'), (2, 8, 2, 'ME706'), (2, 8, 3, 'ME707'); -- Additional Family Room


-- Insert rooms for Urban Retreat (UR)
INSERT INTO `Room` (`HotelID`, `RoomTypeID`, `RoomStatusID`, `RoomNumber`) VALUES
(3, 1, 1, 'UR101'), (3, 1, 2, 'UR102'), (3, 1, 3, 'UR103'), -- Standard Single
(3, 2, 1, 'UR105'), (3, 2, 2, 'UR106'), (3, 2, 3, 'UR107'), -- Standard Double
(3, 3, 1, 'UR201'), (3, 3, 2, 'UR202'), (3, 3, 3, 'UR203'), -- Deluxe Single
(3, 4, 1, 'UR301'), (3, 4, 2, 'UR302'), (3, 4, 3, 'UR303'), -- Deluxe Double
(3, 5, 1, 'UR401'), (3, 5, 2, 'UR402'), (3, 5, 3, 'UR403'), -- Suite
(3, 6, 1, 'UR501'), (3, 6, 2, 'UR502'), (3, 6, 3, 'UR503'), -- Executive Suite
(3, 7, 1, 'UR601'), (3, 7, 2, 'UR602'), (3, 7, 3, 'UR603'), -- Presidential Suite
(3, 8, 1, 'UR701'), (3, 8, 2, 'UR702'), (3, 8, 3, 'UR703'), -- Family Room
(3, 1, 1, 'UR105'), (3, 1, 2, 'UR106'), (3, 1, 3, 'UR107'), -- Additional Standard Single
(3, 2, 1, 'UR109'), (3, 2, 2, 'UR110'), (3, 2, 3, 'UR111'), -- Additional Standard Double
(3, 3, 1, 'UR205'), (3, 3, 2, 'UR206'), (3, 3, 3, 'UR207'), -- Additional Deluxe Single
(3, 4, 1, 'UR305'), (3, 4, 2, 'UR306'), (3, 4, 3, 'UR307'), -- Additional Deluxe Double
(3, 5, 1, 'UR405'), (3, 5, 2, 'UR406'), (3, 5, 3, 'UR407'), -- Additional Suite
(3, 6, 1, 'UR505'), (3, 6, 2, 'UR506'), (3, 6, 3, 'UR507'), -- Additional Executive Suite
(3, 7, 1, 'UR605'), (3, 7, 2, 'UR606'), (3, 7, 3, 'UR607'), -- Additional Presidential Suite
(3, 8, 1, 'UR705'), (3, 8, 2, 'UR706'), (3, 8, 3, 'UR707'); -- Additional Family Room



-- Populate Service Data
INSERT INTO `Service` (`Name`, `Description`, `Price`) VALUES 
('Car Rental', 'Offers convenient car rental options for guests', 60.00),
('Flower Arrangement', 'Provides custom flower arrangement services for rooms and events', 35.00),
('Dry Cleaning', 'Professional dry cleaning services for guest apparel', 20.00),
('Ironing', 'Quick and efficient ironing services for guest clothing', 15.00),
('Catering', 'Offers catering for events, meetings, and room service', 100.00),
('Concierge', 'Provides assistance with bookings, reservations, and local information', 25.00),
('Excursions and Guided Tours', 'Organizes local excursions and guided tours for guests', 50.00),
('Booking Cancellation Service', 'Allows guests to cancel their bookings with ease', 10.00),
('Room Upgrade', 'Offers guests the option to upgrade their room', 75.00),
('Early Check-In', 'Enables guests to check in earlier than the standard time', 30.00),
('Late Check-Out', 'Allows guests to extend their check-out time', 30.00),
('Airport Shuttle Service', 'Provides shuttle services to and from the airport', 40.00),
('Spa Appointment Booking', 'Assists guests in booking spa appointments', 5.00),
('Theatre and Event Ticketing', 'Helps guests purchase tickets for local theatres and events', 15.00),
('Personal Trainer Services', 'Offers personal training sessions in the hotel gym', 50.00);

-- Associating services with Sunset Resort (HotelID 1)
INSERT INTO HotelService (`HotelID`, `ServiceID`) VALUES 
(1, 1),  -- Car Rental
(1, 2),  -- Flower Arrangement
(1, 3),  -- Dry Cleaning
(1, 5),  -- Catering
(1, 6),  -- Concierge
(1, 7),  -- Excursions and Guided Tours
(1, 9),  -- Room Upgrade
(1, 11), -- Late Check-Out
(1, 12), -- Airport Shuttle Service
(1, 13), -- Spa Appointment Booking
(1, 15); -- Personal Trainer Services

-- Associating services with Mountain Escape (HotelID 2)
INSERT INTO HotelService (`HotelID`, `ServiceID`) VALUES 
(2, 2),  -- Flower Arrangement
(2, 4),  -- Ironing
(2, 5),  -- Catering
(2, 6),  -- Concierge
(2, 8),  -- Booking Cancellation Service
(2, 10), -- Early Check-In
(2, 12), -- Airport Shuttle Service
(2, 13), -- Spa Appointment Booking
(2, 14), -- Theatre and Event Ticketing
(2, 15); -- Personal Trainer Services

-- Associating services with Urban Retreat (HotelID 3)
INSERT INTO HotelService (`HotelID`, `ServiceID`) VALUES 
(3, 1),  -- Car Rental
(3, 3),  -- Dry Cleaning
(3, 4),  -- Ironing
(3, 6),  -- Concierge
(3, 7),  -- Excursions and Guided Tours
(3, 9),  -- Room Upgrade
(3, 11), -- Late Check-Out
(3, 12), -- Airport Shuttle Service
(3, 14), -- Theatre and Event Ticketing
(3, 15); -- Personal Trainer Services

-- Populate ServiceStatus table with sample data
INSERT INTO `ServiceStatus` (`Name`, `Description`) VALUES
('Pending', 'Service request is pending confirmation'),
('Confirmed', 'Service request has been confirmed'),
('Canceled', 'Service request has been cancelled'),
('Completed', 'Service has been provided and completed');

-- Populate BookingStatus table with sample data
INSERT INTO `BookingStatus` (`Name`, `Description`) VALUES
('Confirmed', 'The booking is confirmed and the room is reserved'),
('CheckedIn', 'The guest has checked into the hotel'),
('CheckedOut', 'The guest has checked out and the booking is complete'),
('Cancaled',  'Booking has been cancelled');

-- Insert guests
INSERT INTO Guest (`FirstName`, `LastName`, `DateOfBirth`, `Phone`, `Email`) VALUES
('Alice', 'Johnson', '1985-02-15', '123-456-7890', 'alice.johnson@example.com'),
('Bob', 'Smith', '1990-06-20', '234-567-8901', 'bob.smith@example.com'),
('Carol', 'Davis', '1988-03-05', '345-678-9012', 'carol.davis@example.com'),
('David', 'Miller', '1975-07-22', '456-789-0123', 'david.miller@example.com'),
('Emma', 'Wilson', '1982-11-30', '567-890-1234', 'emma.wilson@example.com'),
('Frank', 'Brown', '1992-04-16', '678-901-2345', 'frank.brown@example.com'),
('Grace', 'Taylor', '1986-09-08', '789-012-3456', 'grace.taylor@example.com');


-- Insert bookings
INSERT INTO `Booking` (`GuestID`, `HotelID`, `BookingStatusID`, `CheckinDate`, `CheckoutDate`, `Price`) VALUES
(1, 1, 1, '2024-01-10', '2024-01-12', 300.00),  -- Booking by Alice
(2, 2, 2, '2024-01-15', '2024-01-18', 450.00),  -- Booking by Bob
(3, 3, 3, '2024-01-20', '2024-01-22', 500.00),  -- Booking by Carol
(4, 1, 4, '2024-02-05', '2024-02-07', 350.00),  -- Booking by David
(5, 1, 1, '2024-02-10', '2024-02-12', 500.00),  -- Booking by Emma
(6, 2, 2, '2024-02-15', '2024-02-17', 650.00),  -- Booking by Frank
(7, 3, 3, '2024-02-20', '2024-02-22', 400.00);  -- Booking by Grace


-- Insert bookings room type
INSERT INTO BookingRoomType (BookingID, RoomTypeID, Unit) VALUES
(1, 1, 1), -- Booking by Alice, Standard Single, 1 unit
(1, 2, 1), -- Booking by Alice, Standard Double, 1 unit
(2, 2, 1), -- Booking by Bob, Standard Double, 1 unit
(2, 4, 1), -- Booking by Bob, Deluxe Double, 1 unit
(3, 4, 1), -- Booking by Carol, Deluxe Double, 1 unit
(4, 5, 1), -- Booking by David, Suite, 1 unit
(5, 3, 2), -- Booking by Emma, Deluxe Single, 2 units
(6, 3, 1), -- Booking by Frank, Deluxe Single, 1 unit
(6, 6, 1), -- Booking by Frank, Executive Suite, 1 unit
(7, 8, 1); -- Booking by Grace, Family Room, 1 unit

-- Insert bookings room
INSERT INTO `BookingRoom` (`BookingID`, `RoomID`) VALUES
-- Assigning rooms for Sunset Resort (Hotel ID 1)
(1, 1), -- Booking by Alice, Standard Single, RoomID 1 (SR101)
(1, 5), -- Booking by Alice, Standard Double, RoomID 5 (SR105)
(2, 6), -- Booking by Bob, Standard Double, RoomID 6 (SR106)
(2, 8), -- Booking by Bob, Deluxe Double, RoomID 8 (SR201)
(3, 9), -- Booking by Carol, Deluxe Double, RoomID 9 (SR202)
(4, 10), -- Booking by David, Suite, RoomID 10 (SR301)
(5, 7), (5, 11), -- Booking by Emma, Deluxe Single, RoomIDs 7 (SR203), 11 (SR205)
(6, 12), -- Booking by Frank, Deluxe Single, RoomID 12 (SR206)
(6, 13), -- Booking by Frank, Executive Suite, RoomID 13 (SR501)
(7, 14), (7, 15); -- Booking by Grace, Family Room, RoomIDs 14 (SR701), 15 (SR702)


-- Insert service bookings
INSERT INTO `BookingService` (`BookingID`, `ServiceID`, `ServiceStatusID`, `Unit`, `Note`) VALUES
(1, 1, 1, 1, 'Car rental for entire stay'),        -- Car Rental for Alice
(1, 7, 1, 2, 'Two guided tours'),                  -- Excursions and Guided Tours for Alice
(2, 4, 1, 3, 'Daily ironing service'),             -- Ironing for Bob
(3, 5, 1, 1, 'Catering for a private event'),      -- Catering for Carol
(4, 12, 1, 1, 'Airport shuttle on departure'),     -- Airport Shuttle for David
(5, 3, 1, 5, 'Dry cleaning during stay'),          -- Dry Cleaning for Emma
(6, 9, 1, 1, 'Room upgrade to Executive Suite'),   -- Room Upgrade for Frank
(7, 10, 1, 1, 'Early check-in requested'),         -- Early Check-In for Grace
(7, 15, 1, 2, 'Personal trainer sessions');        -- Personal Trainer Services for Grace


-- Insert Feedback for each booking
INSERT INTO `Feedback` (`BookingID`, `Rating`, `Comment`) VALUES
(1, 5, 'Excellent service and comfortable stay. Loved the car rental service.'),
(2, 4, 'Very good experience, but the ironing service took longer than expected.'),
(3, 3, 'Average stay. Room was clean, but catering service was not up to the mark.'),
(4, 5, 'Fantastic experience! Concierge was exceptionally helpful.'),
(5, 4, 'Great stay overall, loved the flower arrangement in the room.'),
(6, 2, 'Room was nice, but car rental service was not available when needed.'),
(7, 5, 'Perfect stay with excellent guided tour arrangements. Highly recommended.');

-- Insert PaymentMethod
INSERT INTO `PaymentMethod` (`MethodName`, `Description`) VALUES
('Credit Card', 'Payment made using a credit card'),
('Debit Card', 'Payment made using a debit card'),
('Cash', 'Payment made in cash'),
('Online Transfer', 'Payment made via online bank transfer');

-- Insert Payment
INSERT INTO `Payment` (`BookingID`, `PaymentMethodID`, `Amount`) VALUES
(1, 1, 300.00), -- Payment for Alice's booking
(2, 2, 450.00), -- Payment for Bob's booking
(3, 3, 500.00), -- Payment for Carol's booking
(4, 1, 350.00), -- Payment for David's booking
(5, 4, 500.00), -- Payment for Emma's booking
(6, 2, 650.00), -- Payment for Frank's booking
(7, 3, 400.00); -- Payment for Grace's booking
