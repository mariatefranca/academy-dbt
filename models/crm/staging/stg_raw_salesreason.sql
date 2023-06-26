with
  salesreason as (
    select
      salesreasonid 
      , name as name_sr
    from {{ source('source_adw', 'salesreason') }}
)

select *
from salesreason