enum RefreshState {
  def,
  all_data_load_finished,

  header_release_load,
  header_loading,
  header_load_finished,
  header_locked_by_footer,


  footer_release_load,
  footer_loading,
  footer_load_finished,
  footer_locked_by_header
}

enum RefresherFunc {
  load_more,
  refresh,
  bouncing,
  no_func,
}
