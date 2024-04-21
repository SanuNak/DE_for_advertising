-- STG ----------------------------------------------------------------------------------
-- Создание таблицы dialogs для stg
create table if not exists STV2023081238__STAGING.dialogs
(
    message_id   int PRIMARY KEY,
    message_ts   timestamp,
    message_from int,
    message_to   int,
    message      varchar(1000),
    message_group int
)
order by message_id
segmented by hash(message_id) all nodes
partition by message_ts::date
group by calendar_hierarchy_day(message_ts::date, 3, 2);


-- Создание таблицы groups для stg
create table if not exists STV2023081238__STAGING.groups
(
    id int PRIMARY KEY,
    admin_id int,
    group_name varchar(100),
    registration_dt timestamp(6) NOT NULL,
    is_private binary(1)
)
order by id, admin_id
segmented by hash(id) all nodes
partition by registration_dt::date
group by calendar_hierarchy_day(registration_dt::date, 3, 2);


-- Создание таблицы users для stg
create table if not exists STV2023081238__STAGING.users
(
    id int PRIMARY KEY,
    chat_name varchar(200) NOT NULL,
    registration_dt timestamp NOT NULL,
    country varchar(200) NOT NULL,
    age int NOT NULL
)
order by
    id PARTITION BY registration_dt::date
group by 
    calendar_hierarchy_day(registration_dt::date, 3, 2);


-- Создание таблицы group_log для stg 
create table if not exists STV2023081238__STAGING.group_log 
(
    group_id  int PRIMARY KEY,
    user_id int,
    user_id_from int,
    "event" varchar(6),
    "datetime" timestamp NOT NULL
)
order by user_id, group_id
segmented by hash(user_id) all nodes
partition by "datetime"::date
group by calendar_hierarchy_day("datetime"::date, 3, 2);
