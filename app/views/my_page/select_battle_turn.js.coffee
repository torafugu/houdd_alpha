p2 = Processing.getInstanceById("trial_result_tactical_canvas")
<% unless @current_battle_turn.blank? %>
$('#battle_log').text("<%= escape_javascript(@current_battle_turn.log) %>")
<% @current_battle_turn.trial_mob_statuses.each do |trial_mob_status| %>
p2.updateMob(<%= trial_mob_status.trial_mob_id %>, <%= trial_mob_status.vpos %>, <%= trial_mob_status.dead? %>, <%= trial_mob_status.just_dead? %>)
<% end %>
<% end %>