
HomeStore = Reflux.createStore
  init: ->
    @user = {}
    @display = 
      login: true
    @form = 
      errors:
        wrongPassword: false
        nameTaken: false
    @inputs = {}

  registerListeners: ->
    @listenToMany App.Modules.Home.actions
  
  onSwitchForm: ->
    @display.login = !@display.login
    @update()

  onSignUp: ->
    console.log 'onSignUp validate first'
    App.Modules.Home.actions.apiSignUp
      name: @inputs.name.value
      password: @inputs.password.value

  onApiSignUpCompleted: (res) ->
    console.log 'c', res

  onApiSignUpFailed: (res) ->
    console.log 'f', res

  onRegisterComponents: (args) ->
    for name, element of args
      @inputs[name] = element

  loadData: (data) ->
    @update()

  props: ->
    display: @display
    user: @user
    form: @form

  update: ->
    @trigger @props

module.exports = HomeStore