SELECT
playid
, play_year
, play_date
, course_name

{{ summary_logic() }}

FROM
{{ ref('mrts_play_score') }}

GROUP BY 
playid
