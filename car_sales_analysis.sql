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
 
 
# 5. Using a CTE , find all cars with a price above the average price abd display their Car_id , Company , Model and Price.

with avg_price_cte as ( select avg(`Price ($)`) as avg_price from car_sales )
select Car_id , Company , Model , `Price ($)` 
from car_sales as cs
cross join avg_price_cte as ap
where cs.`Price ($)` > ap.avg_price;


# 6. Create a CTE to calculate the average Annual Income for each company, then select only those comapnies where the average income is greater than 500000.

with avg_annual_income as ( select avg(`Annual Income`) as Average_Annual_Income from car_sales)
select Car_id , Company , Model , `Price ($)`
from car_sales as cs
cross join avg_annual_income as aa
where Average_Annual_Income > 500000;

# 7. Rank cars by Annual Income in descending order , but only include cars where body_Style is 'Sedan' and dealer_Region is 'Austin'. Use Dense Rank.

select Car_id , `Customer Name`, `Body Style` , Dealer_Region , `Annual Income` ,  dense_rank() over (order by `Annual Income` desc) as Income_rank
from car_sales 
where `Body Style` = 'Sedan' and  Dealer_Region = 'Austin';


#8. Find all company is either 'Toyoto' , 'Honda' , or 'BMW' and group by Dealer_region, calculating the total cars sold and average price per region 

select Dealer_Region , count(Car_id) as Total_cars , avg(`Price ($)`) as average_price
from car_sales 
where Company in ('toyoto' , 'Honda' , 'BMW' )
group by Dealer_Region;


# 9. Rank all cars by their price in descending order within each  Dealer_region using Dense_rank . Display Car_id , Company , Dealer_Region , Price , and the Rank.

select Car_id , Company , Dealer_Region , `Price ($)` ,  dense_rank() over (order by `Price ($)` desc) as Price_rank 
from car_sales;
