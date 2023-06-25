with
  product as (
    select
      productid as productid_p
      , name as product_name
      , productsubcategoryid as productsubcategoryid_p
    from {{ source('source_adw', 'product') }}
)

select *
from product