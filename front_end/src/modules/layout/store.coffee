
LayoutStore = App.Helpers.CreateStore
  init: ->
    @display = {}
    @user = null

  registerListeners: ->
    @listenTo App.Modules.Home.store, @_getUser

  _getUser: (data) ->
    return unless data.user
    @user = data.user
    @update()

  props: ->
    display: @display
    user: @user

module.exports = LayoutStore