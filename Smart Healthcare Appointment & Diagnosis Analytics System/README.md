readme_md = '''
# Smart Healthcare Appointment & Diagnosis Analytics System

This project simulates a real-world healthcare system with appointments, diagnoses, and billing. It showcases SQL and Python skills across database design, data analysis, and visual reporting.

## Features
- Relational database with normalized schema
- Advanced SQL queries: joins, groupings, revenue analytics
- Python data extraction and visualization using Pandas & Matplotlib
- Sample data generation scripts

## Skills Demonstrated
- SQL (queries, optimization, schema design)
- Python (data analysis, visualization)
- Data analytics mindset

## Visual Reports
- Appointments by specialization
- Revenue trend analysis

## Run Instructions
1. Run `generate_data.py` to populate the database
2. Run `analytics.py` to generate reports
3. Check `appointments_by_specialization.png` and `revenue_trend.png` for visuals
'''

# Save to README.md

with open("README.md", "w") as f:
f.write(readme_md)
