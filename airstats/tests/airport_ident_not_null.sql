SELECT airport_ident FROM {{ ref('silver_airports') }}
WHERE airport_ident IS NULL
LIMIT 10