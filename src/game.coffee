preload = ->
  game.load.image 'paddleOne', 'lib/assets/paddleBlu.png'
  game.load.image 'paddleTwo', 'lib/assets/paddleRed.png'

create = ->
  game.add.sprite 0, 300, 'paddleOne'

update = ->


game = new Phaser.Game 800, 600, Phaser.AUTO, '', { preload: preload, create: create, update: update }
