{ div, h2 } = React.DOM

EmailInput = require('./email_input')
PasswordInput = require('./password_input')
SwitchFormLink = require('./switch_form_link')

class LogInForm extends React.Component
  render: ->
    div {},
      h2 {},
        'Log In'
      div {}
        EmailInput()
        PasswordInput()
        SwitchFormLink {},
          "Signup Instead"  
        
module.exports = React.createFactory LogInForm