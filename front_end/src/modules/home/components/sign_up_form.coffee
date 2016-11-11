{ div, h2 } = React.DOM

EmailInput = require('./email_input')
PasswordInput = require('./password_input')

class SignUpForm extends React.Component
  render: ->
    div {},
      h2 {},
        'Sign up'
      div {}
        EmailInput()
        PasswordInput()

module.exports = React.createFactory SignUpForm