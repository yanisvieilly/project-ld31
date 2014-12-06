class Tile
    constructor: (x, y, imgName, tilesGroup) ->
      @item = tilesGroup.create x, y, imgName
      @item.body.immovable = true
      @breakSequence = [@break]
      @breakCount = 0

    onCollide: ->
      if @breakCount >= @breakSequence.length
        return
      @breakSequence[@breakCount]()
      @breakCount++

    break: ->
      @item.kill()
