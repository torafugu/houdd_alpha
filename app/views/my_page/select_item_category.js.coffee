$("#mypage_item_category_id").empty();
$("#mypage_item_category_id").html("<%= escape_javascript(options_for_select(@item_categories)) %>");