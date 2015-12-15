$ ->
  # タグ編集モードトグル
  $('#edit_tag').click ->
    if not $(this).hasClass('on')
      $(this).addClass('on')
      $(this).text('完了')
      $('.add_tag_form').removeClass('hide');
      $('.delete-tag').removeClass('hide')
    else
      $(this).removeClass('on')
      $(this).text('タグ編集')
      $('.add_tag_form').addClass('hide');
      $('.delete-tag').addClass('hide')

  $('#add_tag_btn').click ->
    tag = $('#add_tag_text').val()
    if tag == "" or $('.tag_list').children("li[tag_name=#{tag}]").length > 0
      return

    $('#add_tag_text').val('')
    data =
      article_id: $('#edit_tag').attr('article-id')
      tag: tag
    $.post '/api/v1/tags',
      data,
      (json) =>
        $li = $('<li />').attr('tag_name', tag)
        $li.append $('<a />').attr('href', '/articles?tag=' + tag).html(tag)
        $li.append $('<a />').attr('href', '#').addClass('delete-tag').html('x')
        $('.tag_list').append($li)

  # タグ削除ボタン
  $('.delete-tag').click ->
    data =
      article_id: $('#edit_tag').attr('article-id')
      tag: $(this).attr('tag_text')
    $.ajax
      url: '/api/v1/tags'
      type: 'DELETE'
      data: data
      success: (json) =>
        $(this).parent().remove()
