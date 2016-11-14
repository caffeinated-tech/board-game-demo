{ div, h1 } = React.DOM
LogInForm = require('./log_in_form')
SignUpForm = require('./sign_up_form')
WelcomeScreen = require('./welcome_screen')


class Home extends React.Component
  render: ->
    div {},
      h1 {},
        'Welcome to the React Board Game Demo'
      div {}
        # already logged in?
        if @props.user?.id?
          WelcomeScreen @props
        else if @props.display.login
          LogInForm @props
        else
          SignUpForm @props

module.exports = React.createFactory Home