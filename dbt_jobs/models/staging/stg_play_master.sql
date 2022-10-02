{{ config(
      tags=["score"],
      alias='play_master'
    )
}}

SELECT
playid
, course_name
, play_date

FROM
{{ source('src_source_gss', 'gss_play') }}

WHERE
playid IS NOT NULL
