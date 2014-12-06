preload = ->
  game.load.image 'tile', 'lib/assets/element_yellow_rectangle_v.png'

create = ->
  game.add.sprite 0, 0, 'tile'

update = ->


game = new Phaser.Game 800, 600, Phaser.AUTO, '', { preload: preload, create: create, update: update }
