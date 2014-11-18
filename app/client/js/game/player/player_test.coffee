suite 'app.game.Player', ->

  Player = app.game.Player
  player = null

  suite 'init', ->
    test 'should return zero stone count in the beggining', ->
      player = new Player
      assert.equal player.getStoneCount(), 0

    test 'should not return last stone in the beggining', ->
      player = new Player
      assert.equal player.getLastStone(), null

  suite 'addStone', ->
    test 'should return one stone after move', ->
      player = new Player
      stone = new goog.math.Coordinate 1, 1
      player.addStone stone
      assert.equal player.getStoneCount(), 1    

  suite 'getLastStone', ->
    test 'should return last stone after some moves', ->
      player = new Player
      stone = new goog.math.Coordinate 1, 1
      player.addStone stone
      stone = new goog.math.Coordinate 2, 2
      player.addStone stone
      lastStone = player.getLastStone()
      assert.isTrue goog.math.Coordinate.equals lastStone, new goog.math.Coordinate 1, 1

  suite 'move', ->
    test 'should throw an error when moved stone is not found', ->
      player = new Player
      stone1 = new goog.math.Coordinate 1, 1
      player.addStone stone1
      stone2 = new goog.math.Coordinate 2, 2
      player.addStone stone2
      assert.throws () ->
        player.move(new goog.math.Coordinate(3, 4), new goog.math.Coordinate(5, 6))
      , Error

    test 'should moved stone', ->
      player = new Player
      stone1 = new goog.math.Coordinate 1, 1
      player.addStone stone1
      player.move(new goog.math.Coordinate(1, 1), new goog.math.Coordinate(5, 6))
      lastStone = player.getLastStone()
      assert.isTrue goog.math.Coordinate.equals lastStone, new goog.math.Coordinate 5, 6
      assert.equal player.getStoneCount(), 1
