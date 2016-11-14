
HomeActions = Reflux.createActions
  signUp: {}
  logIn: {}
  switchForm: {}
  registerComponents: {}
  apiSignUp: { asyncResult: true }
  apiLogIn: { asyncResult: true }

HomeActions.apiSignUp.listenAndPromise (args) ->
  App.Helpers.Api.POST
    url: 'api/users'
    data:
      user: args

HomeActions.apiLogIn.listenAndPromise (args) ->
  console.log 'apiLogIn'
  App.Helpers.Api.POST
    url: 'api/users/login'
    data:
      user: args

module.exports = HomeActions