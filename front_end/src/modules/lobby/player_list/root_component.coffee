{ div } = React.DOM
PlayerList = require('./player_list')

class RootComponent extends App.Helpers.ConnectStore
  constructor: (props) ->
    @store = App.Modules.Lobby.PlayerList.store
    super(props)

  render: ->
    div {},
      PlayerList @state, @props.children
    
module.exports = RootComponent