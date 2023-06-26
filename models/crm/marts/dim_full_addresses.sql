with addresses as (
    select * 
    from {{ref('stg_raw_addresses')}}
)

, stateprovince as (
    select * 
    from {{ref('stg_raw_stateprovince')}}
)

, countryregion as (
    select * 
    from {{ref('stg_raw_countryregion')}}
)

, full_addresses as (
    select
        {{ dbt_utils.generate_surrogate_key([
            'addresses.addressid_ad']) }} as full_addresses_sk
        , addresses.addressid_ad
	    , addresses.city as city_name
        , stateprovince.state_name
        , countryregion.country_name
    from addresses
    left join stateprovince  
            on addresses.stateprovinceid_ad = stateprovince.stateprovinceid 
    left join countryregion 
            on stateprovince.countryregioncode_sp = countryregion.countryregioncode
)

select * 
from full_addresses