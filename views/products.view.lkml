view: products {
  sql_table_name: "PUBLIC"."PRODUCTS"
    ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}."BRAND" ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}."CATEGORY" ;;
  }

  dimension: cost {
    type: number
    sql: ${TABLE}."COST" ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}."DEPARTMENT" ;;
  }

  dimension: distribution_center_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."DISTRIBUTION_CENTER_ID" ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}."NAME" ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}."RETAIL_PRICE" ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}."SKU" ;;
  }

  dimension: sku_link_to{
    type: string
    sql: ${TABLE}."SKU" ;;
    action: {
      label: "search in google"
      url: "https://www.google.com/search?q={{ value }}"
      icon_url: "https://looker.com/favicon.ico"
      #form_param: {"http://www.google.com/search?q={{ value }}"}
      #form_url: "https://example.com/ping/{{ value }}/form.json"
      param: {
        name: "name string"
        value: "value string"
      }
      form_param: {
        name: "name string"
        type: select
        label: "possibly-localized-string"
        option: {
          name: "name string"
          label: "possibly-localized-string"
        }
        required:  no
        description: "possibly-localized-string"
        default: "string"
      }
      #user_attribute_param: {
      #  user_attribute: user_attribute_name
      #  name: "name_for_json_payload"
      #}
    }
  }

  measure: count {
    type: count
    drill_fields: [id, name, distribution_centers.name, distribution_centers.id, inventory_items.count]
  }
}
