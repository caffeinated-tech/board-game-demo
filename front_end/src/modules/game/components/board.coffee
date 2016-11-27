{ div } = React.DOM
Square = require './square'

class Board extends React.Component
  render: ->
    if @props.game.moves.length > 0
      [..., lastSquare] = @props.game.moves 
      lastMove = "#{lastSquare.to.row}#{lastSquare.to.column}"

    div { className: 'board' },
      for row in [0..7]
        div { className: 'row', key: "row-#{row}" },
          for column in [0..7]
            thisSquare = "#{row}#{column}" 
            Square
              row: row
              column: column
              piece: @props.board[row][column]
              valid: thisSquare in @props.validMoves
              selected: thisSquare is @props.selectedSquare
              last: thisSquare is lastMove
              check: thisSquare is @props.check
module.exports = React.createFactory Board