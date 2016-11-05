{ div } = React.DOM

class Home extends React.Component
  render: ->
    console.log 'render the Home'
    div {},
      'This is the Home'

module.exports = Home