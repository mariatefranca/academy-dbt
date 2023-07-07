with
    salesorderheader_transformed as (
        select   
            salesorderid
            , subtotal
            , taxamt
            , taxamt/subtotal as taxamt_perc
            , freight
            , freight/subtotal as freight_perc
            , totaldue
            , orderdate
            , duedate
            , case 
                when sales_status = 1 then 'In process'
                when sales_status = 2 then 'Approved'
                when sales_status = 3 then 'Backordered' 
                when sales_status = 4 then 'Rejected' 
                when sales_status = 5 then 'Shipped' 
                when sales_status = 6 then 'Cancelled'
            end as sales_status
            , onlineorderflag
            /* Treat null salespersonid values as 0, meaning no vendor*/
            , case 
                when salespersonid is null and onlineorderflag is true
                then 0
                else salespersonid
            end as salespersonid
            , customerid
            , shiptoaddressid
            , creditcardid
        from {{ ref('stg_raw_salesorderheader') }}
    )

    , creditcard as (
        select * 
        from {{ref('stg_raw_creditcard')}}
    )

    , joining_creditcard as (
        select
            salesorderheader_transformed.salesorderid
            , salesorderheader_transformed.subtotal
            , salesorderheader_transformed.taxamt
            , salesorderheader_transformed.taxamt_perc
            , salesorderheader_transformed.freight
            , salesorderheader_transformed.freight_perc
            , salesorderheader_transformed.totaldue
            , salesorderheader_transformed.orderdate
            , salesorderheader_transformed.duedate
            , salesorderheader_transformed.sales_status
            , salesorderheader_transformed.salespersonid
            , salesorderheader_transformed.customerid
            , salesorderheader_transformed.shiptoaddressid
            , coalesce(creditcard.cardtype, 'Unknown') as cardtype
        from salesorderheader_transformed
        left join creditcard
            on salesorderheader_transformed.creditcardid = creditcard.creditcardid_cc
    )

select *
from joining_creditcard