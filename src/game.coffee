playerOne = null
playerTwo = null
level_map = [
  ['tile_blue', 'tile_green', 'tile_blue'],
  ['tile_blue', 'tile_green', 'tile_blue'],
  ['tile_blue', 'tile_green', 'tile_blue'],
  ['tile_blue', 'tile_green', 'tile_blue']
]

###
# Phaser hooks
###

preload = ->
  game.load.image 'tile_blue', 'lib/assets/img/element_blue_rectangle_v.png'
  game.load.image 'tile_green', 'lib/assets/img/element_green_rectangle_v.png'
  game.load.image 'paddleOne', 'lib/assets/img/paddleBlu_v.png'
  game.load.image 'paddleTwo', 'lib/assets/img/paddleRed_v.png'

create = ->
  level = new Level level_map
  level.create()

  playerOne = new Player 10, 248, 'paddleOne', up: Phaser.Keyboard.Z, down: Phaser.Keyboard.S
  playerTwo = new Player 766, 248, 'paddleTwo', up: Phaser.Keyboard.UP, down: Phaser.Keyboard.DOWN

update = ->
  playerOne.update()
  playerTwo.update()

game = new Phaser.Game 800, 600, Phaser.AUTO, '', { preload: preload, create: create, update: update }
