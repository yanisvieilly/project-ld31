class Ball extends Phaser.Sprite
  constructor: (game, x, y, image) ->
    super game, x, y, image

    game.physics.arcade.enable @
    @body.velocity = x: 300, y: game.rnd.integerInRange -100, 100
    @body.bounce = x: 1, y: 1
    @body.collideWorldBounds = true

  update: ->
