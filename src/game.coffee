playerOne = null
playerTwo = null
players = null
ballOne = null
ballTwo = null
balls = null
level = null
scoreTextOne = ''
scoreTextTwo = ''
level_map = [
  ['brk3_grey', 'tile_red']
  ['brk3_grey', 'tile_purple']
  ['brk3_grey', 'tile_blue', 'void', 'tile_blue', 'tile_blue']
  ['brk3_grey', 'tile_blue', 'void', 'tile_blue', 'tile_blue']
  ['brk3_grey', 'tile_red']
  ['brk3_grey', 'tile_purple']
]

# loadSprite = (id, image, size) ->
#   if size
#     game.load.spritesheet

###
# Phaser hooks
###

preload = ->
  # Load background
  game.load.image 'background', 'lib/assets/img/background.jpg'

  # Loading tiles
  game.load.image 'tile_blue', 'lib/assets/img/element_blue_rectangle_v.png'
  game.load.image 'tile_green', 'lib/assets/img/element_green_rectangle_v.png'
  game.load.image 'tile_yellow', 'lib/assets/img/element_yellow_rectangle_v.png'
  game.load.image 'tile_purple', 'lib/assets/img/element_purple_rectangle_v.png'
  game.load.image 'tile_red', 'lib/assets/img/element_red_rectangle_v.png'
  game.load.image 'tile_grey', 'lib/assets/img/element_grey_rectangle_v.png'
  game.load.spritesheet 'brk3_grey', 'lib/assets/img/brick_brk3_grey.png', TILE_SIZE.width, TILE_SIZE.height

  # Loading paddles
  game.load.image 'paddleOne', 'lib/assets/img/paddleBlu_v.png'
  game.load.image 'paddleTwo', 'lib/assets/img/paddleRed_v.png'

  # Loading balls
  game.load.image 'ballOne', 'lib/assets/img/ballGrey.png'
  game.load.image 'ballTwo', 'lib/assets/img/ballBlue.png'

create = ->
  game.physics.startSystem Phaser.Physics.ARCADE
  # game.physics.arcade.checkCollision.left = false
  # game.physics.arcade.checkCollision.right = false

  game.add.sprite 0, 0, 'background'

  level = new Level level_map
  level.create()

  playerOne = new Player game, 25, 300, 'paddleOne', up: Phaser.Keyboard.Z, down: Phaser.Keyboard.S
  playerTwo = new Player game, game.world.width - 25, 300, 'paddleTwo', up: Phaser.Keyboard.UP, down: Phaser.Keyboard.DOWN

  players = game.add.group()
  players.addMultiple [playerOne, playerTwo]

  ballOne = new Ball game, 40, 300, 'ballOne'
  ballTwo = new Ball game, game.world.width - 40, 300, 'ballTwo'

  balls = game.add.group()
  balls.addMultiple [ballOne, ballTwo]

  scoreTextOne = game.add.text 20, 20, "Score: #{ballOne.score}", fontSize: '32px', fill: '#FFF'
  scoreTextTwo = game.add.text game.world.width - 135, 20, "Score: #{ballTwo.score}", fontSize: '32px', fill: '#FFF'

update = ->
  playerOne.update()
  playerTwo.update()
  ballOne.update()
  ballTwo.update()

  scoreTextOne.text = "Score: #{ballOne.score}"
  scoreTextTwo.text = "Score: #{ballTwo.score}"

  game.physics.arcade.collide balls, level.tilesGroup, level.onCollide
  game.physics.arcade.collide balls, players, (ball, player) -> ball.onPlayerCollide player

game = new Phaser.Game window.innerWidth, window.innerHeight, Phaser.AUTO, '', { preload: preload, create: create, update: update }
