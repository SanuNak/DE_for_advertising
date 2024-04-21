-- Загрузка данных в таблицу  STV2023081238__STAGING.users
COPY STV2023081238__STAGING.users (
    id,
    chat_name,
    registration_dt NULL ' ',
    country,
    age
)
FROM LOCAL '/data/users.csv' 
SKIP 1
DELIMITER ','
ENFORCELENGTH 
REJECTED DATA AS TABLE STV2023081238__STAGING.REJECTED_users
REJECTMAX 200 /* 0 = ABORT ON ERROR */
ENCLOSED BY '"'
NULL ' '; 





