class Ball
  constructor: (x, y, image) ->
    @item = game.add.sprite x, y, image

    game.physics.arcade.enable @item
    @item.body.velocity = x: 300, y: game.rnd.integerInRange -100, 100
    @item.body.bounce = x: 1, y: 1
    @item.body.collideWorldBounds = true

  update: ->
