debug = require('debug')('t3tris')
app = require '../app.coffee'
config = require '../config.json'

port = Number process.env.port || 5000 

server = app.listen port, ->
  debug 'Server running on port: ' + port

