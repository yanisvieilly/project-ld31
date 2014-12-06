cursors = null
playerOne = null

preload = ->
  game.load.image 'tile', 'lib/assets/img/element_yellow_rectangle_v.png'
  game.load.image 'paddleOne', 'lib/assets/img/paddleBlu_v.png'
  game.load.image 'paddleTwo', 'lib/assets/img/paddleRed_v.png'

create = ->
  game.add.sprite 0, 0, 'tile'
  playerOne = game.add.sprite 10, 248, 'paddleOne'

  cursors = game.input.keyboard.createCursorKeys()

update = ->
  if cursors.up.isDown
    playerOne.y -= 5

  if cursors.down.isDown
    playerOne.y += 5

game = new Phaser.Game 800, 600, Phaser.AUTO, '', { preload: preload, create: create, update: update }
