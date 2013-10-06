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
      jQuery.ajax
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

$ ->
  $('[id*=level_up_road]').click ->
    if confirm("レベルアップを行いますか？")
      road_id = $(this).attr("id").replace("level_up_road_", "")
      jQuery.ajax
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
      jQuery.ajax
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

$ ->
  $('#mypage_type_sym').change ->
    $.get($('#mypage_type_sym').val() + "/select_item_category.js")

$ ->
  $('#mypage_item_category_id').change ->
    if $('#mypage_item_category_id').val() isnt ""
      $.get($('#mypage_item_category_id').val() + "/select_item_info.js")

$ ->
  $('[id*=delete_production_que]').click ->
    if confirm("取り壊しを行いますか？")
      que_id = $(this).attr("id").replace("delete_production_que_", "")
      jQuery.ajax
        url: que_id + '/delete_production_que',
        type: 'DELETE',
        dataType: 'json',
        timeout: 1000,
        error: ->
          alert("エラーが発生しました。")
        success: ->
          alert("取り壊しを開始しました。")
          window.location.reload(true)
    return false
