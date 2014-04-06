$("#my_page_free_mobs").empty();
$("#my_page_free_mobs").html("<%= escape_javascript(options_for_select(@free_mobs)) %>");