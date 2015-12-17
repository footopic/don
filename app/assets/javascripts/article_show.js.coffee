$ ->
  if $('#text-preview').length > 0 and $('#text-preview').attr('raw_text')
    $('#text-preview').html marked($('#text-preview').attr('raw_text'))
    $('pre code').each (i, block) ->
      hljs.highlightBlock block
      return
    emojify.run $('#text-preview')[0]
  return
