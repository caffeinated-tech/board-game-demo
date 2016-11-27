
LayoutStore = App.Helpers.CreateStore
  init: ->
    @display = {}
    @user = null

  registerListeners: ->
    @listenTo App.Modules.Home.store, @_getUser

  _getUser: (data) ->
    console.log '_getUser', data.user
    return unless data.user
    @user = data.user
    @update()

  props: ->
    console.log 'render layout props'
    console.log @user
    display: @display
    user: @user

module.exports = LayoutStore