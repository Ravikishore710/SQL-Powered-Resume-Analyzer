# SQL-Powered Resume Analyzer

**It’s not just SQL. It’s a system, a story, and a statement.**

This project is a resume-to-job matching system built entirely in SQL using native JSON logic and advanced querying features — no machine learning, no external scripting, no libraries. Just expressive, structured logic.

---

## 🔍 What It Does

1. Stores candidate resumes and job descriptions using structured and semi-structured data (JSON columns)  
2. Extracts and compares skill sets using `JSON_TABLE` joins  
3. Filters candidates based on minimum experience for each job  
4. Ranks candidates per job based on skill-match score using SQL window functions

---

## 💡 Why SQL?

Because SQL is more than just a query language — it's a framework for reasoning.  
This project showcases the power of modern SQL (MySQL 8+) for logic-driven data applications, often considered out-of-reach for SQL alone.

---

## 🧰 Technologies Used

- MySQL 8+  
- JSON column operations  
- `JSON_TABLE` for array unnesting  
- `CTEs` (Common Table Expressions)  
- `RANK()` window function  
- Dynamic SQL views

---

## 📊 Sample Dataset

6 crafted candidates:  
- 4 in Data Science  
- 1 in Data Analysis  
- 1 in Full Stack Development  
(One profile reflects my own resume)

5 curated job listings:  
- Data Scientist  
- NLP Research Engineer  
- CV Engineer  
- Data Analyst  
- Full Stack Developer

---

## 📌 How to Use

1. Run `resume_matcher.sql` in MySQL 8+  
2. Query the view `ranked_matches_per_job` to see top-ranked candidates for each job  
3. Modify or expand candidate/job data to simulate more scenarios

---

## ✅ Example Queries

Get all matches for a specific job:

```sql
SELECT * FROM ranked_matches_per_job WHERE job_id = 1;
