SELECT
playid

{{ summary_logic() }}

FROM
{{ ref('mrts_play_score') }}

GROUP BY 
playid
