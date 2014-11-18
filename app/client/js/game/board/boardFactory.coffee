goog.provide 'app.game.BoardFactory'

goog.require 'app.game.Board'

class app.game.BoardFactory

  ###*    
    @constructor
  ###
  constructor: () ->

  ###*
    @param {number} size
    @return {app.game.Player}
  ###
  create: (size) ->
    return new app.game.Board size