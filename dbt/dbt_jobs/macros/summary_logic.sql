{% macro summary_logic() -%}

, CAST(FLOOR(SUM(stroke)/10)*10 AS INT64) AS stroke_category
, COUNT(hole) AS hole_count
, SUM(yard) AS yard_total
, SUM(par) AS par_total
, SUM(stroke) AS stroke_total
, SUM(stroke_diff) AS stroke_diff_total
, SUM(shortgame) AS shortgame_total
, SUM(approach) AS approach_total
, SUM(putt) AS putt_total
, SUM(longgame) AS longgame_total
, SUM(longshot) AS longshot_total
, SUM(penalty) AS penalty_total

, COUNT(CASE WHEN stroke_diff = 0 THEN hole ELSE NULL END) AS par_count
, COUNT(CASE WHEN stroke_diff = 1 THEN hole ELSE NULL END) AS boggy_count
, COUNT(CASE WHEN stroke_diff = 2 THEN hole ELSE NULL END) AS double_boggy_count
, COUNT(CASE WHEN stroke_diff >= 3 THEN hole ELSE NULL END) AS triple_par_or_over_count
, COUNT(CASE WHEN stroke_diff <= -1 THEN hole ELSE NULL END) AS par_under_count

, COUNT(CASE WHEN fw_keep_type = 'ok' AND par >= 4 THEN hole ELSE NULL END) AS fw_keep_count
, COUNT(CASE WHEN fw_keep_type = 'right' THEN hole ELSE NULL END) AS fw_error_right_count
, COUNT(CASE WHEN fw_keep_type = 'left' THEN hole ELSE NULL END) AS fw_error_left_count
, COUNT(CASE WHEN is_possible_second_shot = 1 THEN hole ELSE NULL END) AS second_ok_count

, COUNT(CASE WHEN is_paron = 1 THEN hole ELSE NULL END) AS paron_count
, COUNT(CASE WHEN is_bogeyon = 1 THEN hole ELSE NULL END) AS bogeyon_count
, COUNT(CASE WHEN is_dbbogeyon = 1 THEN hole ELSE NULL END) AS dbbogeyon_count
, COUNT(CASE WHEN is_dbparoveron = 1 THEN hole ELSE NULL END) AS dbparoveron_count
, COUNT(CASE WHEN is_scramble = 1 THEN hole ELSE NULL END) AS scramble_count

{%- endmacro %}
