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

  tag_regex = /[#＃]+[A-Za-z0-9-_ぁ-ヶ亜-黑ー%{}]+/g

  updatePreview = ->
    # NOTE: marked で xss escape 済みで返る
    $text_preview.html marked($text_edit.val())
    # code hilighting
    $('pre code').each (i, block) ->
      hljs.highlightBlock block
    # 絵文字
    emojify.run $text_preview[0]

  updateTitlePreview = ->
    title = $pre_title.val()
    # タグ削除とりだし
    tags = title.match(tag_regex)
    if tags
      htags = tags.map((tag) -> tag.replace('#', ''))
      $tag_edit.val(htags.join(','))
      $tags_preview.empty()
      $.each htags, (i, v) ->
        $tags_preview.append($('<li/>').append($('<span/>').text(v)))
    else
      $tag_edit.val('')
      $tags_preview.val()

    # タグ削除と前後の空白削除
    title = title.replace(tag_regex, '').replace(/^\s+|\s+$/g,'')
    $title_preview.text title
    $title.val(title)
    # 絵文字
    emojify.run $title_preview[0]

  if !$pre_title.length or !$text_edit.length
    return
  l = localStorage

  syncFromForm = ->
    # カンマ区切りのタグリストをタイトル末尾のフォーマットに
    tags = ''
    tagval = $tag_edit.val()
    if tagval
      tags = tagval.split(',').map((tag) -> " ##{tag}").join('')
    $pre_title.val $title.val() + tags

  if $title.val()
    syncFromForm()

  # // ローカルストレージに保存されていたら復元
  if $text_edit.val() == '' and l.getItem('text') != null
    text = l.getItem('text')
    $text_edit.val text
  if $pre_title.val() == '' and $pre_title.length and l.getItem('title') != null
    $pre_title.val l.getItem('title')

  updatePreview()
  updateTitlePreview()

  nosave_check = ->
    # 移動した時は消す
    l.removeItem 'text'
    l.removeItem 'title'
    # 移動しなかった場合は戻す
    setTimeout =>
      l.setItem 'text', $(this).val()
      l.setItem 'title', $(this).val()
    , 1000
    '編集内容が保存されていません。このまま移動しますか？'

  # 変更をマークダウンにしプレビューに反映する
  $text_edit.keyup ->
    $(window).on 'beforeunload', nosave_check
    l.setItem 'text', $(this).val()
    updatePreview()
  $pre_title.keyup ->
    $(window).on 'beforeunload', nosave_check
    l.setItem 'title', $(this).val()
    updateTitlePreview()

  insertAtCaret = (target, str) ->
    target.focus()
    if navigator.userAgent.match(/MSIE/)
      r = document.selection.createRange()
      r.text = str
      r.select()
    else
      s = target.val()
      p = target.get(0).selectionStart
      np = p + str.length
      target.val(s.substr(0, p) + str + s.substr(p))
      target.get(0).setSelectionRange(np, np)

  insertImgMd = (url) ->
    target = $text_edit
    img_md = "![#{url}](#{url})\n"
    insertAtCaret(target, img_md)
    updatePreview()

  $submit_btn.click ->
    # TODO: validation check
    $(window).off('beforeunload')
    l.removeItem 'text'
    l.removeItem 'title'

  $('#upload-btn').click ->
    # NOTE: なんで二回呼ばれることがあるの, mac, chrome
    $input_file[0].click()
    return false

  $input_file.change ->
    # fd = new FormData($('form')[0])
    if $(@).files < 1
      return
    file = $(@)[0].files[0]
    if file.clientHeight > 2000 or file.clientWidth > 2000
      alert '画像アップロードでエラーが発生しました 画像サイズが大きいです'
      return

    fd = new FormData()
    fd.append('name', 'jquery test')
    # fd.append('file', 'hoge')
    fd.append('file', file)

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
      error: (json) ->
        # TODO: エラー
        alert '画像アップロードでエラーが発生しました'
    $input_file.val('')

  # template manage

  setup_template_dropdown = (articles) ->
    $dropdown_list.empty()
    $.each articles, ->
      $a = $('<a/>').text(@title).click =>
        $title.val(@title)
        # console.log @tags
        $tag_edit.val(@tags.join(','))
        syncFromForm()
        updateTitlePreview()
        $text_edit.val(@text)
        updatePreview()
      $li = $('<li/>').append($a)
      $dropdown_list.append($li)

  $.ajax
    url: '/api/v1/templates'
    method: "GET"
    data: 'me=' + $('#current-user-info').attr('screen_name') +
          '&name=' + $('#current-user-info').attr('name')
    processData: false
    contentType: false
    success: (json) ->
      setup_template_dropdown(json.articles)
    error: (json) ->
      alert '画像アップロードでエラーが発生しました'
