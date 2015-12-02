$ ->
  $file_form = $('#user_image')
  $img_icon = $('#img-user-icon')

  if not $file_form.length or not $img_icon.length
    return

  $file_form.change ->
    return if not $file_form[0].files.length
    file = $file_form[0].files[0];
    return if (!/^image\/(png|jpeg|gif)$/.test(file.type))

    fr = new FileReader()
    fr.onload = ->
      fr.result
      $img_icon.attr('src', fr.result)
    fr.readAsDataURL(file)
