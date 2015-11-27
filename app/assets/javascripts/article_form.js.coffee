$ ->
  $title = $('#article_title')
  $text_edit = $('#article_text')
  $categories_preview = $('#categories-preview')
  $title_preview = $('#title-preview')
  $text_preview = $('#text-preview-area')
  $submit_btn = $('#btn-submit')

  updatePreview = ->
    # NOTE: marked で xss escape 済みで返る
    $text_preview.html marked($text_edit.val())
    # code hilighting
    $('pre code').each (i, block) ->
      hljs.highlightBlock block
      return
    # 絵文字
    emojify.run $text_preview[0]
    return

  updateTitlePreview = ->
    words = $title.val().split('/')
    title = words.pop()
    categories_text = words.join('/')
    $title_preview.text title
    $categories_preview.text categories_text
    # 絵文字
    emojify.run $title_preview[0]
    return

  if !$title.length or !$text_edit.length
    return
  l = localStorage

  # // ローカルストレージに保存されていたら復元
  if $text_edit.val() == '' and l.getItem('text') != null
    text = l.getItem('text')
    $text_edit.val text
  if $title.val() == '' and $title.length and l.getItem('title') != null
    $title.val l.getItem('title')

  updatePreview()
  updateTitlePreview()

  # 変更をマークダウンにしプレビューに反映する
  $text_edit.keyup ->
    l.setItem 'text', $(this).val()
    updatePreview()
    return
  $title.keyup ->
    l.setItem 'title', $(this).val()
    updateTitlePreview()
    return

  $submit_btn.click ->
    # TODO: validation check
    l.removeItem 'text'
    l.removeItem 'title'
    return
  return
