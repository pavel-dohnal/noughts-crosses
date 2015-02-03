goog.provide 'app.react.App'

goog.require 'goog.dom'
goog.require 'goog.events'

class app.react.App

  ###*
    @param {app.Actions} actions
    @param {app.Routes} routes
    @param {app.Title} appTitle
    @param {este.react.Element} element
    @param {app.react.pages.Home} homePage
    @param {app.react.pages.NotFound} notFoundPage
    @constructor
  ###
  constructor: (actions, routes, appTitle, element,
      homePage, notFoundPage) ->

    {div} = element

    @component = React.createFactory React.createClass

      render: ->
        pageProps = {}
        page = @getActivePage pageProps

        div className: 'app active-page-' + @getPageClassName(page),
          page.component pageProps

      getActivePage: (props) ->
        page = switch routes.active
          when routes.home then homePage
        # 404 is handled in two places for a good reason.
        # app.Storage can return 404, which is used by router, but app data can
        # be changed anytime later, so that's why render has to check it again.
        page || notFoundPage

      getPageClassName: (page) ->
        switch page
          when homePage then 'home'
          when notFoundPage then 'notfound'          

      componentDidMount: ->
        actions.listen 'change', @onStoreChange       
        goog.events.listen window, 'orientationchange', @onOrientationChange

      onOrientationChange: ->
        goog.dom.getDocumentScrollElement().scrollTop = 0

      onStoreChange: ->
        @forceUpdate()

      componentDidUpdate: ->
        document.title = appTitle.get()
