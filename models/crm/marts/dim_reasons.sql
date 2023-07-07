with
    reason_aggregate as (
        select
            salesorderid_sr as reasons_sk
            , salesorderid_sr
            , case
                when reasons in ('Other & Other', 'Other')
                    then 'Other'
                when reasons in ('Other & Promotion', 'Other & Promotion & Other'
                    , 'Promotion & Other', 'Promotion')
                    then 'Promotion'
                when reasons in ('Marketing & Other', 'Marketing')
                    then 'Marketing'                 
            end as reasons
        from {{ ref('int_reasons') }}
    )

select *
from reason_aggregate