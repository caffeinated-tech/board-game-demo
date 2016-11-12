
HomeStore = Reflux.createStore
  init: ->
    @user = {}
    @display = 
      login: true

  registerListeners: ->
    @listenToMany App.Modules.Home.actions

  
  onSwitchForm: ->
    @display.login = !@display.login
    @update()


  loadData: (data) ->
    @update()

  props: ->
    display: @display
    user: @user

  update: ->
    @trigger @props



module.exports = HomeStore