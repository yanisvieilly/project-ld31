TILE_SIZE = {width: 32, height: 64}

class Level
  constructor: (levelMap) ->
    @levelMap = levelMap

  create: ->
    rect = @_getRect(@levelMap)
    x = 0
    y = game.world.height / 2.0 - rect.height / 2.0
    @tiles = []
    for line, lineIdx in @levelMap
      tilesLine = []
      lineWidth = line.length * TILE_SIZE.width
      x = game.world.width / 2.0 - lineWidth / 2.0
      y += TILE_SIZE.height if lineIdx > 0
      for tile, tileIdx in line
        tilesLine.push new Tile(x, y, tile)
        x += TILE_SIZE.width

  _getRect: (levelMap) ->
    maxLineLength = 0
    for line in levelMap
      maxLineLength = Math.max maxLineLength, line.length

    width = maxLineLength * TILE_SIZE.width
    height = levelMap.length * TILE_SIZE.height

    return {width: width, height: height}
