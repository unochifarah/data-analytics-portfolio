# 📊 Jasmine's Data Analytics Portfolio

Welcome to my portfolio! This repository is a collection of SQL, Python, and data visualization projects that demonstrate my skills in data analysis, data cleaning, and extracting actionable insights. Each project tackles a different dataset or challenge using real-world methods and tools.

---

## 🧠 Skills Highlighted

- SQL (CTEs, window functions, joins, filtering, date and string manipulation)
- Database management and querying with PostgreSQL
- Data cleaning and standardization
- Exploratory Data Analysis (EDA)
- Data visualization (Matplotlib, Seaborn, Power BI)
- Python (Pandas, NumPy, Jupyter Notebooks)
- Communication of insights through visuals and storytelling

---

## 📁 Projects

### 🔹 1. Layoffs Data Cleaning (SQL)
Dataset:
[Layoffs Data](https://github.com/AlexTheAnalyst/MySQL-YouTube-Series/blob/main/layoffs.csv)
**Goal**: Clean a dataset of global tech layoffs to make it ready for analysis.

**Highlights**:
- Removed duplicate rows using `ROW_NUMBER()` and CTEs
- Standardized inconsistent company, industry, and country names
- Converted date strings into proper `DATE` format
- Imputed missing industry values with self-joins
- Removed rows with incomplete layoff data

**Tools**: MySQL

📄 [View Script](./layoffs_data_cleaning.sql)

### 🔹 2. Layoffs Exploratory Data Analysis (SQL)
Dataset:
[Layoffs Data](https://github.com/AlexTheAnalyst/MySQL-YouTube-Series/blob/main/layoffs.csv)
**Goal**: Analyze the cleaned layoffs dataset to extract insights and trends using SQL.

**Highlights**:
- Aggregated data by year, country, and company
- Used `DENSE_RANK` and window functions to find top layoffs per year
- Built rolling monthly layoff trends
- Identified extreme cases (e.g. 100% layoffs)

📄 [View Project](./layoffs_eda.sql)

### 🔹 3. UKT Indonesia Analysis (PostgreSQL + SQL)
Dataset:
[UKT PTN Indonesia S1/D4/D3](https://www.kaggle.com/datasets/irvifa/ukt-ptn-indonesia-s1-d4-d3) – sourced from Kaggle.

**Workflow**:
- Imported the CSV dataset into a PostgreSQL database.
- Connected PostgreSQL to Visual Studio Code using the SQL Tools extension.
- Performed analysis using CTEs, LEAST(), GREATEST(), grouping, categorization, and ranking logic.

**Highlights**:
- Calculated minimum and maximum UKT values per university and program.
- Computed UKT gaps to identify pricing disparities.
- Ranked universities with the highest UKT levels.
- Classified universities into fee tiers based on minimum UKT.
- Produced clean, standardized SQL scripts for reproducible analysis.

📄 [View Project](./ukt_db.session.sql)

---

## 📌 About Me

I'm Jasmine Unochi Farah Hatrawijaya, a fresh graduate from Game Technology Major, passionate about data and storytelling. I enjoy working with structured datasets and transforming messy information into actionable insights.

📫 **Connect with me**:  
- [LinkedIn](https://www.linkedin.com/in/jasmine-unochi-4613a3169/)  
- 📧 jasmineunochii@gmail.com

---

## 🚧 Work in Progress

This portfolio is continuously evolving as I complete more projects and gain new skills. Stay tuned!

