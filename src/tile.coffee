class Tile
    constructor: (sprite) ->
      # @item = tilesGroup.create x, y, imgName
      @sprite = sprite
      @sprite.body.immovable = true
      @breakSequence = [@break]
      @breakCount = 0

    onCollide: ->
      if @breakCount >= @breakSequence.length
        return
      @breakSequence[@breakCount]()
      @breakCount++

    break: =>
      @sprite.kill()
