$ ->
  # タグ編集モードトグル
  $('#edit_tag').click ->
    if not $(this).hasClass('on')
      $(this).addClass('on')
      $(this).text('完了')
      $('.delete-tag').removeClass('hide')
    else
      $(this).removeClass('on')
      $(this).text('タグ編集')
      $('.delete-tag').addClass('hide')

  # タグ削除ボタン
  $('.delete-tag').click ->
    data =
      article_id: $('#edit_tag').attr('article-id')
      tag: $(this).attr('tag_text')
    $.ajax
      url: '/api/v1/tags'
      type: 'DELETE'
      data: data
      success: (json) ->
        for val in json
          console.log val
          $li = $('<a />').attr()
          # concat content_tag(:a, tag.name, href: articles_path(tag: tag.name))
          # concat content_tag(:a, 'x', href: '#', class: 'delete-tag hide', tag_text: tag.name)
          $('.tag_list').append()
    $(this).parent().remove()
