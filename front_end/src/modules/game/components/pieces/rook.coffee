{ div } = React.DOM

Piece = require './piece'

class Rook extends Piece
  _type: ->
    '\u265C'

module.exports = React.createFactory Rook