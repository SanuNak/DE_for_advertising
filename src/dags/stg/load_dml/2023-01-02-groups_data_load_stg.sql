-- Загрузка данных в таблицу  STV2023081238__STAGING.groups
COPY STV2023081238__STAGING.groups (
    id,
    admin_id,
    group_name,
    registration_dt,
    is_private
)
FROM LOCAL '/data/groups.csv' 
SKIP 1
DELIMITER ','
ENFORCELENGTH 
REJECTED DATA AS TABLE STV2023081238__STAGING.REJECTED_groups
REJECTMAX 200 /* 0 = ABORT ON ERROR */
ENCLOSED BY '"'
NULL ''; 
