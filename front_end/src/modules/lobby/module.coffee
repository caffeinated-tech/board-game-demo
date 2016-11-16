LobbyModule =
  component: require './lobby'
  actions: require './actions'
  store: require './store'
  rootComponent: require './root_component'
  CreateGame: require './create_game/module'

module.exports = LobbyModule