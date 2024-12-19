select * from sales.accounts;
select * from sales.data_dictionary;
select * from sales.products;
select * from sales.sales_pipeline;
select * from sales.sales_teams;

#1. List All Products
select * from sales.products;

#2. Find Sales Agents in a Specific Region
select sales_agent 
from sales.sales_teams
where regional_office = 'Central';

#3. Count Opportunities by Deal Stage
select deal_stage , count(deal_stage)
from sales.sales_pipeline
group by deal_stage;

#4. Get Unique Product Series
select distinct series 
from sales.products;

#5. Calculate Total Close Value
select sum(close_value) as Total_Value
from sales.sales_pipeline;

#6. Agents with Closed Deals
select distinct sales_agent 
from sales.sales_pipeline
where deal_stage = 'Won';

#7. Average Close Value by Product
select product , avg(close_value)
from sales.sales_pipeline
group by product;

#8. Revenue by Region
select st.regional_office , sum(sp.close_value)
as total_revenue from sales.sales_pipeline sp
join sales.sales_teams st on sp.sales_agent = st.sales_agent
group by st.regional_office;

#9. Products Not Sold
select product from sales.products
where product not in 
(select distinct product from sales.sales_pipeline);

#10. Deals Without Close Dates
select * from sales.sales_pipeline
where close_date is null;

#11. Top Performing Sales Agent
select sales_agent , sum(close_value) as Total_Sales
from sales.sales_pipeline
group by sales_agent
order by Total_Sales desc
limit 1;

#12. Monthly Revenue Trend
select date_format(close_date , '%Y-%m') as month ,
sum(close_value) as total_revenue
from sales.sales_pipeline
where close_date is not null
group by date_format(close_date, '%Y-%m');

#13. Manager Performance
select st.manager , sum(sp.close_value) as total_revenue
from sales.sales_pipeline sp
join sales.sales_teams st on sp.sales_agent = st.sales_agent
group by st.manager;

#14. Longest Sales Cycle
select opportunity_id , datediff(close_date , engage_date)
as Sales_Cycle from sales.sales_pipeline
order by Sales_Cycle desc
limit 1;

#15. Sales Contribution by Product Series
select p.series , sum(sp.close_value) as total_revenue
from sales.sales_pipeline sp
join sales.products p on sp.product = p.product
group by p.series;