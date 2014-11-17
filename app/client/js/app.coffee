goog.provide 'App'

class App

  ###*
    @param {Element} element
    @param {este.Dispatcher} dispatcher
    @param {app.ErrorReporter} errorReporter
    @param {app.LocalStorage} localStorage
    @param {app.react.App} reactApp
    @param {app.routes.Store} routesStore
    @param {app.users.Store} usersStore
    @constructor
  ###
  constructor: (element, dispatcher, errorReporter, localStorage, 
      reactApp, routesStore, usersStore) ->

    dispatcher.register (action, payload) ->
      switch action
        when app.Actions.RENDER_APP
          React.render reactApp.component(), element

    errorReporter.init dispatcher
    localStorage.init [usersStore]
    routesStore.start()
