class Level
  constructor: (levelMap) ->
    @levelMap = levelMap

  create: ->
    @bricksGroup = game.add.group()
    @bricksGroup.enableBody = true
    @bricks = {}

    rect = @_getRect(@levelMap)
    x = 0
    y = game.world.height / 2.0 - rect.height / 2.0
    idx = 0
    for line, lineIdx in @levelMap
      lineWidth = line.length * BRICK_SIZE.width
      x = game.world.width / 2.0 - lineWidth / 2.0
      y += BRICK_SIZE.height if lineIdx > 0
      for tileName, tileIdx in line
        if tileName != 'void'
          brickSprite = @bricksGroup.create x, y, tileName
          brickSprite.name = "tile_#{idx}"
          @bricks[brickSprite.name] = new Brick(brickSprite)
        x += BRICK_SIZE.width
        idx++

  onCollide: (ballSprite, brickSprite) =>
    score = @bricks[brickSprite.name].onCollide()
    ballSprite.score += score


  _getRect: (levelMap) ->
    maxLineLength = 0
    for line in levelMap
      maxLineLength = Math.max maxLineLength, line.length

    width = maxLineLength * BRICK_SIZE.width
    height = levelMap.length * BRICK_SIZE.height

    return {width: width, height: height}
