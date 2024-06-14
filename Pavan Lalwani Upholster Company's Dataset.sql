-- Exploring the dataset
select City, Sales,region,[Sub-Category], Profit
from Orders
where region = 'west' and [Sub-Category] = 'Binders'
group by City, Sales,region,[Sub-Category], Profit
order by profit desc


select City, Sales,region,[Sub-Category], Profit, Quantity
from Orders 
where [Sub-Category] = 'table' or region = 'south'
group by City, Sales,region,[Sub-Category], Profit, Quantity
order by Profit desc
 

--STANDADIZE THE DATEFORMATE
select [Order Date], [Ship Date], convert(date,[Order Date]), convert(date,[Ship Date])
from Orders

update Orders
set [Order Date] = convert(date,[Order Date])

update Orders
set [Ship Date] = convert(date,[Ship Date])
-- creation of column for the cleaned order date column 
alter table  Orders
add Order_date date;

update Orders
set Order_date  = convert(date,[Order Date]) 

-- creation of column for the cleaned ship date column 
alter table  Orders
add Ship_date date;

update Orders
set Ship_date  = convert(date,[Ship Date]) 

-- populate product name data
select *
from Orders
--where [Product ID] is null
order by [Product ID]



-- Removing Duplicates from Dataset
  WITH ROWnumCTE AS (
  SELECT *,
        ROW_NUMBER() OVER (
		PARTITION BY [Customer ID],
		             [Product Name],
					 [Profit],
					 [Quantity],
					 [Sales]
					 ORDER BY 
					     [Product ID]
					    ) row_num
from Orders 
)
select *
from ROWnumCTE 
where row_num >1
order by [Product Name]


  WITH ROWnumCTE AS (
  SELECT *,
        ROW_NUMBER() OVER (
		PARTITION BY [Customer ID],
		             [Product Name],
					 [Profit],
					 [Quantity],
					 [Sales]
					 ORDER BY 
					     [Product ID]
					    ) row_num
from Orders 
)
delete 
from ROWnumCTE 
where row_num >1
--order by [Product Name]


-- Deleting Unwanted Columns 


select * 
from Orders

Alter Table Orders 
Drop Column [order date] , [ship date] 