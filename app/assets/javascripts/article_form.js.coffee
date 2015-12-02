$ ->
  $title = $('#article_title')
  $pre_title = $('#pre_article_title')
  $text_edit = $('#article_text')
  $tag_edit = $('#article_tag_list')

  $tags_preview = $('#tags-preview')
  $title_preview = $('#title-preview')
  $text_preview = $('#text-preview-area')
  $submit_btn = $('#btn-submit')

  $input_file = $('#async-image-data')
  $dropdown_list = $('#templates-dropdown-list')

  tag_regex = /[#＃]+[A-Za-z0-9-_ぁ-ヶ亜-黑]+/g

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
    title = $pre_title.val()
    # タグ削除とりだし
    tags = title.match(tag_regex)
    if tags
      htags = tags.map((tag) -> tag.replace('#', ''))
      $tag_edit.val(htags.join(','))
      $tags_preview.empty()
      $.each tags, (i, v) ->
        $tags_preview.append($('<li/>').text(v))
    else
      $tag_edit.val('')
      $tags_preview.val()

    # タグ削除と前後の空白削除
    title = title.replace(tag_regex, '').replace(/^\s+|\s+$/g,'')
    $title_preview.text title
    $title.val(title)
    # 絵文字
    emojify.run $title_preview[0]
    return

  if !$pre_title.length or !$text_edit.length
    return
  l = localStorage

  if $title.val()
    # カンマ区切りのタグリストをタイトル末尾のフォーマットに
    tags = ''
    tagval = $tag_edit.val()
    if tagval
      tags = tagval.split(',').map((tag) -> " ##{tag}").join('')
    $pre_title.val $title.val() + tags

  # // ローカルストレージに保存されていたら復元
  if $text_edit.val() == '' and l.getItem('text') != null
    text = l.getItem('text')
    $text_edit.val text
  if $pre_title.val() == '' and $pre_title.length and l.getItem('title') != null
    $pre_title.val l.getItem('title')

  updatePreview()
  updateTitlePreview()

  # 変更をマークダウンにしプレビューに反映する
  $text_edit.keyup ->
    l.setItem 'text', $(this).val()
    updatePreview()
    return
  $pre_title.keyup ->
    l.setItem 'title', $(this).val()
    updateTitlePreview()
    return

  insertAtCaret = (target, str) ->
    target.focus()
    if navigator.userAgent.match(/MSIE/)
      r = document.selection.createRange()
      r.text = str
      r.select()
      return
    else
      s = target.val()
      p = target.get(0).selectionStart
      np = p + str.length
      target.val(s.substr(0, p) + str + s.substr(p))
      target.get(0).setSelectionRange(np, np)
      return

  insertImgMd = (url) ->
    target = $text_edit
    img_md = "![#{url}](#{url})\n"
    insertAtCaret(target, img_md)
    updatePreview()

  $submit_btn.click ->
    # TODO: validation check
    l.removeItem 'text'
    l.removeItem 'title'
    return

  $('#upload-btn').click ->
    # NOTE: なんで二回呼ばれることがあるの, mac, chrome
    $input_file[0].click()
    return false

  $input_file.change ->
    # fd = new FormData($('form')[0])
    if $(@).files < 1
      return

    fd = new FormData()
    fd.append('name', 'jquery test')
    # fd.append('file', 'hoge')
    fd.append('file', $(@)[0].files[0])

    # curl -X POST -F "name=curl_test" -F "file=@co01.png" localhost:3000/api/v1/upload_files/upload
    $.ajax
      url: '/api/v1/upload_files/upload'
      method: "POST"
      data: fd
      processData: false
      contentType: false
      success: (json) ->
        url = json.file.url
        insertImgMd(url)
        return
      error: (json) ->
        # TODO: エラー
        alert '画像アップロードでエラーが発生しました'
        return
    $input_file.val('')
    return

  # template manage

  setup_template_dropdown = (articles) ->
    $dropdown_list.empty()
    $.each articles, ->
      $a = $('<a/>').text(@title).click =>
        $pre_title.val(@title)
        updateTitlePreview()
        # HACK:
        tags_tmp = []
        $.each @tags, ->
          if String(@) != 'template'
            tags_tmp.push(@)
        $tag_edit.val(tags_tmp.join(','))
        $text_edit.val(@text)
        updatePreview()
        return
      $li = $('<li/>').append($a)
      $dropdown_list.append($li)
      return
    return

  $.ajax
    url: '/api/v1/articles'
    method: "GET"
    data: 'tags=template'
    processData: false
    contentType: false
    success: (json) ->
      setup_template_dropdown(json.articles)
      return
    error: (json) ->
      alert '画像アップロードでエラーが発生しました'
      return

  return
