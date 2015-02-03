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
    {td, img} = element

    @component = React.createFactory React.createClass

      render: ->
        imgsrc = '/app/client/img/cross.svg'
        if @props.position == app.game.Board.STONE_TYPES.PLAYER_0
          imgsrc = '/app/client/img/nought.svg'
        td 
          onClick: @onClick
        , 
          if @props.position == app.game.Board.STONE_TYPES.EMPTY
            ' '
          else
            img {src: imgsrc, width: 50, height:50, key:'img' + imgsrc}, 

      ###*
        @param {SyntheticMouseEvent} e
      ###
      onClick: (e) ->
        coordinate = new goog.math.Coordinate @props.x, @props.y
        @props.onAction coordinate
