goog.provide 'app.react.pages.Home'

class app.react.pages.Home

  ###*
    @param {app.Routes} routes    
    @param {este.react.Element} element
    @constructor
  ###
  constructor: (routes, element) ->
    {div, ul, li, p, nav, h1} = element

    @component = React.createFactory React.createClass

      render: ->
        div className: 'page',
            h1 {}, Home.MSG_HEADING


  @MSG_TODO: goog.getMsg 'Message message'
  @MSG_HEADING: goog.getMsg 'Noughts and Crosses'
