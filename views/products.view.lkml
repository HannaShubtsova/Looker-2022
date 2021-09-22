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
  sql: TRIM(${TABLE}.brand) ;;

  link: {
    label: "Website"
    url: "http://www.google.com/search?q={{ value | encode_uri }}+clothes&btnI"
    icon_url: "http://www.google.com/s2/favicons?domain=www.{{ value | encode_uri }}.com"
  }

  link: {
    label: "Facebook"
    url: "http://www.google.com/search?q=site:facebook.com+{{ value | encode_uri }}+clothes&btnI"
    icon_url: "https://static.xx.fbcdn.net/rsrc.php/yl/r/H3nktOa7ZMg.ico"
  }
  action: {

    label: "Send to zappier test"
    url: "https://hooks.zapier.com/hooks/catch/10920976/b654qm1/"
    param: {
      name: "item_id"
      value: "{{value}}"
    }
  }
#  link: {
#    label: "{{value}} Analytics Dashboard"
#    url: "/dashboards/thelook::brand_analytics?Brand%20Name={{ value | encode_uri }}"
#    icon_url: "http://www.looker.com/favicon.ico"
 # }
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
    link: {
      label: "Website"
      url: "http://www.google.com/search?q={{ value | encode_uri }}+clothes&btnI"
      icon_url: "http://www.google.com/s2/favicons?domain=www.{{ value | encode_uri }}.com"
    }
    action: {

      label: "Send to zappier"
      url: "https://hooks.zapier.com/hooks/catch/10920976/b654qm1/"
      param: {
        name: "item_id"
        value: "{{value}}"
      }
    }

    }


  measure: count {
    type: count
    drill_fields: [id, name, distribution_centers.name, distribution_centers.id, inventory_items.count]
  }
}
