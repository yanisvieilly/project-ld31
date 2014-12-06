class Brick
    constructor: (sprite) ->
      @sprite = sprite
      @sprite.body.immovable = true
      @breakSequence = [@break]
      @breakCount = 0

    onCollide: ->
      if @sprite.animations.frame == @sprite.animations.frameTotal - 1
        @break()
        return 10
      else
        @sprite.frame += 1
        return 0

    break: =>
      @sprite.kill()
