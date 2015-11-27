$ ->
  $text_preview = $('#text-preview')
  $text_raw = $('#text-raw')
  if $text_raw.length > 0 and $text_preview.length > 0
    $text_preview.html marked($text_raw.html())
    $('pre code').each (i, block) ->
      hljs.highlightBlock block
      return
    emojify.run $text_preview[0]
  return
