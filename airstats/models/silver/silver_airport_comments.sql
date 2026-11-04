{{
    config(
        materialized='incremental'
    )
}}
WITH bronze_airport_comments AS (
    SELECT * FROM {{ ref('src_airport_comments') }}
)

SELECT
    comment_id,
    airport_ident,
    comment_timestamp,
    coalesce(member_nickname, '__UNKNOWN__') as member_nickname,
    comment_subject,
    comment_body,
    current_timestamp() as loaded_at
FROM bronze_airport_comments
WHERE comment_body is not NULL
{% if is_incremental() %}
    AND comment_id > (SELECT max(comment_id) FROM {{ this }})
{% endif %}