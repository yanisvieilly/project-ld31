class Level
  constructor: (levelMap) ->
    @levelMap = levelMap

  create: ->
    @tilesGroup = game.add.group()
    @tilesGroup.enableBody = true
    @tiles = {}

    rect = @_getRect(@levelMap)
    x = 0
    y = game.world.height / 2.0 - rect.height / 2.0
    idx = 0
    for line, lineIdx in @levelMap
      tilesLine = []
      lineWidth = line.length * TILE_SIZE.width
      x = game.world.width / 2.0 - lineWidth / 2.0
      y += TILE_SIZE.height if lineIdx > 0
      for tileName, tileIdx in line
        if tileName != 'void'
          tileSprite = @tilesGroup.create x, y, tileName
          tileSprite.name = "tile_#{idx}"
          @tiles[tileSprite.name] = new Tile(tileSprite)
        x += TILE_SIZE.width
        idx++

  onCollide: (ballSprite, tileSprite) =>
    score = @tiles[tileSprite.name].onCollide()
    ballSprite.score += score


  _getRect: (levelMap) ->
    maxLineLength = 0
    for line in levelMap
      maxLineLength = Math.max maxLineLength, line.length

    width = maxLineLength * TILE_SIZE.width
    height = levelMap.length * TILE_SIZE.height

    return {width: width, height: height}
