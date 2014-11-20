goog.provide 'app.game.NoughtsAndCrosses'

goog.require 'app.game.Board'
goog.require 'app.game.BoardFactory'
goog.require 'app.game.Player'
goog.require 'app.game.PlayerFactory'

class app.game.NoughtsAndCrosses

  ###*
    @type {number}
  ###
  @SIZE: 4

  ###*
    @type {number}
  ###
  @PLAYER_COUNT: 2

  ###*    
    @param {app.game.PlayerFactory} playerFactory
    @param {app.game.BoardFactory} boardFactory
    @param {app.game.noughtsAndCrosses.WinningStrategy} winningStrategy
    @constructor
  ###
  constructor: (@playerFactory, @boardFactory, @winningStrategy) ->
    @board = @boardFactory.create NoughtsAndCrosses.SIZE
    @currentPlayer = 0
    @winner = -1
    @players = []

  ###*
    @type {Array<app.game.Player>}
  ###
  players: []

  ###*
    @type {app.game.Board}
  ###
  board: null

  ###*
    @type {number}
  ###
  currentPlayer: 0

  ###*
    @type {number}
  ###
  winner: -1

  startGame: () ->
    @players = []
    @currentPlayer = 0
    for i in [1 .. NoughtsAndCrosses.PLAYER_COUNT]
      @players.push @playerFactory.create()
    @board.init @players
    @winner = -1

  ###*
    @return {app.game.Board}
  ###
  getBoard: () ->
    return @board

  ###*
    @param {goog.math.Coordinate} coordinate
  ###
  move: (coordinate) ->
    #TODO check if move is allowed
    player = @players[@currentPlayer]
    if player.getStoneCount() == NoughtsAndCrosses.SIZE
      last = player.getLastStone()
      player.move last, coordinate
    else
      player.addStone coordinate
    @board.updatePlayersStones player
    @currentPlayer = (@currentPlayer + 1) % NoughtsAndCrosses.PLAYER_COUNT
    #TODO check if end
    
