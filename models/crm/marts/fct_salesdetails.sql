with
    salesorderdetail as (
        select *
        , unitprice*(1-unitpricediscount)*orderqty as linetotal
        from {{ ref('stg_raw_salesorderdetail') }}
    )

    ,  orderheader as (
        select *
        from {{ ref('int_salesorderheader') }}
    )

    , salesdetails as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'salesorderdetail.salesorderdetailid']) }} as salesdetails_sk
            , salesorderdetail.salesorderdetailid
            , salesorderdetail.orderqty
            , salesorderdetail.productid
            , salesorderdetail.unitprice
            , salesorderdetail.unitpricediscount 
            , salesorderdetail.linetotal
            , orderheader.taxamt_perc
            , orderheader.freight_perc
            , salesorderdetail.linetotal + (
                salesorderdetail.linetotal*orderheader.taxamt_perc) + (
                salesorderdetail.linetotal*orderheader.freight_perc) as totaldue
            , orderheader.orderdate
            , orderheader.duedate
            , orderheader.sales_status
            , orderheader.salespersonid
            , orderheader.customerid
            , orderheader.shiptoaddressid
            , orderheader.cardtype
            , orderheader.salesorderid
        from salesorderdetail
        left join orderheader
            on salesorderdetail.salesorderid_od = orderheader.salesorderid
    )

select *
from salesdetails