SPEED = 5

class Player extends Phaser.Sprite
  @LEFT = 0
  @RIGHT = 1

  constructor: (game, x, y, image, cursors, @id) ->
    super game, x, y, image

    @anchor.setTo 0.5, 0.5

    @ball = null

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

    shipX = if @id is Player.LEFT then @x - 35 else @x + 35
    shipImage = if @id is Player.LEFT then 'shipOne' else 'shipTwo'
    @ship = new Ship game, shipX, @y, shipImage
    game.world.add @ship

  update: ->
    if @cursors.up.isDown && @y > SPEED + @height / 2
      @y -= SPEED
      @ship.y -= SPEED
      @ball.y -= SPEED if @ball.stopped()
    if @cursors.down.isDown && @y < game.world.height - @height / 2 - SPEED
      @y += SPEED
      @ship.y += SPEED
      @ball.y += SPEED if @ball.stopped()

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
    @ball.launch() if @ball.stopped()

  onBulletCollide: (player, bullet) ->
    @life -= LIVES_LOST_WITH_BULLETS
    bullet.kill()

  description: ->
    "Player #{if @id == Player.LEFT then 'LEFT' else 'RIGHT'}"
