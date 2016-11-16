{ div } = React.DOM
CreateGame = require('./create_game')

class RootComponent extends App.Helpers.ConnectStore
  constructor: (props) ->
    @store = App.Modules.Lobby.CreateGame.store
    super(props)

  render: ->
    div {},
      CreateGame @state, @props.children
    
module.exports = RootComponent