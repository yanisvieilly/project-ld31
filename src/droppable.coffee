class Droppable

  @types:
    WEAPON:
      img: 'lib/assets/img/droppable_weapon.png'
      spriteId: 'droppable_weapon'
      config:
        weapon: 1

  @loadAssets: ->
    for key, droppableInfo of @types
      game.load.image droppableInfo.spriteId, droppableInfo.img

  createFromType: (type) ->
    throw new Error("Undefined droppable type: #{type}") if !@types[type]

    info = @types[type]
    return new Droppable(info.spriteId, info.config)

  constructor: (spriteId, config) ->

    @spriteId = spriteId
    @time = config.time || 0 #Number of seconds before droppable action is stopped

    @weapon = config.weapon || 0 #Increases or decreases weapon level
    @paddleSize = config.paddleSize || 0 #Increases or decreases paddle size
    @life = config.life || 0 #Amount of life
    @addedBricks = config.addedBricks || 0 #Amount of bricks added to the game board

    @catchesBall = config.catchesBall || false #If true, ball will stick to paddle until gamer throw it manually
    @playerImmunity = config.playerImmunity || false #If true, player no longer receives damages when hitting the enemy's ball
    @superBall = config.superBall || false #If true, receiver's ball will go through the bricks after breaking them

    @ballColor = config.ballColor || null #If set to a brick color, receiver's ball will only break those bricks for a given amount of time

  onCatchBy: (receiver) ->
    # TODO: Apply effects to receiver
    # TODO: Launch timer if @time > 0
