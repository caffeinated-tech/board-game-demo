{ div, h2 } = React.DOM

EmailInput = require('./email_input')
PasswordInput = require('./password_input')

class LogInForm extends React.Component
  render: ->
    div {},
      h2 {},
        'Log In'
      div {}
        EmailInput()
        PasswordInput()

      
        
module.exports = React.createFactory LogInForm