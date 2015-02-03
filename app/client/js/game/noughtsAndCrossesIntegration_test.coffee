suite 'app.game.NoughtsAndCrosses', ->

	noughtsAndCrosses = new app.game.NoughtsAndCrosses(
		new app.game.PlayerFactory(), 
		new app.game.BoardFactory(), 
		new app.game.noughtsAndCrosses.WinningStrategy
	)

	test 'simple game works', ->		
		noughtsAndCrosses.startGame()
		noughtsAndCrosses.move new goog.math.Coordinate 0, 0 # x
		noughtsAndCrosses.move new goog.math.Coordinate 3, 0 # 0
		noughtsAndCrosses.move new goog.math.Coordinate 2, 2 # x
		noughtsAndCrosses.move new goog.math.Coordinate 3, 1 # 0
		noughtsAndCrosses.move new goog.math.Coordinate 1, 1 # x
		noughtsAndCrosses.move new goog.math.Coordinate 3, 2 # 0
		assert.isNull noughtsAndCrosses.getWinner()
		noughtsAndCrosses.move new goog.math.Coordinate 3, 3 # x - winning move, diagonal
		assert.equal noughtsAndCrosses.players[0].getStoneCount(), 4
		assert.equal noughtsAndCrosses.players[1].getStoneCount(), 3
		winner = noughtsAndCrosses.getWinner()
		assert.instanceOf winner, app.game.Player

	test 'long game works', ->
		noughtsAndCrosses.startGame()
		# let's populate top and bottom row, both players alternate so no one should win
		noughtsAndCrosses.move new goog.math.Coordinate 0, 0 # x
		noughtsAndCrosses.move new goog.math.Coordinate 0, 1 # 0
		noughtsAndCrosses.move new goog.math.Coordinate 0, 2 # x
		noughtsAndCrosses.move new goog.math.Coordinate 0, 3 # 0
		noughtsAndCrosses.move new goog.math.Coordinate 3, 0 # x
		noughtsAndCrosses.move new goog.math.Coordinate 3, 1 # 0
		noughtsAndCrosses.move new goog.math.Coordinate 3, 2 # x
		noughtsAndCrosses.move new goog.math.Coordinate 3, 3 # 0
		assert.isNull noughtsAndCrosses.getWinner()
		assert.equal noughtsAndCrosses.players[0].getStoneCount(), 4
		assert.equal noughtsAndCrosses.players[0].getStoneCount(), 4
		# right now both players've got all stones on board, game should removing stones
		noughtsAndCrosses.move new goog.math.Coordinate 1, 0 # x - from 0, 0
		noughtsAndCrosses.move new goog.math.Coordinate 1, 1 # 0 - from 0, 1
		noughtsAndCrosses.move new goog.math.Coordinate 1, 2 # x - from 0, 2
		noughtsAndCrosses.move new goog.math.Coordinate 1, 3 # 0 - from 0, 3
		noughtsAndCrosses.move new goog.math.Coordinate 2, 0 # x - from 3, 0
		noughtsAndCrosses.move new goog.math.Coordinate 2, 1 # 0 - from 3, 1
		noughtsAndCrosses.move new goog.math.Coordinate 2, 2 # x - from 3, 2
		noughtsAndCrosses.move new goog.math.Coordinate 2, 3 # 0 - from 3, 3
		# both middle rows are populated, top and bottom rows are free, let's start to move stones x to top line and 0 to bottom
		noughtsAndCrosses.move new goog.math.Coordinate 0, 0 # x - from 1, 0
		noughtsAndCrosses.move new goog.math.Coordinate 3, 0 # 0 - from 1, 1
		noughtsAndCrosses.move new goog.math.Coordinate 0, 1 # x - from 1, 2
		noughtsAndCrosses.move new goog.math.Coordinate 3, 1 # 0 - from 1, 3
		noughtsAndCrosses.move new goog.math.Coordinate 0, 2 # x - from 2, 0
		noughtsAndCrosses.move new goog.math.Coordinate 3, 2 # 0 - from 2, 1
		assert.isNull noughtsAndCrosses.getWinner()
		noughtsAndCrosses.move new goog.math.Coordinate 0, 3 # x - from 3, 2
		# at this point x should be winner with line on top row
		winner = noughtsAndCrosses.getWinner()
		assert.instanceOf winner, app.game.Player

