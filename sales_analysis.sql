use sales;

# this is data cleaning to remove all the null values in the dataset

delete from retail_sales where transactions_id is null
or sale_date is null
or sale_time is null
or customer_id is null
or gender is null
or age is null
or category is null
or quantity is null
or price_per_unit is null
or cogs is null 
or total_sale is null;


# Count the number of sales/transactions made ? 
Select count(*) from retail_sales;

#Count the number of customers?
select count(distinct customer_id) as total_customers from retail_sales;

#What are the unique category we have?
select distinct category from retail_sales;

#BUSINESS PROBLEMS: 
# Calculate the date when the sales is maximum ?
Select sale_date,total_sale as amount from retail_sales where total_sale = (Select max(total_sale) from retail_sales);

#Select all the sales where category is clothing and their quantity sold ? 
select transactions_id,category,quantity from retail_sales where category = 'Clothing';

#SQL query to calculate the total sales for each category
Select category,sum(total_sale)as sales,count(*)as no_of_orders from retail_sales group by category;

#SQL query to find the average age of customers for each category ?
Select avg(age),category from retail_sales group by category;

#SQL query to find the average age of customers for each category = Beauty ?
select round(avg(age),2) as average_age from retail_sales where category = 'Beauty';

#Find all transactions where total_sales > 1000
select * from retail_sales where total_sale > 1000;

#Find the number of transactions made in each category ? 
select count(transactions_id) as no_of_transactions from retail_sales group by category;

#Find the number of transactions made by male and female respectively ? 
Select count(transactions_id)as no_of_transactions,gender from retail_sales group by gender;

#Find the number of transactions made divided by gender in each category ? 
select category,gender ,count(transactions_id)as no_of_transactions from retail_sales
group by category,gender order by category;

#SQL query to find out the average sale of each month
SELECT years, months, sales, 
    RANK() OVER (PARTITION BY years ORDER BY sales DESC) AS position
FROM (
    SELECT YEAR(sale_date) AS years, MONTH(sale_date) AS months, SUM(total_sale) AS sales
    FROM retail_sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) AS monthly_sales
ORDER BY years, months;

#Write a SQL query to get the top 5 customer_id based on the sales
select customer_id,sum(total_sale)as amount from retail_sales group by customer_id order by amount desc limit 5;

#Write a sql query to find the the number of unique customers that made a purchase from each category ?
select category,count(distinct customer_id) as count_of_unique_customers from retail_sales group by category;

#Find all customers that made a purchase in each sections
Select customer_id from retail_sales group by customer_id
Having count(distinct category) = (Select count(distinct category) from retail_sales);