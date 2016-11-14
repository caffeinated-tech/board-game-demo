{ div, input, label } = React.DOM

Error = require('./error')

class NameInput extends React.Component
  render: ->
    div { className: 'pure-control-group' },
      label {},
        'User name '
      input 
        type: 'text'
        ref: 'name'
        placeholder: 'Name'
      if @props.form.errors.nameTaken
        Error {},
          'This name is already taken'
      if @props.form.errors.nameMissing
        Error {},
          'Please enter a name'
      if @props.form.errors.wrongName
        Error {},
          'This name doesn\'t exist'

  componentDidMount: ->
    App.Modules.Home.actions.registerComponents
      name: @refs.name


module.exports = React.createFactory NameInput