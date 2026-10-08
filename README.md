# 🚕 Uber Executive Analytics Dashboard

### End-to-End Business Intelligence & Data Engineering Project

An enterprise-grade analytics project analyzing **150,000 Uber booking records** to identify conversion funnel leakage, evaluate fleet economics, diagnose cancellation drivers, and quantify lost revenue.

The project demonstrates a complete analytics workflow — from **raw data auditing and transformation to SQL warehousing, Python statistical analysis, and an interactive multi-page Power BI executive dashboard**.

---

## 📊 Executive Summary

The analysis evaluates Uber's platform performance across four key business areas:

* **Conversion & Fulfillment** — Where and why bookings fail to become completed rides
* **Cancellation Diagnostics** — Root causes behind customer and driver cancellations
* **Fleet Economics** — Revenue contribution and unit economics across vehicle categories
* **Operational Performance** — Dispatch efficiency, pickup hotspots, and customer experience

### Key Business Metrics

| KPI                      |               Result |
| ------------------------ | -------------------: |
| Total Platform Demand    | **150,000 bookings** |
| Completed Rides          |     **93,000 trips** |
| Fulfillment Rate         |            **62.0%** |
| Funnel Loss              |            **38.0%** |
| Gross Completed GMV      |          **₹47.26M** |
| Estimated Lost GMV       |          **₹28.97M** |
| Driver Cancellation Loss |          **₹13.72M** |
| Average Trip Distance    |         **26.00 km** |
| Average Fare             |          **₹508.18** |
| Average VTAT             |         **8.46 min** |
| Customer CSAT            |      **4.40 / 5.00** |
| Driver CSAT              |      **4.23 / 5.00** |

---

# 🔎 Key Business Insights

## 1. Conversion Funnel Leakage

Only **62.0% of platform demand converts into completed rides**, leaving **38.0% of bookings unfulfilled**.

The largest sources of leakage are:

| Failure Category       | Share of Demand |
| ---------------------- | --------------: |
| Driver Cancellations   |       **18.0%** |
| Customer Cancellations |        **7.0%** |
| No Driver Found        |        **7.0%** |
| Incomplete Bookings    |        **6.0%** |

### Business implication

**Driver cancellations are the primary fulfillment bottleneck**, making driver-side operational reliability the highest-priority improvement area.

---

## 2. Driver Cancellations Are the Largest Revenue Leakage

Driver cancellations account for approximately:

**₹13.72M in estimated lost GMV**

This represents **47.4% of total estimated lost revenue**.

The major driver cancellation causes are relatively evenly distributed:

* Customer Issues — **25.32%**
* Driver Sick — **25.00%**
* Personal & Vehicle Issues — **24.91%**
* Excess Passengers — **24.77%**

### Business implication

Because no single driver cancellation reason dominates, reducing leakage likely requires **multiple operational interventions rather than a single policy fix**.

---

## 3. Customer Cancellation Causes Are Also Broadly Distributed

The leading customer-side cancellation reasons are:

* Wrong Address — **22.50%**
* Change of Plans — **22.41%**
* Driver Stationary — **22.24%**
* Driver Asked to Cancel — **21.86%**

### Business implication

Customer cancellations appear to be driven by a combination of **address accuracy, driver behavior, and changing customer intent**, rather than one dominant cause.

---

# 💰 Fleet & Unit Economics

## Revenue Contribution

The largest revenue-generating vehicle categories are:

| Vehicle Category | Gross Revenue |
| ---------------- | ------------: |
| Auto             |   **₹11.73M** |
| Go Mini          |    **₹9.41M** |
| Go Sedan         |    **₹8.54M** |
| Bike             |    **₹7.14M** |

Auto and Go Mini together contribute approximately **44.7% of total gross completed revenue**.

---

## Distance-Based Yield

A major economic insight is that average fare remains relatively stable at approximately **₹508**, despite substantial differences in trip distance.

This creates a significant difference in revenue efficiency:

| Distance Segment |   Revenue / KM |
| ---------------- | -------------: |
| Under 5 km       | **₹153.73/km** |
| Over 30 km       |  **₹13.00/km** |

Short trips therefore generate approximately **11.8× higher revenue per kilometer** than trips exceeding 30 km.

### Business implication

The platform's fare structure creates a strong **distance-to-yield imbalance**, highlighting an opportunity to evaluate pricing, minimum fares, incentives, and supply allocation by trip distance.

---

# 🚦 Operations Diagnostics

## Dispatch Performance

Average Vehicle Travel Arrival Time (**VTAT**) is:

**8.46 minutes**

Severe delays exceeding 15 minutes represent approximately:

**2.6% of trips**

The severe-delay rate remains relatively stable across vehicle categories.

### Business implication

Dispatch delays are **not the primary explanation for overall fulfillment leakage**. Cancellation behavior appears to be a more significant operational issue.

---

# 📍 Failure Hotspots

The analysis identifies several pickup locations with high volumes of unfulfilled trips.

Top hotspots include:

| Pickup Location | Unfulfilled Trips |
| --------------- | ----------------: |
| Pragati Maidan  |           **382** |
| Saket           |           **374** |
| Vinobapuri      |           **373** |
| Akshardham      |           **368** |

These locations are further investigated through the Power BI **Location Diagnostic Drillthrough** page.

---

# ⭐ Customer Experience

Customer and driver satisfaction scores are:

* **Customer CSAT:** 4.40 / 5.00
* **Driver CSAT:** 4.23 / 5.00

Trip duration remains relatively consistent across rating bands:

* Average VTAT — **8.45 min**
* Average CTAT — **29.15 min**

### Business implication

Ratings do not appear to be strongly explained by operational duration alone.

This suggests that lower satisfaction may be more closely related to **qualitative in-trip experiences and service interactions** rather than simply pickup or trip duration.

---

# 📈 Power BI Dashboard

The Power BI solution contains **four interactive pages** designed for executive and operational analysis.

### 01 — Executive Overview

Provides a high-level view of:

* Platform demand
* Conversion funnel
* Fulfillment rate
* Fleet revenue contribution
* Distance-tier economics
* Lost GMV waterfall

### 02 — Operations Diagnostics

Focuses on:

* Driver cancellation causes
* Customer cancellation causes
* Top unfulfilled pickup hotspots
* Dispatch SLA performance
* VTAT distribution

### 03 — Fleet & Customer Experience

Analyzes:

* 7-category vehicle performance
* Revenue contribution
* Completion rates
* CSAT performance
* Operational duration by rating
* Payment-channel revenue share

### 04 — Location Diagnostic Drillthrough

Enables users to select a pickup hotspot and drill into:

* Drop-off destinations
* Booking volume
* Fulfillment performance
* Localized cancellation patterns
* Failure distributions

The page includes native Power BI drillthrough and back-navigation functionality.

---

# 🏗️ Data Architecture

The project follows a **Kimball-style dimensional modeling approach** with a reporting-oriented star schema.

```text
Raw Booking Data
       │
       ▼
Data Cleaning & Standardization
       │
       ├── Excel Validation
       │
       └── Python / Pandas ETL
              │
              ▼
        Cleaned Booking Data
              │
              ▼
          MySQL Warehouse
              │
       ┌──────┴──────┐
       ▼             ▼
 Reporting Views   SQL Analysis
       │
       ▼
 Power BI Semantic Model
       │
       ▼
 Executive Dashboard
```

---

# 🛠️ Tech Stack

| Layer                | Technology                           |
| -------------------- | ------------------------------------ |
| Data Validation      | **Microsoft Excel**                  |
| Data Cleaning / ETL  | **Python, Pandas, NumPy**            |
| Database             | **MySQL 8.0**                        |
| Statistical Analysis | **Python, Pandas, NumPy**            |
| Visualization        | **Matplotlib, Seaborn**              |
| BI & Reporting       | **Microsoft Power BI**               |
| Data Modeling        | **Kimball / Star Schema**            |
| BI Calculations      | **DAX**                              |
| SQL Optimization     | **B-tree Indexing, Reporting Views** |

---

# 📁 Repository Structure

```text
uber-executive-analytics/
│
├── data/
│   ├── raw_booking.csv
│   └── cleaned_booking.csv
│
├── excel/
│   └── cleaned_booking.xlsb
│
├── sql/
│   ├── 01_schema.sql
│   ├── 02_views.sql
│   └── 03_analysis.sql
│
├── python/
│   ├── data_cleaning.ipynb
│   ├── data_ingestion.ipynb
│   ├── advanced_analysis.ipynb
│   └── visuals.ipynb
│
├── powerbi/
│   └── Uber_Executive_Analytics.pbix
│
├── docs/
│   ├── PROJECT_DOCUMENTATION.txt
│   └── README.txt
│
└── README.md
```

---

# 🔄 End-to-End Workflow

## 1. Data Cleaning & Validation

The raw booking dataset is cleaned and standardized using Python/Pandas.

Key processes include:

* Data type standardization
* Missing-value treatment
* Category normalization
* Cancellation flag creation
* Fulfillment classification
* Revenue / GMV calculations
* Distance and duration validation

Excel is then used for additional validation through:

* Structured Tables
* `XLOOKUP`
* `SUMIFS`
* Pivot Tables
* Reconciliation checks

---

## 2. SQL Data Warehouse

The cleaned dataset is loaded into **MySQL 8.0**.

Run:

```sql
01_schema.sql
```

to create the database structure, tables, indexes, and required schema objects.

Then execute:

```text
data_ingestion.ipynb
```

to load the cleaned dataset.

---

## 3. Reporting Layer

Create the analytical reporting views using:

```sql
02_views.sql
```

The primary reporting view:

```text
v_fact_trips
```

contains standardized metric logic used for downstream analysis.

---

## 4. SQL Business Analysis

Execute:

```sql
03_analysis.sql
```

to reproduce the primary diagnostic analysis, including:

* Conversion funnel analysis
* Cancellation analysis
* Lost GMV
* Fleet revenue
* Distance economics
* Location hotspots
* Dispatch SLA performance
* Customer experience analysis

---

## 5. Python Statistical Analysis

Run:

```text
advanced_analysis.ipynb
```

for:

* Descriptive statistics
* Distribution analysis
* Correlation analysis
* Segment profiling
* Metric validation

Visual outputs can be generated using:

```text
visuals.ipynb
```

---

## 6. Power BI Dashboard

Open:

```text
powerbi/Uber_Executive_Analytics.pbix
```

Update the local data source / MySQL credentials if required, then select:

**Refresh**

The dashboard will populate the dimensional model, calculated measures, and report pages.

---

# 🧮 Core Analytical Metrics

The project calculates and analyzes:

* Total Bookings
* Completed Trips
* Fulfillment Rate
* Cancellation Rate
* No Driver Found Rate
* Gross Completed GMV
* Estimated Lost GMV
* Revenue by Vehicle Category
* Revenue per Kilometer
* Average Fare
* Average Distance
* VTAT
* CTAT
* Severe Delay Rate
* Customer CSAT
* Driver CSAT

Power BI calculations use DAX concepts including:

* Filter context
* Context transition
* `CALCULATE`
* `ALL`
* `KEEPFILTERS`
* Iterators
* Time / segmentation logic

---

# 🎯 Business Recommendations

Based on the analysis, the highest-value areas for operational improvement are:

### 1. Reduce Driver Cancellation Leakage

Driver cancellations represent the largest source of both **trip loss and financial leakage**.

Potential interventions include:

* Driver reliability scoring
* Vehicle readiness monitoring
* Better driver availability forecasting
* Targeted driver incentives
* Cancellation reason monitoring

### 2. Investigate High-Failure Locations

Pickup hotspots such as Pragati Maidan, Saket, Vinobapuri, and Akshardham should be investigated for:

* Supply-demand imbalance
* Traffic conditions
* Pickup accessibility
* Driver availability
* Location-specific cancellation behavior

### 3. Optimize Distance-Based Pricing

The large difference between short-trip and long-trip revenue per kilometer suggests an opportunity to evaluate:

* Minimum fares
* Distance-based pricing
* Long-trip incentives
* Driver compensation
* Dynamic pricing strategies

### 4. Improve Qualitative Customer Experience

Since operational duration remains relatively stable across rating bands, customer experience initiatives should look beyond basic trip timing and examine:

* Driver behavior
* Communication quality
* Vehicle condition
* Pickup experience
* In-trip service quality

---

# 💡 What This Project Demonstrates

This project was designed to demonstrate practical **end-to-end Data Analyst / BI capabilities**, including:

* Business problem translation
* Data cleaning and validation
* Exploratory data analysis
* SQL analytics
* Relational data modeling
* ETL pipeline design
* Statistical analysis
* KPI development
* DAX development
* Power BI dashboard design
* Drillthrough reporting
* Revenue and unit-economics analysis
* Root-cause analysis
* Executive storytelling

The focus is not simply on creating charts, but on connecting **data → diagnosis → business impact → decision-making**.

---

# 🚀 Reproducibility

To reproduce the project:

```bash
# 1. Clone repository
git clone <repository-url>

# 2. Navigate to project
cd uber-executive-analytics

# 3. Review / clean the dataset
# Open python/data_cleaning.ipynb

# 4. Initialize MySQL warehouse
# Run sql/01_schema.sql

# 5. Load cleaned data
# Run python/data_ingestion.ipynb

# 6. Create reporting views
# Run sql/02_views.sql

# 7. Run analytical queries
# Run sql/03_analysis.sql

# 8. Run statistical analysis
# Open python/advanced_analysis.ipynb

# 9. Generate analytical visuals
# Open python/visuals.ipynb

# 10. Open the Power BI report
# powerbi/Uber_Executive_Analytics.pbix
```

---

# 📌 Project Outcome

The final solution transforms **150,000 raw booking records** into an integrated analytical system capable of answering:

> **Where is the platform losing demand?**

> **Why are rides being cancelled?**

> **How much revenue is being lost?**

> **Which fleet segments generate the most value?**

> **Where are operational failures concentrated?**

> **Are dispatch performance and customer satisfaction connected?**

The result is an end-to-end **executive analytics platform** connecting data engineering, statistical analysis, SQL, and business intelligence into a single decision-support workflow.

---

## 👤 Author

**Arnav Singh Chauhan**

Data Analyst | SQL | Python | Power BI | Data Analytics

---

⭐ If you find this project useful, consider giving the repository a star.
