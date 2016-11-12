
class ConntectStore extends React.Component
  constructor: (props) ->
    super(props)
    @state = @store.props()

  onStatusChange: (newProps) =>
    @setState(newProps)

  componentDidMount: ->
    @unsubscribe = @store.listen(@onStatusChange)

  componentWillUnmount: ->
    @unsubscribe()

module.exports = ConntectStore
