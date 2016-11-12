{ div, input, label } = React.DOM

Error = require('./error')

class NameInput extends React.Component
  render: ->
    div {},
      label {},
        'User name: '
      input {}
      if @props.form.errors.nameTaken
        Error {},
          'This name is already taken'

module.exports = React.createFactory NameInput