$ ->
  username_comp = [{
    match: /@([^\s]*)$/
    search: (term, callback) ->
      $.getJSON '/api/v1/users/comp', { q: term }, (res) ->
        callback res
    replace: (user) ->
      "[@#{user.screen_name}](/#{user.screen_name})"
    template: (user) ->
      console.log user
      '<img src="' + user.thumb_url + '" />' + user.screen_name
    index: 1
    maxCount: 8
  }]
  $('#article_text').textcomplete username_comp
  $('#template_text').textcomplete username_comp
  $('#comment_text').textcomplete username_comp
