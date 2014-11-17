goog.provide 'app.react.Row'

class app.react.Row

  ###*
    @param {este.react.Element} element
  	@param {app.react.Position} positionComponent
    @constructor
  ###
  constructor: (element, positionComponent) ->
    {tr, td} = element

    @component = React.createFactory React.createClass

      render: ->
        tr {}, @props.positions.map (positionValue) ->
            positionComponent.component position: positionValue
