{ div } = React.DOM

Piece = require './piece'

class Queen extends Piece
  _type: ->
    '\u265B'

module.exports = React.createFactory Queen