class Droppable extends Phaser.Sprite

  @types:
    WEAPON:
      img: 'lib/assets/img/droppable_weapon.png'
      spriteId: 'droppable_weapon'
      config:
        weapon: 1
        countdown: WEAPON_DURATION
        resetCountdownOnCatch: false

  @_timers = {}

  @_getTimer: (receiver, type) ->
    return Droppable._timers[receiver][type] if Droppable._timers[receiver]
    return null

  @_setTimer: (receiver, type, timer) ->
    Droppable._timers[receiver] = {} if !Droppable._timers[receiver]
    Droppable._timers[receiver][type] = timer

  @loadAssets: ->
    for key, droppableInfo of @types
      game.load.image droppableInfo.spriteId, droppableInfo.img

  @createFromType: (type, game) ->
    throw new Error("Undefined droppable type: #{type}") if !@types[type]

    info = @types[type]
    return new Droppable(game, 0, 0, info.spriteId, type, info.config)

  constructor: (game, x, y, spriteId, type, config) ->
    super game, x, y, spriteId
    @anchor.setTo 0.5, 0.5

    @type = type
    @spriteId = spriteId
    @countdown = config.countdown || 0 #Number of seconds before droppable action is stopped
    if typeof config.resetCountdownOnCatch isnt 'undefined'
      @resetCountdownOnCatch = config.resetCountdownOnCatch #Resets countdown timer when catched by a receiver
    else
      @resetCountdownOnCatch = true

    @weapon = config.weapon || 0 #Increases or decreases weapon level
    @paddleSize = config.paddleSize || 0 #Increases or decreases paddle size
    @life = config.life || 0 #Amount of life given to receiver
    # @addedBricks = config.addedBricks || 0 #Amount of bricks added to the game board

    @catchesBall = config.catchesBall || false #If true, ball will stick to paddle until gamer throw it manually
    @playerImmunity = config.playerImmunity || false #If true, player no longer receives damages when hitting the enemy's ball
    @superBall = config.superBall || false #If true, receiver's ball will go through the bricks after breaking them

    @ballColor = config.ballColor || null #If set to a brick color, receiver's ball will only break those bricks for a given amount of time

  onCatchBy: (receiver) =>
    if @weapon && receiver.addWeaponLevel
      receiver.addWeaponLevel @weapon
    if @paddleSize && receiver.setPaddleSize
      receiver.weapon @paddleSize
    if @life && receiver.addLife
      receiver.addLife @life
    if @catchesBall && receiver.setCatchBallMode
      receiver.setCatchBallMode true
    if @playerImmunity && receiver.setImmune
      receiver.setImmune true
    if @superBall && receiver.setSuperBall
      receiver.setSuperBall true
    if @ballColor && receiver.setBallColor
      receiver.setBallColor @ballColor

    if @countdown
      timer = Droppable._getTimer receiver, @type
      return if timer && !@resetCountdownOnCatch

      TIMER_STOP timer
      timer = TIMER_START @countdown, =>
        console.log("End of #{@type} for #{receiver.description()}")
      Droppable._setTimer receiver, @type, timer
