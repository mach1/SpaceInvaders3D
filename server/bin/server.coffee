debug = require('debug')('t3tris')
app = require '../app.coffee'
config = require '../config.json'

port = process.env.PORT || 5000
console.log process.env.PORT

server = app.listen port, ->
  debug 'Server running on port: ' + port

