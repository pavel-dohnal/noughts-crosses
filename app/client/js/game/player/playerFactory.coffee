goog.provide 'app.game.PlayerFactory'

goog.require 'app.game.Player'

class app.game.PlayerFactory

  ###*    
    @constructor
  ###
  constructor: () ->

  ###*
    @return {app.game.Player}
  ###
  create: () ->
  	return new app.game.Player