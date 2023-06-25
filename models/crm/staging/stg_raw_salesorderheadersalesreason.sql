with
  salesorderheadersalesreason as (
    select
      salesorderid as salesorderid_sohsr
      , salesreasonid as salesreasonid_sohsr
      , cast(modifieddate as date) as modifieddate_sr
    from {{ source('source_adw', 'salesorderheadersalesreason') }}
)

select *
from salesorderheadersalesreason