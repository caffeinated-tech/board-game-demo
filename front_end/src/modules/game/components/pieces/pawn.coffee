{ div } = React.DOM

Piece = require './piece'

class Pawn extends Piece
  _type: ->
    '\u265F'

module.exports = React.createFactory Pawn