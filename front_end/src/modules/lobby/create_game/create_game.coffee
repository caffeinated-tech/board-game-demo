{ div, a, h2, ul, li, a } = React.DOM

class CreateGame extends React.Component
  render: ->
    console.log 'render the CreateGame', @props
    div {},
      'This is the CreateGame'
      
module.exports = CreateGame