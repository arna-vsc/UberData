
                   UBER EXECUTIVE ANALYTICS DASHBOARD
               End-to-End Business Intelligence and Data Engineering
================================================================================

PROJECT SUMMARY
--------------------------------------------------------------------------------
An enterprise analytics suite analyzing 150,000 Uber ride records. The project
identifies conversion funnel leakage, evaluates vehicle fleet yield economics,
diagnoses cancellation root causes, and models platform fulfillment through an
end-to-end pipeline: raw data auditing in Excel, SQL data warehousing, Python
statistical modeling, and an interactive multi-page executive Power BI dashboard
with drillthrough capabilities.


KEY METRICS AT A GLANCE
--------------------------------------------------------------------------------
* Total Platform Demand       : 150,000 Bookings
* Completed Rides             : 93,000 Trips (62.0% Fulfillment Rate)
* Total Gross Completed GMV   : ₹47,260,574
* Total Estimated Lost GMV    : ₹28,969,426
* Primary Bottleneck          : Driver Cancellations with 27,000 trips and ₹13.72M Lost GMV
* Platform Average Distance   : 26.00 km across completed rides
* Platform Average Fare       : ₹508.18 across distance tiers
* Highest Yield Segment       : Short Rides under 5 km at ₹153.73 per km
* Dispatch SLA                : 8.46 minutes average VTAT with severe delay rate at 2.6%
* Customer CSAT / Driver CSAT : 4.40 / 4.23 out of 5.00


KEY INSIGHTS SUMMARY
--------------------------------------------------------------------------------
- Conversion Funnel          : 62.0% completion rate; 38.0% funnel loss driven by
                               Driver Cancels at 18.0%, Customer Cancels at 7.0%,
                               No Driver Found at 7.0%, and Incomplete at 6.0%.
- Customer Cancel Causes     : Wrong Address at 22.50%, Change of Plans at 22.41%,
                               Driver Stationary at 22.24%, and Driver Asked to Cancel at 21.86%.
- Driver Cancel Causes       : Customer Issues at 25.32%, Driver Sick at 25.00%,
                               Personal and Vehicle Issues at 24.91%, and Excess Passengers at 24.77%.
- Failure Hotspots           : High failure clusters led by Pragati Maidan at 382,
                               Saket at 374, Vinobapuri at 373, and Akshardham at 368 unfulfilled trips.
- Dispatch SLAs              : VTAT averages 8.46 min; severe delays over 15 min are
                               tightly controlled near 2.6% across all vehicle tiers.
- Fleet Contribution         : Auto at ₹11.73M and Go Mini at ₹9.41M generate 44.7%
                               of total gross revenue, followed by Go Sedan at ₹8.54M and Bike at ₹7.14M.
- Unit Yield Economics       : Nominal fares remain flat near ₹508 regardless of distance,
                               making Short trips under 5 km 11.8 times more lucrative per km
                               at ₹153.73 per km than trips over 30 km at ₹13.00 per km.
- Fleet Performance          : Completion rate holds stable near 62% uniformly across all
                               7 vehicle categories.
- CSAT vs. Operations        : Trip durations with VTAT at 8.45 min and CTAT at 29.15 min are
                               constant across rating bands; penalties stem from qualitative
                               in-vehicle friction rather than operational delays.
- Lost GMV Sizing            : ₹28.97M in total lost revenue, with Driver Cancellations
                               accounting for ₹13.72M which represents 47.4% of total loss.


REPOSITORY STRUCTURE

```text

├── data/
│   ├── raw_booking.csv             # Raw 150K Uber booking records
│   └── cleaned_booking.csv         # Cleaned, standardized tabular dataset
├── excel/
│   └── cleaned_booking.xlsb        # Excel workbook with validation formulas, XLOOKUP and pivot tables
├── sql/
│   ├── 01_schema.sql               # DDL table creation, indexes and schema definitions
│   ├── 02_views.sql                # SQL views including v_fact_trips with metric logic
│   └── 03_analysis.sql             # Diagnostic queries answering business questions
├── python/
│   ├── advanced_analysis.ipynb     # Python statistical profiling and correlation analysis
│   └── data_ingestion.ipynb        # Ingested the data cleaned csv into the SQL
|   └── data_cleaning.ipynb         # Cleaned data for the SQL 
|   └── visuals.ipynb               # Created distribution plots and visuals
├── powerbi/
│   └── Uber_Executive_Analytics.pbix # Multi-page interactive Power BI dashboard
├── docs/
│   ├── PROJECT_DOCUMENTATION.txt   # Comprehensive technical whitepaper and DAX dictionary
│   └── README.txt                  # Project quickstart and architecture overview

```

TECH STACK
--------------------------------------------------------------------------------
- Spreadsheet Engineering  : Microsoft Excel with XLOOKUP, SUMIFS, Pivot Tables, and Structured Tables
- Data Ingestion and ETL   : Excel Power Query and Python Pandas
- Database and Warehousing : MySQL 8.0 with DDL schemas, B-tree indexes, and reporting views
- Statistical Analysis     : Python with Pandas, NumPy, Matplotlib, and Seaborn
- Business Intelligence    : Microsoft Power BI Desktop
- Modeling Architecture    : Star Schema under Kimball Methodology
- Calculation Language     : DAX with context transition, ALL, and KEEPFILTERS


DASHBOARD PAGES OVERVIEW
--------------------------------------------------------------------------------
1. Executive Overview:
   Conversion funnel leakage normalized against 150K total platform demand,
   fleet revenue contribution, distance tier yield invariance, and lost GMV financial waterfall.

2. Operations Diagnostics:
   Driver vs customer cancellation root causes, complete top 10 unfulfilled pickup
   hotspots, and dispatch wait time SLA analysis.

3. Fleet and Customer Experience:
   Full 7-tier vehicle matrix scorecard, CSAT vs operational duration invariance,
   and payment channel revenue share with clear center metrics.

4. Location Diagnostic Drillthrough Page:
   Contextual drilldown on any pickup hotspot to isolate drop-off destinations,
   volume patterns, and localized failure distributions with native back navigation.


HOW TO REPRODUCE AND RUN
--------------------------------------------------------------------------------
1. Data Sanitization and Staging:
   - Run python/data_cleaning.py to generate sanitized flags and strings.
   - Open Cleaned_Data.xlsx to review Excel structured tables, XLOOKUP mapping, and pivot checks.
2. Database Warehousing:
   - Execute sql/01_schema.sql in MySQL to initialize database structure and indexing.
   - Run python/data_ingestion.py to append cleaned_booking.csv into the bookings table.
   - Execute sql/02_views.sql to generate the reporting view v_fact_trips.
   - Run sql/03_analysis.sql to execute diagnostic analytical queries.
3. Statistical Analysis:
   - Run python/advance_analysis.py to output statistical profiling and correlation matrix.
   - Run python/visuals.py to generate visual charts in the outputs directory.
4. Power BI Reporting:
   - Open powerbi/Uber_Executive_Analytics.pbix.
   - Update MySQL data source credentials or point the local CSV source to cleaned_booking.csv.
   - Click Refresh to populate the dimensional model, DAX measures, and interactive reports.
