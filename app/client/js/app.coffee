goog.provide 'App'

class App

  ###*
    @param {Element} element
    @param {este.Dispatcher} dispatcher
    @param {app.ErrorReporter} errorReporter
    @param {app.react.App} reactApp
    @param {app.routes.Store} routesStore
    @param {app.game.NoughtsAndCrosses} noughtsAndCrosses
    @constructor
  ###
  constructor: (element, dispatcher, errorReporter,
      reactApp, routesStore, noughtsAndCrosses) ->

    dispatcher.register (action, payload) ->
      switch action
        when app.Actions.RENDER_APP
          React.render reactApp.component(), element

    errorReporter.init dispatcher
    routesStore.start()
    noughtsAndCrosses.startGame()
