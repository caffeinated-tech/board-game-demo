console.log 'hello world'

# load libraries
window.React = require 'react'
window.ReactDOM = require 'react-dom'
window.Reflux = require 'reflux'
window.ReactDnD = require 'react-dnd'

window.Game = 
  Modules: require './modules/module'
  Initializer: require './initializer'

window.Game.Initializer.mount()