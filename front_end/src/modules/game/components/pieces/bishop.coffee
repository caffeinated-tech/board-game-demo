{ div } = React.DOM

Piece = require './piece'

class Bishop extends Piece
  _type: ->
    '\u265D'

module.exports = React.createFactory Bishop