{% docs order_payment_method_amounts %}
/* This is a docsblock */

This model counts how much of an order payment was paid with each different payment method. 
Each payment may have a payment method of bank transfer, credit card or gift card, 
and therefore each order can have multiple payment methods. 
From an analytics perspective, it's important to know how much of each order was paid for with each payment method.
This model utilises the macro dbt_utils.get_column_values.

[More info in the dbt tutorial](https://docs.getdbt.com/tutorial/using-jinja)


{% enddocs %}    