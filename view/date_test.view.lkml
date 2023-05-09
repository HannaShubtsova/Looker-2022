# this is the code for the date comparison tool, which mimics what google 360 does in the browser in comparing two different date ranges. use with _date_dim.view.lkml
include: "/view/d_dates.view"
view: _date_comparison {
    extends: [d_dates]
#  label: "Timeline Comparison Fields"
 ##extended
  dimension: month_name2 {
    type: string
    sql: ${TABLE}."MONTH_NAME" ;;
    hidden: yes
  }


  filter: current_date_range {
    view_label: "Timeline Comparison Fields"
    label: "1. Date Range"
    description: "Select the date range you are interested in using this filter, can be used by itself. Make sure any filter on Event Date covers this period, or is removed."
    type: date
    convert_tz: yes
  }
  filter: previous_date_range {
    view_label: "Timeline Comparison Fields"
    label: "2b. Compare To (Custom):"
    group_label: "Compare to:"

    description: "Use this if you want to specify a custom date range to compare to (limited to 2 comparison periods). Always use with '1. Date Range' filter (or it will error). Make sure any filter on Event Date covers this period, or is removed."

    type: date
    convert_tz: yes
  }

  dimension_group: in_period {
    type: duration
    intervals: [day]
    description: "Gives the number of days in the current period date range"
    sql_start: {% date_start current_date_range %} ;;
    sql_end: {% date_end current_date_range %} ;;
    #hidden:  yes
  }

  parameter: date_granularity  {
    allowed_value: {
      label: "Break down by Month new"
      value: "month"
    }

    allowed_value: {
      label: "Break down by quarter new"
      value: "quarter"
    }
  }
}

view: _date_comparison3 {
  extends: [d_dates]
#  label: "Timeline Comparison Fields"
  ##extended
  dimension: month_name3 {
    type: string
    sql: ${TABLE}."MONTH_NAME" ;;
    hidden: no
  }


  filter: current_date_range {
    view_label: "Timeline Comparison Fields"
    label: "1. Date Range3"
    description: "Select the date range you are interested in using this filter, can be used by itself. Make sure any filter on Event Date covers this period, or is removed."
    type: date
    convert_tz: no
    default_value: "2022-01-01"

  }
  filter: previous_date_range {
    view_label: "Timeline Comparison Fields"
    label: "2b. Compare To (Custom):"
    group_label: "Compare to:"

    description: "Use this if you want to specify a custom date range to compare to (limited to 2 comparison periods). Always use with '1. Date Range' filter (or it will error). Make sure any filter on Event Date covers this period, or is removed."

    type: date
    convert_tz: yes
  }

  dimension_group: in_period {
    type: duration
    intervals: [day]
    description: "Gives the number of days in the current period date range"
    sql_start: {% date_start current_date_range %} ;;
    sql_end: {% date_end current_date_range %} ;;
    #hidden:  yes
  }

  parameter: date_granularity  {
    allowed_value: {
      label: "Break down by Month 3"
      value: "month"
    }

    allowed_value: {
      label: "Break down by quarter 3"
      value: "quarter"
    }
  }

  set: date+_set3_test{
    fields: [dayname_of_week,dayname_of_week]
  }
}

view: Dates_Test_1
{ extends: [d_dates]
  view_label: "Dates Test 2"}


view: Dates_Test_2
{ extends: [d_dates]
  view_label: "Dates Test 2"}
