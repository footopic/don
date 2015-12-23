$ ->
  article_link = [{
    match: /#([0-9]*)$/
    search: (term, callback) ->
      $.getJSON '/api/v1/articles/comp', { num: term }, (res) ->
        callback $.map res, (article) ->
          "#{article.id}: #{article.title}"
    replace: (value) ->
      [id, title] = value.split(': ')
      "[##{value}](/articles/#{id})"
    template: (value) ->
      value
    index: 1
    maxCount: 8
  }]
  $('#article_text').textcomplete article_link
  $('#template_text').textcomplete article_link
