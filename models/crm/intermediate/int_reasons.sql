with
    salesorderheadersalesreason as (
        select * 
        from {{ref('stg_raw_salesorderheadersalesreason')}}
    )

    , salesreason as (
        select * 
        from {{ref('stg_raw_salesreason')}}
    )

    /* Aggregating sales reason type name by salesorderid */
    , reason_aggregate as (
        select
            salesorderheadersalesreason.salesorderid_sr
            , string_agg(salesreason.reasontype, ' & ') as reasons  
        from salesorderheadersalesreason
        left join salesreason  
                on salesorderheadersalesreason.salesreasonid_sr = salesreason.salesreasonid
        group by salesorderheadersalesreason.salesorderid_sr
    )

    select *
    from reason_aggregate