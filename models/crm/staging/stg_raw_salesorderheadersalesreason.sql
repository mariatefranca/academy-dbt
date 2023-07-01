with
  salesorderheadersalesreason as (
    select
      salesorderid as salesorderid_sr
      , salesreasonid as salesreasonid_sr
      , cast(modifieddate as datetime) as modifieddate_sr
    from {{ source('source_adw', 'salesorderheadersalesreason') }}
)

select *
from salesorderheadersalesreason