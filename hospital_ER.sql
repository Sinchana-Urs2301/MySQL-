create database hospital;
use hospital;
select * from er_data;

# 1. Write a query to retrive all patient details where the Patient Gender is 'F'[Female] and Patient Age is greater than 50.

select * from er_data
where `Patient Gender` = 'F';


# 2. Find all patient who have 'None' as Department Referral and Patient Admission Flag is 'True'.

select `ï»¿Patient Id` , `Patient Last Name`, `Patient Age` , `Department Referral` , `Patient Admission Flag`
from er_data
where `Department Referral` = 'None' and `Patient Admission Flag` = 'True';


# 3. Write a query to count the number of patients by Patients Gender.

select `Patient Gender` , count(`Patient Gender`) as Gender_Count
from er_data 
group by `Patient Gender`;


# 4. Calculated the total number of patients and average wait time for each Department Referral. 

select `Department Referral` , count(`ï»¿Patient Id`) as Total_patient , avg(`Patient Waittime`) as Average_WaitTime
from er_data
group by `Department Referral`;


# 5. Find all the Department Referrals that have more than 3 patients and calculated their average Patients Satisfaction score.

select `Department Referral` , count(`ï»¿Patient Id`) as Total_patient , avg(`Patient Satisfaction Score`) as Average_Satisfaction_score
from er_data
group by `Department Referral`;

# 6. Rank patients by their age within each gender group using Dense_rank. Display Patients_id , Patients_last_name, Patients_Gender, Patient_Age , and the rank.

select `ï»¿Patient Id` , `Patient Last Name` , `Patient Gender` , `Patient Age` , dense_rank () over (order by `Patient Age`  desc) as Age_Rank
from er_data ;

# 7. Using CTE, find all patients who are above the average age and dispaly their Patient_Id , Patient_Last_Name , and Patient_Age.

with Average as (select  avg(`Patient Age`) as avg_age from er_data)
select er.`ï»¿Patient Id` , er.`Patient Last Name` , er.`Patient Age`
from er_data as er
cross join Average as av
where er.`Patient Age` > av.avg_age;

# 8. Create a CTE to calculate the average wait time for each Patient Race, then select only those races where the average wait time is greater than 40 minutes. 

with averagewait as (select  avg(`Patient Waittime`) as Average_wait_time 
from er_data group by `Patient Race`)
select er.`Patient Race` , er.`Patient Waittime`
from er_data as er
cross join averagewait as avw
where  avw.Average_wait_time > 40;


# 9. Create a CTE that calculate the minimum, maximum, and average Patinet Satisfaction for each Department Referral, then select departmnets where the averagesatisfaction is greater than 1.

with calculate as ( select `Department Referral`,
min(`Patient Satisfaction Score`) as Minimum , 
max(`Patient Satisfaction Score`) as Maximum , 
avg(`Patient Satisfaction Score`) as Average 
from er_data
group by `Department Referral`)
select `Department Referral` , Minimum ,  Maximum , Average 
from calculate
where Average > 1;