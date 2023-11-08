view: d_supplier_customer {
  derived_table: {
    #materialized_view: yes
    sql:
      SELECT S_SUPPKEY AS OWNER_ID, S_NAME  AS OWNER_NAME, 'SUPPLIER' AS OWNER_ROLE FROM D_SUPPLIER
      UNION ALL
      SELECT C_CUSTKEY AS OWNER_ID , C_NAME AS OWNER_NAME, 'CUSTOMER' AS OWNER_ROLE FROM D_CUSTOMER
      ORDER BY 3, 2 ;;
   }
  suggestions: yes

  dimension: owner_id
  {
    type:  number
    label:  "{% if _view._name == 'd_supplier_customer' %} Owner
              {% elsif _view._name == 'd_supplier_customer_customer' %} Customer
              {% elsif _view._name == 'd_supplier_customer_supplier' %} Supplier
              {% else %} Dummy {% endif %} ID"
    sql: ${TABLE}.OWNER_ID ;;
    primary_key: yes
    hidden: yes
  }

  dimension: owner_name
  {
    type:  string
    label:  "{% if _view._name == 'd_supplier_customer' %} Owner
    {% elsif _view._name == 'd_supplier_customer_customer' %} Customer
    {% elsif _view._name == 'd_supplier_customer_supplier' %} Supplier
    {% else %} Dummy {% endif %} Name"
    sql: ${TABLE}.OWNER_NAME ;;
  }

  dimension: owner_role
  {
    type:  string
    sql: ${TABLE}.OWNER_role ;;
  }

  dimension: owner_name_and_role {

    type:  string
    label:  "{% if _view._name == 'd_supplier_customer' %} Owner
    {% elsif _view._name == 'd_supplier_customer_customer' %} Customer
    {% elsif _view._name == 'd_supplier_customer_supplier' %} Supplier
    {% else %} Dummy {% endif %} Name And Role"
    sql: CONCAT(${owner_name}, ', ',${owner_role})  ;;
  }


  # filter: owner_filter {
  #   type: string
  #   suggest_dimension: owner_name_and_role
  #   sql: EXISTS
  #       (SELECT
  #       S_SUPPKEY FROM D_SUPPLIER WHERE {% condition %} CONCAT(S_NAME, ', SUPPLIER')  {% endcondition %} )
  #     OR  EXISTS
  #       (SELECT C_CUSTKEY
  #         FROM D_CUSTOMER WHERE {% condition %} CONCAT(C_NAME, ', CUSTOMER'){% endcondition %} )
  #     ;;

  #   # sql:  {% condition %} CONCAT(D_SUPPLIER.S_NAME, ', SUPPLIER')   {% endcondition %}
  #   #     OR  {% condition %} CONCAT(D_CUSTOMER.C_NAME, ', CUSTOMER')  {% endcondition %} ;;



  # }

  }

view: d_supplier_customer_customer  {

  extends: [d_supplier_customer]
  dimension: owner_role
  {
    type:  string
    hidden: yes
    sql: ${TABLE}.OWNER_role ;;
  }

}


view: d_supplier_customer_supplier {

  extends: [d_supplier_customer]
  dimension: owner_role
  {
    type:  string
    hidden: yes
    sql: ${TABLE}.OWNER_role ;;
  }

}
