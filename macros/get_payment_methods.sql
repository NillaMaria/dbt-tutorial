/*Macros in Jinja are pieces of code that can be called 
multiple times – they are analogous to a function in Python, 
and are extremely useful if you find yourself repeating 
code across multiple models.

This macro is simply going to return the list of payment methods:*/
/*
{% macro get_payment_methods_hardcode() %}
{{ return(["bank_transfer", "credit_card", "gift_card"]) }}
{% endmacro %}
*/

/*If a new payment_method was introduced, or one of the 
existing methods was renamed, the list would need to be 
updated.
Statements provide a way to run this query and return the 
results to your Jinja context. This means that the list of 
payment_methods can be set based on the data in your database 
rather than a hardcoded value.*/

/*Macro to generically return a column from a relation*/
{% macro get_column_values(column_name, relation) %}

{% set relation_query %}
select distinct
{{ column_name }}
from {{ relation }}
order by 1
{% endset %}

{% set results = run_query(relation_query) %}

{% if execute %}
{# Return the first column #}
{% set results_list = results.columns[0].values() %}
{% else %}
{% set results_list = [] %}
{% endif %}

{{ return(results_list) }}

{% endmacro %}


/*Specific macro that calls the generic macro with the correct arguments to get back the list of payment methods.*/
{% macro get_payment_methods() %}

{{ return(get_column_values('payment_method', ref('raw_payments'))) }}

{% endmacro %}
