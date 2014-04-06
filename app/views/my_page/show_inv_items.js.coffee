$('tbody tr').remove()
<% @inv_items.each do |item| %>
item_row = '<tr><td><%= item.item_info.name %></td>'
item_row += '<td><div class="number"><%= item.item_info.max_dp %>/<%= item.dp %></div></td>'
item_row += '<td><div class="number"><%= item.quality_txt %></div></td>'
item_row += '<td><%= item.status %></td>'
item_row += '<td>廃棄 修理</td></tr>'
$('tbody').append(item_row)
<% end %>
