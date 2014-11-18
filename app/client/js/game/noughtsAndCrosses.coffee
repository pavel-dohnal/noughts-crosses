goog.provide 'app.game.NoughtsAndCrosses'

class app.game.NoughtsAndCrosses

  ###*
    @type {number}
  ###
  @SIZE: 4

  ###*    
    @param {app.game.PlayerFactory} playerFactory
    @param {app.game.BoardFactory} boardFactory
    @constructor
  ###
  constructor: (@playerFactory, @boardFactory) ->
  	@board = @boardFactory.create NoughtsAndCrosses.SIZE

  ###*
    @type {Array<app.game.Player>}
  ###
  players: []

  board: null

  ###*
    @type {number}
  ###
  currentPlayer: 0

  startGame: () ->
    @players = []
    @currentPlayer = 0
    #TODO
