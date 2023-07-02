with
    salesorderdetail as (
        select *
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
            , salesorderdetail.unitprice*(1-salesorderdetail.unitpricediscount)*salesorderdetail.orderqty as linetotal
            , orderheader.orderdate
            , orderheader.duedate
            , orderheader.sales_status
            , orderheader.salespersonid
            , orderheader.customerid
            , orderheader.shiptoaddressid
            , orderheader.cardtype
        from salesorderdetail
        left join orderheader
            on salesorderdetail.salesorderid_od = orderheader.salesorderid
    )

select *
from salesdetails