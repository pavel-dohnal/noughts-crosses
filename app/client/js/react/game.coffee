goog.provide 'app.react.Game'

class app.react.Game

  ###*
    @param {este.react.Element} element
    @param {app.game.NoughtsAndCrosses} noughtsAndCrosses
  	@param {app.react.Position} positionComponent
    @param {este.Dispatcher} dispatcher
    @constructor
  ###
  constructor: (element, noughtsAndCrosses, positionComponent, dispatcher) ->
    {div, table, tr, p} = element


    @component = React.createFactory React.createClass

      render: ->        
        board = noughtsAndCrosses.getBoard()
        boardSize = board.getSize()
        div {},
          table {className: 'game-board'},
            for i in [0 .. boardSize - 1]
              tr {}, 
                for j in [0 .. boardSize - 1]
                  positionComponent.component position: board.getPosition(i, j), x:i, y:j, onAction: (coordinate) =>
                    noughtsAndCrosses.move coordinate
                    @forceUpdate()
          p {}, 
            if noughtsAndCrosses.getWinner() == null
              'Play play play' 
            else
              'We\'ve got a winner'

