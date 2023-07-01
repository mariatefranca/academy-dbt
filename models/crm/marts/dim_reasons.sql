with
    salesorderheadersalesreason as (
        select * 
        from {{ref('stg_raw_salesorderheadersalesreason')}}
    )

    , salesreason as (
        select * 
        from {{ref('stg_raw_salesreason')}}
    )

    , reason as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'salesorderheadersalesreason.salesorderid_sr'
                , 'salesorderheadersalesreason.salesreasonid_sr']) }} as reason_sk
            , salesorderheadersalesreason.salesorderid_sr
            , salesreason.reasontype
            , salesorderheadersalesreason.modifieddate_sr    
        from salesorderheadersalesreason
        left join salesreason  
                on salesorderheadersalesreason.salesreasonid_sr = salesreason.salesreasonid
    )

select * 
from reason
