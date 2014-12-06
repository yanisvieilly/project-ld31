class Level
  constructor: (levelMap) ->
    @levelMap = levelMap

    @droppablesGroup = game.add.group()

  create: ->
    @bricksGroup = game.add.group()
    @bricksGroup.enableBody = true
    @bricks = {}

    rect = @_getRect(@levelMap)
    x = 0
    y = game.world.height / 2.0 - rect.height / 2.0
    idx = 0
    for line, lineIdx in @levelMap
      lineWidth = line.length * BRICK_SIZE.width
      x = game.world.width / 2.0 - lineWidth / 2.0
      y += BRICK_SIZE.height if lineIdx > 0
      for tileName, tileIdx in line
        if tileName != 'void'
          brickSprite = @bricksGroup.create x, y, tileName
          brickSprite.name = "tile_#{idx}"
          @bricks[brickSprite.name] = new Brick(brickSprite)
        x += BRICK_SIZE.width
        idx++

  onCollide: (ball, brickSprite) =>
    brick = @bricks[brickSprite.name]
    res = brick.onBallCollide(ball)
    ball.score += res.score
    @_addDroppable res.droppable, brick, ball if res.droppable


  _getRect: (levelMap) ->
    maxLineLength = 0
    for line in levelMap
      maxLineLength = Math.max maxLineLength, line.length

    width = maxLineLength * BRICK_SIZE.width
    height = levelMap.length * BRICK_SIZE.height

    return {width: width, height: height}

  _addDroppable: (droppable, brick, ball) ->
    drop = @droppablesGroup.create 0, 0, droppable.spriteId
    game.physics.arcade.enable drop
    drop.x = brick.sprite.x
    drop.y = brick.sprite.y + brick.sprite.height / 2.0 - drop.height / 2.0
    direction = if ball.player.id == Player.RIGHT then 1 else -1
    drop.body.velocity = x: direction * 300, y: game.rnd.integerInRange -100, 100
    console.log 'velocity: ', drop.body.velocity, 'direction: ', direction
    drop.body.bounce = x: 1, y: 1
    drop.body.collideWorldBounds = true
