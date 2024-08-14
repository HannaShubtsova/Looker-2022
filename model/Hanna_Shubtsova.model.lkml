connection: "tpchlooker"

# include all the views
include: "/view/**/*.view"
# include: "/Dashboard/Test-akulbi.dashboard.lookml"

datagroup: group1 {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

explore: test_pdt {}

persist_with: group1

explore: f_lineitems {
  label: "Order Analysis"
  view_label: "OrderItems"
  join: d_part {
    view_label: "Parts"
    type: left_outer
    sql_on: ${f_lineitems.l_partkey} = ${d_part.p_partkey} ;;
    relationship: many_to_one
  }
  join: d_supplier {
    view_label: "Supplier"
    type: left_outer
    sql_on: ${f_lineitems.l_suppkey} = ${d_supplier.s_suppkey} ;;
    relationship: many_to_one
  }
  join: d_customer {
    view_label: "Customer"
    type: left_outer
    sql_on: ${f_lineitems.l_custkey} = ${d_customer.c_custkey} ;;
    relationship: many_to_one
  }
  join: d_dates {
    view_label: "Dates"
    type: left_outer
    sql_on: ${f_lineitems.l_shipdatekey} = ${d_dates.datekey} ;;
    relationship: many_to_one
  }

  join: d_supplier_customer {
    view_label: "filters"
    type: left_outer
    sql_on: ( ${f_lineitems.l_custkey} = ${d_supplier_customer.owner_id} and ${d_supplier_customer.owner_role} ='CUSTOMER') OR
          (${f_lineitems.l_suppkey} = ${d_supplier_customer.owner_id} and ${d_supplier_customer.owner_role} = 'SUPPLIER') ;;

    relationship: many_to_one
  }



  join: d_supplier_customer_customer {
    view_label: "customer_new"
    type: left_outer
    sql_on: ${f_lineitems.l_custkey} = ${d_supplier_customer_customer.owner_id}
          and ${d_supplier_customer_customer.owner_role} ='CUSTOMER';;
    relationship: many_to_one
  }

  join: d_supplier_customer_supplier {
    view_label: "supplier_new"
    type: left_outer
    sql_on: ${f_lineitems.l_suppkey} = ${d_supplier_customer_supplier.owner_id}
      and ${d_supplier_customer_supplier.owner_role} ='SUPPLIER';;
    relationship: many_to_one
  }

}
