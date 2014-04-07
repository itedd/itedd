$ ->
  $('select#user_user_group_id').change ->
    if $(this).val()==''
      $('#nested_user_group').show()
    else
      $('#nested_user_group').hide()

