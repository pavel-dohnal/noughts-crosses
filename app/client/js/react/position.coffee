goog.provide 'app.react.Position'

goog.require 'app.game.Board'

class app.react.Position

  ###*
  	@param {este.react.Element} element
    @constructor
  ###
  constructor: (element) ->
    {td, img} = element

    @component = React.createFactory React.createClass

      render: ->
        imgsrc = '/app/client/img/cross.svg'
        if @props.position == app.game.Board.STONE_TYPES.PLAYER_0
          imgsrc = '/app/client/img/nought.svg'
        td {}, 
          if @props.position == app.game.Board.STONE_TYPES.EMPTY
            ' '
          else
            img {src: imgsrc, width: 50, height:50}, 
