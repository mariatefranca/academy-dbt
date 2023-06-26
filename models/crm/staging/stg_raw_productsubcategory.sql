with
  productsubcategory as (
    select
      productsubcategoryid
      , name as productsubcategory_name
    from {{ source('source_adw', 'productsubcategory') }}
)

select *
from productsubcategory