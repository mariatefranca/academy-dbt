with
  salesorderdetail as (
    select
      salesorderid as salesorderid_od
      , salesorderdetailid
      , orderqty
      , productid
      , unitprice
      , unitpricediscount
    from {{ source('source_adw', 'salesorderdetail') }}
)

select *
from salesorderdetail
