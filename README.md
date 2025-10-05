# SQL-Revenue-Tracking
SQL project analyzing course revenue trends, counselor performance, and monthly growth for an EdTech company.

## Objective
To track and analyze total, monthly, and course-wise revenue for an EdTech company, providing actionable insights into business performance and counselor efficiency.

---

## Business Context
This project simulates an **EdTech organization** where students enroll in various courses through different counselors and make payments via multiple modes.  
The goal is to identify:
- Which courses generate the most revenue  
- Who are the top-performing counselors  
- What are the monthly revenue trends  
- Which payment modes are most preferred  

This data-driven approach supports smarter business and sales decisions.

---

## Database Design
The database contains **three interconnected tables** designed using SQL relational concepts:

| Table | Description |
|--------|--------------|
| **Students** | Student details, assigned counselor, and enrolled course |
| **Courses** | Course details with course name and price |
| **Payments** | Payment transactions with amount, mode, and date |

**Relationships:**
- `Students.course_id` → references `Courses.course_id`  
- `Payments.student_id` → references `Students.student_id`

---

## SQL Queries Overview

1. **Total Revenue**
   ```sql
   SELECT SUM(amount) AS total_revenue
   FROM Payments;
   
   ```

   
2. **Revenue by Course**
   ```sql
   SELECT c.course_name, SUM(p.amount) AS revenue
   FROM Payments p
   JOIN Students s ON p.student_id = s.student_id
   JOIN Courses c ON s.course_id = c.course_id
   GROUP BY c.course_name
   ORDER BY revenue DESC;
   ```

3. **Monthly Revenue Trend**
   ```sql
   SELECT DATE_FORMAT(payment_date, '%Y-%m') AS month, SUM(amount) AS revenue
   FROM Payments
   GROUP BY DATE_FORMAT(payment_date, '%Y-%m')
   ORDER BY month;
   ```

4. **Top Paying Students**
   ```sql
   SELECT s.name, SUM(p.amount) AS total_paid
   FROM Payments p
   JOIN Students s ON p.student_id = s.student_id
   GROUP BY s.name
   ORDER BY total_paid DESC
   LIMIT 5;
   ```

5. **Revenue by Counselor**
   ```sql
   SELECT s.counselor_id, SUM(p.amount) AS revenue_generated
   FROM Payments p
   JOIN Students s ON p.student_id = s.student_id
   GROUP BY s.counselor_id
   ORDER BY revenue_generated DESC;
   ```

### Insights from the Data

- Total revenue generated: ₹11,65,000.
- Top course: Full Stack (₹5,95,000 revenue).
- Top counselor: Prerna C01 (₹3,00,000 revenue).
- Top-paying student: Isha (₹3,50,000).
- Peak month: February 2025.
