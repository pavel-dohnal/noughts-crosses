goog.provide 'app.react.Position'

class app.react.Position

  ###*
  	@param {este.react.Element} element
    @constructor
  ###
  constructor: (element) ->
    {td, img} = element

    @component = React.createFactory React.createClass

      render: ->
        imgsrc = '/app/client/img/cross.svg'
        if @props.position == 'x'
          imgsrc = '/app/client/img/nought.svg'
        td {}, 
          img {src: imgsrc, width: 50, height:50}, 
