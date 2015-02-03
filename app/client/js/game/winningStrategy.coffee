goog.provide 'app.game.noughtsAndCrosses.WinningStrategy'

goog.require 'goog.math.Coordinate'
goog.require 'app.game.Player'

class app.game.noughtsAndCrosses.WinningStrategy

  ###*    
    @constructor
  ###
  constructor: () ->

  ###*
    @param {app.game.Player} player
    @return {boolean}
  ###
  didWin: (player) ->
    stones = goog.array.clone player.getStones()
    goog.array.sort stones, (x, y) ->
      return x.x - y.x if x.x != y.x
      return x.y - y.y if x.y != y.y
      return 0
    return false if player.getStoneCount() < app.game.NoughtsAndCrosses.SIZE
    return true if @stonesInVerticalLine stones
    return true if @stonesInBackDiagonalLine stones
    return true if @stonesInHorizontalLine stones
    return true if @stonesInFrontDiagonalLine stones    
    return false

  ###*
    @param {Array.<goog.math.Coordinate>} stones
    @return {boolean}
  ###
  stonesInVerticalLine: (stones) ->
    column = stones[0].x
    for stone in stones
      if column != stone.x
        return false
    return true

  ###*
    @param {Array.<goog.math.Coordinate>} stones
    @return {boolean}
  ###
  stonesInHorizontalLine: (stones) ->
    column = stones[0].y
    for stone in stones
      if column != stone.y
        return false
    return true

  ###*
    @param {Array.<goog.math.Coordinate>} stones
    @return {boolean}
  ###
  stonesInFrontDiagonalLine: (stones) ->
    for stone in stones
      if stone.x != stone.y
        return false
    return true

  ###*
    @param {Array.<goog.math.Coordinate>} stones
    @return {boolean}
  ###
  stonesInBackDiagonalLine: (stones) -> 
    firstStone = stones[0]
    goog.array.removeAt stones, 0
    prevX = firstStone.x
    prevY = firstStone.y
    for stone in stones
      if prevY <= stone.y || prevX >= stone.x
        return false
      prevX = stone.x
      prevY = stone.y        
    return true
