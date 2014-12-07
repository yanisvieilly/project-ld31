class Droppable extends Phaser.Sprite


  # Droppable items config

  @types:

    WEAPON:
      img: 'lib/assets/img/droppable_weapon.png'
      spriteId: 'droppable_weapon'
      config:
        weapon: 1
        countdown: WEAPON_DURATION

    SUPERBALL:
      img: 'lib/assets/img/droppable_superball.png'
      spriteId: 'droppable_superball'
      config:
        superBall: 10
        countdown: SUPERBALL_DURATION

    IMMUNITY:
      img: 'lib/assets/img/shield_silver.png'
      spriteId: 'droppable_immunity'
      config:
        playerImmunity: true
        countdown: IMMUNITY_DURATION

    ENLARGER:
      img: 'lib/assets/img/droppable_enlarger.png'
      spriteId: 'droppable_enlarger'
      config:
        paddleSize: Player.PaddleSize.BIG
        countdown: ENLARGER_DURATION

    REDUCER:
      img: 'lib/assets/img/droppable_reducer.png'
      spriteId: 'droppable_reducer'
      config:
        paddleSize: Player.PaddleSize.SMALL
        countdown: REDUCER_DURATION

    MEDKIT:
      img: 'lib/assets/img/droppable_medkit.png'
      spriteId: 'droppable_medkit'
      config:
        health: MEDKIT_HEALTH



  # Class Helpers

  @_timers = {}

  @_getOrCreateTimer: (receiver, type, duration, reset) ->
    Droppable._timers[receiver.id] = {} if !Droppable._timers[receiver.id]
    timer = Droppable._timers[receiver.id][type]
    if timer && reset
      TIMER_STOP timer.event
      timer = null
    if !timer
      timer =
        endEvents: []
        event: TIMER_START duration, =>
          @_endTimer receiver, type
    !Droppable._timers[receiver.id][type] = timer
    return timer

  @_addTimedAction: (receiver, type, duration, reset, func) ->
    return if !duration
    timer = @_getOrCreateTimer receiver, type, duration, reset
    timer.endEvents.push func

  @_endTimer: (receiver, type) ->
    return if !Droppable._timers[receiver.id] || !Droppable._timers[receiver.id][type]
    timer = Droppable._timers[receiver.id][type]
    for endEvent in timer.endEvents
      endEvent()
    delete Droppable._timers[receiver.id][type]
    delete Droppable._timers[receiver.id] if !Object.keys(Droppable._timers[receiver.id]).length
    # console.log "End of #{type} for #{receiver.description()}(#{receiver.id}), timers: ", Droppable._timers

  @getRandomType: ->
    types = Object.keys(Droppable.types)
    idx = game.rnd.integerInRange 0, types.length - 1
    return types[idx]


  # Initialization

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
    @health = config.health || 0 #Amount of health given to receiver
    @superBall = config.superBall || 0 #Amount of super ball strength given to receiver's ball
    # @addedBricks = config.addedBricks || 0 #Amount of bricks added to the game board

    @catchesBall = config.catchesBall || false #If true, ball will stick to paddle until gamer throw it manually
    @playerImmunity = config.playerImmunity || false #If true, player no longer receives damages when hitting the enemy's ball

    @ballColor = config.ballColor || null #If set to a brick color, receiver's ball will only break those bricks for a given amount of time


  # Events

  onCatchBy: (receiver) =>

    console.log "#{@type} caught by #{receiver.description()}"
    if @weapon && receiver.addWeaponLevel
      receiver.addWeaponLevel @weapon
      Droppable._addTimedAction receiver, @type, @countdown, @resetCountdownOnCatch, =>
        receiver.addWeaponLevel -@weapon
    if @paddleSize && receiver.setPaddleSize
      receiver.setPaddleSize @paddleSize
      Droppable._addTimedAction receiver, @type, @countdown, @resetCountdownOnCatch, =>
        receiver.setPaddleSize Player.PaddleSize.DEFAULT
    if @health && receiver.addHealth
      receiver.addHealth @health

    if @catchesBall && receiver.setCatchBallMode
      receiver.setCatchBallMode true
    if @playerImmunity && receiver.setImmune
      receiver.setImmune true
      Droppable._addTimedAction receiver, @type, @countdown, @resetCountdownOnCatch, =>
        receiver.setImmune false
    if @superBall && receiver.ball
      receiver.ball.addSuperBallStrength @superBall
      Droppable._addTimedAction receiver, @type, @countdown, @resetCountdownOnCatch, =>
        receiver.ball.addSuperBallStrength -@superBall
    if @ballColor && receiver.setBallColor
      receiver.setBallColor @ballColor
