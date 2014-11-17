goog.provide 'app.react.Game'

class app.react.Game

  ###*
    @param {este.react.Element} element
  	@param {app.react.Row} row
    @constructor
  ###
  constructor: (element, row) ->
    {div, table, tr, td} = element

    @component = React.createFactory React.createClass

      render: ->
        table {className: 'game-board'},
          row.component positions: ['x', 'o', 'x']
          row.component positions: ['o', 'o', 'x']
          row.component positions: ['x', 'x', 'o']
            
