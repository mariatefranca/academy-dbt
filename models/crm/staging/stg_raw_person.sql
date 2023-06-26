with
  person as (
    select
      businessentityid as personid
      , persontype
      , firstname
      , middlename
      , person.lastname
    from {{ source('source_adw', 'person') }}
)

select *
from person