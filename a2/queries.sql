1)

select HName, city
from hospital
where AnnualBudget > 3000000
order by AnnualBudget desc;

2)

select distinct p1.FirstName, p1.LastName, p1.Gender, p1.DateOfBirth
from Patient p, Diagnose d, Person p1
where p1.ID = p.patientID and p1.DateOfBirth between '1978-10-28' and '2018-10-28' and p1.city = 'Toronto' and d.patientID = p.patientID and d.Disease like '%Cancer';

3) a)
select specialty, avg(Salary) as ave
from physician
group by specialty;

3) b)
select p.specialty, avg(p.Salary) as ave
from physician p, Department D, hospital H
where d.Dname = p.Dname and d.HName = h.HName and h.City = 'Toronto'
group by p.specialty
having count(Salary) > 4;

3) c)
select YearsOfPractice, avg(salary) as ave
from nurse
group by YearsOfPractice
order by YearsOfPractice desc;

4)
select HName, count(patientID) as num
from Admission
where Date between '2017-08-05' and '2017-08-10'
group by HName;

5) a)
select distinct d.DName 
from Department d, hospital, (select count(d.DName) as c, d.DName from Department d group by d.DName) as d1
where (d1.c = (select count(HName) from hospital)) and d1.DName = d.DName;

5) b)
select (count(n.nurseID) + count(p.physicianID)) as stuffnumber, d.DName, d.HName 
from Nurse_work n, physician p, department d
where p.DName = n.DName and p.DName = d.DName and p.HName = n.HName and p.HName = d.HName
group by d.DName, d.HName
order by stuffnumber desc
fetch first 1 rows only;

5) c)
select distinct d.DName 
from Department d, hospital, (select count(d.DName) as c, d.DName from Department d group by d.DName) as d1
where (d1.c = 1) and d1.DName = d.DName;

6) a)
select firstName, lastName 
from person
where id in (
select nurseID from (
select count(patientID) as c, nurseID
from patient
group by nurseID)
where c < 3)
order by lastName;

6) c)
select firstName, lastName 
from person 
where id in (
select patientID 
from diagnose, (
select patientID as p
from patient
where nurseID in (
select nurseID from (
select count(patientID) as c, nurseID
from patient
group by nurseID)
where c < 3))
where patientID in p and prognosis = 'poor');

7)
select date, count(patientID) as numberOFpatients
from admission 
where HName = 'Hamilton General Hospital'
group by date
order by numberOFpatients desc
fetch first 1 row only;

8)
select d.drugcode, d.Name, p.c*d.unitcost as revenue
from drug d, (
select (count(drugcode)) as c, drugcode
from prescription
group by drugcode) as p
where d.drugcode = p.drugcode
order by revenue desc
fetch first 1 row only;

9)
select distinct d.patientID, p.firstName, p.lastName, p.gender
from diagnose d, take t, medicaltest m, person p
where d.patientID = p.ID and d.disease = 'Diabetes' and t.testId = m.testID and m.Name <> 'Red Blood Cell' and m.Name <> 'Lymphocytes' and d.patientID = t.patientID;

10) a)
select distinct d.physicianID, d.disease, d.Prognosis
from physician p, diagnose d
where p.DName = 'Intensive Care Unit' and p.HName = 'McMaster University Medical Centre' and d.physicianId = p.physicianID;


10) b)
select sum(m.fee) as total, pa.patientID
from take t, Medicaltest m, patient pa
where t.testID = m.testID and pa.patientID = t.patientID and pa.patientID in (
	select distinct d.patientID
	from physician p, diagnose d
	where p.DName = 'Intensive Care Unit' and p.HName = 'McMaster University Medical Centre' and d.physicianId = p.physicianID)
group by pa.patientID
order by total desc;

10) c)
select sum(d.unitcost) as total, pa.patientID
from prescription p, drug d, patient pa
where p.drugcode = d.drugcode and pa.patientID = p.patientID and pa.patientID in (
	select distinct d.patientID
	from physician p, diagnose d
	where p.DName = 'Intensive Care Unit' and p.HName = 'McMaster University Medical Centre' and d.physicianId = p.physicianID)
group by pa.patientID
order by total desc;

11)
select p.ID, p.firstName, p.lastName 
from person p 
where p.id in (
select patientID
from (
select count(HName) as c, patientID
from admission
where category = 'urgent' or category = 'standard'
group by patientID)
where c = 2);





