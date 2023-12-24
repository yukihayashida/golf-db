SELECT
*
, CASE 
    WHEN smash_factor BETWEEN 0 AND 1.5
    AND total_distance is not null
    AND face_angle is not null 
    AND attack_angle is not null
    THEN True
    ELSE False
    END AS is_valid_shot

FROM
{{ ref('stg_shot_log_r10') }} AS r

{% if is_incremental() %}

WHERE _fivetran_synced > (select max(_fivetran_synced) from {{ this }})

{% endif %}
