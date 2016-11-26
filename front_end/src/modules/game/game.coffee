{ div } = React.DOM

Board = require './components/board'
Controls = require './components/controls'

class Game extends React.Component
  render: -> 
    div {},
      if @_gameReady()
        div {},
          Board @props
          Controls @props
      else if @props.game? && @props.game.finished
        div {},
          'This game is over'
          'TODO: show game history'
      else
        div {},
          'Waiting on a player to join the game'
          'TODO: joinable link'

  _gameReady: ->
    return false unless @props.game? and not @props.game.finished

    (@props.game.white_user_id? and @props.game.black_user_id?) or 
      @props.game.local

module.exports = React.createFactory Game