
CreateStore = (args={}) ->
  args.init ?= ->
    @display = {}
    @form = {}
    @inputs = {}

  args.registerListeners ?= -> null

  args.onRegisterComponents ?= (args) ->
    for name, element of args
      @inputs[name] = element

  args.props ?= ->
    display: @display
    form: @form

  args.update ?= ->
    @trigger @props()

  args._anyErrors ?= ->
    for name, error of @form.errors
      return true if error

  Reflux.createStore args

module.exports = CreateStore