{ div } = React.DOM

class Lobby extends React.Component
  render: ->
    console.log 'render the Lobby'
    div {},
      'This is the Lobby'

module.exports = Lobby