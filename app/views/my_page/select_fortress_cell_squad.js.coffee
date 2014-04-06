<% unless @fortress_cell.blank? %>
<% if @fortress_cell.squad_id.blank? %>
$("#update_fortress_cell_squad_id").val("")
<% else %>
$("#update_fortress_cell_squad_id").val("<%= @fortress_cell.squad_id %>")
<% end %>
<% end %>
