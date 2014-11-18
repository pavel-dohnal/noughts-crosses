suite 'app.game.Board', ->

  Board = app.game.Board
  board = null

  suite 'init', ->
    test 'should initialise all positions to correct size', ->
      board = new app.game.Board 2      
      board.init []
      assert.equal board.positions.length, 2
      assert.equal board.positions[0].length, 2
      assert.equal board.positions[1].length, 2

    test 'should be empty after init', ->
      board = new app.game.Board 2
      board.init []
      assert.equal board.positions[0][0], Board.STONE_TYPES.EMPTY
      assert.equal board.positions[1][0], Board.STONE_TYPES.EMPTY
      assert.equal board.positions[0][1], Board.STONE_TYPES.EMPTY
      assert.equal board.positions[1][1], Board.STONE_TYPES.EMPTY

    test 'should throw exception if too many players', ->
      players = [new app.game.Player, new app.game.Player, new app.game.Player, new app.game.Player]
      board = new app.game.Board 2
      assert.throws () ->
        board.init players
      , Error

    test 'should map players', ->
      player1 = new app.game.Player 
      player2 = new app.game.Player 
      board = new app.game.Board 2
      board.init [player1, player2]
      assert.strictEqual player1, board.stonesToPlayerMapping[Board.STONE_TYPES.PLAYER_0]
      assert.strictEqual player2, board.stonesToPlayerMapping[Board.STONE_TYPES.PLAYER_1]

    test 'should forget previous game after init', ->
      player1 = new app.game.Player 
      player2 = new app.game.Player 
      board.init [player1]
      stone = new goog.math.Coordinate 1, 1
      player1.addStone stone
      board.updatePlayersStones player1
      board.init [player2]
      assert.strictEqual player2, board.stonesToPlayerMapping[Board.STONE_TYPES.PLAYER_0]
      assert.equal board.positions[0][0], Board.STONE_TYPES.EMPTY
      assert.equal board.positions[1][0], Board.STONE_TYPES.EMPTY
      assert.equal board.positions[0][1], Board.STONE_TYPES.EMPTY
      assert.equal board.positions[1][1], Board.STONE_TYPES.EMPTY

    test 'should initialise players stones', ->
      player = new app.game.Player 
      player.addStone new goog.math.Coordinate 1, 1
      board = new app.game.Board 2
      board.init [player]
      assert.equal board.positions[0][0], Board.STONE_TYPES.EMPTY
      assert.equal board.positions[1][0], Board.STONE_TYPES.EMPTY
      assert.equal board.positions[0][1], Board.STONE_TYPES.EMPTY
      assert.equal board.positions[1][1], Board.STONE_TYPES.PLAYER_0

  suite 'updatePlayersStones', ->
    test 'should throw an error if player is not in game', ->
      board = new app.game.Board 2
      board.init
      assert.throws () ->
        board.updatePlayersStones new app.game.Player
      , Error

    test 'should update empty player', ->
      player = new app.game.Player
      board = new app.game.Board 2
      board.init [player]
      board.updatePlayersStones player
      assert.equal board.positions[0][0], Board.STONE_TYPES.EMPTY
      assert.equal board.positions[1][0], Board.STONE_TYPES.EMPTY
      assert.equal board.positions[0][1], Board.STONE_TYPES.EMPTY
      assert.equal board.positions[1][1], Board.STONE_TYPES.EMPTY

    test 'should update players stones', ->
      player = new app.game.Player      
      board = new app.game.Board 2
      board.init [player]
      player.addStone new goog.math.Coordinate 1, 1
      board.updatePlayersStones player
      assert.equal board.positions[0][0], Board.STONE_TYPES.EMPTY
      assert.equal board.positions[1][0], Board.STONE_TYPES.EMPTY
      assert.equal board.positions[0][1], Board.STONE_TYPES.EMPTY
      assert.equal board.positions[1][1], Board.STONE_TYPES.PLAYER_0

    test 'should update players stones after he moves', ->
      player = new app.game.Player      
      board = new app.game.Board 2
      board.init [player]
      stone = new goog.math.Coordinate 1, 1
      player.addStone stone
      board.updatePlayersStones player
      assert.equal board.positions[0][0], Board.STONE_TYPES.EMPTY
      assert.equal board.positions[1][0], Board.STONE_TYPES.EMPTY
      assert.equal board.positions[0][1], Board.STONE_TYPES.EMPTY
      assert.equal board.positions[1][1], Board.STONE_TYPES.PLAYER_0
      player.move stone, new goog.math.Coordinate 0, 0
      board.updatePlayersStones player
      assert.equal board.positions[0][0], Board.STONE_TYPES.PLAYER_0
      assert.equal board.positions[1][0], Board.STONE_TYPES.EMPTY
      assert.equal board.positions[0][1], Board.STONE_TYPES.EMPTY
      assert.equal board.positions[1][1], Board.STONE_TYPES.EMPTY