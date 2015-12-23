$ ->
  article_link = [{
    match: /#([^\s]*)$/
    search: (term, callback) ->
      $.getJSON '/api/v1/articles/comp', { q: term }, (res) ->
        callback $.map res, (article) ->
          "#{article.id}: #{article.title}"
    replace: (value) ->
      [id, title] = value.split(': ')
      "[##{value}](/articles/#{id})"
    template: (value) ->
      # HTML エスケープ
      value = $('<div>').text(value).html()
      value
    index: 1
    maxCount: 8
  }]
  $('#article_text').textcomplete article_link
  $('#template_text').textcomplete article_link
