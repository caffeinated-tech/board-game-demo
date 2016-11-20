# load libraries
window.React = require 'react'
window.ReactDOM = require 'react-dom'
window.ReactRouter = require 'react-router'
window.Reflux = require 'reflux'
window.RefluxPromise = require 'reflux-promise'
window.Bluebird = require 'bluebird'
window.ReactDnD = require 'react-dnd'
window.ActionCable = require 'actioncable'

window.Promise = window.Bluebird
window.Cable = ActionCable.createConsumer()
Reflux.use(RefluxPromise(window.Bluebird))

require('./monkey_patches')()
require('./constants')

# load modules
window.App = {} 
window.App.Helpers =  require './helpers/helper'
window.App.Modules = require './modules/module'
window.App.Initializer = require './initializer'


window.App.Initializer.connectStores()
window.App.Initializer.populateStores()
# finally render the view
window.App.Initializer.mount()