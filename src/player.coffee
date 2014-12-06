SPEED = 5

class Player
  constructor: (x, y, image, cursors) ->
    @item = game.add.sprite x, y, image

    @cursors =
      up: game.input.keyboard.addKey cursors.up
      down: game.input.keyboard.addKey cursors.down

  update: ->
    if @cursors.up.isDown && @item.y > SPEED
      @item.y -= SPEED
    if @cursors.down.isDown && @item.y < game.world.height - @item.height - SPEED
      @item.y += SPEED
