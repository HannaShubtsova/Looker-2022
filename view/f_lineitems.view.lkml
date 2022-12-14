view: f_lineitems {
  sql_table_name: "DATA_MART"."F_LINEITEMS" ;;

  dimension: l_availqty {
    type: number
    sql: ${TABLE}."L_AVAILQTY" ;;
  }

  dimension: l_clerk {
    type: string
    sql: ${TABLE}."L_CLERK" ;;
  }

  dimension: l_commitdatekey {
    type: number
    sql: ${TABLE}."L_COMMITDATEKEY" ;;
  }

  dimension: l_custkey {
    type: number
    sql: ${TABLE}."L_CUSTKEY" ;;
  }

  dimension: l_discount {
    type: number
    sql: ${TABLE}."L_DISCOUNT" ;;
  }

  dimension: l_totalprice {
    type: number
    sql: ${TABLE}."L_TOTALPRICE" ;;
  }

  dimension: l_linenumber {
    type: number
    sql: ${TABLE}."L_LINENUMBER" ;;
  }

  dimension: l_orderdatekey {
    type: number
    sql: ${TABLE}."L_ORDERDATEKEY" ;;
  }

  dimension: l_orderkey {
    type: number
    sql: ${TABLE}."L_ORDERKEY" ;;
  }

  dimension: l_orderpriority {
    type: string
    sql: ${TABLE}."L_ORDERPRIORITY" ;;
  }

  dimension: l_orderstatus {
    type: string
    sql: ${TABLE}."L_ORDERSTATUS" ;;
  }

  dimension: l_partkey {
    type: number
    sql: ${TABLE}."L_PARTKEY" ;;
  }

  dimension: l_quantity {
    type: number
    sql: ${TABLE}."L_QUANTITY" ;;
  }

  dimension: l_receiptdatekey {
    type: number
    sql: ${TABLE}."L_RECEIPTDATEKEY" ;;
  }

  dimension: l_returnflag {
    type: string
    sql: ${TABLE}."L_RETURNFLAG" ;;
  }

  dimension: l_shipdatekey {
    type: number
    sql: ${TABLE}."L_SHIPDATEKEY" ;;
  }

  dimension: l_shipinstruct {
    type: string
    sql: ${TABLE}."L_SHIPINSTRUCT" ;;
  }

  dimension: l_shipmode {
    type: string
    sql: ${TABLE}."L_SHIPMODE" ;;
  }

  dimension: l_shippriority {
    type: number
    sql: ${TABLE}."L_SHIPPRIORITY" ;;
  }

  dimension: l_suppkey {
    type: number
    sql: ${TABLE}."L_SUPPKEY" ;;
  }

  dimension: l_supplycost {
    type: number
    sql: ${TABLE}."L_SUPPLYCOST" ;;
  }

  dimension: l_tax {
    type: number
    sql: ${TABLE}."L_TAX" ;;
  }

  dimension: l_extended_price {
    type: number
    sql: ${TABLE}."L_EXTENDEDPRICE" ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
  measure: TotalSalePrice {
    label: "Total Sale Price"
    description: "Total Sales Value in USD"
    type: sum
    sql: ${l_totalprice} ;;
    value_format_name: usd
  }
  measure: AVGSalePrice {
    label: "Total Average Price"
    description: "Total Average Value in USD"
    type: average
    sql: ${l_totalprice};;
    # value_format_name: usd
  }
  measure: CumulativeTotalSales {
    label: "Cumulative Total Sales Price"
    description: "Cumulative Sales Value in USD"
    type: running_total
    sql: ${l_totalprice} ;;
    value_format_name: usd
  }
  measure: SalesbyAIRMode {
    label: "Sales made from AIR mode"
    description: "Sales made from AIR mode in USD"
    type: sum
    sql: ${l_totalprice} ;;
    filters: [l_shipmode: "AIR"]
    value_format_name: usd
  }
  measure: SalesByUS {
    label: "Sales made from US mode"
    description: "Sales filter US in USD"
    type: sum
    sql: ${l_totalprice} ;;
    filters: [d_customer.c_nation: "UNITED STATES"]
    value_format_name: usd
  }
  measure: Gross_revenue{
    label: "Total Gross Revenue"
    description: "Gross Revenue in USD"
    type: sum
    sql: ${l_totalprice} ;;
    filters: [l_orderstatus: "F"]
    value_format_name: usd
    link: {
      label: "Searching suppliers"
      url: "https://www.google.com"
    }
  }

  measure: TotalCost{
    label: "Total Cost"
    type: sum
    sql: ${l_supplycost} ;;
    value_format_name: usd
  }

  measure: Gross_Margin {
    label: "Total Gross Margin Amount"
    type: number
    sql: ${Gross_revenue}-${TotalCost} ;;
    value_format_name: usd
    drill_fields: [d_supplier.s_Account_Balance, d_supplier.s_region, Gross_Margin]
    link: {
      label: "Searching suppliers"
      # url: "https://www.google.com"
      # url: "https://epam.cloud.looker.com/dashboards/243?fields=d_supplier.s_region"
      url: "https://epam.cloud.looker.com/dashboards/243?region={{ _filters['d_supplier.region']}}"
    }
  }

  measure: MarginPercentage {
    label: "Margin Percentage"
    type: number
    sql: ${Gross_Margin}/nullif(${Gross_revenue},0) ;;
    value_format_name: percent_2
    html:
    {% if value > 100 %}
    <span style="color:darkgreen;">{{ rendered_value }}</span>
      {% elsif value > 50 %}
    <span style="color:yellow;">{{ rendered_value }}</span>
      {% else %}
    <span style="color:darkred;">{{ rendered_value }}</span>
    {% endif %} ;;
  }

  dimension: ReturnedFlag {
    type: yesno
    sql: ${l_returnflag} = 'R' ;;
  }

  measure: ItemReturned {
    label: "Item Returned"
    type: sum
    sql: ${l_quantity} ;;
    filters: [ReturnedFlag: "yes"]
  }

  measure: ItemSold {
    label: "Item Sold"
    type: sum
    sql: ${l_quantity} ;;
    value_format_name: id
  }

  measure: ReturnRate{
    label: "Return Rate"
    type: number
    sql: ${ItemReturned}/IFNULL(${ItemSold},0) ;;
    value_format_name: percent_2
  }

  measure: CustomerCount {
    label: "Customer Count"
    type: count_distinct
    sql: ${l_custkey}  ;;
  }

  measure: SendByCustomer {
    label: "Spend By Customer"
    type: number
    sql: ${TotalSalePrice}/NULLIFF(${CustomerCount},0) ;;
    value_format_name: usd
  }

  measure: TotalNumberofOrders  {
    label: "Total Number of orders"
    type: count_distinct
    sql: ${l_orderkey} ;;
  }

  measure: NumberOfSales  {
    label: "Number Of Sales"
    type: count_distinct
    sql: ${l_orderkey} ;;
  }
}
