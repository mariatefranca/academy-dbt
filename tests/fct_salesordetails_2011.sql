/*Teste para garantir que:
    - os valores líquidos de venda continuam iguais aos valores encontrados na source e  que,
    - os valores brutos de vendas correspondem aos valores informados pela empresa*/
with
    test as (
        select  round(sum(linetotal_liq), 2) as sales_amount_liq_2011
        , round(sum(linetotal_regular), 2) as sales_amount_gross_2011
        from {{ ref('fct_salesdetails') }}
        where extract(year from orderdate) = 2011
    )

select *
from test
where sales_amount_liq_2011 != 12641672.21 and 
    sales_amount_gross_2011 != 12646112.16