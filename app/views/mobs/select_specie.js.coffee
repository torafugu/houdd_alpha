$("#mob_specie_id").empty();
$("#mob_specie_id").html("<%= escape_javascript(options_for_select(@species)) %>");