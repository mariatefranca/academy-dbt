with
  salesorderheader as (
    select
      salesorderid
      , subtotal
      , taxamt
      , freight
      , totaldue
      , cast(orderdate as datetime) as orderdate
      , cast(duedate as datetime) as duedate
      , cast(shipdate as datetime) as shipdate
      , shipmethodid
      , status as sales_status
      , onlineorderflag
      , salespersonid
      , customerid
      , shiptoaddressid
      , creditcardid
    from {{ source('source_adw', 'salesorderheader') }}
)

select *
from salesorderheader