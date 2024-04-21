-- DDS -----------------------------------------------------------------------------------
-- LINKS ---------------------------------------------------------------------------------

-- Создание таблицы l_user_message для dds
create table  if not exists STV2023081238__DWH.l_user_message
(
hk_l_user_message bigint primary key,
hk_user_id      bigint CONSTRAINT fk_l_user_message_user REFERENCES STV2023081238__DWH.h_users (hk_user_id),
hk_message_id bigint CONSTRAINT fk_l_user_message_message REFERENCES STV2023081238__DWH.h_dialogs (hk_message_id),
load_dt datetime,
load_src varchar(20)
)
order by load_dt
SEGMENTED BY hk_user_id all nodes
PARTITION BY load_dt::date
GROUP BY calendar_hierarchy_day(load_dt::date, 3, 2); 

-- Создание таблицы l_admins для dds
create table  if not exists STV2023081238__DWH.l_admins
(
hk_l_admin_id bigint primary key,
hk_user_id    bigint CONSTRAINT fk_l_admins_user REFERENCES STV2023081238__DWH.h_users (hk_user_id),
hk_group_id bigint CONSTRAINT fk_l_user_message_group REFERENCES STV2023081238__DWH.h_groups (hk_group_id),
load_dt datetime,
load_src varchar(20)
)
order by load_dt
SEGMENTED BY hk_l_admin_id all nodes
PARTITION BY load_dt::date
GROUP BY calendar_hierarchy_day(load_dt::date, 3, 2); 

-- Создание таблицы l_groups_dialogs для dds
create table  if not exists STV2023081238__DWH.l_groups_dialogs
(
hk_l_groups_dialogs bigint primary key,
hk_message_id     bigint CONSTRAINT fk_l_groups_dialogs_message REFERENCES STV2023081238__DWH.h_dialogs (hk_message_id),
hk_group_id bigint CONSTRAINT fk_l_groups_dialogs_group REFERENCES STV2023081238__DWH.h_groups (hk_group_id),
load_dt datetime,
load_src varchar(20)
)
order by load_dt
SEGMENTED BY hk_l_groups_dialogs all nodes
PARTITION BY load_dt::date
GROUP BY calendar_hierarchy_day(load_dt::date, 3, 2);

-- Создание таблицы l_user_group_activity  для dds
create table if not exists STV2023081238__DWH.l_user_group_activity 
(
hk_l_user_group_activity INT primary key,
hk_user_id    INT CONSTRAINT fk_l_admins_user REFERENCES STV2023081238__DWH.h_users (hk_user_id),
hk_group_id   INT CONSTRAINT fk_l_user_message_group REFERENCES STV2023081238__DWH.h_groups (hk_group_id),
load_dt       DATETIME,
load_src      VARCHAR(20)
)
order by load_dt
SEGMENTED BY hk_l_user_group_activity all nodes
PARTITION BY load_dt::date
GROUP BY calendar_hierarchy_day(load_dt::date, 3, 2); 

