
class ConntectStore extends React.Component
  
  onStatusChange: (newProps) =>
    console.log 'onStatusChange', newProps
    @setState(newProps)

  componentDidMount: ->
    console.log 'componentDidMount'
    @unsubscribe = @store.listen(@onStatusChange)
  
  componentWillUnmount: ->
    console.log 'componentWillUnmount'
    @unsubscribe()

module.exports = ConntectStore
