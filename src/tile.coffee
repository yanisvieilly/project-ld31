class Tile
    constructor: (x, y, imgName) ->
      @item = game.add.sprite x, y, imgName if imgName != 'void'
