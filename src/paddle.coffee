PADDLE_TOP_HEIGHT = 6
PADDLE_BOTTOM_HEIGHT = 6
PADDLE_WIDTH = 26

class Paddle extends Phaser.Sprite

  @BLUE = 'blue'
  @RED = 'red'

  @loadAssets: ->
    game.load.image "paddle_#{Paddle.BLUE}_top", "lib/assets/img/paddle_#{Paddle.BLUE}_top.png"
    game.load.image "paddle_#{Paddle.BLUE}_body", "lib/assets/img/paddle_#{Paddle.BLUE}_body.png"
    game.load.image "paddle_#{Paddle.BLUE}_bottom", "lib/assets/img/paddle_#{Paddle.BLUE}_bottom.png"

    game.load.image "paddle_#{Paddle.RED}_top", "lib/assets/img/paddle_#{Paddle.RED}_top.png"
    game.load.image "paddle_#{Paddle.RED}_body", "lib/assets/img/paddle_#{Paddle.RED}_body.png"
    game.load.image "paddle_#{Paddle.RED}_bottom", "lib/assets/img/paddle_#{Paddle.RED}_bottom.png"

  constructor: (game, x, y, height, color) ->
    super game, x, y

    @color = color
    @setHeight(height)

    # @_topSprite = new Phaser.Sprite(game, 0, 0, "paddle_#{@color}_top")
    # @_bodySprite = new Phaser.TileSprite(game, 0, PADDLE_TOP_HEIGHT, PADDLE_WIDTH, 10, "paddle_#{@color}_body")
    # @_bottomSprite = new Phaser.Sprite(game, 0, 10 + PADDLE_TOP_HEIGHT, "paddle_#{@color}_bottom")
    # @addChild @_topSprite
    # @addChild @_bodySprite
    # @addChild @_bottomSprite

  setHeight: (height) ->
    # @height = height

    console.log 'color: ', @color
    # @removeChild @_topSprite
    # @removeChild @_bodySprite
    # @removeChild @_bottomSprite
    @_topSprite.destroy() if @_topSprite
    @_bodySprite.destroy() if @_bodySprite
    @_bottomSprite.destroy() if @_bottomSprite

    bodyHeight = height - PADDLE_TOP_HEIGHT - PADDLE_BOTTOM_HEIGHT
    @_topSprite = new Phaser.Sprite(game, 0, 0, "paddle_#{@color}_top")
    @_bodySprite = new Phaser.TileSprite(game, 0, PADDLE_TOP_HEIGHT, PADDLE_WIDTH, bodyHeight, "paddle_#{@color}_body")
    @_bottomSprite = new Phaser.Sprite(game, 0, bodyHeight + PADDLE_TOP_HEIGHT, "paddle_#{@color}_bottom")
    @addChild @_topSprite
    @addChild @_bodySprite
    @addChild @_bottomSprite



    # @_topSprite.height = PADDLE_TOP_HEIGHT
    # @_bodySprite.height = height - PADDLE_BOTTOM_HEIGHT - PADDLE_TOP_HEIGHT
    # @_bottomSprite.y = PADDLE_TOP_HEIGHT + @_bodySprite.height
    # @_bottomSprite.height = PADDLE_BOTTOM_HEIGHT

    console.log @height
    #
    # console.log @_topSprite.height
    # console.log @_bodySprite.height
    # console.log @_bottomSprite.height
    # console.log @height
