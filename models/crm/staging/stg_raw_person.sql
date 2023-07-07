with
  person as (
    select
      businessentityid as personid
      , persontype
      , firstname
      , middlename
      , lastname
    from {{ source('source_adw', 'person') }}
)

select *
from person