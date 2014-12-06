class Player
  constructor: (@x, @y, @image, cursors) ->
    @item = game.add.sprite @x, @y, @image
    @cursors =
      up: game.input.keyboard.addKey cursors.up
      down: game.input.keyboard.addKey cursors.down

  update: ->
    if @cursors.up.isDown && @item.y > 5
      @item.y -= 5
    if @cursors.down.isDown && @item.y < 491
      @item.y += 5
