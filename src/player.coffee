SPEED = 5

class Player extends Phaser.Sprite
  constructor: (game, x, y, image, cursors) ->
    super game, x, y, image

    @cursors =
      up: game.input.keyboard.addKey cursors.up
      down: game.input.keyboard.addKey cursors.down

    game.physics.arcade.enable @
    @body.immovable = true

  update: ->
    if @cursors.up.isDown && @y > SPEED
      @y -= SPEED
    if @cursors.down.isDown && @y < game.world.height - @height - SPEED
      @y += SPEED
