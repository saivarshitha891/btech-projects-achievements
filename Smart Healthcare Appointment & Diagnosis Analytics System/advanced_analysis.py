# 4. Python Analytics - analytics.py
import pandas as pd
import sqlite3
import matplotlib.pyplot as plt

conn = sqlite3.connect('healthcare.db')

# Doctor specialization count
df = pd.read_sql_query("""
    SELECT d.specialization, COUNT(*) AS appointment_count
    FROM Appointments a
    JOIN Doctors d ON a.doctor_id = d.doctor_id
    GROUP BY d.specialization
""", conn)
df.plot(kind='bar', x='specialization', y='appointment_count', title='Appointments by Specialization')
plt.tight_layout()
plt.savefig('appointments_by_specialization.png')
plt.close()

# Revenue trend
df2 = pd.read_sql_query("""
    SELECT strftime('%Y-%m', a.appointment_date) AS month, SUM(b.amount) AS revenue
    FROM Appointments a
    JOIN Billing b ON a.appointment_id = b.appointment_id
    GROUP BY month
    ORDER BY month
""", conn)
df2.plot(kind='line', x='month', y='revenue', title='Monthly Revenue Trend')
plt.tight_layout()
plt.savefig('revenue_trend.png')
plt.close()

conn.close()
