console.log 'hello world'

# load libraries
window.React = require 'react'
window.ReactDOM = require 'react-dom'
window.ReactRouter = require 'react-router'
window.Reflux = require 'reflux'
window.RefluxPromise = require 'reflux-promise'
window.Bluebird = require 'bluebird'
window.Promise = window.Bluebird
window.ReactDnD = require 'react-dnd'

Reflux.use(RefluxPromise(window.Bluebird))

require('./monkey_patches')()

# load modules
window.App = {} 
window.App.Helpers =  require './helpers/helper'
window.App.Modules = require './modules/module'
window.App.Initializer = require './initializer'


window.App.Initializer.connectStores()
window.App.Initializer.populateStores()
# finally render the view
window.App.Initializer.mount()