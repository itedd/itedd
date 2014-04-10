# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

update_code= (user_group_id) ->
  if $('.embedded_url').length>0 && $('.embedded_iframe_code').length>0
    final_url = $('.embedded_url').val()+'?user_group_id='+user_group_id
    content = $('.embedded_iframe_code').val().replace /\$URL/, final_url

    $('iframe').attr('src', final_url)
    $('.embedded_iframe_code_final').val(content)

$ ->
  update_code(0)

  $('select#user_group').change ->
    update_code( $(this).val() )

  $('.embedded_iframe_code_final').focus ->
    $(this).select()

    $(this).mouseup ->
      $(this).unbind("mouseup")
      return false