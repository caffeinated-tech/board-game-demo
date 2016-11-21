{ div } = React.DOM

Piece = require './piece'

class Knight extends Piece
  _type: ->
    '\u265E'

module.exports = React.createFactory Knight