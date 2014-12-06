TILE_SIZE = {width: 32, height: 64}

class Level
  constructor: (level_map) ->
    @level_map = level_map

  create: ->
    console.log 'create'
    x = 0
    y = 0
    for line, line_idx in @level_map
      console.log line
      x = 0
      y = line_idx * TILE_SIZE.height
      for tile, tile_idx in line
        console.log tile, x, y
        game.add.sprite x, y, tile
        x += TILE_SIZE.width
