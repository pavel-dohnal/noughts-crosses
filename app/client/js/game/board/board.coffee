goog.provide 'app.game.Board'

goog.require 'app.game.Player'

class app.game.Board

  ###*
    @enum {string}
  ###
  @STONE_TYPES:
    EMPTY: 'x'
    PLAYER_0: '0'
    PLAYER_1: '1'

  ###*
    @type {number}
  ###
  @MAX_PLAYERS: 2

  ###*    
    @constructor
  ###
  constructor: (@size) ->  
       

  ###*
    @type {Object.<string, app.game.Player>}
  ###
  stonesToPlayerMapping: {}

  ###*
    @type {Array.<Array.<number>>}
  ###
  positions: []

  ###*
    @param {Array.<app.game.Player>} players
  ###
  init: (players) ->
    @initPositions()
    @initPlayers players

  ###*
    @private
  ###
  initPositions: () ->
    @positions = []
    for i in [1 .. @size]
      @positions.push []
      for j in [1 .. @size]
        @positions[i - 1].push Board.STONE_TYPES.EMPTY

  ###*
    @param {Array.<app.game.Player>} players
    @private
  ###
  initPlayers: (players) ->
    if players.length > Board.MAX_PLAYERS
      throw new Error 'Too many players. Maximum is ' + Board.MAX_PLAYERS + ' players.'
    @stonesToPlayerMapping = {}
    for player, i in players
      symbol = Board.STONE_TYPES['PLAYER_' + i]
      @stonesToPlayerMapping[symbol] = player
      @addPlayersStones symbol, player

  ###*
    @param {app.game.Player} player
  ###
  updatePlayersStones: (player) ->
    symbol = @findPlayersSymbol player
    @removePlayerStones symbol
    @addPlayersStones symbol, player
    
  ###*
    @param {string} symbol
    @param {Array<app.game.Player>} player
    @private
  ###
  addPlayersStones: (symbol, player) ->
    for coordinates in player.getStones()
      @positions[coordinates.x][coordinates.y] = symbol

  ###*
    @param {string} symbol
    @private
  ###
  removePlayerStones: (symbol) ->
    for i in [0 .. @size - 1]
      for j in [0 .. @size - 1]
        if @positions[i][j] == symbol
          @positions[i][j] = Board.STONE_TYPES.EMPTY

  ###*
    @param {app.game.Player} player
    @return {string}
    @private
  ###
  findPlayersSymbol: (player) ->
    for iSymbol, iPlayer of @stonesToPlayerMapping
      if iPlayer = iSymbol
        return iSymbol
    throw new Error 'Player is not in game'

