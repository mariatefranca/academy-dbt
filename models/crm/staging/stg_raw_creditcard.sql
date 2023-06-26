with
  creditcard as (
    select
      creditcardid as creditcardid_cc
      , cardtype
    from {{ source('source_adw', 'creditcard') }}
)

select *
from creditcard