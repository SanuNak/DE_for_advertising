-- DDS -------------------------------------------------------------------------------------
-- SATELITS --------------------------------------------------------------------------------

-- Создание таблицы s_admins для dds
create table if not exists STV2023081238__DWH.s_admins
(
	hk_admin_id bigint not null 
		CONSTRAINT fk_s_admins_l_admins 
		REFERENCES STV2023081238__DWH.l_admins (hk_l_admin_id),
	is_admin boolean,
	admin_from datetime,
	load_dt datetime,
	load_src varchar(20)
)
order by load_dt
SEGMENTED BY hk_admin_id all nodes
PARTITION BY load_dt::date
GROUP BY calendar_hierarchy_day(load_dt::date, 3, 2);


-- Создание таблицы s_group_name для dds
create table if not exists STV2023081238__DWH.s_group_name
(
	hk_group_id bigint not null 
		CONSTRAINT fk_s_group_name_h_groups 
		REFERENCES STV2023081238__DWH.h_groups (hk_group_id),
	group_name varchar(100),
	load_dt datetime,
	load_src varchar(20)
)
order by load_dt
SEGMENTED BY hk_group_id all nodes
PARTITION BY load_dt::date
GROUP BY calendar_hierarchy_day(load_dt::date, 3, 2);


-- Создание таблицы s_group_private_status для dds
create table if not exists STV2023081238__DWH.s_group_private_status
(
	hk_group_id bigint not null 
		CONSTRAINT fk_s_group_private_status_h_groups 
		REFERENCES STV2023081238__DWH.h_groups (hk_group_id),
	is_private binary(1),
	load_dt datetime,
	load_src varchar(20)
)
order by load_dt
SEGMENTED BY hk_group_id all nodes
PARTITION BY load_dt::date
GROUP BY calendar_hierarchy_day(load_dt::date, 3, 2);


-- Создание таблицы s_dialog_info для dds
create table if not exists STV2023081238__DWH.s_dialog_info
(
	hk_message_id bigint not null 
		CONSTRAINT fk_s_dialog_info_h_dialogs 
		REFERENCES STV2023081238__DWH.h_dialogs (hk_message_id),
	message varchar(1000),
	message_from int,
	message_to int,
	load_dt datetime,
	load_src varchar(20)
)
order by load_dt
SEGMENTED BY hk_message_id all nodes
PARTITION BY load_dt::date
GROUP BY calendar_hierarchy_day(load_dt::date, 3, 2);


-- Создание таблицы s_user_socdem для dds
create table if not exists STV2023081238__DWH.s_user_socdem
(
	hk_user_id bigint not null 
		CONSTRAINT fk_s_user_socdem_h_users
		REFERENCES STV2023081238__DWH.h_users (hk_user_id),
	country varchar(100),
	age int,
	load_dt datetime,
	load_src varchar(20)
)
order by load_dt
SEGMENTED BY hk_user_id all nodes
PARTITION BY load_dt::date
GROUP BY calendar_hierarchy_day(load_dt::date, 3, 2);


-- Создание таблицы s_user_chatinfo для dds
create table if not exists STV2023081238__DWH.s_user_chatinfo
(
	hk_user_id bigint not null 
		CONSTRAINT fk_s_user_chatinfo_h_users 
		REFERENCES STV2023081238__DWH.h_users (hk_user_id),
	chat_name varchar(200),
	load_dt datetime,
	load_src varchar(20)
)
order by load_dt
SEGMENTED BY hk_user_id all nodes
PARTITION BY load_dt::date
GROUP BY calendar_hierarchy_day(load_dt::date, 3, 2);


-- Создание таблицы s_auth_history  для dds
create table if not exists STV2023081238__DWH.s_auth_history 
(
	hk_l_user_group_activity INT
		CONSTRAINT fk_s_auth_history_l_user_group_activity 
		REFERENCES STV2023081238__DWH.l_user_group_activity (hk_l_user_group_activity),
	user_id_from INT,
	"event" varchar(10),
	event_dt datetime, 
	load_dt datetime,
	load_src varchar(20)
)
order by load_dt
SEGMENTED BY hk_l_user_group_activity all nodes
PARTITION BY load_dt::date
GROUP BY calendar_hierarchy_day(load_dt::date, 3, 2);
