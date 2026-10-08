USE UberData;

-- =============================================================================
-- VIEW 1: Fact Trips (Pre-calculated dimensional and operational metrics)
-- =============================================================================
CREATE OR REPLACE VIEW v_fact_trips AS
SELECT 
    trip_id,
    date,
    time,
    HOUR(time) AS booking_hour,
    DAYNAME(date) AS day_of_week,
    CASE WHEN DAYOFWEEK(date) IN (1, 7) THEN 'Weekend' ELSE 'Weekday' END AS day_type,
    booking_id,
    booking_status,
    customer_id,
    vehicle_type,
    pickup_location,
    drop_location,
    avg_vtat,
    avg_ctat,
    booking_value,
    ride_distance,
    CASE 
        WHEN ride_distance IS NOT NULL AND ride_distance > 0 
        THEN ROUND(booking_value / ride_distance, 2) 
        ELSE NULL 
    END AS fare_per_km,
    driver_ratings,
    customer_rating,
    payment_method,
    is_cancelled_by_customer,
    reason_for_cancelling_by_customer,
    is_cancelled_by_driver,
    driver_cancellation_reason,
    is_incomplete,
    incomplete_rides_reason
FROM bookings;

-- =============================================================================
-- VIEW 2: Hourly Demand Summary (Aggregated operational view)
-- =============================================================================
CREATE OR REPLACE VIEW v_hourly_demand_summary AS
SELECT 
    HOUR(time) AS hour_of_day,
    COUNT(*) AS total_requests,
    SUM(CASE WHEN booking_status = 'Completed' THEN 1 ELSE 0 END) AS completed_trips,
    SUM(CASE WHEN booking_status != 'Completed' THEN 1 ELSE 0 END) AS failed_trips,
    ROUND((SUM(CASE WHEN booking_status = 'Completed' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 2) AS completion_rate_pct,
    ROUND(AVG(avg_vtat), 2) AS avg_pickup_wait_min,
    ROUND(SUM(CASE WHEN booking_status = 'Completed' THEN booking_value ELSE 0 END), 2) AS total_revenue
FROM bookings
GROUP BY HOUR(time)
ORDER BY hour_of_day;

-- =============================================================================
-- VIEW 3: Vehicle Performance Scorecard
-- =============================================================================
CREATE OR REPLACE VIEW v_vehicle_scorecard AS
SELECT 
    vehicle_type,
    COUNT(*) AS total_bookings,
    SUM(CASE WHEN booking_status = 'Completed' THEN 1 ELSE 0 END) AS completed_trips,
    ROUND((SUM(CASE WHEN booking_status = 'Completed' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 2) AS completion_rate_pct,
    ROUND(SUM(CASE WHEN booking_status = 'Completed' THEN booking_value ELSE 0 END), 2) AS total_revenue,
    ROUND(AVG(CASE WHEN booking_status = 'Completed' THEN booking_value ELSE NULL END), 2) AS avg_fare_per_ride,
    ROUND(AVG(CASE WHEN booking_status = 'Completed' THEN ride_distance ELSE NULL END), 2) AS avg_distance_km,
    ROUND(AVG(CASE WHEN booking_status = 'Completed' THEN customer_rating ELSE NULL END), 2) AS avg_customer_rating,
    ROUND(AVG(CASE WHEN booking_status = 'Completed' THEN driver_ratings ELSE NULL END), 2) AS avg_driver_rating
FROM bookings
GROUP BY vehicle_type;