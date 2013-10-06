$ ->
  $(window).load ->
    if $('[id=edit_mini_map_cells_canvas]')[0]?
      $.get("1/render_map_cells.js")

$ ->
  $('[id*=edit_mini_map_cells]').change ->
    $.get($(this).val() + "/render_map_cells.js")

$ ->
  $('#update_map_cell_btn').click ->
    if $('input[name="edit_mini_map_cells[mode]"]:checked').val() isnt '1' or $('#update_map_cell_mapchip_id').val() isnt ""
      $.ajax
        url: $('input[name="edit_mini_map_cells[mode]"]:checked').val() + '/' + $('form#update_map_cell').attr('action'),
        type: 'PUT',
        dataType: 'json',
        timeout: 10000,
        data : $('form#update_map_cell').serialize(),
        error: ->
          alert("エラーが発生しました。")
        success: ->
          alert("セルの変更が完了しました。")
          $.get($('input[name="edit_mini_map_cells[mode]"]:checked').val() + "/render_map_cells.js")

$ ->
  $('[id*=link_to_generate_map_cells]').click ->
    if confirm("セルの自動生成を行いますか？")
      map_id = $(this).attr("id").replace("link_to_generate_map_cells_", "")
      $.ajax
        url: map_id + '/generate_mini_map_cells',
        type: 'POST',
        dataType: 'json',
        timeout: 20000,
        error: ->
          alert("エラーが発生しました。")
        success: ->
          alert("セルの生成が完了しました。")
          window.location.reload(true)
    return false

$ ->
  $('#add_row_of_road').click ->
    $.get("add_row_of_road.js")

$ ->
  $('[id*=delete_road]').click ->
    if confirm("道路の削除を行いますか？")
      road_id = $(this).attr("id").replace("delete_road_", "")
      jQuery.ajax
        url: road_id + "/delete_road",
        type: 'DELETE',
        dataType: 'json',
        timeout: 1000,
        error: ->
          alert("エラーが発生しました。")
        success: ->
          alert("削除が完了しました。")
          window.location.reload(true)
    return false

$ ->
  $('[id*=link_to_generate_fortress_cells]').click ->
    if confirm("要塞セルの自動生成を行いますか？")
      map_id = $(this).attr("id").replace("link_to_generate_fortress_cells_", "")
      $.ajax
        url: map_id + '/generate_fortress_cells',
        type: 'POST',
        dataType: 'json',
        timeout: 20000,
        error: ->
          alert("エラーが発生しました。")
        success: ->
          alert("セルの生成が完了しました。")
          window.location.reload(true)
    return false

$ ->
  $('[id*=my_page_family_id]').change ->
    $.get($(this).val() + "/select_specie.js")