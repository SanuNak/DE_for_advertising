WITH 
	user_group_messages AS (
							SELECT 
								hg.hk_group_id,
								COUNT(DISTINCT lum.hk_user_id) AS cnt_users_in_group_with_messages
							from STV2023081238__DWH.h_groups hg
							LEFT JOIN STV2023081238__DWH.l_groups_dialogs lgd ON hg.hk_group_id  = lgd.hk_group_id 
							LEFT JOIN STV2023081238__DWH.l_user_message lum ON lgd.hk_message_id = lum.hk_message_id
							GROUP BY hg.hk_group_id),
	user_group_log AS (
						WITH 
							sah AS (SELECT
										sah.hk_l_user_group_activity,
										COUNT(sah.event) AS cnt_added_users
									FROM
										STV2023081238__DWH.s_auth_history sah
									WHERE
										event = 'add'
									GROUP BY sah.hk_l_user_group_activity),
							hg AS (select
										hg.hk_group_id
									FROM
										STV2023081238__DWH.h_groups hg
									order by
										hg.registration_dt
									limit 10)
						SELECT 
							hk_group_id,
							cnt_added_users
						FROM STV2023081238__DWH.l_user_group_activity luga
						INNER JOIN sah ON luga.hk_l_user_group_activity = sah.hk_l_user_group_activity 
						WHERE luga.hk_group_id IN (SELECT hk_group_id FROM hg))
SELECT
	ugl.hk_group_id,
	ugl.cnt_added_users,
	ugm.cnt_users_in_group_with_messages,
	ugm.cnt_users_in_group_with_messages / ugl.cnt_added_users AS group_conversion
FROM user_group_log as ugl
LEFT JOIN user_group_messages as ugm on ugl.hk_group_id = ugm.hk_group_id
ORDER BY ugm.cnt_users_in_group_with_messages / ugl.cnt_added_users desc;