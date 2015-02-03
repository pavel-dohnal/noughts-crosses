goog.provide 'app.game.NoughtsAndCrosses'

goog.require 'app.game.Board'
goog.require 'app.game.BoardFactory'
goog.require 'app.game.noughtsAndCrosses.WinningStrategy'
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
    @return {app.game.Player|null}
  ###
  getWinner: () ->
    return null if @winner == -1
    return @players[@winner]
    
  ###*
    @param {goog.math.Coordinate} coordinate
  ###
  move: (coordinate) ->
    #TODO check if move is allowed
    return if @winner != -1    
    if @players[@currentPlayer].getStoneCount() == NoughtsAndCrosses.SIZE
      last = @players[@currentPlayer].getLastStone()
      @players[@currentPlayer].move last, coordinate
    else
      @players[@currentPlayer].addStone coordinate    
    @board.updatePlayersStones @players[@currentPlayer]    
    if @winningStrategy.didWin @players[@currentPlayer]      
      @winner = @currentPlayer
    else
      @currentPlayer = (@currentPlayer + 1) % NoughtsAndCrosses.PLAYER_COUNT    