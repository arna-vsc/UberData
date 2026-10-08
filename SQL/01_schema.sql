CREATE DATABASE IF NOT EXISTS UberData;
USE UberData;

DROP TABLE IF EXISTS bookings;

CREATE TABLE bookings (
    trip_id INT AUTO_INCREMENT PRIMARY KEY,
    date DATE NOT NULL,
    time TIME NOT NULL,
    booking_id VARCHAR(50) NOT NULL,
    booking_status VARCHAR(50) NOT NULL,
    customer_id VARCHAR(50) NOT NULL,
    vehicle_type VARCHAR(50) NOT NULL,
    pickup_location VARCHAR(150) NOT NULL,
    drop_location VARCHAR(150) NOT NULL,
    avg_vtat DECIMAL(6,2) NULL,
    avg_ctat DECIMAL(6,2) NULL,
    is_cancelled_by_customer TINYINT NOT NULL DEFAULT 0,
    reason_for_cancelling_by_customer VARCHAR(255) NOT NULL,
    is_cancelled_by_driver TINYINT NOT NULL DEFAULT 0,
    driver_cancellation_reason VARCHAR(255) NOT NULL,
    is_incomplete TINYINT NOT NULL DEFAULT 0,
    incomplete_rides_reason VARCHAR(255) NOT NULL,
    booking_value DECIMAL(10,2) NULL,
    ride_distance DECIMAL(8,2) NULL,
    driver_ratings DECIMAL(3,2) NULL,
    customer_rating DECIMAL(3,2) NULL,
    payment_method VARCHAR(50) NOT NULL,
    INDEX idx_date (date),
    INDEX idx_status (booking_status),
    INDEX idx_vehicle (vehicle_type),
    INDEX idx_pickup (pickup_location)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

USE UberData;

SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT booking_id) AS unique_booking_ids,
    SUM(CASE WHEN booking_status = 'Completed' THEN 1 ELSE 0 END) AS completed_trips,
    SUM(CASE WHEN booking_status = 'Completed' THEN booking_value ELSE 0 END) AS total_revenue
FROM bookings;