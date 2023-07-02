with
    reason_aggregate as (
        select
            salesorderid_sr as reasons_sk
            , salesorderid_sr
            , case
                when reasons in ('Other & Other', 'Other')
                    then 'Other'
                when reasons in ('Other & Promotion', 'Other & Promotion & Other', 'Promotion & Other')
                    then 'Promotion & Other'
                when reasons = 'Marketing & Other'
                    then 'Marketing & Other'
                when reasons = 'Marketing'
                    then 'Marketing'
                when reasons = 'Promotion'
                    then 'Promotion'                   
            end as reasons
        from {{ ref('int_reasons') }}
    )

select *
from reason_aggregate