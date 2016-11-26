{ tr, td, span } = React.DOM

class GameRow extends React.Component
  render: -> 
    tr {},
      td {},
        @props.game.id
      td {},
        @props.game.white_user_name || '--'
      td {},
        @props.game.black_user_name || '--'
      td { onClick: @_goToGame },
        span { className: 'pure-button' },
          if @_open()
            'Join'
          else
            'View'

  _status: ->
    if @_open()
      'Open'

  _open: ->
    not @props.game.black_user_id? or not @props.game.white_user_id

  _goToGame: =>
    if @_open()
      App.Modules.Lobby.GameList.actions.apiJoinGame 
        gameId: @props.game.id
    else
      App.Modules.Lobby.GameList.actions.viewGame @props.game.id



module.exports = React.createFactory GameRow