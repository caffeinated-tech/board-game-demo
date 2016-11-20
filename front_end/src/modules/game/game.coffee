{ div } = React.DOM

Board = require './components/board'

class Game extends React.Component
  render: ->
    console.log 'render the game', @props.game
    div {},
      'This is the Game'
      Board @props

module.exports = React.createFactory Game