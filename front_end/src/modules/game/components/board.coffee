{ div } = React.DOM
Square = require './square'

class Board extends React.Component
  render: ->
    console.log 'mmmm', @props.pieces
    div { className: 'board' },
      for row in [0..7]
        div { className: 'row', key: "row-#{row}" },
          for column in [0..7]
            Square
              row: row
              column: column
              piece: @props.pieces[row][column]

module.exports = React.createFactory Board