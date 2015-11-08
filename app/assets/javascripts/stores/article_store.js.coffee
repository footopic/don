@ArticleStore = Fluxxor.createStore
  initialize: ->
    @article = null

    @bindActions(
      articleConstants.UPDATE_TEXT, @onUpdateText
    )

  onUpdateText: (playload) ->
    @article = playload.article
    @emit('change')

  getState: -> article: @article
