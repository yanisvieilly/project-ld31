SPEED = 5

class Player extends Phaser.Sprite
  @LEFT = 0
  @RIGHT = 1

  constructor: (game, x, y, image, cursors, @id) ->
    super game, x, y, image

    @anchor.setTo 0.5, 0.5

    @cursors =
      up: game.input.keyboard.addKey cursors.up
      down: game.input.keyboard.addKey cursors.down
      shoot: game.input.keyboard.addKey cursors.shoot

    @_weaponLevel = 0

    game.physics.arcade.enable @
    @body.immovable = true

    @bullets = game.add.group()

    @cursors.shoot.onDown.add @shoot, @

    @life = 100

  update: ->
    if @cursors.up.isDown && @y > SPEED + @height / 2
      @y -= SPEED
    if @cursors.down.isDown && @y < game.world.height - @height / 2 - SPEED
      @y += SPEED

  addWeaponLevel: (lvl) ->
    @_weaponLevel = CLAMP(@_weaponLevel + lvl, 0, WEAPON_MAX_LVL)
    console.log "#{@description()} weapon lvl is #{@_weaponLevel}"

  shoot: ->
    console.log "#{@description()} shoot at #{@_weaponLevel}"
    if @_weaponLevel > 0
      if @id == Player.LEFT
        @bullets.add new Bullet game, @x + 25, @y, 'bulletLeftOne', 1
      else
        @bullets.add new Bullet game, @x - 25, @y, 'bulletRightOne', -1

  onBulletCollide: (player, bullet) =>
    @life -= 10
    bullet.kill()

  description: ->
    "Player #{if @id == Player.LEFT then 'LEFT' else 'RIGHT'}"
