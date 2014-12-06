SPEED = 5
PLAYER_LEFT = 0
PLAYER_RIGHT = 1

class Player extends Phaser.Sprite
  constructor: (game, x, y, image, cursors, @id) ->
    super game, x, y, image

    @anchor.setTo 0.5, 0.5

    @cursors =
      up: game.input.keyboard.addKey cursors.up
      down: game.input.keyboard.addKey cursors.down
      shoot: game.input.keyboard.addKey cursors.shoot

    @weaponType = 1

    game.physics.arcade.enable @
    @body.immovable = true

    @bullets = game.add.group()

    @cursors.shoot.onDown.add @shoot, @

  update: ->
    if @cursors.up.isDown && @y > SPEED + @height / 2
      @y -= SPEED
    if @cursors.down.isDown && @y < game.world.height - @height / 2 - SPEED
      @y += SPEED

  shoot: ->
    if @weaponType > 0
      if @id == PLAYER_LEFT
        new Bullet game, @x + 25, @y, 'bulletLeftOne', 1, @bullets
      else
        new Bullet game, @x - 25, @y, 'bulletRightOne', -1, @bullets
