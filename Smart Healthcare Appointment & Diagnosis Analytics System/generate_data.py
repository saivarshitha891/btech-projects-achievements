# 2. Sample Data Generation - generate_data.py
import random
import sqlite3
from datetime import datetime, timedelta

conn = sqlite3.connect('healthcare.db')
cursor = conn.cursor()
cursor.executescript(schema_sql)

# Insert sample patients and doctors
for i in range(1, 11):
    cursor.execute("INSERT INTO Patients VALUES (?, ?, ?, ?, ?)",
                   (i, f'Patient {i}', random.randint(18, 80), random.choice(['Male', 'Female']), f'+91-98765{i:04}'))
    cursor.execute("INSERT INTO Doctors VALUES (?, ?, ?, ?)",
                   (i, f'Doctor {i}', random.choice(['Cardiology', 'Dermatology', 'Neurology']), True))

# Insert appointments, diagnoses, billing
for i in range(1, 21):
    pid = random.randint(1, 10)
    did = random.randint(1, 10)
    appt_date = datetime.now() - timedelta(days=random.randint(0, 30))
    cursor.execute("INSERT INTO Appointments VALUES (?, ?, ?, ?, ?)",
                   (i, pid, did, appt_date.date(), random.choice(['Completed', 'Cancelled'])))
    cursor.execute("INSERT INTO Diagnoses VALUES (?, ?, ?, ?, ?)",
                   (i, i, 'Fever, Cough', 'Flu', 'Paracetamol'))
    cursor.execute("INSERT INTO Billing VALUES (?, ?, ?, ?)",
                   (i, i, round(random.uniform(100.0, 1000.0), 2), 'Paid'))

conn.commit()
conn.close()
