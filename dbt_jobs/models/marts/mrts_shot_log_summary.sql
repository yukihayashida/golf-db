-- このクエリは、mrts_shot_log_r10 から、月次のショットログの集計を行うクエリです。
-- 各数値カラムに対して、平均値、中央値、最大値、最小値、第1四分位数、第3四分位数を算出しています。
-- 実行環境は、BigQueryです。
{{ config(
    pre_hook="{{ delete_recent_shot_log_summary() }}"
) }}

{% set PARTITION_KEY = 'PARTITION BY log_month, club_type' %}
{% set TARGET_COLS = ['total_distance',
'carry_distance',
'total_deviation_distance',
'carry_deviation_distance',
'club_speed',
'ball_speed',
'smash_factor',
'launch_angle',
'launch_direction',
'face_angle',
'club_path',
'back_spin',
'side_spin',
'spin_axis',
'spin_rate',
'face_to_path',
'attack_angle',
'height_apex'] %}

WITH 
_shot_log AS (
SELECT
* 
, DATE(log_time, 'Asia/Tokyo') AS log_date
, DATE_TRUNC(DATE(log_time, 'Asia/Tokyo'), month) AS log_month

FROM
{{ ref('mrts_shot_log_r10') }} AS r

WHERE
is_valid_shot = True
)

SELECT DISTINCt

log_month
, club_type

, COUNT(shot_number) OVER ({{ PARTITION_KEY }}) AS shot_count
, COUNT(DISTINCT log_date) OVER ({{ PARTITION_KEY }}) AS log_date_count
, MAX(log_date) OVER ({{ PARTITION_KEY }}) AS last_shot_date

-- 平均値、中央値、標準偏差、最大値、最小値、第1四分位数、第3四分位数 をBigQuery形式で記述

{% for COL in TARGET_COLS %}
, AVG({{COL}}) OVER ({{ PARTITION_KEY }}) AS {{COL}}_avg
, PERCENTILE_CONT({{COL}}, 0.5) OVER ({{ PARTITION_KEY }}) AS {{COL}}_median
, STDDEV_POP({{COL}}) OVER ({{ PARTITION_KEY }}) AS {{COL}}_stddev
, MAX({{COL}}) OVER ({{ PARTITION_KEY }}) AS {{COL}}_max
, MIN({{COL}}) OVER ({{ PARTITION_KEY }}) AS {{COL}}_min
, PERCENTILE_CONT({{COL}}, 0.25) OVER ({{ PARTITION_KEY }}) AS {{COL}}_q1
, PERCENTILE_CONT({{COL}}, 0.75) OVER ({{ PARTITION_KEY }}) AS {{COL}}_q3
{% endfor %}

FROM
_shot_log

{% if is_incremental() %}

WHERE log_month >= (select DATE_SUB(max(log_month), INTERVAL 1 MONTH) from _shot_log)

{% endif %}
