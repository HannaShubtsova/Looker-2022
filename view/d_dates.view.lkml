view: d_dates {
  sql_table_name: "DATA_MART"."D_DATES"
    ;;

  dimension_group: date_val {
    group_label: "Group lablel 3"
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
    group_label: "Group lablel 3"
    type: time
    timeframes: [
      year
    ]
    sql: getdate() ;;
  }

  dimension: datekey {
    group_label: "Group lablel 3"
    type: number
    sql: ${TABLE}."DATEKEY" ;;
  }

  dimension: day_of_week {
    group_label: "Group lablel 3"
    label: "{{ _view._label }} of week"
    type: number
    sql: ${TABLE}."DAY_OF_WEEK" ;;
  }

  dimension: dayname_of_week {
    group_label: "Group lablel 3"
    type: string
    sql: ${TABLE}."DAYNAME_OF_WEEK" ;;
  }

  dimension: month_name {
    group_label: "Group lablel 3"
    type: string
    sql: ${TABLE}."MONTH_NAME" ;;
  }

  dimension: month_num {
    group_label: "Group lablel 3"
    type: number
    sql: ${TABLE}."MONTH_NUM" ;;
  }

  dimension: quarter {
    group_label: "Group lablel 3"
    type: number
    sql: ${TABLE}."QUARTER" ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}."YEAR" ;;
  }

  measure: count {
    group_label: "Group lablel 3"
    type: count
    drill_fields: [month_name]
  }

  parameter: date_granularity {
    group_label: "Group lablel 3"
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
    group_label: "Group lablel 3"
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
