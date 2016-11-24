{ div } = React.DOM
Square = require './square'

class Board extends React.Component
  render: ->
    div { className: 'board' },
      for row in [0..7]
        div { className: 'row', key: "row-#{row}" },
          for column in [0..7]
            Square
              row: row
              column: column
              piece: @props.board[row][column]
              valid: "#{row}#{column}" in @props.validMoves
              selected: "#{row}#{column}" is @props.selectedSquare

module.exports = React.createFactory Board