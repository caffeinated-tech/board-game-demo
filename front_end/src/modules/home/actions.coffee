
HomeActions = Reflux.createActions
  signUp: {}
  logIn: {}
  switchForm: {}
  registerComponents: {}
  apiSignUp: { async: true }
  apiLogIn: { async: true }

HomeActions.apiSignUp.listen (args) ->
  App.Helpers.Api.POST
    url: 'api/users'
    data:
      user: args

module.exports = HomeActions