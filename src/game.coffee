cursors = null
playerOne = null
level = [
  ['tile_blue', 'tile_green', 'tile_blue'],
  ['tile_blue', 'tile_green', 'tile_blue'],
  ['tile_blue', 'tile_green', 'tile_blue'],
  ['tile_blue', 'tile_green', 'tile_blue']
]

TILE_SIZE = {width: 32, height: 64}

initLevel = (level) ->
  x = 0
  y = 0
  for line, line_idx in level
    console.log line
    x = 0
    y = line_idx * TILE_SIZE.height
    for tile, tile_idx in line
      console.log tile, x, y
      game.add.sprite x, y, tile
      x += TILE_SIZE.width

###
# Phaser hooks
###

preload = ->
  game.load.image 'tile_blue', 'lib/assets/img/element_blue_rectangle_v.png'
  game.load.image 'tile_green', 'lib/assets/img/element_green_rectangle_v.png'
  game.load.image 'tile_blue', 'lib/assets/img/element_blue_rectangle_v.png'
  game.load.image 'paddleOne', 'lib/assets/img/paddleBlu_v.png'
  game.load.image 'paddleTwo', 'lib/assets/img/paddleRed_v.png'

create = ->
  initLevel level
  playerOne = game.add.sprite 10, 248, 'paddleOne'

  cursors = game.input.keyboard.createCursorKeys()

update = ->
  if cursors.up.isDown
    playerOne.y -= 5

  if cursors.down.isDown
    playerOne.y += 5

game = new Phaser.Game 800, 600, Phaser.AUTO, '', { preload: preload, create: create, update: update }
