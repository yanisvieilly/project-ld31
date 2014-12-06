TILE_SIZE = {width: 32, height: 64}

class Level
  constructor: (levelMap) ->
    @levelMap = levelMap

  create: ->
    console.log 'create'
    x = 0
    y = 0
    for line, lineIdx in @levelMap
      console.log line
      x = 0
      y = lineIdx * TILE_SIZE.height
      for tile, tileIdx in line
        console.log tile, x, y
        game.add.sprite x, y, tile
        x += TILE_SIZE.width

  _getRect: (levelMap) ->
