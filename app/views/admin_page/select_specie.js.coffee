$('tbody tr').remove()
<% @species.each do |specie| %>
specie_row = '<tr><td><%= hidden_field_tag("adminpage[][specie_id]", specie.id) %><%= specie.name %></td>'
specie_row += '<td><div class="number"></div></td>'
specie_row += '<td><div class="number"></div></td>'
specie_row += '<td><div class="number"></div></td>'
specie_row += '<td><div class="number"></div></td>'
specie_row += '<td><%= link_to 'シードMOB追加', specie.id.to_s + '/new_seed_mobs' %> <%= link_to '突然変異率設定', specie.id.to_s + '/edit_mutation_rate' %><br />'
specie_row += '<%= link_to '新規MOB配属', specie.id.to_s + '/assign_new_mobs' %> '
<% if specie.family.asexual_flg %>
specie_row += '<%= link_to 'MOB分裂', specie.id.to_s + '/split_new_mobs' %>'
<% else %>
specie_row += '<%= link_to 'MOB交配', specie.id.to_s + '/mate_new_mobs' %>'
<% end %>
specie_row += '<br /></td></tr>'
$('tbody').append(specie_row)
<% end %>
