preload = ->
  game.load.image 'tile', 'lib/assets/img/element_yellow_rectangle_v.png'
  game.load.image 'paddleOne', 'lib/assets/img/paddleBlu.png'
  game.load.image 'paddleTwo', 'lib/assets/img/paddleRed.png'

create = ->
  game.add.sprite 0, 0, 'tile'
  game.add.sprite 0, 300, 'paddleOne'

update = ->


game = new Phaser.Game 800, 600, Phaser.AUTO, '', { preload: preload, create: create, update: update }
