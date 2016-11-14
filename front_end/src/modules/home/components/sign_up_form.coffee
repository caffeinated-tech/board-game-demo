{ div, h2, form, fieldset } = React.DOM

NameInput = require('./name_input')
PasswordInput = require('./password_input')
SwitchFormLink = require('./switch_form_link')
SubmitButton = require('./submit_button')

class SignUpForm extends React.Component
  render: ->
    div {},
      h2 {},
        'Sign up'
      form { className: 'pure-form pure-form-aligned' },
        fieldset {},
          NameInput @props
          PasswordInput @props
          div { className: 'pure-controls' },
            SubmitButton
              onClick: App.Modules.Home.actions.signUp
              ,
              "Sign up"
            SwitchFormLink {},
              "Login Instead"

module.exports = React.createFactory SignUpForm