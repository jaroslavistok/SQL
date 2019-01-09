-- SCD1 (overwritte values in row)

create table date_dim(
    date_key date,
    day_number_in_week number,
    day_number_in_month number,
    day_name varchar2(20),
    calendar_month_number number,
    calendar_month_name varchar(20),
    calendar_week_number number,
    days_in_calendar_month number,
    end_of_calendar_month date,
    calendar_year number,
    is_feast smallint,
    week_ending_date date,
    constraint date_dim_pk primary key (date_key)
);

create sequence time_key_seq start with 1;

-- SCD1 (overwritte values in row)
create table time_dim(
    time_key number DEFAULT time_key_seq.nextval NOT NULL,
    minute number,
    hour number,
    constraint time_dim_pk primary key (time_key)
);


create sequence product_key_seq 
start with 1;

-- SCD2 (add new row)
create table product_dim(
    -- surrogate
    product_key number DEFAULT product_key_seq.nextval NOT NULL,

    sku varchar2(50),
    product_name varchar2(255),
    brand_name varchar2(255),
    category varchar2(255),
    sub_category varchar2(255),
    package_type varchar2(255),
    product_weight varchar2(255),
    constraint product_dim_pk primary key (product_key)
);

create sequence store_key_seq 
start with 1;

-- SCD2 (add new row)
create table store_dim(
    -- surrogate
    store_key number DEFAULT store_key_seq.nextval NOT NULL,

    store_dim_id number,
    store_name varchar2(255),
    street varchar2(255),
    city varchar2(255),
    country varchar2(255),
    postal_number varchar2(10),
    area number,
    store_type varchar2(255),
    opened date,
    constraint store_dim_pk primary key (store_key)
);

create sequence promotion_key_seq 
start with 1;

-- SCD2 (add new row)
create table promotion_dim(
    -- surrogate
    promotion_key number DEFAULT promotion_key_seq.nextval NOT NULL,

    promotion_id number,
    promotion_name varchar2(255),
    promotion_start_date date, 
    promotion_end_date date, 
    advert_type varchar2(255),
    coupon_type varchar2(255),
    promotion_medium varchar2(255),
    constraint promotion_dim_pk primary key (promotion_key)
);

create sequence cashier_key_seq 
start with 1;

-- SCD2 (add new row)
create table cashier_dim(
    --surrogate
    cashier_key number DEFAULT cashier_key_seq.nextval NOT NULL,

    cashier_code varchar2(100),
    cashier_forename varchar2(100),
    cashier_surname varchar2(100),
    constraint cashier_dim_pk primary key (cashier_key)
);

create sequence payment_method_key_seq 
start with 1;

-- SCD2 (add new row)
create table payment_method_dim(
    --surrogate 
    payment_method_key number DEFAULT payment_method_key_seq.nextval NOT NULL,

    method varchar2(255),
    constraint payment_method_pk primary key (payment_method_key)
);

-- Degenerated dimension
create table transaction_code_dim(
    transaction_code varchar2(255),
    constraint transaction_code_dim_pk primary key (transaction_code)
);

create sequence customer_key_seq 
start with 1;

-- SCD 5 or SCD 6
create table customers_dim(
    customer_key number DEFAULT customer_key_seq.nextval NOT NULL,
    customer_forename varchar2(255),
    customer_surname varchar2(255),
    customer_street varchar2(255),
    customer_city varchar2(255),
    customer_country varchar2(255),
    customer_postal_code varchar2(255),
    -- age group
    constraint customer_dim_pk primary key (customer_key)
);

-- SCD2
create sequence currency_key_seq 
start with 1;

create table currency_dim(
    currency_key number DEFAULT currency_key_seq.nextval NOT NULL,
    currency varchar2(5),
    constraint currency_dim_pk primary key (currency_key)
);


-- Fact table
create table sales_fact(
    -- dimensions fk
    date_key date not null,
    time_key number not null, 
    product_key number not null,
    cashier_key number not null,
    store_key number not null,  
    payment_method_key number not null,
    customer_key number not null,
    currency_key number not null,


    -- facts
    quantity_sold number,
    amount_sold number,
    unit_standart_price number, 
    unit_costs number,
    unit_discount number,
    unit_price_after_discount number,
    special_discount number,

    -- derivated facts
    overall_standart_price number as ((quantity_sold * unit_standart_price) * special_discount),
    overall_discount number as ((quantity_sold * unit_discount) * special_discount),
    overall_costs_after_discount number as ((quantity_sold * unit_price_after_discount) * special_discount),
    overall_costs number as ((quantity_sold * unit_costs) * special_discount),
    profit number as (((quantity_sold * unit_standart_price) * special_discount) - ((quantity_sold * unit_costs) * special_discount)),

    CONSTRAINT fk_date_dim_sales_fact
    FOREIGN KEY (date_key)
    REFERENCES date_dim(date_key),

    CONSTRAINT fk_time_dim_sales_fact
    FOREIGN KEY (time_key)
    REFERENCES time_dim(time_key),

    CONSTRAINT fk_product_dim_sales_fact
    FOREIGN KEY (product_key)
    REFERENCES product_dim(product_key),

    CONSTRAINT fk_cashier_dim_sales_fact
    FOREIGN KEY (cashier_key)
    REFERENCES cashier_dim(cashier_key),

    CONSTRAINT fk_store_dim_sales_fact
    FOREIGN KEY (store_key)
    REFERENCES store_dim(store_key),

    CONSTRAINT fk_payment_method_dim_sales_fact
    FOREIGN KEY (payment_method_key)
    REFERENCES payment_method_dim(payment_method_key),

    CONSTRAINT fk_customer_dim_sales_fact
    FOREIGN KEY (customer_key)
    REFERENCES customers_dim(customer_key),

    CONSTRAINT fk_currency_dim_sales_fact
    FOREIGN KEY (currency_key)
    REFERENCES currency_dim(currency_key)


);


-- list of dimensions
-- date_dim, time_dim, product_dim, store_dim, promotion_dim, transaction_code_dim, customers_dim,
-- currency_dim


-- Fact table
create table payment_fact(
    -- dimensions fks
    payment_method_key number not null,
    date_key date not null,  
    time_key number not null, 
    transaction_code varchar2(255) not null, 
    -- cashier_key ... ?

    -- facts
    payed_price number,
    currency varchar2(5),

    CONSTRAINT fk_payment_method_dim_payment_fact
    FOREIGN KEY (payment_method_key)
    REFERENCES payment_method_dim(payment_method_key),
    
    
    CONSTRAINT fk_date_dim_payment_fact
    FOREIGN KEY (date_key)
    REFERENCES date_dim(date_key),

    CONSTRAINT fk_time_dim_payment_fact
    FOREIGN KEY (time_key)
    REFERENCES time_dim(time_key),
    
    CONSTRAINT fk_transaction_code_dim_payment_fact
    FOREIGN KEY (transaction_code)
    REFERENCES transaction_code_dim(transaction_code)

);

-- Fact table
create table points_fact(
    -- customer dimension
    -- date dimension
    used_points number,
    gained_points number
);


-- Selects
-- 1.
select sum(profit), sd.store_name 
from sales_fact sf 
inner join date_dim dd on sf.date_key = dd.date_key
inner join store_dim sd on sf.store_key = sd.store_key
where (date condition)
order by sf.profit
group by sf.store_key;


-- 2.
