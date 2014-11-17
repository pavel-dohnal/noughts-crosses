goog.provide 'app.Actions'

goog.require 'este.Actions'

class app.Actions extends este.Actions

  ###*
    @param {este.Dispatcher} dispatcher
    @constructor
    @extends {este.Actions}
  ###
  constructor: (dispatcher) ->
    super dispatcher

  @LOAD_ROUTE: 'load-route'
  @RENDER_APP: 'render-app'

  loadRoute: (route, params) ->
    @dispatch Actions.LOAD_ROUTE, route: route, params: params

  renderApp: ->
    @dispatch Actions.RENDER_APP

