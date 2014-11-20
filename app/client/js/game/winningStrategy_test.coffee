suite 'app.game.noughtsAndCrosses.WinningStrategy', ->

  WinningStrategy = app.game.noughtsAndCrosses.WinningStrategy
  winningStrategy = new WinningStrategy

  suite 'didWin not win', ->
    test 'should not win if doesnt have enough moves', ->
      player = new app.game.Player
      player.addStone new goog.math.Coordinate 0, 0
      assert.isFalse winningStrategy.didWin player

    test 'should not win if stones not in line', ->
      player = new app.game.Player
      player.addStone new goog.math.Coordinate 0, 0
      player.addStone new goog.math.Coordinate 1, 0
      player.addStone new goog.math.Coordinate 0, 1
      player.addStone new goog.math.Coordinate 1, 1
      assert.isFalse winningStrategy.didWin player

    test 'should not win if stones are in horizontal line but first', ->
      player = new app.game.Player
      player.addStone new goog.math.Coordinate 2, 0
      player.addStone new goog.math.Coordinate 1, 1
      player.addStone new goog.math.Coordinate 1, 2
      player.addStone new goog.math.Coordinate 1, 3      
      assert.isFalse winningStrategy.didWin player

  suite 'didWin win', ->    
    test 'should win if stones are in horizontal line', ->
      player = new app.game.Player
      player.addStone new goog.math.Coordinate 1, 2
      player.addStone new goog.math.Coordinate 1, 3
      player.addStone new goog.math.Coordinate 1, 0
      player.addStone new goog.math.Coordinate 1, 1
      assert.isTrue winningStrategy.didWin player    

    test 'should win if stones are in vertical line', ->
      player = new app.game.Player
      player.addStone new goog.math.Coordinate 2, 1
      player.addStone new goog.math.Coordinate 3, 1
      player.addStone new goog.math.Coordinate 0, 1
      player.addStone new goog.math.Coordinate 1, 1
      assert.isTrue winningStrategy.didWin player

    test 'should win if stones are in front diagonal line', ->
      player = new app.game.Player
      player.addStone new goog.math.Coordinate 2, 2
      player.addStone new goog.math.Coordinate 0, 0
      player.addStone new goog.math.Coordinate 1, 1      
      player.addStone new goog.math.Coordinate 3, 3
      assert.isTrue winningStrategy.didWin player

    test 'should win if stones are in back diagonal line', ->      
      player = new app.game.Player
      player.addStone new goog.math.Coordinate 3, 0
      player.addStone new goog.math.Coordinate 1, 2
      player.addStone new goog.math.Coordinate 0, 3      
      player.addStone new goog.math.Coordinate 2, 1      
      assert.isTrue winningStrategy.didWin player

