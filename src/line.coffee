class Line extends Phaser.Sprite
  constructor: (game, x, y, image) ->
    super game, x, y, image

    @height = game.world.height

    game.physics.arcade.enable @
    @body.immovable = true
