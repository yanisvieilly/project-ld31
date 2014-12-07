SPEED = 5

class Player extends Phaser.Sprite
  @LEFT = 0
  @RIGHT = 1

  @PaddleSize =
    DEFAULT:  0
    BIG:      1
    SMALL:    2

  @loadAssets: ->
    game.load.image 'paddle_blue_default', 'lib/assets/img/paddle_blue_default.png'
    game.load.image 'paddle_blue_big', 'lib/assets/img/paddle_blue_big.png'
    game.load.image 'paddle_blue_small', 'lib/assets/img/paddle_blue_small.png'
    game.load.image 'paddle_red_default', 'lib/assets/img/paddle_red_default.png'
    game.load.image 'paddle_red_big', 'lib/assets/img/paddle_red_big.png'
    game.load.image 'paddle_red_small', 'lib/assets/img/paddle_red_small.png'

  constructor: (game, x, y, size, cursors, @id) ->
    super game, x, y, @_getSpriteIdFromSize(size)

    @anchor.setTo 0.5, 0.5

    @ball = null
    @line = null

    @cursors =
      up: game.input.keyboard.addKey cursors.up
      down: game.input.keyboard.addKey cursors.down
      shoot: game.input.keyboard.addKey cursors.shoot

    @_weaponLevel = 0

    game.physics.arcade.enable @
    @body.immovable = true

    @bullets = game.add.group()

    @cursors.shoot.onDown.add @shoot, @

    @health = PLAYER_MAX_HEALTH

    @immune = false

    shipX = if @id is Player.LEFT then @x - 35 else @x + 35
    shipImage = if @id is Player.LEFT then 'shipOne' else 'shipTwo'
    @ship = new Ship game, shipX, @y, shipImage, @
    game.world.add @ship

    @shield = game.add.image @ship.x, @ship.y, 'shield'
    @shield.anchor.setTo 0.5, 0.5
    @shield.scale.setTo 0.5, 0.5
    @shield.rotation = Math.PI if @id is Player.RIGHT
    @shield.visible = false

  update: ->
    if @cursors.up.isDown && @y > SPEED + @height / 2
      @y -= SPEED
      @ship.y -= SPEED
      @shield.y -= SPEED
      @ball.y -= SPEED if @ball.stopped()
    if @cursors.down.isDown && @y < game.world.height - @height / 2 - SPEED
      @y += SPEED
      @ship.y += SPEED
      @shield.y += SPEED
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
    player.reduceHealth LIVES_LOST_WITH_BULLETS
    bullet.kill()

  description: ->
    "Player #{if @id == Player.LEFT then 'LEFT' else 'RIGHT'}"

  displayWinText: ->
    winner = if @id == Player.LEFT then 'Red' else 'Blue'
    winningText = game.add.text game.world.width / 2, game.world.height / 2, "#{winner} player wins!", font: 'bold 100px Arial', fill: '#FFF'
    winningText.anchor.setTo 0.5, 0.5

  reduceHealth: (value) ->
    unless @immune
      @health -= value
      if @health <= 0
        @health = 0
        @displayWinText()

  addHealth: (value) ->
    @health = Math.min(@health + value, PLAYER_MAX_HEALTH)

  setImmune: (value) ->
    @immune = value
    @line.setImmune value
    @shield.visible = value

  setPaddleSize: (size) ->
    console.log 'size before: ', @width, ', ', @height
    img = @_getSpriteIdFromSize size
    @loadTexture img
    @body.setSize(@width, @height)
    console.log 'size after: ', @width, ', ', @height

  _getColorForId: (id) ->
    return if id == Player.LEFT then 'blue' else 'red'

  _getSpriteIdFromSize: (size) ->
    color = @_getColorForId(@id)
    spriteIds = {}
    spriteIds[Player.PaddleSize.DEFAULT] = "paddle_#{color}_default"
    spriteIds[Player.PaddleSize.BIG] = "paddle_#{color}_big"
    spriteIds[Player.PaddleSize.SMALL] = "paddle_#{color}_small"
    return spriteIds[size]
