with
  countryregion as (
    select
      countryregioncode
      , name as country_name
    from {{ source('source_adw', 'countryregion') }}
)

select *
from countryregion