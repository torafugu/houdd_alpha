$('tbody tr').remove()
<% @mobs.each do |mob| %>
item_row = '<tr><td><%= mob.name %></td>'
item_row += '<td><div class="number"><%= mob.age %></div></td>'
item_row += '<td><%= mob.gender_sym_txt %></td>'
item_row += '<td><%= mob.job.name %></td>'
item_row += '<td><%= mob.con %>/<%= mob.hp %></td>'
item_row += '<td><%= mob.int %>/<%= mob.sp %></td>'
item_row += '<td><%= mob.squad.name unless mob.squad.blank? %></td>'
item_row += '<td><%= link_to mob.equipped_items_txt, mob.id.to_s + "/edit_mob_equips" %></td></tr>'
$('tbody').append(item_row)
<% end %>
