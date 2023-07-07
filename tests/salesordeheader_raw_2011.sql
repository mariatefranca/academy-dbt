with
    test as (
        select  round(sum(subtotal), 2) as sales_amount_2011
        from {{ ref('stg_raw_salesorderheader') }}
        where extract(year from orderdate) = 2011
    )

select *
from test
where sales_amount_2011 != 12641672.21