

view: test_pdt {
   # Or, you could make this view a derived table, like this:
   derived_table: {
     sql:  SELECT L_PARTKEY, 'test'  FROM  DATA_MART.F_LINEITEMS ;;
  sql_trigger_value: SELECT CURRENT_DATE ;;
   }
#



   dimension: part {
     description: "Unique ID for each user that has ordered"
     type: number
     sql: ${TABLE}.L_PARTKEY ;;
   }


 }
