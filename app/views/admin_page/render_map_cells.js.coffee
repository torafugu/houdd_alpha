p = Processing.getInstanceById("edit_mini_map_cells_canvas")
p.clearMapCells()
<% unless @mini_map.blank? %>
$('#edit_mini_map_cells_mode_<%= @mini_map_edit_mode %>').attr('checked', 'checked')
p.setMapMode(<%= @mini_map_edit_mode %>)
<% @mini_map.mini_map_cells.each do |cell| %>
p.setMapCell(<%= cell.x %>, <%= cell.y %>, '<%= cell.terrain.id %>', '<%= cell.sp_resource.id unless cell.sp_resource.blank? %>', '<%= cell.construction.id unless cell.construction.blank? %>', <%= cell.capital_flg %>)
<% end %>
<% end %>