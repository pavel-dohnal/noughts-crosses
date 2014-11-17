goog.provide 'app.Title'

class app.Title

  ###*
    Isomorphic app title.
    @param {app.Routes} routes
    @constructor
  ###
  constructor: (@routes) ->

  @MSG_HOME: goog.getMsg 'N & C'
  @MSG_NOT_FOUND: goog.getMsg 'Page Not Found'

  get: ->
    switch @routes.active
      when @routes.home then Title.MSG_HOME
      else Title.MSG_NOT_FOUND

