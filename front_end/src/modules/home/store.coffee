
HomeStore = App.Helpers.CreateStore
  init: ->
    @user = {}
    @display = 
      login: true
    @form = 
      errors:
        wrongPassword: false
        wrongName: false
        nameMissing: false
        passwordMissing: false
        nameTaken: false
    @inputs = {}

  registerListeners: ->
    @listenToMany App.Modules.Home.actions

  # actions
  
  onSwitchForm: ->
    @display.login = !@display.login
    @update()

  onSignUp: ->
    @_clearFormErrors()
    @_validateForm()
    @update()
    return if @_anyErrors()

    App.Modules.Home.actions.apiSignUp
      name: @inputs.name.value
      password: @inputs.password.value

  onLogIn: ->
    @_clearFormErrors()
    @_validateForm()
    @update() 
    return if @_anyErrors()
    App.Modules.Home.actions.apiLogIn
      name: @inputs.name.value
      password: @inputs.password.value

  # api actions

  onApiSignUpCompleted: (res) ->
    console.log 'onApiSignUpCompleted', res
    @user = res
    @update()

  onApiSignUpFailed: (res) ->
    switch res.name
      when 'MissingParamError'
        switch res.field
          when 'name' then @form.errors.nameMissing = true
          when 'password' then @form.errors.passwordMissing = true
          else
            @form.errors.genericError = true      
      when 'NameTakenError'
        @form.errors.nameTaken = true
      else
        @form.errors.genericError = true      
    @update()

  onApiLogInCompleted: (res) ->
    @user = res
    @update()

  onApiLogInFailed: (res) ->
    switch res.name
      when 'WrongPasswordError'
        @form.errors.wrongPassword = true
      when 'WrongNameError'
        @form.errors.wrongName = true
      else
        @form.errors.genericError = true      
    @update()

  props: ->
    user: @user
    form: @form
    display: @display

  # various helper methods

  loadUser: (user) ->
    @user = user
    @update()

  _clearFormErrors: ->
    @form.errors = 
      wrongPassword: false
      wrongName: false
      nameMissing: false
      passwordMissing: false
      nameTaken: false

  _validateForm: ->
    @form.errors.passwordMissing = @inputs.password.value.length < 1
    @form.errors.nameMissing = @inputs.name.value.length < 1

  _anyErrors: ->
    for name, error of @form.errors
      return true if error

module.exports = HomeStore