class Ball extends Phaser.Sprite
  constructor: (game, x, y, image) ->
    super game, x, y, image

    @anchor.setTo 0.5, 0.5

    game.physics.arcade.enable @
    @body.velocity = x: 300, y: game.rnd.integerInRange -100, 100
    @body.bounce = x: 1, y: 1
    @body.collideWorldBounds = true

  onPlayerCollide: (player) ->
    if @y < player.y
      @body.velocity.y = (player.y - @y) * -3
    else if @y > player.y
      @body.velocity.y = (@y - player.y) * 3
    else
      @body.velocity.y = game.rnd.integerInRange -1, 1

  update: ->
