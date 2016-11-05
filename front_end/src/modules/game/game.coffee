{ div } = React.DOM

class Game extends React.Component
  render: ->
    console.log 'render the game'
    div {},
      'This is the Game'

module.exports = React.createFactory Game