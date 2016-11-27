{ div, br} = React.DOM
{ Link } = ReactRouter

Link = React.createFactory Link

Board = require './components/board'
Controls = require './components/controls'

class Game extends React.Component
  render: -> 
    div {},
    
      Controls @props
      if @_gameReady()
        div {},
          Board @props
      else 
        div {},
          if @props.game? && @props.game.finished
            div {},
              'This game is over'
              br {}
              'TODO: show game history'
          else
            div {},
              'Waiting on a player to join the game'
              br {}
              'TODO: joinable link'
          br {}
            Link { to: '/lobby/create' },
              'create a new game'

  _gameReady: ->
    console.log '_gameReady?', @props.game
    return false unless @props.game? 
    console.log '_gameReady?', @props.game.finished
    return false if @props.game.finished
    console.log 'a'
    (@props.game.white_user_id and @props.game.black_user_id) or 
      @props.game.local

module.exports = React.createFactory Game