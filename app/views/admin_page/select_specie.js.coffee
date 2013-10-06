$('tbody tr').remove()
<% @species.each do |specie| %>
specie_row = '<tr><td><%= hidden_field_tag("adminpage[][specie_id]", specie.id) %><%= specie.name %></td>'
specie_row += '<td><div class="number"></div></td>'
specie_row += '<td><div class="number"></div></td>'
specie_row += '<td><div class="number"></div></td>'
specie_row += '<td><div class="number"></div></td>'
specie_row += '<td><%= link_to 'シードMOB管理', specie.id.to_s + '/edit_seed_mobs' %> <%= link_to '突然変異率設定', specie.id.to_s + '/edit_mutation_rate' %></td></tr>'
$('tbody').append(specie_row)
<% end %>
