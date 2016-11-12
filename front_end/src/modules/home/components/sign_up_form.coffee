{ div, h2 } = React.DOM

NameInput = require('./name_input')
PasswordInput = require('./password_input')
SwitchFormLink = require('./switch_form_link')
SubmitButton = require('./submit_button')

class SignUpForm extends React.Component
  render: ->
    div {},
      h2 {},
        'Sign up'
      div {}
        NameInput @props
        PasswordInput @props
        SubmitButton
          onClick: App.Modules.Home.SignUp
          ,
          "Sign up"
        SwitchFormLink {},
          "Login Instead"

module.exports = React.createFactory SignUpForm