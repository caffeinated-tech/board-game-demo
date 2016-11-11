{ div, input, label } = React.DOM

class EmailInput extends React.Component
  render: ->
    div {},
      label {},
        'Email'
      input {}


module.exports = React.createFactory EmailInput