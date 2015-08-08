class Level
  constructor: (levelMap, @playerOne, @playerTwo) ->
    @levelMap = levelMap
    @droppablesGroup = game.add.group()

  create: ->
    @bricksGroup = game.add.group()
    @bricksGroup.enableBody = true
    @bricks = {}

    bricksHeight = @levelMap.length * BRICK_SIZE.height
    x = 0
    y = game.world.height / 2.0 - bricksHeight / 2.0
    idx = 0
    for line, lineIdx in @levelMap
      lineWidth = line.length * BRICK_SIZE.width
      x = game.world.width / 2.0 - lineWidth / 2.0
      y += BRICK_SIZE.height if lineIdx > 0
      for tileName, tileIdx in line
        if tileName != 'void'
          brickSprite = @bricksGroup.create x, y, tileName
          brickSprite.name = "brick_#{idx}"
          @bricks[brickSprite.name] = new Brick(brickSprite)
        x += BRICK_SIZE.width
        idx++

  reset: ->
    @bricksGroup.forEach (brickSprite) =>
      brick = @bricks[brickSprite.name]
      brick.revive()
    @droppablesGroup.forEach (droppable) ->
      droppable.kill()
    @playerOne.reset()
    @playerTwo.reset()
    @hideWinningText()

  onBallBrickShouldCollide: (ball, brickSprite) ->
    brick = @bricks[brickSprite.name]
    res = brick.onBallCollide(ball, game)
    if res.droppable
      x = brick.sprite.x
      y = brick.sprite.y + brick.sprite.height / 2.0 - res.droppable.height / 2.0
      direction = if ball.player.id == Player.RIGHT then 1 else -1
      @_addDroppable x, y, res.droppable, direction
    return !ball.hasSuperBall()

  onPlayerDroppableOverlap: (player, droppable) ->
    droppable.onCatchBy player
    droppable.kill()

  displayWinText: (player) ->
    centerX = game.world.width / 2
    centerY = game.world.height / 2
    @winningText = game.add.text centerX, centerY, "#{player.name} player wins!", font: 'bold 50px KenvectorFuture', fill: '#FFF'
    @winningText.anchor.setTo 0.5, 0.5

  hideWinningText: ->
    game.world.remove(@winningText) if @winningText

  endGame: ->
    game.paused = true
    @displayWinText if @playerOne.health is 0 then @playerTwo else @playerOne

  update: ->
    if @playerOne.health is 0 or @playerTwo.health is 0
      @endGame()

  _addDroppable: (x, y, drop, direction) ->
    @droppablesGroup.add drop
    drop.x = x
    drop.y = y
    game.physics.arcade.enable drop

    velocity = game.rnd.integerInRange DROPPABLE_MIN_SPEED, DROPPABLE_MAX_SPEED
    spread = DROPPABLE_SPREAD_RADIUS * velocity
    vy = game.rnd.integerInRange(-spread, spread)
    vx = velocity - Math.abs(vy)
    drop.body.velocity =
      x: vx * direction
      y: vy
    drop.body.bounce = x: 1, y: 1
    drop.body.collideWorldBounds = true
