with
    persons as (
        select
            personid
            , case
                when middlename is not null
                    then concat(firstname, ' ', middlename, ' ', lastname)
                else concat(firstname, ' ', lastname)
            end as person_name
            , case
                when persontype = 'SC'
                    then 'Store Contact'
                when persontype = 'IN'
                    then 'Individual customer'
                when persontype = 'SP'
                    then 'Sales person' 
                when persontype = 'EM'
                    then 'Employee'
                when persontype = 'VC'
                    then 'Vendor contact'
                when persontype = 'GC'
                    then 'General contact'
            end as persontype
        from {{ ref('stg_raw_person') }}
    )

select *
from persons