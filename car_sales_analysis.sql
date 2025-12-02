create database car;

use car;

select * from car_sales;



# 1. find all cars where body_style in 'SUV' and price is greater than 20000

select Car_id , `Customer Name`, `Body Style` , `Price ($)` , Dealer_Region 
from car_sales 
where `Body Style` = 'SUV' and `Price ($)` > 20000;


# 2. Find the average Price of each Company where Gender is 'Male'

select Company , avg(`Price ($)`) as avg_price 
from car_sales
group by Company;


# 3. Calculate the total sales  (sum of price) and average annual income for each dealer_Region.

select Dealer_Region , sum(`Price ($)`) as total_sales , avg(`Annual Income`) as average_annual_income
from car_sales 
group by Dealer_Region;


# 4. Find all companies that have sold more than 2 cars and have an average price greater than 25000.

select Company , count(Car_id) as car_count , avg(`Price ($)`) as average_price
from car_sales
group by company
having average_price > 25000 and car_count >2;
 
