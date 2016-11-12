{ span } = React.DOM

class Error extends React.Component
  render: ->
    span
      className: 'error'
      ,
      @props.children


module.exports = React.createFactory Error