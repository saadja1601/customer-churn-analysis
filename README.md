# US Telecom Customer Churn Analysis
**Tools:** Python · MySQL · Tableau  
**Dataset:** Cell2Cell (Real US Telecom Data — 49,752 customers)  
**Dashboard:** [View Live on Tableau Public](https://public.tableau.com/app/profile/saad.ahmed7758/viz/USTelecomCustomerChurnAnalysis/CustomerChurnAnalysis)

---

## Business Problem
A US telecom company is losing over 28% of its customers. This analysis identifies 
who is churning, when they churn, and where churn is most concentrated — 
to help leadership prioritize retention efforts.

---

## Key Findings
- **$824,404/month** in revenue is lost to churn — 28.2% of total monthly revenue
- **13–24 month customers** churn the most at **30.5%** — the critical retention window
- **High credit customers** (Good/Highest) churn more than low credit ones (30.7% vs 21.7%), 
  suggesting credit risk is not what drives churn; service quality is one possible explanation worth testing
  (this is a correlation from a single snapshot, not proof of cause)
- **Top churn markets:** Tallahassee FL area (39.3%), Seattle WA area (38.9%), Portland OR area (37.7%); each market has only 112 to 162 customers, so treat these as leads to investigate

---

## Recommendations
1. **Target the 13–24 month window.** Customers in this tenure band churn the most (30.5%), so retention offers and check-ins should reach them before they hit month 13.
2. **Investigate service quality in the top churn markets.** Tallahassee FL, Seattle WA and Portland OR areas (39.3%, 38.9% and 37.7%) churn well above the overall rate. Review network quality and support in these markets first.
3. **Do not use credit rating as a retention filter.** High credit customers churn more (30.7% vs 21.7%), so a credit-based approach would miss the customers most likely to leave. Look at service quality and plan fit for this group instead.

---

## Dashboard Preview
![Dashboard](images/dashboard_screenshot.png)

---

## Project Structure

```
customer-churn-analysis/
├── data/
│   └── cell2cell_clean.csv        # Cleaned dataset (49,752 rows)
├── notebooks/
│   └── 01_cleaning_eda.ipynb      # Data cleaning + 5 EDA charts
├── sql/
│   └── churn_analysis.sql         # 5 business queries with findings
├── images/
│   └── (chart screenshots)
└── README.md
```

## Steps Taken
1. **Data Cleaning** — Dropped 1,295 rows with missing values (about 2.5% of 51,047), 
   converted Churn to binary
2. **EDA in Python** — 5 charts analyzing churn by credit rating, 
   revenue, tenure, and customer care calls
3. **SQL Analysis** — 5 business queries in MySQL answering revenue 
   impact, credit risk, tenure patterns, and geographic concentration
4. **Tableau Dashboard** — 3 KPIs + 3 charts published on Tableau Public
