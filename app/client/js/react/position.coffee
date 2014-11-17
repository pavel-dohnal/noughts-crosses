goog.provide 'app.react.Position'

class app.react.Position

  ###*
  	@param {este.react.Element} element
    @constructor
  ###
  constructor: (element) ->
    {td} = element

    @component = React.createFactory React.createClass

      render: ->
        td {}, @props.position
