-- SCD1 (overwritte values in row)
create table date_dim(
    date_dim_id date,
    day_number_in_week number,
    day_name varchar2(20),
    day_number_in_month number,
    calendar_month_number number,
    calendar_month_name varchar(20),
    calendar_week_number number,
    days_in_calendar_month number,
    end_of_calendar_month date,
    calendar_year number,
    is_feast smallint,
    week_ending_date date,
    constraint date_dim_pk primary key (date_dim_id)
);

-- SCD1 (overwritte values in row)
create table time_dim(
    minute number,
    hour number
);

-- SCD2 (add new row)
create table product_dim(

);

-- SCD2 (add new row)
create table store_dim(

);

-- SCD2 (add new row)
create table promotion_dim(

);

-- SCD2 (add new row)
create table cashier_dim(

);

-- SCD2 (add new row)
create table payment_method_dim(

);

-- Degenerated dimension
create table transaction_code_dim(

);

-- SCD 5 or SCD 6
create table customers_dim(

);

-- SCD2
create table currency_dim(

);


-- Fact table
create table sales_fact(

);

-- Fact table
create table payment_fact(

);

-- Fact table
create table points_fact(

);

