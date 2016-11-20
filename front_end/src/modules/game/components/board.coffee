{ div } = React.DOM
Square = require './square'

class Board extends React.Component
  render: ->
    console.log 'render the board'
    div { className: 'board' },
      for row in [0..7]
        div { className: 'row' },
          for column in [0..7]
            Square
              row: row
              column: column

module.exports = React.createFactory Board