playerOne = null
playerTwo = null
level_map = [
  ['tile_red', 'tile_red']
  ['tile_purple', 'tile_purple']
  ['tile_blue', 'tile_blue', 'void', 'tile_blue', 'tile_blue']
  ['tile_blue', 'tile_blue', 'void', 'tile_blue', 'tile_blue']
  ['tile_red', 'tile_red']
  ['tile_purple', 'tile_purple']
]

###
# Phaser hooks
###

preload = ->
  # Loading tiles
  game.load.image 'tile_blue', 'lib/assets/img/element_blue_rectangle_v.png'
  game.load.image 'tile_green', 'lib/assets/img/element_green_rectangle_v.png'
  game.load.image 'tile_yellow', 'lib/assets/img/element_yellow_rectangle_v.png'
  game.load.image 'tile_purple', 'lib/assets/img/element_purple_rectangle_v.png'
  game.load.image 'tile_red', 'lib/assets/img/element_red_rectangle_v.png'
  game.load.image 'tile_grey', 'lib/assets/img/element_grey_rectangle_v.png'

  # Loading paddles
  game.load.image 'paddleOne', 'lib/assets/img/paddleBlu_v.png'
  game.load.image 'paddleTwo', 'lib/assets/img/paddleRed_v.png'

  # Loading balls
  game.load.image 'ballOne', 'lib/assets/img/ballGrey.png'
  game.load.image 'ballTwo', 'lib/assets/img/ballBlue.png'

create = ->
  game.physics.startSystem Phaser.Physics.ARCADE

  level = new Level level_map
  level.create()

  playerOne = new Player 10, 248, 'paddleOne', up: Phaser.Keyboard.Z, down: Phaser.Keyboard.S
  playerTwo = new Player 766, 248, 'paddleTwo', up: Phaser.Keyboard.UP, down: Phaser.Keyboard.DOWN

update = ->
  playerOne.update()
  playerTwo.update()

game = new Phaser.Game 800, 600, Phaser.AUTO, '', { preload: preload, create: create, update: update }
