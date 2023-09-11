
{% set suffix_lists = get_fivetran_suffix_lists() %}
{{ log("lists length : "~suffix_lists|length, info=False) }}
{{ log("lists contents : "~suffix_lists, info=False) }}

SELECT

_fivetran_synced
, log_time
, ROW_NUMBER() OVER (PARTITION BY DATE(log_time, 'Asia/Tokyo') ORDER BY log_time) AS shot_number
, kurabutaipu AS club_type
, ROUND(CAST(he_ji_ju_li AS FLOAT64), 0) AS total_distance
, ROUND(CAST(kyari_fei_ju_li AS FLOAT64), 0) AS carry_distance
, ROUND(CAST(totaru_pian_cha_ju_li AS FLOAT64), 0) AS total_deviation_distance
, ROUND(CAST(kyari_pian_cha_ju_li AS FLOAT64), 0) AS carry_deviation_distance
, ROUND(CAST(heddosupido AS FLOAT64), 0) AS club_speed
, ROUND(CAST(borusupido AS FLOAT64), 0) AS ball_speed
, ROUND(CAST(sumasshufakuta AS FLOAT64), 2) AS smash_factor
, ROUND(CAST(da_chu_jiao AS FLOAT64), 2) AS launch_angle
, ROUND(CAST(da_chu_fang_xiang AS FLOAT64), 2) AS launch_direction
, ROUND(CAST(kurabufesu_jiao AS FLOAT64), 2) AS face_angle
, ROUND(CAST(kurabupasu AS FLOAT64), 2) AS club_path
, ROUND(CAST(bakkusupin AS FLOAT64), 0) AS back_spin
, ROUND(CAST(saidosupin AS FLOAT64), 0) AS side_spin
, ROUND(CAST(supin_zhou AS FLOAT64), 2) AS spin_axis
, ROUND(CAST(supin_liang AS FLOAT64), 0) AS spin_rate
, ROUND(CAST(fesuto_upasu AS FLOAT64), 2) AS face_to_path
, ROUND(CAST(atakkuanguru AS FLOAT64), 2) AS attack_angle
, ROUND(CAST(zui_gao_dao_da_dian AS FLOAT64), 0) AS height_apex

FROM 
(
    SELECT
    *
    , PARSE_TIMESTAMP('%Y/%m/%d %H:%M:%S', ri_fu, 'Asia/Tokyo') AS log_time
    
    FROM
    {{ source('src_shot_log', 'csv_r10_log') }}

    WHERE
    -- 不要なレコードの削除
    pureiya IS NOT NULL

    {%- if is_incremental() %}
    -- full-refresh 指定時はすべてのレコードを対象
        {% if suffix_lists|length > 0 %}
        -- テーブルサフィックスの指定(対象無ければ抽出0)
        AND _table_suffix in ('{{ suffix_lists | join("', '") }}')
        {% else %}
        limit 0
        {% endif %}
    {% endif %}
)