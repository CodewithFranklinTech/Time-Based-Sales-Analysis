# Load libraries 
library(tidyr)
library(dplyr)
library(lubridate)
library(ggplot2)

sales_time <- tibble(
  order_id = 1:12,
  order_date = c(
    "2023-01-05","2023-01-18","2023-02-02","2023-02-20",
    "2023-03-05","2023-03-25","2023-04-10","2023-04-28",
    "2023-05-04","2023-05-19","2023-06-01","2023-06-15"
  ),
  category = c(
    "Technology","Furniture","Technology","Office Supplies",
    "Furniture","Technology","Office Supplies","Technology",
    "Furniture","Technology","Office Supplies","Technology"
  ),
  sales = c(450,200,620,180,300,750,220,690,310,840,260,900)
)
sales_time

# Convert order_date into a date format.
sales_time <- sales_time %>%
  mutate(
    order_date = ymd(order_date)
  )
sales_time

# Create these columns: year, month, and month_name.
sales_time <- sales_time %>%
  mutate(
    year = year(order_date),
    month = month(order_date),
    month_name = month(order_date, label = TRUE)
  )
sales_time

# Find the total sales per month. And Identify the month with the highest sales.
month_sales <- sales_time %>%
  group_by(month_name) %>%
  summarise(total_sales = sum(sales)) %>%
  arrange(desc(total_sales))
month_sales

# Calculate total sales per product category.
product_category <- sales_time %>%
  group_by(category) %>%
  summarise(total_sales = sum(sales)) %>%
  arrange(desc(total_sales))
product_category

# Create two charts using ggplot2. Chart 1 — Monthly Sales Trend. Idea: Month vs Total Sales. 
sales_time %>%
  group_by(month_name) %>%
  summarise(total_sales = sum(sales)) %>%
  arrange(month_name) %>%
  ggplot(aes(x = month_name, y = total_sales, group = 1)) +
  geom_line() +
  geom_point(size = 3, color = "red") +
  ggtitle("Monthly Sales Trend")

# Chart 2 — Sales by Category. Idea: Category vs Sales.
sales_time %>%
  group_by(category) %>%
  summarise(total_sales_cate = sum(sales)) %>%
  arrange(desc(total_sales_cate)) %>%
  ggplot(aes(x = category, y = total_sales_cate, fill = category)) +
  geom_col() +
  ggtitle("Sales by Category")
