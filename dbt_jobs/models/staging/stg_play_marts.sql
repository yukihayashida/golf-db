{{ config(tags=["score"]) }}

SELECT
s.*
, p.course_name
, p.play_date

FROM
{{ source('src_source_gss', 'gss_play') }} AS p
INNER JOIN
{{ source('src_source_gss', 'gss_hole_score') }} AS s

ON
p.playid = s.playid
