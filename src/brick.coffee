class Brick
    constructor: (sprite) ->
      @sprite = sprite
      @sprite.body.immovable = true
      @breakSequence = [@break]
      @breakCount = 0

    onBallCollide: (ball) ->
      if @sprite.animations.frame == @sprite.animations.frameTotal - 1
        @break()

        droppable = null
        luckyNumber = game.rnd.integerInRange 0, 100
        if luckyNumber < 20 #% of chances to drop an item
          droppable = Droppable.createFromType 'WEAPON'
        res =
          score: 10
          droppable: droppable
        return res
      else
        @sprite.frame += 1
        res =
          score: 0
        return res

    break: =>
      @sprite.kill()
