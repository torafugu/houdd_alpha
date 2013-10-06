$('tbody tr').remove()
<% @item_infos.each do |item_info| %>
product_item_row = '<tr><td><%= hidden_field_tag("mypage[][item_info_id]", item_info.id) %><%= item_info.item_category.name %></td>'
product_item_row += '<td><%= item_info.name %></td>'
product_item_row += '<td><div class="number"><%= item_info.research_level %></div></td>'
product_item_row += '<td><div class="number"><%= item_info.rq_prod_point %></div></td>'
product_item_row += '<td><%= item_info.rq_sp_resource_txt %></td>'
product_item_row += '<td><%= text_field_tag "mypage[][production_volume]",'',:class=>'number3' %></td></tr>'
$('tbody').append(product_item_row)
<% end %>
