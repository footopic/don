@ArticleActions =
  updateText: (text) ->
    @dispatch(articleConstants.UPDATE_TEXT, text: text)