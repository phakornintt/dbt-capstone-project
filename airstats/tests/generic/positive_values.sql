{% test positive_values(model, column_name) %}
{{ config(
    severity='warn'
)}}
    SELECT 
        *
    FROM {{ model }}
    WHERE {{ column_name }} > 0
    LIMIT 10
{% endtest %}