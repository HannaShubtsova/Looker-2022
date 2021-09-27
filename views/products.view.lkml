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
    icon_url:"https://images.squarespace-cdn.com/content/v1/5dc1ccd7e0292e070ef93a24/1573244994447-PIPZPQJL2BF9HGMEPF1E/Stormboard+and+Zapier?format=1000w"
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

  link: {
    label: " Chat"
    #url: "https://epam.cloud.looker.com/extensions/epam_oleksandr_korenev_test1::epam_oleksandr_korenev_ext_test1/?q={{ value | encode_uri }}"
    url: "https://epam.cloud.looker.com/extensions/epam_oleksandr_korenev_test1::epam_oleksandr_korenev_ext_test1/?q={{ value | encode_uri }}&r={{order_items.item_return_rate._value|encode_uri }}"
  }

    action: {
      label: "Email Promotion to Customer"
      url: "https://desolate-refuge-53336.herokuapp.com/posts"
      icon_url: "https://sendgrid.com/favicon.ico"
      param: {
        name: "some_auth_code"
        value: "abc123456"
      }
      form_param: {
        name: "Subject"
        required: yes
        default: "Thank you {{ users.name._value }}"
      }

      form_param: {
        name: "TEST2"
        required: yes
        default: "test2"
      }

      form_param: {
        name: "Body"
        type: textarea
        required: yes
        default:
        "Dear {{ users.first_name._value }},

        Thanks for your loyalty to the Look.  We'd like to offer you a 10% discount
        on your next purchase!  Just use the code LOYAL when checking out!

        Your friends at the Look"
      }
    }


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

    action: {
      label: "Call chatbot"
      url: "https://hooks.slack.com/services/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"
      param:
      {name: "param1"
      value: "{{value}}"
      }

      param: {
      name: "param2"
      value: "{{order_items.item_return_rate._value}} "
      }
      }

      action: {
        label: "Call chatbot throgh zappier"
        url: "https://hooks.zapier.com/hooks/catch/10920976/b6q0u7e"
        param:
        {name: "param1"
          value: "{{value}}"
        }

        param: {
          name: "param2"
          value: "{{order_items.item_return_rate._value}} "
        }
    }



    }


  measure: count {
    type: count
    drill_fields: [id, name, distribution_centers.name, distribution_centers.id, inventory_items.count]
    link: {
      label: "Drill as scatter plot"
      url: "
      {% assign vis_config = '{\"type\": \"looker_scatter\"}' %}
      {{ link }}&vis_config={{ vis_config | encode_uri }}&toggle=dat,pik,vis&limit=5000"
    }


  }
}
