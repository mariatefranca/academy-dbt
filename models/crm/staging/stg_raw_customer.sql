with
  customer as (
    select
      customerid as customerid_cus
      , personid as personid_cus
    from {{ source('source_adw', 'customer') }}
    where personid is not null
)

select *
from customer