# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

update_code= (item, user_group_id) ->
  if $("#embedded_#{item}_url").length>0 && $("#embedded_#{item}_iframe").length>0
    final_url = $("#embedded_#{item}_url").val()+'?user_group_id='+user_group_id

    if window.location.port && final_url.indexOf(window.location.host) == -1
        final_url = final_url.replace "//#{window.location.hostname}/", "//#{window.location.host}/"

    width = $("#embedded_width").val()
    height = $("#embedded_height").val()

    final_url = final_url + "&width=#{width}&height=#{height}"

    content = $("#embedded_#{item}_source").val().replace /\$URL/, final_url
    content = content.replace /\$WIDTH/, width
    content = content.replace /\$HEIGHT/, height

    $("#embedded_#{item}_iframe").attr('src', final_url)
    $("#embedded_#{item}_iframe").attr('width', width)
    $("#embedded_#{item}_iframe").attr('height', height)

    $("#embedded_#{item}_source_textarea").val(content)
    $("#embedded_#{item}_source_textarea").attr('width', width)
    $("#embedded_#{item}_source_textarea").attr('height', height)

update_all= (user_group_id) ->
  update_code('list', user_group_id)
  update_code('calendar', user_group_id)

get_user_group_id= () ->
  $('select#user_group_').val() || 0

@on_page_loaded=() ->
  update_all(0)

  $('select#user_group_').change ->
    update_all( get_user_group_id() )

  $('#embedded_width').change ->
    update_all( get_user_group_id() )

  $('#embedded_height').change ->
    update_all( get_user_group_id() )

  $('textarea.embedded').focus ->
    $(this).select()

    $(this).mouseup ->
      $(this).unbind("mouseup")
      return false
