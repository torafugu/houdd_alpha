p = Processing.getInstanceById("edit_mini_map_constructions_canvas")
p.clearMapCells()
<% unless @mini_map.blank? %>
<% @mini_map.mini_map_cells.each do |cell| %>
p.setMapCell(<%= cell.x %>, <%= cell.y %>, '<%= cell.terrain.id %>', '<%= cell.construction_id unless cell.construction.blank? %>', <%= cell.active_flg %>, <%= cell.capital_flg %>)
<% end %>
<% end %>