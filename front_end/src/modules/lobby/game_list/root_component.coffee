{ div } = React.DOM
GameList = require('./game_list')

class RootComponent extends App.Helpers.ConnectStore
  constructor: (props) ->
    @store = App.Modules.Lobby.GameList.store
    super(props)

  render: ->
    div {},
      GameList @state, @props.children
    
  componentWillReceiveProps: (nextProps) ->
    if nextProps.params.filter isnt @props.params.filter
      App.Modules.Lobby.GameList.actions.setFilter(
        nextProps.params.filter)
      

  componentDidMount: ->
    super()
    App.Modules.Lobby.GameList.actions.setFilter(@props.params.filter)


module.exports = RootComponent