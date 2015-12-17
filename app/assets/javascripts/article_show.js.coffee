$ ->
  $('pre code').each (i, block) ->
    hljs.highlightBlock block
  emojify.run $('#text-preview')[0]
