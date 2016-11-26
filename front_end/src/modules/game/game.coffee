{ div } = React.DOM

Board = require './components/board'

class Game extends React.Component
  render: ->
    # if both players are here, the game can begin
    gameReady = @props.game.white_user_id? and @props.game.black_user_id?
    div {},
      if gameReady or @props.game.local?
        Board @props
      else
        div {},
          'Waiting on a player to join the game'

module.exports = React.createFactory Game