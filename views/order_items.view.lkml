view: order_items {
  sql_table_name: "PUBLIC"."ORDER_ITEMS"
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."CREATED_AT" ;;
  }

  dimension_group: delivered {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."DELIVERED_AT" ;;
  }

  dimension: inventory_item_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."INVENTORY_ITEM_ID" ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}."ORDER_ID" ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."RETURNED_AT" ;;
  }


  dimension_group: shipped {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}."SHIPPED_AT" ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}."STATUS" ;;
  }

  dimension: status_color_format {

    sql: ${TABLE}.status ;;

    html:

    {% if value == 'Paid' %}
      <p style="color: black; background-color: lightblue; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% elsif value == 'Shipped' %}
      <p style="color: black; background-color: lightgreen; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% else %}
      <p style="color: black; background-color: orange; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% endif %}

;;

    }

  dimension: status_image_format{
    sql: ${TABLE}.status ;;
    html:
    {% if value == 'Shipped' or value == 'Complete' %}
     <p><img src="http://findicons.com/files/icons/573/must_have/48/check.png" height=20 width=20>{{ rendered_value }}</p>
    {% elsif value == 'Processing' %}
    <p><img src="http://findicons.com/files/icons/1681/siena/128/clock_blue.png" height=20 width=20>{{ rendered_value }}</p>
    {% else %}
      <p><img src="http://findicons.com/files/icons/719/crystal_clear_actions/64/cancel.png" height=20 width=20>{{ rendered_value }}</p>
    {% endif %}
;;

    }



  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."USER_ID" ;;
  }



  dimension: is_returned {
    type: yesno
    label: "Is Returned?"
    group_label: "Filters"
    description: "Calculates whether the order was returned or not"
    sql: ${status}='Returned' ;;
  }

  dimension: is_cancelled_or_returned{
    type: yesno
    label: "Is Cancelled or Returned?"
    group_label: "Filters"
    description: "Calculates whether the order was returned or cancelled - can filter Gross Revenue"
    sql: ${status}='Returned' or ${status}='Cancelled'  ;;
  }


  measure: total_gross_revenue {
    type: sum
    description: "Total revenue from completed sales (cancelled and returned orders excluded)"
    group_label: "Revenue"
    sql: ${sale_price};;
    filters: [is_cancelled_or_returned: "No"]
    value_format_name: usd
    drill_fields: [detail*]
  }

  measure: total_cost_sold_items {
    type: sum
    group_label: "Cost"
    description: "Total cost of items sold from inventory - No Returned or No Cancelled"
    sql: ${inventory_items.cost} ;;
    filters: [is_cancelled_or_returned: "No"]
  }

  measure: average_cost_sold_items {
    type: average
    group_label: "Cost"
    description: "Total cost of items sold from inventory - No Returned or No Cancelled"
    sql: ${inventory_items.cost} ;;
    filters: [is_cancelled_or_returned: "No"]
  }

  dimension: margin {
    description: "Margin (Sales - Cost)"
    group_label: "Margin"
    type: number
    hidden: yes
    sql: ${sale_price} - ${inventory_items.cost} ;;
    value_format_name: usd
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }



  measure: total_gross_margin_amount {
    type: sum
    group_label: "Margin"
    description: "Total difference between the total revenue from completed sales and the cost of the goods that were sold"
    sql: ${margin};;
    filters: [is_cancelled_or_returned: "No"]
    value_format_name: usd
  }


  measure: average_gross_margin_amount {
    type: average
    group_label: "Margin"
    description: "Average difference between the total revenue from completed sales and the cost of the goods that were sold"
    sql: ${margin};;
    filters: [is_cancelled_or_returned: "No"]
    value_format_name: usd
  }

  measure: Gross_Margin_Percent {
    type: number
    label: "Gross Margin %"
    group_label: "Margin"
    description: "Total Gross Margin Amount / Total Gross Revenue"
    sql: ${total_gross_margin_amount}/nullif(${total_gross_revenue},0) ;;
    value_format_name: percent_2
  }

  measure: count_returns {
    type: count
    label: "Number of Items Returned"
    group_label: "Returns"
    description: "Count Returned Items in an order - Number of items that were returned by dissatisfied customers"
    filters: [is_returned: "Yes"]
  }

  measure: item_return_rate {
    type: number
    description: "Number of Items Returned / total number of items sold"
    group_label: "Returns"
    sql: ${count_returns} / ${count} ;;
    value_format_name: percent_2
  }

  measure: count_customer_return_items{
    description: "Number of users who have returned an item at some point"
    group_label: "Returns"
    type: count_distinct
    sql: ${user_id} ;;
    filters: [is_returned: "yes"]
  }

  measure: percent_users_with_returns {
    description: "Number of Customer Returning Items / total number of customers"
    group_label: "Returns"
    type: number
    sql: ${count_customer_return_items} / nullif(${users.count},0) ;;
    value_format_name: percent_2
  }

  measure: average_spend_per_customer {
    description: "Average Spend per Customer - Total Sale Price / total number of customers"
    group_label: "Sale"
    type: number
    sql:  ${total_sale_price} / nullif(${users.count},0) ;;
    value_format_name: usd
  }

  dimension: sale_price {
    type: number
    hidden: yes
    group_label: "Sale"
    sql: ${TABLE}."SALE_PRICE" ;;
    value_format_name: usd
  }


  measure: total_sale_price {
    type: sum
    group_label: "Sale"
    description: "Total sales from items sold"
    sql: ${sale_price};;
    value_format_name: usd
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      inventory_items.product_name,
      inventory_items.id,
      users.last_name,
      users.id,
      users.first_name
    ]
  }
}
