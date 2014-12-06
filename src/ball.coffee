class Ball
  constructor: (x, y, image) ->
    @item = game.add.sprite x, y, image

    game.physics.arcade.enable @item
    @item.body.velocity.x = 200
    @item.body.velocity.y = 5
    @item.body.bounce.y = 1
    @item.body.collideWorldBounds = true

  update: ->
