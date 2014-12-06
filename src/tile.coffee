class Tile
    constructor: (x, y, imgName, tilesGroup) ->
      if imgName != 'void'
        @item = tilesGroup.create x, y, imgName
        @item.body.immovable = true
