<% if @end_mini_map_id.blank? %>
alert("新ルートの探索に失敗しました")
<% else %>
$ ->
  $.ajax
    url: <%= @end_mini_map_id %> + '/new_road',
    type: 'POST',
    dataType: 'json',
    timeout: 1000,
    error: ->
      alert("エラーが発生しました。")
    success: ->
      alert("新ルートの建設を開始しました。")
      window.location.reload(true)
<% end %>


