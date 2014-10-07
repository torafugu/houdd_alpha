# Production Queue

$ ->
  $('[id*=delete_production_queue]').click ->
    if confirm("取り壊しを行いますか？")
      queue_id = $(this).attr("id").replace("delete_production_queue_", "")
      $.ajax
        url: queue_id + '/delete_production_queue',
        type: 'DELETE',
        dataType: 'json',
        timeout: 1000,
        error: ->
          alert("エラーが発生しました。")
        success: ->
          alert("取り壊しを開始しました。")
          window.location.reload(true)
    return false

# Mini map - Construction

$ ->
  $(window).load ->
    if $('[id=edit_mini_map_constructions_canvas]')[0]?
      $.get("render_map_cells.js")

$ ->
  $('#new_construction').click ->
    if $('#update_map_cell_mapchip_id').val() isnt ""
      $.ajax
        url: 'new_construction',
        type: 'POST',
        dataType: 'json',
        timeout: 1000,
        data : $('form#update_map_cell').serialize(),
        error: ->
          alert("エラーが発生しました。")
        success: ->
          alert("建設を開始しました。")
          $.get("render_map_cells.js")

$ ->
  $('#delete_construction').click ->
    if confirm("取り壊しを行いますか？")
      $.ajax
        url: 'delete_construction',
        type: 'DELETE',
        dataType: 'json',
        timeout: 1000,
        data : $('form#update_map_cell').serialize(),
        error: ->
          alert("エラーが発生しました。")
        success: ->
          alert("取り壊しを開始しました。")
          $.get("render_map_cells.js")
    return false

# Mini map - Road

$ ->
  $('[id*=level_up_road]').click ->
    if confirm("レベルアップを行いますか？")
      road_id = $(this).attr("id").replace("level_up_road_", "")
      $.ajax
        url: road_id + '/level_up_road',
        type: 'PUT',
        dataType: 'json',
        timeout: 1000,
        error: ->
          alert("エラーが発生しました。")
        success: ->
          alert("レベルアップを開始しました。")
          window.location.reload(true)
    return false

$ ->
  $('[id*=delete_road]').click ->
    if confirm("取り壊しを行いますか？")
      road_id = $(this).attr("id").replace("delete_road_", "")
      $.ajax
        url: road_id + '/delete_road',
        type: 'DELETE',
        dataType: 'json',
        timeout: 1000,
        error: ->
          alert("エラーが発生しました。")
        success: ->
          alert("取り壊しを開始しました。")
          window.location.reload(true)
    return false

$ ->
  $('#find_new_root').click ->
    if confirm("新ルートの探索を行いますか？")
      end_mini_map_id = $.get("find_new_root.js")

# Item

$ ->
  $('#mypage_type_symbol').change ->
    if $('#mypage_type_symbol').val() isnt ""
      $.get($('#mypage_type_symbol').val() + "/select_item_type.js")

$ ->
  $('#mypage_inv_type_symbol').change ->
    if $('#mypage_inv_type_symbol').val() isnt ""
      $.get($('#mypage_inv_type_symbol').val() + "/show_inv_items.js")

# Mob

$ ->
  $('#my_page_family_id').change ->
    if $('#my_page_family_id').val() isnt ""
      $.get($('#my_page_family_id').val() + "/select_specie.js")

$ ->
  $('#mypage_specie_id').change ->
    if $('#mypage_specie_id').val() isnt ""
      $.get($('#mypage_specie_id').val() + "/show_mobs.js")

# Squad

$ ->
  $('#new_squad').click ->
    window.location = "new_squad"

$ ->
  $('#my_page_job_id').change ->
    if $('#my_page_job_id').val() isnt ""
      $.get($('#my_page_job_id').val() + "/select_mobs_to_assign.js")

$ ->
  $('#btn_mob_move_right').click ->
    if $('#my_page_free_mobs').val() is null
      alert('移動するMOBを選択してください。')
    else
      $('#my_page_free_mobs').each ->
        $('option:selected', this).each ->
          $('#my_page_assigned_mobs').append($('<option value="' + $(this).val() + '">' + $(this).text() + '</option>'))
          $(this).remove()

$ ->
  $('#btn_mob_move_left').click ->
    if $('#my_page_assigned_mobs').val() is null
      alert('移動するMOBを選択してください。')
    else
      $('#my_page_assigned_mobs').each ->
        $('option:selected', this).each ->
          $('#my_page_free_mobs').append($('<option value="' + $(this).val() + '">' + $(this).text() + '</option>'))
          $(this).remove()

$ ->
  $('#btn_new_squad').click ->
    selected_assigned_mobs_ids = new Array()
    $('#my_page_assigned_mobs option:not(:selected)').each ->
      selected_assigned_mobs_ids.push(this.value)
    $('#my_page_assigned_mobs').val(selected_assigned_mobs_ids)
    $("form").trigger("submit")
    return false

$ ->
  $('#btn_update_squad').click ->
    selected_assigned_mobs_ids = new Array()
    $('#my_page_assigned_mobs option:not(:selected)').each ->
      selected_assigned_mobs_ids.push(this.value)
    $('#my_page_assigned_mobs').val(selected_assigned_mobs_ids)
    $("form").trigger("submit")
    return false

# Mission

$ ->
  $('#mypage_mission_completed_false').click ->
    window.location = "/my_page/" + $('#mypage_houdd_user_id').val() + "/0/mission_index"

$ ->
  $('#mypage_mission_completed_true').click ->
    window.location = "/my_page/" + $('#mypage_houdd_user_id').val() + "/1/mission_index"

$ ->
  $('#new_mission').click ->
    window.location = "new_mission"

$ ->
  $('#btn_squad_move_right').click ->
    if $('#my_page_free_squads').val() is null
      alert('移動する部隊を選択してください。')
    else
      $('#my_page_free_squads').each ->
        $('option:selected', this).each ->
          $('#my_page_assigned_squads').append($('<option value="' + $(this).val() + '">' + $(this).text() + '</option>'))
          $(this).remove()

$ ->
  $('#btn_squad_move_left').click ->
    if $('#my_page_assigned_squads').val() is null
      alert('移動する部隊を選択してください。')
    else
      $('#my_page_assigned_squads').each ->
        $('option:selected', this).each ->
          $('#my_page_free_squads').append($('<option value="' + $(this).val() + '">' + $(this).text() + '</option>'))
          $(this).remove()

$ ->
  $('#btn_new_mission').click ->
    selected_assigned_squads_ids = new Array()
    $('#my_page_assigned_squads option:not(:selected)').each ->
      selected_assigned_squads_ids.push(this.value)
    $('#my_page_assigned_squads').val(selected_assigned_squads_ids)
    $("form").trigger("submit")
    return false

$ ->
  $('#btn_update_mission').click ->
    selected_assigned_squads_ids = new Array()
    $('#my_page_assigned_squads option:not(:selected)').each ->
      selected_assigned_squads_ids.push(this.value)
    $('#my_page_assigned_squads').val(selected_assigned_squads_ids)
    $("form").trigger("submit")
    return false
$ ->
  $('#first_trial_move_turn').click ->
    int_current_trial_move_turn = parseInt($('#current_trial_move_turn').text())
    if int_current_trial_move_turn > 1
      window.location = "/my_page/" + $('#mypage_houdd_user_id').val() + "/" + $('#mypage_mission_id').val() + "/" + $('#mypage_trial_id').val() + "/1/mission_result"

$ ->
  $('#previous_trial_move_turn').click ->
    int_current_trial_move_turn = parseInt($('#current_trial_move_turn').text())
    if int_current_trial_move_turn > 1
      window.location = "/my_page/" + $('#mypage_houdd_user_id').val() + "/" + $('#mypage_mission_id').val() + "/" + $('#mypage_trial_id').val() + "/" + (int_current_trial_move_turn - 1) + "/mission_result"

$ ->
  $('#next_trial_move_turn').click ->
    int_current_trial_move_turn = parseInt($('#current_trial_move_turn').text())
    if int_current_trial_move_turn < parseInt($('#max_trial_move_turn').text())
      window.location = "/my_page/" + $('#mypage_houdd_user_id').val() + "/" + $('#mypage_mission_id').val() + "/" + $('#mypage_trial_id').val() + "/" + (int_current_trial_move_turn + 1) + "/mission_result"

$ ->
  $('#last_trial_move_turn').click ->
    int_current_trial_move_turn = parseInt($('#current_trial_move_turn').text())
    if int_current_trial_move_turn < parseInt($('#max_trial_move_turn').text())
      window.location = "/my_page/" + $('#mypage_houdd_user_id').val() + "/" + $('#mypage_mission_id').val() + "/" + $('#mypage_trial_id').val() + "/" + $('#max_trial_move_turn').text() + "/mission_result"

$ ->
  $('#first_battle_turn').click ->
    int_current_battle_set = parseInt($('#current_battle_set').text())
    int_current_battle_turn = parseInt($('#current_battle_turn').text())
    if int_current_battle_turn > 1
      jQuery('#current_battle_turn').text(1)
      jQuery.get(int_current_battle_set + "/1/select_battle_turn.js")

$ ->
  $('#previous_battle_turn').click ->
    int_current_battle_set = parseInt($('#current_battle_set').text())
    int_current_battle_turn = parseInt($('#current_battle_turn').text())
    if int_current_battle_turn > 1
      int_next_battle_turn = int_current_battle_turn - 1
      jQuery('#current_battle_turn').text(int_next_battle_turn)
      jQuery.get(int_current_battle_set + "/" + int_next_battle_turn + "/select_battle_turn.js")

$ ->
  $('#next_battle_turn').click ->
    int_current_battle_set = parseInt($('#current_battle_set').text())
    int_current_battle_turn = parseInt($('#current_battle_turn').text())
    if int_current_battle_turn < parseInt($('#max_battle_turn').text())
      int_next_battle_turn = int_current_battle_turn + 1
      jQuery('#current_battle_turn').text(int_next_battle_turn)
      jQuery.get(int_current_battle_set + "/" + int_next_battle_turn + "/select_battle_turn.js")

$ ->
  $('#last_battle_turn').click ->
    int_current_battle_set = parseInt($('#current_battle_set').text())
    int_current_battle_turn = parseInt($('#current_battle_turn').text())
    if int_current_battle_turn < parseInt($('#max_battle_turn').text())
      jQuery('#current_battle_turn').text($('#max_battle_turn').text())
      jQuery.get(int_current_battle_set + "/" + $('#max_battle_turn').text() + "/select_battle_turn.js")

# Strategy

$ ->
  $('#new_strategy').click ->
    window.location = "new_strategy"
