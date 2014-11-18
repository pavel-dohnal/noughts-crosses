goog.provide 'app.react.Game'

class app.react.Game

  ###*
    @param {este.react.Element} element
    @param {app.game.NoughtsAndCrosses} noughtsAndCrosses
  	@param {app.react.Position} positionComponent
    @constructor
  ###
  constructor: (element, noughtsAndCrosses, positionComponent) ->
    {div, table, tr, td} = element

    @component = React.createFactory React.createClass

      render: ->
        board = noughtsAndCrosses.getBoard()
        boardSize = board.getSize()
        table {className: 'game-board'},
          for i in [1 .. boardSize]
            tr {}, 
              for j in [1 .. boardSize]
                positionComponent.component position: board.getPosition i - 1, j - 1
            
