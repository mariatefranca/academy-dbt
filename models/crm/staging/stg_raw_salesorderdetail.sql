with
  salesorderdetail as (
    select
      salesorderid as salesorderid_od
      , salesorderdetailid
      , orderqty
      , productid
      , unitprice
    from {{ source('source_adw', 'salesorderdetail') }}
)

select *
from salesorderdetail
