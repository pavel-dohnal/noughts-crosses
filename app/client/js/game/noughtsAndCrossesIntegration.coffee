goog.provide 'app.game.NoughtsAndCrossesIntegration'

goog.require 'app.game.NoughtsAndCrosses'
goog.require 'app.game.PlayerFactory'
goog.require 'app.game.BoardFactory'
goog.require 'app.game.noughtsAndCrosses.WinningStrategy'

class app.game.NoughtsAndCrossesIntegration

	###*
		This class is here only for testing reasons, it is not instantiated anywhere.
		Este framework doesn't run tests which doesn't have class. 
		@constructor
	###
	constructor: () ->