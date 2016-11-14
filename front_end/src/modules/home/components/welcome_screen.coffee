{ div, h2 } = React.DOM

class WelcomeScreen extends React.Component
  render: ->
    div {},
      h2 {},
        "Welcome back #{@props.user.name}"
      div {}
        "These are the things you should do..."

module.exports = React.createFactory WelcomeScreen