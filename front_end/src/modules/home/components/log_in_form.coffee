{ div, h2 } = React.DOM

EmailInput = require('./email_input')
PasswordInput = require('./password_input')
SwitchFormLink = require('./switch_form_link')
SubmitButton = require('./submit_button')

class LogInForm extends React.Component
  render: ->
    div {},
      h2 {},
        'Log In'
      div {}
        EmailInput @props
        PasswordInput @props
        SubmitButton
          onClick: App.Modules.Home.actions.logIn
          ,
          "Log in"
        SwitchFormLink {},
          "Signup Instead"  
        
module.exports = React.createFactory LogInForm