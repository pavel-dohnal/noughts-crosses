goog.provide 'app.Xhr'
goog.provide 'app.Xhr.OfflineError'

goog.require 'goog.Promise'
goog.require 'goog.debug.Error'
goog.require 'goog.labs.net.xhr'

class app.Xhr

  ###*
    @constructor
  ###
  constructor: ->
    @createHttpMethods_()

  @XHR_OPTIONS:
    headers:
      'Content-Type': 'application/json;charset=utf-8'

  @MSG_MUST_BE_ONLINE: goog.getMsg '
    For this action you have to be online. Check your internet connection please.
  '

  createHttpMethods_: ->
    @delete = @send.bind @, 'DELETE'
    @get = @send.bind @, 'GET'
    @patch = @send.bind @, 'PATCH'
    @post = @send.bind @, 'POST'
    @put = @send.bind @, 'PUT'

  ###*
    @param {string} method
    @param {string} url
    @param {Object=} json
    @return {!goog.Promise}
  ###
  send: (method, url, json) ->
    if !navigator.onLine
      return goog.Promise.reject new app.Xhr.OfflineError

    goog.labs.net.xhr
      .send method, url, JSON.stringify(json), Xhr.XHR_OPTIONS
      .then (xhr) -> JSON.parse xhr.responseText

class app.Xhr.OfflineError extends goog.debug.Error

  ###*
    @constructor
    @extends {goog.debug.Error}
    @final
  ###
  constructor: ->
    super app.Xhr.MSG_MUST_BE_ONLINE

  ###*
    @override
  ###
  name: 'offline'
