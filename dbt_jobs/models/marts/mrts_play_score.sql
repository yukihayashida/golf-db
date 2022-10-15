SELECT

s.playid
, p.course_name
, p.play_date
, FORMAT_DATE('%y', p.play_date) AS play_year
, s.outin
, s.half
, s.hole
, s.yard
, s.par
, s.stroke
, s.stroke_diff
, CASE
    WHEN stroke = 1       THEN 'ace'
    WHEN stroke_diff = -2 THEN 'albatross'
    WHEN stroke_diff = -1 THEN 'birdie'
    WHEN stroke_diff = 0  THEN 'par'
    WHEN stroke_diff = 1  THEN 'bogey'
    WHEN stroke_diff = 2  THEN 'double bogey'
    WHEN stroke_diff = 3  THEN 'triple bogey'
    WHEN stroke_diff > 3  THEN 'over+4'
    ELSE 'else'
  END AS score_type

, s.shortgame
, s.approach
, s.putt

, s.longgame
, s.longshot
, s.penalty

, s.fw_keep_type
, s.is_possible_second_shot

, s.is_paron
, s.is_bogeyon
, s.is_dbbogeyon
, s.is_dbparoveron
, s.is_scramble

FROM
{{ ref('stg_play_master') }} AS p
INNER JOIN
{{ ref('stg_hole_score') }} AS s

ON
p.playid = s.playid
