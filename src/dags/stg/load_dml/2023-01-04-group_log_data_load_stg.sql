-- Загрузка данных в таблицу  STV2023081238__STAGING.users
COPY STV2023081238__STAGING.group_log (
    group_id,
    user_id,
    user_id_from,
    "event",
    "datetime"
)
FROM LOCAL '/data/group_log.csv' 
SKIP 1
DELIMITER ','
ENFORCELENGTH 
REJECTED DATA AS TABLE STV2023081238__STAGING.REJECTED_group_log
REJECTMAX 1000 /* 0 = ABORT ON ERROR */
ENCLOSED BY '"'
NULL ''; 

