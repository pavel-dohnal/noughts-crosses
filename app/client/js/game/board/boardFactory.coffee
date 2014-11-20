goog.provide 'app.game.BoardFactory'

goog.require 'app.game.Board'

class app.game.BoardFactory

  ###*    
    @constructor
  ###
  constructor: () ->

  ###*
    @param {number} size
    @return {app.game.Board}
  ###
  create: (size) ->
    return new app.game.Board size