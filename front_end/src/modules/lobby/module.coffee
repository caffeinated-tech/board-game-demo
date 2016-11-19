LobbyModule =
  component: require './lobby'
  actions: require './actions'
  store: require './store'
  rootComponent: require './root_component'
  CreateGame: require './create_game/module'
  GameList: require './game_list/module'
  PlayerList: require './player_list/module'

1
module.exports = LobbyModule