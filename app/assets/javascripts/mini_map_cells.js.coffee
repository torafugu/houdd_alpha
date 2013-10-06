jQuery ->
  jQuery('#map_id').change ->
    window.location = "?map_id=" + jQuery("#map_id").val()
