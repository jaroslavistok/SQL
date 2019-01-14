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
    quartal smallint,
    constraint date_dim_pk primary key (date_key)
);

insert into date_dim 
(date_key, day_number_in_week, day_number_in_month, day_name, calendar_month_number,
calendar_month_name, calendar_week_number, days_in_calendar_month, end_of_calendar_month,
calendar_year, is_feast, week_ending_date, quartal) 
values 
(date '2019-01-11', 4, 11, 'Friday', 1, 'January', 2, 31, date '2019-01-31', 2019, 0, date '2019-01-13', 1);


insert into date_dim 
(date_key, day_number_in_week, day_number_in_month, day_name, calendar_month_number,
calendar_month_name, calendar_week_number, days_in_calendar_month, end_of_calendar_month,
calendar_year, is_feast, week_ending_date, quartal) 
values 
(date '2019-01-13', 6, 13, 'Sunday', 1, 'January', 2, 31, date '2019-01-31', 2019, 1, date '2019-01-13', 1);

insert into date_dim 
(date_key, day_number_in_week, day_number_in_month, day_name, calendar_month_number,
calendar_month_name, calendar_week_number, days_in_calendar_month, end_of_calendar_month,
calendar_year, is_feast, week_ending_date, quartal) 
values 
(date '2019-01-12', 4, 12, 'Saturday', 1, 'January', 2, 31, date '2019-01-31', 2019, 0, date '2019-01-13', 1);

create sequence time_key_seq start with 1;

-- SCD1 (overwritte values in row)
create table time_dim(
    time_key number DEFAULT time_key_seq.nextval NOT NULL,
    minute number,
    hour number,
    constraint time_dim_pk primary key (time_key)
);

insert into time_dim (minute, hour) values (30, 1);
insert into time_dim (minute, hour) values (10, 6);
insert into time_dim (minute, hour) values (11, 3);
insert into time_dim (minute, hour) values (12, 4);

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

     -- scd2 specific culumns
    valid_from date DEFAULT trunc(sysdate), 
    valid_to date DEFAULT date '9999-12-31', 
    valid char(1) DEFAULT 'Y',

    constraint product_dim_pk primary key (product_key)
);

insert into product_dim (sku, product_name, brand_name, category, sub_category, package_type, product_weight)
values ('sku1', 'iphone', 'apple', 'mobilny telefon', 'smartfon', 'box', 200);

insert into product_dim (sku, product_name, brand_name, category, sub_category, package_type, product_weight)
values ('sku2', 'mac', 'apple', 'notebooky', 'ultrabooky', 'box', 2000);

insert into product_dim (sku, product_name, brand_name, category, sub_category, package_type, product_weight)
values ('sku3', 'pracka', 'whirpool', 'elektrospotrebice', 'spotrebice do domacnosti', 'box', 200000);

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

    -- scd2 specific culumns
    valid_from date DEFAULT trunc(sysdate), 
    valid_to date DEFAULT date '9999-12-31', 
    valid char(1) DEFAULT 'Y',

    constraint store_dim_pk primary key (store_key)
);

insert into store_dim (store_dim_id, store_name, street, city, country, postal_number,area,store_type,opened)
values (1, 'store1', 'street1', 'city1', 'country1', '92221', 10000, 'type1', date '2019-01-10');

insert into store_dim (store_dim_id, store_name, street, city, country, postal_number,area,store_type,opened)
values (2, 'store2', 'street2', 'city2', 'country2', '92222', 20000, 'type2', date '2019-01-1');

insert into store_dim (store_dim_id, store_name, street, city, country, postal_number,area,store_type,opened)
values (3, 'store3', 'street3', 'city3', 'country3', '92223', 30000, 'type3', date '2019-01-3');


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

     -- scd2 specific culumns
    valid_from date DEFAULT trunc(sysdate), 
    valid_to date DEFAULT date '9999-12-31', 
    valid char(1) DEFAULT 'Y',


    constraint promotion_dim_pk primary key (promotion_key)
);

insert into promotion_dim(promotion_id, promotion_name, promotion_start_date, 
    promotion_end_date, advert_type, coupon_type, promotion_medium)
    values (1, 'advert1', date '2019-01-01', date '2019-01-06', 'brand', 'coupon1', 'television');
    
insert into promotion_dim(promotion_id, promotion_name, promotion_start_date, 
    promotion_end_date, advert_type, coupon_type, promotion_medium)
    values (2, 'advert2', date '2018-12-10', date '2018-12-30', 'product', 'coupon2', 'newspapers');

insert into promotion_dim(promotion_id, promotion_name, promotion_start_date, 
    promotion_end_date, advert_type, coupon_type, promotion_medium)
    values (3, 'advert3', date '2019-01-07', date '2019-01-10', 'product', 'coupon3', 'bilboard');

create sequence cashier_key_seq 
start with 1;

-- SCD2 (add new row)
create table cashier_dim(
    --surrogate
    cashier_key number DEFAULT cashier_key_seq.nextval NOT NULL,

    cashier_code varchar2(100),
    cashier_forename varchar2(100),
    cashier_surname varchar2(100),

    -- scd2 specific culumns
    valid_from date DEFAULT trunc(sysdate), 
    valid_to date DEFAULT date '9999-12-31', 
    valid char(1) DEFAULT 'Y',

    constraint cashier_dim_pk primary key (cashier_key)
);

insert into cashier_dim(cashier_code, cashier_forename, cashier_surname)
values (1, 'janko', 'hrasko');

insert into cashier_dim(cashier_code, cashier_forename, cashier_surname)
values (1, 'marienka', 'hraskova');

insert into cashier_dim(cashier_code, cashier_forename, cashier_surname)
values (1, 'jozko', 'mrkvicka');


create sequence payment_method_key_seq 
start with 1;

-- SCD2 (add new row)
create table payment_method_dim(
    --surrogate 
    payment_method_key number DEFAULT payment_method_key_seq.nextval NOT NULL,

    method varchar2(255),

     -- scd2 specific culumns
    valid_from date DEFAULT trunc(sysdate), 
    valid_to date DEFAULT date '9999-12-31', 
    valid char(1) DEFAULT 'Y',

    constraint payment_method_pk primary key (payment_method_key)
);

insert into payment_method_dim (method)
values ('card');

insert into payment_method_dim (method)
values ('cash');


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


insert into customers_dim (customer_forename,customer_surname,customer_street,
    customer_city, customer_country, customer_postal_code)
    values ('forename1', 'surname1', 'street1', 'city1', 'country1', '11111');
insert into customers_dim (customer_forename,customer_surname,customer_street,
    customer_city, customer_country, customer_postal_code)
    values ('forename2', 'surname2', 'street2', 'city2', 'country2', '2222');
insert into customers_dim (customer_forename,customer_surname,customer_street,
    customer_city, customer_country, customer_postal_code)
    values ('forename3', 'surname3', 'street3', 'city3', 'country3', '3333');


-- SCD2
create sequence currency_key_seq 
start with 1;

create table currency_dim(
    currency_key number DEFAULT currency_key_seq.nextval NOT NULL,
    currency varchar2(5),

    -- scd2 specific culumns
    valid_from date DEFAULT trunc(sysdate), 
    valid_to date DEFAULT date '9999-12-31', 
    valid char(1) DEFAULT 'Y',

    constraint currency_dim_pk primary key (currency_key)
);

insert into currency_dim (currency) 
values ('sk');

insert into currency_dim (currency) 
values ('cz');

insert into currency_dim (currency) 
values ('huf');


-- Fact table
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
    promotion_key number not null,


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
    
    CONSTRAINT fk_promotion_dim_sales_fact
    FOREIGN KEY (promotion_key)
    REFERENCES promotion_dim(promotion_key)
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
    cashier_key number not null,

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
    REFERENCES transaction_code_dim(transaction_code),
    
    CONSTRAINT fk_cashier_dim_payment_fact
    FOREIGN KEY (cashier_key)
    REFERENCES cashier_dim(cashier_key)
);

-- Fact table
create table points_fact(
    -- dimensions keys
    customer_key number not null,
    date_key date not null,

    -- facts
    used_points number,
    gained_points number,

    -- constraints 
    CONSTRAINT fk_customer_dim_points_fact
    FOREIGN KEY (customer_key)
    REFERENCES customers_dim(customer_key),

    CONSTRAINT fk_date_dim_points_fact
    FOREIGN KEY (date_key)
    REFERENCES date_dim(date_key)
);


-- Selects
-- 1.
select sd.store_name store_name, sum(sf.profit) store_profit
from sales_fact sf 
inner join store_dim sd on sf.store_key = sd.store_key
where (sf.date_key between date '2019-01-01' and date '2019-01-31')
group by store_name
order by store_profit desc;

-- 2
select sum(sf.amount_sold) as sold_units, pd.product_name
from sales_fact sf
inner join product_dim pd on sf.product_key=pd.product_key
group by pd.sku, sold_units
order by sold_units;


-- 3 
select sum(sf.profit) as profit, pd.product_name
from sales_fact sf 
inner join product_dim pd on sf.product_key=pd.product_key
inner join date_dim dd on sf.date_key=dd.date_key
where dd.quartal = 1
group by pd.sku
order by profit

-- 4
select sum(sf.profit) as profit, pd.brand_name, sum(sf.overall_standart_price) overall_standart_price, sum(sf.overall_discount) discounts, sum(sf.overall_costs) costs
from sales_fact sf 
inner join product_dim pd on sf.product_key=pd.product_key
group by pd.brand_name
order by profit

-- 5
select sum(sf.profit) as profit, pd.promotion_name 
from sales_fact sf
inner join promotion_dim pd on sf.promotion_key=pd.promotion_key
group by pd.promotion_name
order by profit

-- 6
select sum(sf.profit) as profit, 
from sales_fact sf
inner join date_dim dd on sf.date_key=dd.date_key
inner join time_dim td on sf.time_key=td.time_key
where (dd.calendar_year = 2018) and 
(td.hour=2) and 
(dd.day_name='Sunday') and 
(sf.store_key=1) and 
(sf.brand_name='apple')
group by ; 

-- 7
select cd.cashier_forename cashier, sum(sf.amount_sold)
from sales_fact sf
inner join cashier_dim cd on sf.cashier_key=cd.cashier_key
group by cd.cashier_forename;

-- 8
select sum(sf.profit) profit
from sales_fact sf
inner join date_dim dd on sf.date_key=dd.date_key
where dd.day_name='Sunday';


--9 
select sum(sf.profit) profit
from sales_fact sf
inner join currency_dim cd on sf.currency_key=cd.currency_key
inner join date_dim dd on sf.date_key=dd.date_key
where cd.currency='EUR' and dd.calendar_year='2019';

-- 10
select sum(sf.profit) profit
from sales_fact sf
inner join customers_dim cd on sf.customer_key=cd.customer_key
where cd.currency='EUR' and dd.calendar_year='2019';

-- 11 drill


--12

select sum(pf.payed_price) total_payed_price, pmd.method
from payment_fact pf
inner join payment_method_dim pmd on pf.payment_method_key=pmd.payment_method_key
group by pmd.method

--13
