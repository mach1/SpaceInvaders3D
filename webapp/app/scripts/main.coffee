THREE = require 'three'

scene = new THREE.Scene()
camera = new THREE.PerspectiveCamera( 75, window.innerWidth / window.innerHeight, 0.1, 1000)

renderer = new THREE.WebGLRenderer()

renderer.setSize window.innerWidth, window.innerHeight

document.body.appendChild renderer.domElement


ambientLight = new THREE.AmbientLight 292923
scene.add ambientLight


invaderPixels = [
  0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0,
  0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0,
  0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0,
  0, 1, 1, 0, 1, 1, 1, 0, 1, 1, 0,
  1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
  1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1,
  1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1,
  0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0
]
invaderLength = 11
invaderHeight = 8
mesh = new THREE.Object3D()
size = 2
material = new THREE.MeshLambertMaterial(color: 0x00FF00, side: THREE.DoubleSide)

for i in [0..invaderPixels.length]
  if invaderPixels[i]
    x = size * (i % invaderLength)
    y = (invaderHeight * size) - size * (~~(i / invaderLength))
    pixelGeometry = new THREE.BoxGeometry size, size, size

    pixel = new THREE.Mesh pixelGeometry, material
    pixel.position.x = x
    pixel.position.y = y


    mesh.add pixel

scene.add mesh

camera.position.z = 20
camera.position.y = 5
camera.position.x = 11
render = ->
  requestAnimationFrame render
  renderer.render scene, camera
render()
