
HomeStore = Reflux.createStore
  init: ->
    @user = {}
    @display = 
      login: true
    @form = 
      errors:
        wrongPassword: false
        nameTaken: false

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
    form: @form

  update: ->
    @trigger @props

module.exports = HomeStore