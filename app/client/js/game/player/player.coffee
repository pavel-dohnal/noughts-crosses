goog.provide 'app.game.Player'

goog.require 'goog.math.Coordinate'

class app.game.Player

  ###*    
    @constructor
  ###
  constructor: () ->
    @stones = []

  ###*
    @type {Array<goog.math.Coordinate>}
  ###
  stones: []

  ###*
    Return the stone which is the longest in game
    @return {goog.math.Coordinate}
  ###
  getLastStone: () ->
    if @getStoneCount() > 0
      return @stones[0]
    return null

  ###*
    @return {number}
  ###
  getStoneCount: () ->
    return @stones.length

  ###*
    @param {goog.math.Coordinate} stone
  ###
  addStone: (stone) ->
    @stones.push stone

  ###*
    @param {goog.math.Coordinate} stone
    @param {goog.math.Coordinate} destination
  ###
  move: (stone, destination) ->
    index = @indexOfStone stone
    if index == -1
      throw new Error "Stone not found"
    goog.array.removeAt @stones, index
    @stones.push destination

  ###*
    @param {goog.math.Coordinate} stone
    @return {number}
    @private
  ###
  indexOfStone: (stone) ->    
    for iStone, i in @stones
      if goog.math.Coordinate.equals iStone, stone
        return i
    return -1

  ###*
    @return {Array.<goog.math.Coordinate>}
  ###
  getStones: () ->
    return @stones

