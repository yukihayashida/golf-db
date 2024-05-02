{{ config(
      tags=["score"],
      alias='hole_score'
    )
}}

SELECT

playid
, outin
, half
, hole
, yard
, par
, stroke
, stroke_diff

, shortgame
, approach
, putt

, longgame
, longshot
, penalty

, LOWER(fwkeep) AS fw_keep_type
, shot_2nd_ok AS is_possible_second_shot

, paron AS is_paron
, bogeyon AS is_bogeyon
, dbbogeyon AS is_dbbogeyon
, dbparoveron AS is_dbparoveron
, CASE WHEN scramble THEN 1 ELSE 0 END AS is_scramble

FROM
{{ source('src_source_gss', 'gss_hole_score') }}
