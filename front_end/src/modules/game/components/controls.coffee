{ div, br, span } = React.DOM

class Controls extends React.Component
  render: ->
    whiteClass = 'white '
    whiteClass += 'turn' if @props.turn is 'white'
    blackClass = 'black '
    blackClass += 'turn' if @props.turn is 'black'
    
    div { className: 'controls' },
      div { className: 'players' },
        div
          className: whiteClass
          title: @props.game.white_user_name
          ,
          'White'
        div
          className: blackClass
          title: @props.game.black_user_name
          ,
          'Black'
      div {},
        span 
          className: 'pure-button button-warning'
          onClick: @_forfeitGame
          ,
          "Give Up"

  _forfeitGame: =>
    if window.confirm("Are you sure you want to forfeit the game?")
      App.Modules.Game.actions.apiForfeit
        gameId: @props.game.id

module.exports = React.createFactory Controls