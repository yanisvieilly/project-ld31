class Player
  constructor: (@x, @y, @image, cursors) ->
    @item = game.add.sprite @x, @y, @image
    @cursors =
      up: game.input.keyboard.addKey cursors.up
      down: game.input.keyboard.addKey cursors.down

  update: ->
    @item.y -= 5 if @cursors.up.isDown
    @item.y += 5 if @cursors.down.isDown
