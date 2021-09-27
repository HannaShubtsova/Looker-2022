- dashboard: test
  title: test
  layout: newspaper
  preferred_viewer: dashboards-next
  refresh: 1 hour
  elements:
  - title: Untitled
    name: Untitled
    model: demo_preparation_hanna_shubtsova
    explore: order_items
    type: single_value
    fields: [order_items.count_conitional_format, order_items.item_return_rate]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    series_types: {}
    note_state: collapsed
    note_display: hover
    note_text: Here could be a text
    listen:
      Created Date: order_items.created_date
      Distribution center name: distribution_centers.name
    row: 0
    col: 5
    width: 5
    height: 3
  - title: Untitled
    name: Untitled (2)
    model: demo_preparation_hanna_shubtsova
    explore: order_items
    type: looker_grid
    fields: [products.brand, products.category, products.name, products.sku_link_to,
      products.cost]
    sorts: [products.brand]
    limit: 500
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    defaults_version: 1
    listen:
      Created Date: order_items.created_date
      Distribution center name: distribution_centers.name
    row: 3
    col: 8
    width: 16
    height: 6
  - title: Untitled
    name: Untitled (3)
    model: demo_preparation_hanna_shubtsova
    explore: order_items
    type: single_value
    fields: [order_items.average_spend_per_customer]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    series_types: {}
    listen:
      Created Date: order_items.created_date
      Distribution center name: distribution_centers.name
    row: 0
    col: 0
    width: 5
    height: 3
  - title: Time trend
    name: Time trend
    model: demo_preparation_hanna_shubtsova
    explore: order_items
    type: looker_area
    fields: [order_items.created_date, order_items.total_gross_margin_amount, order_items.total_gross_revenue]
    fill_fields: [order_items.created_date]
    sorts: [order_items.total_gross_margin_amount desc]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types:
      order_items.total_gross_margin_amount: column
    defaults_version: 1
    listen:
      Created Date: order_items.created_date
      Distribution center name: distribution_centers.name
    row: 3
    col: 0
    width: 8
    height: 6
  - title: Untitled
    name: Untitled (4)
    model: demo_preparation_hanna_shubtsova
    explore: order_items
    type: single_value
    fields: [order_items.Gross_Margin_Percent]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    defaults_version: 1
    listen:
      Created Date: order_items.created_date
      Distribution center name: distribution_centers.name
    row: 0
    col: 10
    width: 5
    height: 3
  - title: Count - Return Rate
    name: Count - Return Rate
    model: demo_preparation_hanna_shubtsova
    explore: order_items
    type: looker_grid
    fields: [order_items.count, order_items.count_returns, order_items.item_return_rate]
    limit: 500
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    ordering: none
    show_null_labels: false
    listen:
      Created Date: order_items.created_date
      Distribution center name: distribution_centers.name
    row: 0
    col: 15
    width: 9
    height: 3
  - title: Pie chart
    name: Pie chart
    model: demo_preparation_hanna_shubtsova
    explore: order_items
    type: looker_pie
    fields: [products.brand, order_items.Gross_Margin_Percent]
    filters:
      products.brand: adidas,"Levi's",PUMA
    sorts: [order_items.Gross_Margin_Percent desc, products.brand]
    limit: 500
    value_labels: legend
    label_type: labPer
    series_types: {}
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    defaults_version: 1
    show_value_labels: true
    font_size: 12
    show_row_numbers: true
    truncate_column_names: false
    hide_totals: false
    hide_row_totals: false
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    listen: {}
    row: 9
    col: 0
    width: 8
    height: 6
  - title: Untitled (Copy)
    name: Untitled (Copy)
    model: demo_preparation_hanna_shubtsova
    explore: order_items
    type: single_value
    fields: [order_items.count_conitional_format]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    series_types: {}
    note_state: collapsed
    note_display: hover
    note_text: Here could be a text
    listen:
      Created Date: order_items.created_date
      Distribution center name: distribution_centers.name
    row: 9
    col: 8
    width: 8
    height: 6
  filters:
  - name: Created Date
    title: Created Date
    type: field_filter
    default_value: 7 day
    allow_multiple_values: true
    required: false
    ui_config:
      type: relative_timeframes
      display: inline
      options: []
    model: demo_preparation_hanna_shubtsova
    explore: order_items
    listens_to_filters: []
    field: order_items.created_date
  - name: Distribution center name
    title: Distribution center name
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: dropdown_menu
      display: inline
      options: []
    model: demo_preparation_hanna_shubtsova
    explore: order_items
    listens_to_filters: []
    field: distribution_centers.name
