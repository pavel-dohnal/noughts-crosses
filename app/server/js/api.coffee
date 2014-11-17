goog.provide 'server.Api'

goog.require 'goog.Promise'

class server.Api

  ###*
    @param {app.Routes} routes
    @constructor
  ###
  constructor: (routes) ->
    api = routes.api
    @handlers = []


  ###*
    @param {este.Route} route
    @return {Object}
  ###
  route: (route) ->
    create = (method, handler) ->
      @handlers.push
        callback: handler
        method: method
        path: route.path
        route: route
      actions

    actions =
      delete: create.bind @, 'delete'
      get: create.bind @, 'get'
      patch: create.bind @, 'patch'
      post: create.bind @, 'post'
      put: create.bind @, 'put'

  ###*
    @param {Object} app Express instance.
    @param {function(este.Route, Object, Object, goog.Promise)} callback
  ###
  addToExpress: (app, callback) ->
    @handlers.forEach (handler) ->
      app[handler.method] handler.path, (req, res) ->
        promise = handler.callback.call @, req
        callback handler.route, req, res, promise
