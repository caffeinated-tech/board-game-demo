{ div, h1 } = React.DOM
LogInForm = require('./log_in_form')
SignUpForm = require('./sign_up_form')


class Home extends React.Component
  render: ->
    console.log 'render the Home', @props
    div {},
      h1 {},
        'Welcome to the React Board Game Demo'
      div {}
        LogInForm()
        div {}
        SignUpForm()

module.exports = React.createFactory Home