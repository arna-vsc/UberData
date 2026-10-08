USE UberData;

-- =============================================================================
-- QUESTION 1: How efficiently is the platform converting bookings into successful rides?
-- Metric: Booking Conversion Funnel, Completion Rate (%), Cancellation & Dropoff Rates (%)
-- =============================================================================
WITH booking_summary AS (
    SELECT 
        booking_status,
        COUNT(*) AS booking_count,
        SUM(COUNT(*)) OVER() AS total_platform_bookings
    FROM bookings
    GROUP BY booking_status
)
SELECT 
    booking_status,
    booking_count,
    ROUND((booking_count * 100.0) / total_platform_bookings, 2) AS pct_share
FROM booking_summary
ORDER BY booking_count DESC;

-- =============================================================================
-- QUESTION 2: Why are customers cancelling their bookings?
-- Metric: Volume and Percentage Share of Customer Cancellation Reasons
-- =============================================================================
WITH cust_cancels AS (
    SELECT 
        reason_for_cancelling_by_customer AS cancellation_reason,
        COUNT(*) AS total_cancellations,
        SUM(COUNT(*)) OVER() AS total_cust_cancellations
    FROM bookings
    WHERE is_cancelled_by_customer = 1 
      AND reason_for_cancelling_by_customer != 'Not Applicable'
    GROUP BY reason_for_cancelling_by_customer
)
SELECT 
    cancellation_reason,
    total_cancellations,
    ROUND((total_cancellations * 100.0) / total_cust_cancellations, 2) AS pct_share,
    DENSE_RANK() OVER (ORDER BY total_cancellations DESC) AS reason_rank
FROM cust_cancels
ORDER BY total_cancellations DESC;

-- =============================================================================
-- QUESTION 3: Why are drivers cancelling bookings?
-- Metric: Volume and Percentage Share of Driver Cancellation Reasons
-- =============================================================================
WITH driver_cancels AS (
    SELECT 
        driver_cancellation_reason AS cancellation_reason,
        COUNT(*) AS total_cancellations,
        SUM(COUNT(*)) OVER() AS total_driver_cancellations
    FROM bookings
    WHERE is_cancelled_by_driver = 1 
      AND driver_cancellation_reason != 'Not Applicable'
    GROUP BY driver_cancellation_reason
)
SELECT 
    cancellation_reason,
    total_cancellations,
    ROUND((total_cancellations * 100.0) / total_driver_cancellations, 2) AS pct_share,
    DENSE_RANK() OVER (ORDER BY total_cancellations DESC) AS reason_rank
FROM driver_cancels
ORDER BY total_cancellations DESC;

-- =============================================================================
-- QUESTION 4: Where is the platform failing to complete rides?
-- Metric: Top 10 High-Failure Pickup Localities (Unfulfilled + Cancelled + Incomplete)
-- =============================================================================
SELECT 
    pickup_location,
    COUNT(*) AS total_requests,
    SUM(CASE WHEN booking_status = 'Completed' THEN 1 ELSE 0 END) AS completed_trips,
    SUM(CASE WHEN booking_status != 'Completed' THEN 1 ELSE 0 END) AS failed_trips,
    ROUND((SUM(CASE WHEN booking_status != 'Completed' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 2) AS failure_rate_pct,
    DENSE_RANK() OVER (ORDER BY SUM(CASE WHEN booking_status != 'Completed' THEN 1 ELSE 0 END) DESC) AS failure_volume_rank
FROM bookings
GROUP BY pickup_location
ORDER BY failed_trips DESC
LIMIT 10;

-- =============================================================================
-- QUESTION 5: Is the platform providing a fast enough pickup experience?
-- Metric: Vehicle Arrival Time (VTAT), Customer Turnaround Time (CTAT), SLA Delay Rate
-- =============================================================================
SELECT 
    vehicle_type,
    COUNT(*) AS rides_assigned,
    ROUND(AVG(avg_vtat), 2) AS avg_pickup_arrival_time_min,
    ROUND(MIN(avg_vtat), 2) AS min_vtat_min,
    ROUND(MAX(avg_vtat), 2) AS max_vtat_min,
    ROUND(AVG(avg_ctat), 2) AS avg_trip_duration_min,
    ROUND(SUM(CASE WHEN avg_vtat > 15 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS pct_severe_pickup_delays
FROM bookings
WHERE avg_vtat IS NOT NULL
GROUP BY vehicle_type
ORDER BY avg_pickup_arrival_time_min ASC;

-- =============================================================================
-- QUESTION 6: What type of rides generate the most value?
-- Metric: Gross Completed Revenue, Revenue Contribution (%), and Average Fare by Fleet Tier
-- =============================================================================
WITH revenue_summary AS (
    SELECT 
        vehicle_type,
        COUNT(*) AS completed_rides,
        SUM(booking_value) AS total_revenue,
        AVG(booking_value) AS avg_fare_per_ride,
        SUM(SUM(booking_value)) OVER() AS gross_platform_revenue
    FROM bookings
    WHERE booking_status = 'Completed'
    GROUP BY vehicle_type
)
SELECT 
    vehicle_type,
    completed_rides,
    ROUND(total_revenue, 2) AS total_revenue,
    ROUND(avg_fare_per_ride, 2) AS avg_fare_per_ride,
    ROUND((total_revenue * 100.0) / gross_platform_revenue, 2) AS revenue_pct,
    DENSE_RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank
FROM revenue_summary
ORDER BY total_revenue DESC;

-- =============================================================================
-- QUESTION 7: Are longer rides actually more valuable?
-- Metric: Distance Bucketing, Total Rides, Avg Fare, and Fare Yield per Kilometer
-- =============================================================================
SELECT 
    CASE 
        WHEN ride_distance < 5 THEN '1. Short (< 5 km)'
        WHEN ride_distance BETWEEN 5 AND 15 THEN '2. Medium (5 - 15 km)'
        WHEN ride_distance BETWEEN 15.01 AND 30 THEN '3. Long (15 - 30 km)'
        ELSE '4. Very Long (> 30 km)'
    END AS distance_tier,
    COUNT(*) AS completed_rides,
    ROUND(AVG(ride_distance), 2) AS avg_distance_km,
    ROUND(AVG(booking_value), 2) AS avg_booking_value,
    ROUND(AVG(booking_value / NULLIF(ride_distance, 0)), 2) AS avg_fare_per_km
FROM bookings
WHERE booking_status = 'Completed' 
  AND ride_distance IS NOT NULL
GROUP BY distance_tier
ORDER BY distance_tier ASC;

-- =============================================================================
-- QUESTION 8: How do different vehicle types perform?
-- Metric: Operational Scorecard (Bookings, Completion %, Distance, Fare, Customer & Driver CSAT)
-- =============================================================================
SELECT 
    vehicle_type,
    COUNT(*) AS total_bookings,
    SUM(CASE WHEN booking_status = 'Completed' THEN 1 ELSE 0 END) AS completed_rides,
    ROUND((SUM(CASE WHEN booking_status = 'Completed' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 2) AS completion_rate_pct,
    ROUND(AVG(CASE WHEN booking_status = 'Completed' THEN ride_distance ELSE NULL END), 2) AS avg_ride_distance_km,
    ROUND(AVG(CASE WHEN booking_status = 'Completed' THEN booking_value ELSE NULL END), 2) AS avg_fare,
    ROUND(AVG(CASE WHEN booking_status = 'Completed' THEN customer_rating ELSE NULL END), 2) AS avg_customer_rating,
    ROUND(AVG(CASE WHEN booking_status = 'Completed' THEN driver_ratings ELSE NULL END), 2) AS avg_driver_rating
FROM bookings
GROUP BY vehicle_type
ORDER BY total_bookings DESC;

-- =============================================================================
-- QUESTION 9: What makes a ride a good or bad customer experience?
-- Metric: Rating Tier Segmentation vs. Pickup Wait (VTAT), Trip Duration (CTAT), and Fare
-- =============================================================================
SELECT 
    CASE 
        WHEN customer_rating >= 4.5 THEN 'High CSAT (4.5 - 5.0)'
        WHEN customer_rating >= 4.0 THEN 'Medium CSAT (4.0 - 4.49)'
        ELSE 'Low CSAT (< 4.0)'
    END AS csat_tier,
    COUNT(*) AS completed_rated_rides,
    ROUND(AVG(avg_vtat), 2) AS avg_arrival_wait_min,
    ROUND(AVG(avg_ctat), 2) AS avg_trip_time_min,
    ROUND(AVG(ride_distance), 2) AS avg_distance_km,
    ROUND(AVG(booking_value), 2) AS avg_fare
FROM bookings
WHERE customer_rating IS NOT NULL
GROUP BY csat_tier
ORDER BY csat_tier DESC;

-- =============================================================================
-- QUESTION 10: Where are the biggest business opportunities for improving the platform?
-- Metric: Financial Sizing of Lost Gross Merchandise Value (GMV) by Friction Category
-- =============================================================================
WITH benchmark_fare AS (
    SELECT AVG(booking_value) AS avg_completed_fare 
    FROM bookings 
    WHERE booking_status = 'Completed'
)
SELECT 
    b.booking_status AS failure_category,
    COUNT(*) AS lost_or_failed_trips,
    ROUND((COUNT(*) * 100.0) / (SELECT COUNT(*) FROM bookings), 2) AS pct_of_total_demand,
    ROUND(COUNT(*) * bf.avg_completed_fare, 2) AS estimated_lost_gmv,
    DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS financial_loss_rank
FROM bookings b
CROSS JOIN benchmark_fare bf
WHERE b.booking_status != 'Completed'
GROUP BY b.booking_status, bf.avg_completed_fare
ORDER BY lost_or_failed_trips DESC;