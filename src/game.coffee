playerOne = null
playerTwo = null
players = null
ballOne = null
ballTwo = null
balls = null
level = null
lifeTextOne = ''
lifeTextTwo = ''
lineOne = null
lineTwo = null
level_map = [
  ['brick_blue', 'brk3_grey', 'void', 'brk3_grey', 'brick_blue']
  ['brick_blue', 'brk3_grey', 'void', 'brk3_grey', 'brick_blue']
  ['brick_blue', 'brk3_grey', 'void', 'brk3_grey', 'brick_blue']
  ['brick_blue', 'brk3_grey', 'void', 'brk3_grey', 'brick_blue']
  ['brick_blue', 'brick_red']
  ['brick_blue', 'brick_purple']
  ['brick_blue', 'brk3_grey', 'void', 'brk3_grey', 'brick_blue']
  ['brick_blue', 'brk3_grey', 'void', 'brk3_grey', 'brick_blue']
  ['brick_blue', 'brick_red']
  ['brick_blue', 'brick_purple']
  ['brick_blue', 'brk3_grey', 'void', 'brk3_grey', 'brick_blue']
  ['brick_blue', 'brk3_grey', 'void', 'brk3_grey', 'brick_blue']
  ['brick_blue', 'brk3_grey', 'void', 'brk3_grey', 'brick_blue']
  ['brick_blue', 'brk3_grey', 'void', 'brk3_grey', 'brick_blue']
  ['brick_blue', 'brick_red']
  ['brick_blue', 'brick_purple']
  ['brick_blue', 'brk3_grey', 'void', 'brk3_grey', 'brick_blue']
  ['brick_blue', 'brk3_grey', 'void', 'brk3_grey', 'brick_blue']
  ['brick_blue', 'brick_red']
  ['brick_blue', 'brick_purple']
]

# loadSprite = (id, image, size) ->
#   if size
#     game.load.spritesheet

###
# Phaser hooks
###

preload = ->
  # Load background
  game.load.image 'background', 'lib/assets/img/background.png'

  # Loading bricks
  game.load.image 'brick_blue', 'lib/assets/img/element_blue_rectangle_v.png'
  game.load.image 'brick_green', 'lib/assets/img/element_green_rectangle_v.png'
  game.load.image 'brick_yellow', 'lib/assets/img/element_yellow_rectangle_v.png'
  game.load.image 'brick_purple', 'lib/assets/img/element_purple_rectangle_v.png'
  game.load.image 'brick_red', 'lib/assets/img/element_red_rectangle_v.png'
  game.load.image 'brick_grey', 'lib/assets/img/element_grey_rectangle_v.png'
  game.load.spritesheet 'brk3_grey', 'lib/assets/img/brick_brk3_grey.png', BRICK_SIZE.width, BRICK_SIZE.height

  # Loading paddles
  # game.load.image 'paddleOne', 'lib/assets/img/paddle_blue_default.png'
  # game.load.image 'paddleTwo', 'lib/assets/img/paddle_red_default.png'
  Player.loadAssets()

  # Loading ships
  game.load.image 'shipOne', 'lib/assets/img/playerShip1_blue.png'
  game.load.image 'shipTwo', 'lib/assets/img/playerShip3_red.png'

  # Loading balls
  game.load.spritesheet 'ballOne', 'lib/assets/img/ballBlue.png', BALL_SIZE.width, BALL_SIZE.height
  game.load.spritesheet 'ballTwo', 'lib/assets/img/ballRed.png', BALL_SIZE.width, BALL_SIZE.height

  # Load droppables
  Droppable.loadAssets()

  game.load.image 'bulletLeftOne', 'lib/assets/img/laserBlue03.png'
  game.load.image 'bulletRightOne', 'lib/assets/img/laserRed03.png'

  game.load.image 'lineOne', 'lib/assets/img/blueLine.png'
  game.load.image 'lineTwo', 'lib/assets/img/redLine.png'

  game.load.image 'lineOneImmune', 'lib/assets/img/blueLineImmune.png'
  game.load.image 'lineTwoImmune', 'lib/assets/img/redLineImmune.png'

  game.load.image 'shield', 'lib/assets/img/shield.png'

create = ->

  game.physics.startSystem Phaser.Physics.ARCADE
  # game.physics.arcade.checkCollision.left = false
  # game.physics.arcade.checkCollision.right = false

  # background = game.add.image 0, 0, 'background'
  # background = new Phaser.TileSprite
  # background.width = game.width
  # background.height = game.height
  background = game.add.tileSprite 0, 0, game.width, game.height, 'background'

  level = new Level level_map
  level.create()

  playerOne = new Player game, 60, START_Y, Player.PaddleSize.DEFAULT,
    up: Phaser.Keyboard.E
    down: Phaser.Keyboard.D
    shoot: Phaser.Keyboard.SPACEBAR,
    Player.LEFT
  playerTwo = new Player game, game.world.width - 60, START_Y, Player.PaddleSize.DEFAULT,
    up: Phaser.Keyboard.UP
    down: Phaser.Keyboard.DOWN
    shoot: Phaser.Keyboard.ENTER,
    Player.RIGHT

  players = game.add.group()
  players.addMultiple [playerOne, playerTwo]

  ballOne = new Ball game, playerOne.x + 25, START_Y, 'ballOne', playerOne
  ballTwo = new Ball game, playerTwo.x - 25, START_Y, 'ballTwo', playerTwo
  playerOne.ball = ballOne
  playerTwo.ball = ballTwo

  balls = game.add.group()
  balls.addMultiple [ballOne, ballTwo]

  lifeTextOne = game.add.text 80, 20, "Life: #{playerOne.health}", fontSize: '32px', fill: '#FFF'
  lifeTextTwo = game.add.text game.world.width - 190, 20, "Life: #{playerTwo.health}", fontSize: '32px', fill: '#FFF'

  lineOne = new Line game, playerOne.x - 16, 0, 'lineOne', playerOne
  playerOne.line = lineOne
  lineTwo = new Line game, playerTwo.x + 13, 0, 'lineTwo', playerTwo
  playerTwo.line = lineTwo
  lines = game.add.group()
  lines.addMultiple [lineOne, lineTwo]

update = ->
  playerOne.update()
  playerTwo.update()
  ballOne.update()
  ballTwo.update()

  lifeTextOne.text = "Life: #{playerOne.health}"
  lifeTextTwo.text = "Life: #{playerTwo.health}"

  game.physics.arcade.collide balls, level.bricksGroup, null, level.onBallBrickShouldCollide, level
  game.physics.arcade.collide balls, players, (ball, player) -> ball.onPlayerCollide player

  game.physics.arcade.collide playerOne, playerTwo.bullets, playerOne.onBulletCollide, null, playerOne
  game.physics.arcade.collide playerTwo, playerOne.bullets, playerTwo.onBulletCollide, null, playerTwo

  game.physics.arcade.collide ballOne, lineOne
  game.physics.arcade.collide ballTwo, lineTwo

  game.physics.arcade.collide ballOne, lineTwo, ballOne.onLineOverlap, null, ballOne
  game.physics.arcade.collide ballTwo, lineOne, ballTwo.onLineOverlap, null, ballTwo

  # game.physics.arcade.overlap playerOne, level.droppablesGroup, level.onPlayerDroppableOverlap
  # game.physics.arcade.overlap playerTwo, level.droppablesGroup, level.onPlayerDroppableOverlap
  game.physics.arcade.overlap players, level.droppablesGroup, level.onPlayerDroppableOverlap

  game.physics.arcade.overlap playerOne.ship, level.droppablesGroup, (ship, droppable) -> level.onPlayerDroppableOverlap ship.player, droppable
  game.physics.arcade.overlap playerTwo.ship, level.droppablesGroup, (ship, droppable) -> level.onPlayerDroppableOverlap ship.player, droppable

game = new Phaser.Game window.innerWidth, window.innerHeight, Phaser.AUTO, '', { preload: preload, create: create, update: update }
