# 3. Advanced SQL Queries - analysis_queries.sql
analysis_sql = '''
-- Top 3 Specializations by Appointment Count
SELECT d.specialization, COUNT(*) AS total_appointments
FROM Appointments a
JOIN Doctors d ON a.doctor_id = d.doctor_id
GROUP BY d.specialization
ORDER BY total_appointments DESC
LIMIT 3;

-- Revenue Report
SELECT strftime('%Y-%m', a.appointment_date) AS month, SUM(b.amount) AS total_revenue
FROM Appointments a
JOIN Billing b ON a.appointment_id = b.appointment_id
GROUP BY month
ORDER BY month;

-- Frequent Patients
SELECT p.name, COUNT(*) AS visits
FROM Patients p
JOIN Appointments a ON p.patient_id = a.patient_id
GROUP BY p.patient_id
HAVING visits > 1
ORDER BY visits DESC;
'''
