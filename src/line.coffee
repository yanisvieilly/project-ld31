class Line extends Phaser.Sprite
  constructor: (game, x, y, image, @player) ->
    super game, x, y, image

    @height = game.world.height

    game.physics.arcade.enable @
    @body.immovable = true

    @immune = false

  getImmune: -> @immune

  setImmune: (value) ->
    @immune = value
    if @immune
      @loadTexture if @player.id is Player.LEFT then 'lineOneImmune' else 'lineTwoImmune'
    else
      @loadTexture if @player.id is Player.LEFT then 'lineOne' else 'lineTwo'
