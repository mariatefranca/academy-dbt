with
    product as (
        select *
        from {{ref('stg_raw_product')}}
    )

    , productsubcategory as (
        select *
        from {{ref('stg_raw_productsubcategory')}}
    )

    , productdetails as (
        select
            {{ dbt_utils.generate_surrogate_key([
                'product.productid_p']) }} as product_sk
            , product.productid_p
            , product.product_name
            , case
                when productsubcategory.productsubcategory_name is null then 'Unknown'
                else productsubcategory.productsubcategory_name
            end as productsubcategory_name
        from product
        left join productsubcategory
                on product.productsubcategoryid_p = productsubcategory.productsubcategoryid
    )

select * 
from productdetails