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
    sku varchar2(50),
    product_name varchar2(255),
    brand_name varchar2(255),
    category varchar2(255),
    sub_category varchar2(255),
    package_type varchar2(255),
    product_weight varchar2(255)
);

-- SCD2 (add new row)
create table store_dim(
    store_name varchar2(255),
    street varchar2(255),
    city varchar2(255),
    country varchar2(255),
    postal_number varchar2(10),
    area number,
    store_type varchar2(255),
    opened date
);

-- SCD2 (add new row)
create table promotion_dim(
    promotion_name varchar2(255),
    promotion_start_date date, 
    promotion_end_date date, 
    advert_type varchar2(255),
    coupon_type varchar2(255),
    promotion_medium varchar2(255)
);

-- SCD2 (add new row)
create table cashier_dim(
    cashier_code varchar2(100),
    cashier_forename varchar2(100),
    cashier_surname varchar2(100),
);

-- SCD2 (add new row)
create table payment_method_dim(
    method varchar2(255)
);

-- Degenerated dimension
create table transaction_code_dim(
    transaction_code varchar2(255)
);

-- SCD 5 or SCD 6
create table customers_dim(
    customer_forename varchar2(255),
    customer_surname varchar2(255),
    customer_street varchar2(255),
    customer_city varchar2(255),
    customer_country varchar2(255),
    customer_postal_code varchar2(255)
);

-- SCD2
create table currency_dim(
    currency varchar2(5)
);


-- Fact table
create table sales_fact(
    quantity number,
    quantity_type varchar2(10),
    unit_standart_price number, 
    unit_costs number,
    unit_discount number,
    unit_price_after_discount number,

    -- derivated facts
    overall_standart_price number,
    overall_discount number,
    overall_costs_after_discount number,
    overall_costs number,
    profit number

    currency varchar2(5),
    special_discount number
);

-- Fact table
create table payment_fact(
    payed_price number,
    currency varchar2(5)
);

-- Fact table
create table points_fact(
    used_points number,
    gained_points number
);

