#TODO refactor this test
suite 'app.game.NoughtsAndCrosses', ->

  Game = app.game.NoughtsAndCrosses
  game = null
  
  board = new app.game.Board 2   
  boardFactory = new app.game.BoardFactory
  boardFactoryStub = sinon.stub boardFactory, "create"
  boardFactoryStub.returns board

  player1 = new app.game.Player
  player2 = new app.game.Player
  players = [player1, player2]
  board.init players
  playersFactory = new app.game.PlayerFactory
  playersFactoryStub = sinon.stub playersFactory, "create"
  playersFactoryStub.onCall(0).returns(player1)
  playersFactoryStub.onCall(1).returns(player2)

  game = new Game playersFactory, boardFactory

  suite 'startGame', ->
    test 'should init the board and players', ->
      boardMock = sinon.mock board
      boardMock
        .expects('init')
        .once()
        .withArgs(players)
      game.startGame()
      assert.equal game.currentPlayer, 0
      assert.equal game.players.length, 2
      boardMock.verify()
      boardMock.restore()

  suite 'move', ->
    test 'should add stone to player', ->
      game.board = board
      game.players = players
      coordinate = new goog.math.Coordinate 0, 0
      playerMock = sinon.mock player1
      playerMock
        .expects('addStone')
        .once()
        .withArgs(coordinate)

      game.move coordinate
      playerMock.verify()
      playerMock.restore()

    test 'should move last stone when player have enough stones', ->
      game.currentPlayer = 0
      game.players = players
      last = new goog.math.Coordinate 0, 0
      player1.addStone last
      player1.addStone new goog.math.Coordinate 1, 0
      player1.addStone new goog.math.Coordinate 1, 1
      player1.addStone new goog.math.Coordinate 1, 2
      coordinate = new goog.math.Coordinate 1, 1
      playerMock = sinon.mock player1
      playerMock
        .expects('move')
        .once()
        .withArgs(last, coordinate)

      game.move coordinate
      playerMock.verify()
      playerMock.restore()

    test 'should update board', ->
      game.currentPlayer = 0
      game.players = players
      coordinate = new goog.math.Coordinate 0, 0
      boardMock = sinon.mock board
      boardMock
        .expects('updatePlayersStones')
        .once()
        .withArgs(player1)

      game.move coordinate
      boardMock.verify()
      boardMock.restore()

    test 'should switch player', ->
      game.players = players
      game.currentPlayer = 0
      coordinate = new goog.math.Coordinate 0, 0

      game.move coordinate
      assert.equal game.currentPlayer, 1

      game.move coordinate
      assert.equal game.currentPlayer, 0