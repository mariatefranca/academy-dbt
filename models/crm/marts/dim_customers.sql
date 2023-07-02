with
    customer as (
        select *
        from {{ ref('stg_raw_customer') }}
    )

    , persons as (
        select *
        from {{ ref('int_persons') }}
    )

    , customerdetails as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'customer.customerid_cus']) }} as customer_sk
            , customer.customerid_cus
            , persons.person_name as customer_name
            , persons.persontype
        from customer
        left join persons
            on customer.personid_cus = persons.personid
    )

select *
from customerdetails