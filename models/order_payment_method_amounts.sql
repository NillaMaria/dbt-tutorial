/*
select
order_id,
sum(case when payment_method = 'bank_transfer' then amount end) as bank_transfer_amount,
sum(case when payment_method = 'credit_card' then amount end) as credit_card_amount,
sum(case when payment_method = 'gift_card' then amount end) as gift_card_amount,
sum(amount) as total_amount
from {{ ref('raw_payments') }}
group by 1
*/

/*Same select using Jinja to avoid repeating yourself
The following row of code is a variable that holds the 
different payment methods. We can use that or we can use 
a macro. Here we'll use the macro.*/

/*
{% set payment_methods = ["bank_transfer", "credit_card", "gift_card"] %}
*/
/* This code uses the macro we created ourselves.
{%- set payment_methods = get_payment_methods() -%}
*/
/*This code uses a similar macro from the package dbt-utils*/
{%- set payment_methods = dbt_utils.get_column_values(
    table=ref('raw_payments'),
    column='payment_method'
) -%}

select
order_id,
{%- for payment_method in payment_methods %}
sum(case when payment_method = '{{payment_method}}' then amount end) as {{payment_method}}_amount
{%- if not loop.last %},{% endif -%}
{% endfor %}
from {{ ref('raw_payments') }}
group by 1