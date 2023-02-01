view: d_dates {
  sql_table_name: "DATA_MART"."D_DATES"
    ;;

  dimension_group: date_val {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year,
      day_of_month,
      month_name
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}."DATE_VAL" ;;
  }

  dimension_group: current_date{
    type: time
    timeframes: [
      year
    ]
    sql: getdate() ;;
  }

  dimension: datekey {
    type: number
    sql: ${TABLE}."DATEKEY" ;;
  }

  dimension: day_of_week {
    type: number
    sql: ${TABLE}."DAY_OF_WEEK" ;;
  }

  dimension: dayname_of_week {
    type: string
    sql: ${TABLE}."DAYNAME_OF_WEEK" ;;
  }

  dimension: month_name {
    type: string
    sql: ${TABLE}."MONTH_NAME" ;;
  }

  dimension: month_num {
    type: number
    sql: ${TABLE}."MONTH_NUM" ;;
  }

  dimension: quarter {
    type: number
    sql: ${TABLE}."QUARTER" ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}."YEAR" ;;
  }

  measure: count {
    type: count
    drill_fields: [month_name]
  }

  parameter: date_granularity {
    type: unquoted

    allowed_value: {
      label: "Break down by Month"
      value: "month"
    }
    allowed_value: {
      label: "Break down by Qarter"
      value: "quarter"
    }
    allowed_value: {
      label: "Break down by Year"
      value: "year"
    }
  }

  dimension: date_dynamic {
    sql:
    {% if date_granularity._parameter_value == 'month' %}
      ${date_val_month}
    {% elsif date_granularity._parameter_value == 'quarter' %}
      ${date_val_quarter}
    {% else %}
      ${date_val_year}
    {% endif %};;
  }

}
