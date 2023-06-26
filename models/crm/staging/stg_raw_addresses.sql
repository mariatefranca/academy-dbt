
with
  addresses as (
    select
      addressid as addressid_ad
      , city
      , stateprovinceid as stateprovinceid_ad
    from {{ source('source_adw', 'address') }}
)

select *
from addresses