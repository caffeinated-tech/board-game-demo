{ div } = React.DOM

Piece = require './piece'

class Knight extends Piece
  render: ->
    console.log 'render a knight', @props
    div { className: 'piece knight'},
      '\u265E'

module.exports = React.createFactory Knight