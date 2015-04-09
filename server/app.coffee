express = require 'express'

router = express.Router()
bodyParser = require 'body-parser'

app = express()

app.use express.static(__dirname + '/../webapp/dist')
app.use bodyParser.json()
app.use bodyParser.urlencoded
  extended : true

app.use(router)

module.exports = app
