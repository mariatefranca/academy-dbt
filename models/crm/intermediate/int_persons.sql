with
    persons as (
        select
            personid
            , persontype
            , case
                when middlename is not null
                    then concat(firstname, ' ', middlename, ' ', lastname)
                else concat(firstname, ' ', lastname)
            end as person_name
        from {{ ref('stg_raw_person') }}
    )

select *
from persons