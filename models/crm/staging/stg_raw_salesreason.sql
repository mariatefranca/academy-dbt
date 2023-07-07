with
  salesreason as (
    select
      salesreasonid 
      , reasontype as reasontype
    from {{ source('source_adw', 'salesreason') }}
)

select *
from salesreason