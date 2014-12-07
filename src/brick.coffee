class Brick
    constructor: (sprite) ->
      @sprite = sprite
      @sprite.body.immovable = true
      @breakSequence = [@break]
      @breakCount = 0
      @revive()

    revive: ->
      @setHealth(@sprite.animations.frameTotal)

    getStrength: ->
      @getHealth()

    getHealth: ->
      @_health

    setHealth: (health) ->
      @_health = Math.max(health, 0)
      @_updateFrame()

    takeDamage: (damage) ->
      @setHealth(@getHealth() - damage)
      if @getHealth() == 0
        @break()
        return true
      return false

    onBallCollide: (ball, game) ->
      ball.takeDamage(@getStrength())
      broken = @takeDamage(ball.getStrength())
      res = {}
      if broken
        res.droppable = _drop()
      return res

    break: =>
      @sprite.kill()
      TIMER_START BRICK_RESPAWN_TIME, =>
        @sprite.revive()
        @revive()

    _updateFrame: ->
      return if @getHealth() == 0
      @sprite.animations.frame = @sprite.animations.frameTotal - @getHealth()

    _drop = ->
      droppable = null
      luckyNumber = game.rnd.integerInRange 0, 100
      if luckyNumber < BRICK_DROP_CHANCES #% of chances to drop an item
        type = Droppable.getRandomType()
        droppable = Droppable.createFromType type, game
      return droppable
