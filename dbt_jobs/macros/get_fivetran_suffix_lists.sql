{% macro get_fivetran_suffix_lists() %}

{% set table_suffix_query %}
select distinct
regexp_extract(table, 'r_10_([0-9]+)') as table_suffix
from 
`golf-db-361606.src_shot_log.fivetran_audit`
where
DATE(_fivetran_synced, 'Asia/Tokyo')
BETWEEN DATE_SUB(CURRENT_DATE('Asia/Tokyo'), INTERVAL 7 day)
  AND DATE_SUB(CURRENT_DATE('Asia/Tokyo'), INTERVAL 1 day)
{% endset %}

{% set results = dbt_utils.get_query_results_as_dict(table_suffix_query) %}

{% if execute %}
{% set results_list = results['table_suffix'] %}
{% else %}
{% set results_list = [] %}
{% endif %}

{{ return(results_list) }}

{% endmacro %}