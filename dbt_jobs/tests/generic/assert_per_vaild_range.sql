{% test par_vaild_range(model, column_name) %}

    select *
    from {{ model }}
    where {{ column_name }} BETWEEN 3 AND 7

{% endtest %}
