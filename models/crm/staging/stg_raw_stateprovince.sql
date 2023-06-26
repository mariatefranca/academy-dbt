with
  stateprovince as (
    select
      stateprovinceid
      , name as state_name
      , countryregioncode as countryregioncode_sp
    from {{ source('source_adw', 'stateprovince') }}
)

select *
from stateprovince