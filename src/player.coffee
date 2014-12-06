class Player
  constructor: (@x, @y, @image) ->
    @item = game.add.sprite @x, @y, @image

  update: ->
    @item.y -= 5 if cursors.up.isDown
    @item.y += 5 if cursors.down.isDown
