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
    console.log('load server')
    @setState(article: article)

  getInitialState: ->
    # article: null

  getStateFromFlux: ->
    flux = @getFlux()
    flux.store('ArticleStore').getState()

  componentDidMount: ->
    # NOTE: this.isMounted()
    console.log 'componet did mount'
    @loadArticleFromServer()
    setInterval @loadArticleFromServer, @props.pollInterval

  render: ->
    console.log "state"
    console.log @state
    article = @state.article
    `<div>
        <Article article={article} />
    </div>`


document.addEventListener "DOMContentLoaded", (_e) ->
  ReactDOM.render `<Application flux={flux} pollInterval={ 2000 } />`, document.getElementById('app')