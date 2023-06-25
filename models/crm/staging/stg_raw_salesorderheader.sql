with
  salesorderheader as (
    select
      salesorderid
      , subtotal
      , taxamt
      , freight
      , totaldue
      , cast(orderdate as date) as orderdate
      , cast(duedate as date) as duedate
      , cast(shipdate as date) as shipdate
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