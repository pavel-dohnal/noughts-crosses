goog.provide 'app.react.Position'

goog.require 'app.game.Board'
goog.require 'goog.math.Coordinate'

class app.react.Position

  ###*
  	@param {este.react.Element} element
    @param {app.Actions} actions
    @constructor
  ###
  constructor: (element, actions) ->
    {td, img, span, div} = element

    @component = React.createFactory React.createClass

      render: ->

        className = 'cross'
        if @props.position == app.game.Board.STONE_TYPES.PLAYER_0
          className = 'nought'
        else if @props.position == app.game.Board.STONE_TYPES.EMPTY
            className = ''
        td
          onClick: @onClick
          className: className
        ,
          div {className: "cosi"},
            span {}, ' '


      ###*
        @param {SyntheticMouseEvent} e
      ###
      onClick: (e) ->
        coordinate = new goog.math.Coordinate @props.x, @props.y
        @props.onAction coordinate
