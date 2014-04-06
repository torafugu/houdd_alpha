$("#mypage_specie_id").empty();
$("#mypage_specie_id").html("<%= escape_javascript(options_for_select(@species)) %>");