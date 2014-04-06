<% unless @fortress_cell.blank? %>
<% if @fortress_cell.trap_id.blank? %>
$("#update_fortress_cell_trap_id").val("")
<% else %>
$("#update_fortress_cell_trap_id").val("<%= @fortress_cell.trap_id %>")
<% end %>
<% end %>
