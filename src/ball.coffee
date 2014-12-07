class Ball extends Phaser.Sprite
  constructor: (game, @startX, y, image, player) ->
    super game, @startX, y, image

    @player = player
    @anchor.setTo 0.5, 0.5

    @_stoppedState = true

    game.physics.arcade.enable @
    @body.bounce = x: 1, y: 1
    @body.collideWorldBounds = true

    @score = 0

    @_strength = 1
    @_superBall = 0

  onPlayerCollide: (player) ->
    if @y < player.y
      @body.velocity.y = (player.y - @y) * -3
    else if @y > player.y
      @body.velocity.y = (@y - player.y) * 3
    else
      @body.velocity.y = game.rnd.integerInRange -1, 1

  onLineOverlap: (ball, line) ->
    unless line.getImmune()
      line.player.reduceHealth LIVES_LOST_WITH_LINES
      ball.respawn()

  launch: ->
    @body.velocity = x: BALL_DEFAULT_SPEED, y: game.rnd.integerInRange -100, 100
    @_stoppedState = false

  stopped: ->
    @_stoppedState

  respawn: ->
    @_stoppedState = true
    @body.velocity = x: 0, y: 0
    @x = @startX
    @y = @player.y

  getStrength: ->
    return @_strength + @_superBall

  takeDamage: (damage) ->
    @addSuperBallStrength(-damage)

  hasSuperBall: ->
    @_superBall > 0

  addSuperBallStrength: (strength) ->
    @_superBall = CLAMP(@_superBall + strength, 0, SUPERBALL_MAX_STRENGTH)
    console.log "#{@player.description()} super ball is now #{@_superBall}"
    if @_superBall > 0
      #TODO: Change ball sprite, increase speed ?
      @frame = 1
    else
      #TODO: Restore ball sprite
      @frame = 0

  update: ->
