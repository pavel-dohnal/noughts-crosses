goog.provide 'app.routes.Store'

goog.require 'este.Store'
goog.require 'goog.net.HttpStatus'

class app.routes.Store extends este.Store

  ###*
    @param {app.Actions} actions
    @param {app.Routes} routes
    @param {este.Dispatcher} dispatcher
    @param {este.Router} router
    @constructor
    @extends {este.Store}
  ###
  constructor: (@actions, @routes,
      @dispatcher, @router) ->

    @dispatcher.register (action, payload) =>
      switch action
        when app.Actions.LOAD_ROUTE then @loadRoute_ payload

  start: ->
    @routes.addToEste @router, @onRouteMatch_.bind @
    @router.start()

  onRouteMatch_: (route, params) ->
    @actions.loadRoute route, params
      .then => @routes.setActive route, params
      .thenCatch (reason) => @routes.trySetErrorRoute reason
      .then => @actions.renderApp()

  ###*
    @param {Object} payload
    @return {goog.Promise|number}
    @private
  ###
  loadRoute_: (payload) ->
    {route, params} = payload
    HttpStatus = goog.net.HttpStatus

    switch route
      when @routes.home
        HttpStatus.OK
      else
        throw HttpStatus.NOT_FOUND
