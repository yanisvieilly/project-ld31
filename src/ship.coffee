class Ship extends Phaser.Sprite
  constructor: (game, x, y, image, @player) ->
    super game, x, y, image

    @anchor.setTo 0.5, 0.5

    game.physics.arcade.enable @
    @body.immovable = true
