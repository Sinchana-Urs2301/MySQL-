create database blinkit;

use blinkit;

select * from blinkit_sales;


# 1.  Find all items where Outlet Location Type is 'Tier 1'  AND Outlet Size is 'Medium'


select `Item Identifier`, `Outlet Identifier` , `Outlet Location Type`, `Outlet Size`, Sales
from blinkit_sales
where `Outlet Location Type` = 'Tier 1' 
and `Outlet Size` = 'medium';

# 2. Find the average sales fro each Outlet Type where Outlet establishment year is greater than 2015.

select `Outlet Type` ,avg(Sales) as Avg_Sales
from blinkit_sales
where `Outlet Establishment Year` > 2015
group by `Outlet Type` ;

# 3. Calculate the total sales and average item weight fro each item Fat Content category.

select `Item Fat Content`, sum(Sales) as total_sales , avg(`Item Weight`) as Avg_item_weight
from blinkit_sales 
group by `Item Fat Content`;

# 4. Retrive all items where Sales are between 100 and 200 and Outlet Location Tyoe is 'Tier 2' or 'Tier 3'.

select `Item Identifier` , `Item Type` , `Outlet Location Type` , Sales from blinkit_sales
where Sales between 100 and 200 
and
`Outlet Location Type` in ('tier 2' , 'tier 3');

# 5. Find all item tyoes that have more than 2 items and average sales greater than 150.

select `Item Type` , count(`Item Type`) as Item_Count , avg(Sales) as Avg_sales
from blinkit_sales 
group by `Item Type`
having Item_count > 2 and Avg_sales > 150;

# 6. Calculate the average item visibility for each Outlet Location Type, then select only those types where average visibility is gretaer than 0.05.

select `Outlet Location Type` , avg(`Item Visibility`) as Avg_visibility
from blinkit_sales
group by `Outlet Location Type`
having  Avg_visibility > 0.05 ;

# 7. Create a CTE that calculate the minimum, maximum, and average Sales for each item Type, then Select item types, where the average sales is gretaer than 120.

with Sales_count as (select `Item Type`, min(Sales) as Min_sales , Max(Sales) as Max_sales , Avg(Sales) as Avg_sales
from blinkit_sales
group by `Item Type`
having  Avg_sales > 120)

select * from Sales_count;

