$ ->
  $('#comment_text').keydown (e) ->
    if (e.ctrlKey && e.keyCode == 13)
      $('#new_comment').submit()
