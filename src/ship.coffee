class Ship extends Phaser.Sprite
  constructor: (game, x, y, image) ->
    super game, x, y, image
    @anchor.setTo 0.5, 0.5
