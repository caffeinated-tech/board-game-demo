{ div } = React.DOM

Piece = require './piece'

class King extends Piece
  _type: ->
    '\u265A'

module.exports = React.createFactory King