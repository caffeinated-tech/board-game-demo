{ div, h2 } = React.DOM

NameInput = require('./name_input')
PasswordInput = require('./password_input')
SwitchFormLink = require('./switch_form_link')
SubmitButton = require('./submit_button')

class LogInForm extends React.Component
  render: ->
    div {},
      h2 {},
        'Log In'
      div {}
        NameInput @props
        PasswordInput @props
        SubmitButton
          onClick: App.Modules.Home.actions.signUp
          ,
          "Log in"
        SwitchFormLink {},
          "Signup Instead"  
        
module.exports = React.createFactory LogInForm