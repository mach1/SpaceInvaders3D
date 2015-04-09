THREE = require 'three'

class Graphics
  init: ->
    @scene = new THREE.Scene()
    @camera = new THREE.PerspectiveCamera(45, @getAspectRatio(), 0.1, 1000)

  getAspectRatio: ->
    return window.innerWidth / window.innerHeight
module.exports = Graphics
