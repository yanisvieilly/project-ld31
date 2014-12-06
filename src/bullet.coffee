class Bullet extends Phaser.Sprite
  constructor: (game, x, y, image, direction) ->
    super game, x, y, image

    @anchor.setTo 0.5, 0.5

    game.physics.arcade.enable @
    @body.velocity.x = 300 * direction
