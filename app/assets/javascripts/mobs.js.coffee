$ ->
  $('#user_id').change ->
    if $('#user_id').val() isnt ""
      $.get('/mobs/' + $('#user_id').val() + "/select_specie.js")

$ ->
  $('#mobs_search').click ->
    user_id = $('#user_id').val()
    if user_id is ""
      user_id = '0'
    specie_id = $('#mob_specie_id').val()
    if specie_id is ""
      specie_id = '0'
    window.location = '/mobs/' + user_id + '/' + specie_id + '/index'
