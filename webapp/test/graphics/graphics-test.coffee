Graphics = require '../../app/scripts/graphics/graphics.coffee'
THREE = require 'three'
must = require 'must'
describe 'graphics', ->

  graphics = new Graphics()
  graphics.getAspectRatio = sinon.stub().returns(1440 / 900)
  describe 'init', ->
    
    graphics.init()

    it 'should create scene', ->
      graphics.scene.must.be.an.instanceOf(THREE.Scene)

    it 'should create PerspectiveCamera', ->
      graphics.camera.must.be.an.instanceOf(THREE.PerspectiveCamera)
      
