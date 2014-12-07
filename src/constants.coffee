###
# CONFIG
###

BRICK_SIZE =
  width: 16
  height: 32
BRICK_DROP_CHANCES = 30 # %
BRICK_RESPAWN_TIME = 30

DROPPABLE_MIN_SPEED =       80
DROPPABLE_MAX_SPEED =       120
# DROPPABLE_MIN_SPEED =       500
# DROPPABLE_MAX_SPEED =       500
DROPPABLE_SPREAD_RADIUS =   0.7 # 0 to 1

BALL_DEFAULT_SPEED = 600

WEAPON_MAX_LVL = 1
WEAPON_DURATION = 5

###
# MACROS
###

CLAMP = (x, min, max) ->
   Math.max(min, Math.min(x, max))
TIMER_START = (duration, func) =>
  return game.time.events.add(Phaser.Timer.SECOND * duration, func, this)
TIMER_STOP = (timer) =>
  game.time.events.remove timer
