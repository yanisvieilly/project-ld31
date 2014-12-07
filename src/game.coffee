playerOne = null
playerTwo = null
players = null
ballOne = null
ballTwo = null
balls = null
level = null
lifeTextOne = ''
lifeTextTwo = ''
level_map = [
  ['brick_blue', 'brick_blue', 'void', 'brick_blue', 'brick_blue']
  ['brick_blue', 'brick_blue', 'void', 'brick_blue', 'brick_blue']
  ['brick_blue', 'brick_blue', 'void', 'brick_blue', 'brick_blue']
  ['brick_blue', 'brick_blue', 'void', 'brick_blue', 'brick_blue']
  ['brick_blue', 'brick_red']
  ['brick_blue', 'brick_purple']
  ['brick_blue', 'brick_blue', 'void', 'brick_blue', 'brick_blue']
  ['brick_blue', 'brick_blue', 'void', 'brick_blue', 'brick_blue']
  ['brick_blue', 'brick_red']
  ['brick_blue', 'brick_purple']
  ['brick_blue', 'brick_blue', 'void', 'brick_blue', 'brick_blue']
  ['brick_blue', 'brick_blue', 'void', 'brick_blue', 'brick_blue']
  ['brick_blue', 'brick_blue', 'void', 'brick_blue', 'brick_blue']
  ['brick_blue', 'brick_blue', 'void', 'brick_blue', 'brick_blue']
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

  # Loading bricks
  game.load.image 'brick_blue', 'lib/assets/img/element_blue_rectangle_v.png'
  game.load.image 'brick_green', 'lib/assets/img/element_green_rectangle_v.png'
  game.load.image 'brick_yellow', 'lib/assets/img/element_yellow_rectangle_v.png'
  game.load.image 'brick_purple', 'lib/assets/img/element_purple_rectangle_v.png'
  game.load.image 'brick_red', 'lib/assets/img/element_red_rectangle_v.png'
  game.load.image 'brick_grey', 'lib/assets/img/element_grey_rectangle_v.png'
  game.load.spritesheet 'brk3_grey', 'lib/assets/img/brick_brk3_grey.png', BRICK_SIZE.width, BRICK_SIZE.height

  # Loading paddles
  game.load.image 'paddleOne', 'lib/assets/img/paddleBlu_v.png'
  game.load.image 'paddleTwo', 'lib/assets/img/paddleRed_v.png'

  # Loading balls
  game.load.image 'ballOne', 'lib/assets/img/ballGrey.png'
  game.load.image 'ballTwo', 'lib/assets/img/ballBlue.png'

  # Load droppables
  Droppable.loadAssets()

  game.load.image 'bulletLeftOne', 'lib/assets/img/laserBlue03.png'
  game.load.image 'bulletRightOne', 'lib/assets/img/laserRed03.png'

create = ->
  game.physics.startSystem Phaser.Physics.ARCADE
  # game.physics.arcade.checkCollision.left = false
  # game.physics.arcade.checkCollision.right = false

  background = game.add.image 0, 0, 'background'
  background.width = game.width
  background.height = game.height

  level = new Level level_map
  level.create()

  playerOne = new Player game, 60, 300, 'paddleOne', up: Phaser.Keyboard.E, down: Phaser.Keyboard.D, shoot: Phaser.Keyboard.SPACEBAR, 0
  playerTwo = new Player game, game.world.width - 60, 300, 'paddleTwo', up: Phaser.Keyboard.UP, down: Phaser.Keyboard.DOWN, shoot: Phaser.Keyboard.ENTER, 1

  players = game.add.group()
  players.addMultiple [playerOne, playerTwo]

  ballOne = new Ball game, 40, 300, 'ballOne', playerOne
  ballTwo = new Ball game, game.world.width - 40, 300, 'ballTwo', playerTwo

  balls = game.add.group()
  balls.addMultiple [ballOne, ballTwo]

  lifeTextOne = game.add.text 20, 20, "Life: #{playerOne.life}", fontSize: '32px', fill: '#FFF'
  lifeTextTwo = game.add.text game.world.width - 135, 20, "Life: #{playerTwo.life}", fontSize: '32px', fill: '#FFF'

update = ->
  playerOne.update()
  playerTwo.update()
  ballOne.update()
  ballTwo.update()

  lifeTextOne.text = "Life: #{playerOne.life}"
  lifeTextTwo.text = "Life: #{playerTwo.life}"

  game.physics.arcade.collide balls, level.bricksGroup, level.onBallBrickCollide
  game.physics.arcade.collide balls, players, (ball, player) -> ball.onPlayerCollide player

  game.physics.arcade.collide playerOne, playerTwo.bullets, playerOne.onBulletCollide
  game.physics.arcade.collide playerTwo, playerOne.bullets, playerTwo.onBulletCollide

  # game.physics.arcade.overlap playerOne, level.droppablesGroup, level.onPlayerDroppableOverlap
  # game.physics.arcade.overlap playerTwo, level.droppablesGroup, level.onPlayerDroppableOverlap
  game.physics.arcade.overlap players, level.droppablesGroup, level.onPlayerDroppableOverlap

game = new Phaser.Game window.innerWidth, window.innerHeight, Phaser.AUTO, '', { preload: preload, create: create, update: update }
