# E-commerce-Conversion-Analysis

# E-commerce Conversion Analysis (Nov 2020 – Feb 2021)

## 📌 Project Overview
This project analyzes user behavior across an e-commerce conversion funnel using Google Analytics 4 data.

The goal was to identify:
- where the biggest user drop-offs occur,
- how conversion rate varies by device, traffic source, and geography,
- which segments provide the highest-quality traffic.

## 🛠 Tech Stack
- **SQL** — Google BigQuery
- **Data Visualization** — Tableau Public
- **Data Source** — Google Analytics 4 (event-level data)

## 📊 Dataset
- ~4.3 million raw GA4 event records
- Aggregated into **354,857 unique sessions**
- Each session contains boolean indicators for funnel steps:
  - Session Start
  - View Item
  - Add to Cart
  - Begin Checkout
  - Add Shipping
  - Add Payment
  - Purchase

## 🔄 Data Preparation
All data preprocessing was done in **BigQuery**:
- Session-level aggregation
- Funnel step identification using `COUNTIF`
- Creation of a clean analytical table with:
  - device, country, campaign, source, medium, language, landing page

## 📈 Dashboard
The final interactive dashboard includes:
- Conversion funnel
- KPI cards (Sessions, Purchases, Conversion Rate)
- Time trends
- Device, campaign, OS, language, and geographic analysis
- Cross-filtering and global filters

🔗 **Tableau Public Dashboard:**  
(https://public.tableau.com/app/profile/khrystyna.derkach/viz/DA_Final_Project_KD/CRAnalysis)

## 🔍 Key Insights
- ~79% of users drop before viewing a product
- Average conversion rate: **1.34%**
- Referral traffic shows the highest conversion rate (1.66%)
- Conversion rate is consistent across devices
- Canada shows slightly higher CR than the US despite lower volume

## ⚠ Challenges & Decisions
- Landing page data contained noise and tracking parameters — treated as a secondary filter
- Funnel built using Measure Names / Values, limiting its interactivity
- Funnel used as a diagnostic tool, with deeper analysis done via filters

## 👤 Author
**Khrystyna Derkach**  
Final project for Data Analytics course (Cohort 29)
