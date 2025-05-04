---SQL Practice Questions – Hospital Dataset
use SqlQueries
Welcome to a structured SQL practice set built on a synthetic **hospital database**. This set progresses from **beginner to advanced** to help you improve your SQL skills step-by-step.

Use SqlQueries;
🟢 Beginner Level (1–10)
--1. List all patients' names and birth dates.   _Hint: Use `SELECT` from `patients`._
Select  name, birth_date from patients

--2. List only male patients.  _Hint: Use `WHERE `._
Select * from patients where gender = 'Male'

--3. Show doctors specialized in "Cardiology".  _Hint: Use `WHERE `._
Select * from doctors where specialty = 'Cardiology'

--4. Show doctors who started working in 2023.  _Hint: Filter with `hire_date`._
Select * from doctors where hire_date>'2022-12-31'

--5. List patients born after 1980.  _Hint: Use  '1980-01-01'`._
Select * from patients where birth_date > '1980-01-01'

--6. Display each doctor's name and their specialty.  _Hint: Use `SELECT name, specialty`._
Select name,specialty from doctors

--7. Count how many patients are registered.  _Hint: Use `COUNT(*)`._
Select Count(*) from patients

--8. Display each appointment's patient and doctor ID.   _Hint: Query the `appointments` table._
Select patient_id,doctor_id from appointments

--9. List treatments longer than 30 days.  _Hint: Use `DATEDIFF(end_date, start_date)`._
SELECT * 
FROM treatments 
WHERE DATEDIFF(day, start_date, end_date) > 30;

--10. Show all unique doctor specialties.  _Hint: Use `DISTINCT`._
Select distinct (specialty) from doctors
---

## 🟡 Intermediate Level (11–20)
--11. Count how many different patients each doctor has seen.  _Hint: Use `GROUP BY doctor_id`._
Select doctor_id,count(patient_id) from appointments group by doctor_id

--12. Show the longest treatment duration.  _Hint: Use `MAX()` with duration logic._
Select max(treatment_duration) from treatments 

--13. Show the first appointment date for each patient.  _Hint: Use `MIN(date)` with `GROUP BY patient_id`._
Select patient_id,min(appointment_date) as appointment_date from appointments group by patient_id 

--14. Count appointments in the year 2022.  _Hint: Use `YEAR(date) = 2022`._
Select count(*) from appointments where YEAR(appointment_date) = 2022

--15. Find patient IDs and dates of appointments where treatment was exactly 10 days.  _Hint: Use `DATEDIFF(end_date, start_date) = 10`._
Select patients_id,appointments.appointment_date from appointments where DATEDIFF(appointment_date) = 10 

--16. Find doctors who have appointments with female patients.  _Hint: Join `appointments` and `patients`._
Select appointments.doctor_id,appointments.patient_id from appointments join patients on appointments.patient_id=patients.patient_id where patients.gender='Female' 

--17. Who is the doctor with the most patients?  _Hint: Use `COUNT(DISTINCT patient_id)`._
Select Top 1 count(distinct patient_id)as patient_amount, doctor_id from appointments group by doctor_id order by patient_amount desc

--18. Count how many appointments each patient has.  _Hint: `GROUP BY patient_id` in `appointments`._
Select count (distinct appointment_id) as appointment, patient_id from appointments group by patient_id

--19. Count number of doctors per specialty.  _Hint: Use `GROUP BY specialty`._
Select count(*) as total,specialty from doctors group by specialty

--20. Find patients who had more than 1 appointment on the same day.  _Hint: Use `GROUP BY patient_id, date` + `HAVING COUNT(*) > 1`._
Select patient_id,Count(*),appointment_date from appointments group by appointment_date,patient_id having count(*)>1

---

## 🔴 Advanced Level (21–30)
--21. List doctors whose average treatment duration exceeds 20 days.  _Hint: Join `treatments`, group by doctor._
Select treatments.appointment_id,AVG(treatment_duration) as duration,appointments.doctor_id from treatments join appointments on treatments.appointment_id=appointments.appointment_id group by treatments.appointment_id,appointments.doctor_id having AVG(treatment_duration)>20

--22. Find appointments that had no treatments.  _Hint: Use `LEFT JOIN` and `IS NULL`._
SELECT treatments.appointment_id
FROM treatments 
LEFT JOIN appointments ON treatments.appointment_id=appointments.appointment_id where treatments.appointment_id is null 

--23. Show earliest appointment date per doctor.  _Hint: Use `MIN(date)` with `GROUP BY doctor_id`._
Select min(appointment_date),doctor_id from appointments group by doctor_id 

--24. Find the patient who received the longest treatment.  _Hint: Use `ORDER BY duration TOP 1`._
Select TOP 1 appointments.patient_id,treatments.treatment_duration from treatments join appointments on treatments.appointment_id=appointments.appointment_id order by treatments.treatment_duration  desc

--25. Show top 5 patients with the most appointments.  _Hint: Use `ORDER BY COUNT(*) DESC LIMIT 5`._
Select top 5 count(*) as appointment_count, patient_id from appointments group by patient_id order by appointment_count desc 

--26. Show average treatment duration grouped by doctor specialty.  _Hint: Join `treatments`, `doctors`, `GROUP BY specialty`._
Select avg(treatments.treatment_duration) as times,doctors.specialty from treatments join appointments on treatments.appointment_id=appointments.appointment_id 
join doctors on appointments.doctor_id=doctors.doctor_id group by doctors.specialty


--27-List patients who had overlapping treatments (i.e., the start date of one treatment was before the end date of another for the same patient).

--28. List patients with appointments from at least 3 different doctors.  _Hint: `GROUP BY patient_id` and `COUNT(DISTINCT doctor_id)`._
Select patient_id from appointments group by patient_id having count(distinct doctor_id)<=3

--29. Show patients who had no appointments in the last 6 months.  _Hint: Use `NOT IN` or `LEFT JOIN` with date filtering._
SELECT name
FROM patients
WHERE patient_id NOT IN (
    SELECT DISTINCT patient_id
    FROM appointments
    WHERE appointment_date >= DATEADD(MONTH, -6, GETDATE())
);  --INTERVAL 6 MONTH


--30. Show patients who had appointments in both 2022 and 2023.   _Hint: Use `GROUP BY`, `HAVING COUNT(DISTINCT YEAR(date)) = 2`._
Select patient_id from appointments where YEAR(appointment_date) IN (2022,2023) group by patient_id having COUNT(DISTINCT YEAR(appointment_date)) = 2; 

---

> ✨ Stay tuned for answers in a separate walkthrough file!
