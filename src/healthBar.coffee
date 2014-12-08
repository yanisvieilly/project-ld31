class HealthBar
  @loadAssets: ->
    game.load.image 'health', 'lib/assets/img/health.png'

  constructor: (@player, direction, game, x, y) ->
    # super game, x, y, 'health'

    @barSprite = game.add.tileSprite x, y, HEALTHBAR_SIZE.width, HEALTHBAR_SIZE.height, 'health'
    if direction < 0
      @barSprite.x += @barSprite.width
      @barSprite.anchor.setTo 1, 0
    @game = game

  # convert a number to a color using hsl (0 is red, 1 is green)
  _getHealthColor: (health) ->
    # as the function expects a value between 0 and 1, and red = 0° and green = 120°
    # we convert the input to the appropriate hue value
    hue = health * 1.2 / 360;
    # we convert hsl to rgb (saturation 100%, lightness 50%)
    rgb = HSL_TO_RGB(hue, 1, .5)
    # we format to css value and return
    # return r: rgb[0], g: rgb[1], b: rgb[2]
    return rgb

  update: ->
    @game.world.bringToTop @barSprite
    color = @_getHealthColor (@player.health / PLAYER_MAX_HEALTH) * 100
    width = (@player.health / PLAYER_MAX_HEALTH) * HEALTHBAR_SIZE.width

    @barSprite.tint = Phaser.Color.getColor(color.r, color.g, color.b)
    @barSprite.width = width
