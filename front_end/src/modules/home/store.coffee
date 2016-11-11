
HomeStore = Reflux.createStore
  init: ->
    @user = {}

  registerListeners: ->
    @listenToMany App.Modules.Home.actions

  loadData: (data) ->
    @data = data
    @trigger @data
  

module.exports = HomeStore