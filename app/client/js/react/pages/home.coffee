goog.provide 'app.react.pages.Home'

class app.react.pages.Home

  ###*
    TODO: Rename to homepage, this is confusing.
    @param {app.Routes} routes
    @param {este.react.Element} element
    @constructor
  ###
  constructor: (routes, element) ->
    {div, ul, li, p, nav, Link} = element

    @component = React.createFactory React.createClass

      render: ->
       
        div className: 'page',          
            div {},
              p {}, Home.MSG_TODO              


  @MSG_TODO: goog.getMsg 'Message message'
