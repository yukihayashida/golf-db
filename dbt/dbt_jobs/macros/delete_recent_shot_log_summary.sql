{% macro delete_recent_shot_log_summary() -%}
    {%- if is_incremental() -%}
        delete from {{ this }}
        where
            log_month >= 
                (
                    select 
                        DATE_SUB(
                                max(
                                    DATE_TRUNC(DATE(log_time, 'Asia/Tokyo'), month)
                                )
                                , INTERVAL 1 MONTH
                                )
                    from {{ ref('mrts_shot_log_r10') }}
                )
    {%- endif -%}
{%- endmacro %}