stores =
  ArticleStore: new ArticleStore()

flux = new Fluxxor.Flux(stores, ArticleActions)

FluxMixin = Fluxxor.FluxMixin(React)
StoreWatchMixin = Fluxxor.StoreWatchMixin

Article = React.createClass
  mixins: [FluxMixin]

#  propTypes:
#    article: React.PropTypes.object.isRequired

  render: ->
    value = 'Loading...'
    console.log @props
    if @props.article
      value = @props.article.text
    `<textarea value={value}></textarea>`


Application = React.createClass
  mixins: [FluxMixin, StoreWatchMixin('ArticleStore')]

  loadArticleFromServer: ->
    # TODO: ajax
    article =
      title: 'test title'
      text: '''#hoge
**hoge**
piyo

* list
* item
* test
'''
    @setState(article: article)

  getInitialState: ->
    # article: null

  getStateFromFlux: ->
    flux = @getFlux()
    flux.store('ArticleStore').getState()

  componentDidMount: ->
    # NOTE: this.isMounted()
    @loadArticleFromServer()
    setInterval @loadArticleFromServer, @props.pollInterval

  render: ->
    article = @state.article
    `<div>
        <Article article={article} />
    </div>`
    console.log('load server')
