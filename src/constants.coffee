###
# CONFIG
###

BRICK_SIZE =
  width: 16
  height: 32
BALL_SIZE =
  width: 22
  height: 22
HEALTHBAR_SIZE =
  width: 150
  height: 10

BRICK_DROP_CHANCES = 30 # %
BRICK_RESPAWN_TIME = 90

PLAYER_MAX_HEALTH = 100

BALL_DEFAULT_SPEED = 500

LIVES_LOST_WITH_BULLETS = 4
LIVES_LOST_WITH_LINES = 10

###
# DROPPABLES CONFIGURATION
###

# General

DROPPABLE_MIN_SPEED =       120
DROPPABLE_MAX_SPEED =       220
# DROPPABLE_MIN_SPEED =       500
# DROPPABLE_MAX_SPEED =       500
DROPPABLE_SPREAD_RADIUS =   0.5 # 0 to 1

# Items

WEAPON_MAX_LVL = 1
WEAPON_DURATION = 5

SUPERBALL_MAX_STRENGTH = 10
SUPERBALL_DURATION = 10

IMMUNITY_DURATION = 15

ENLARGER_DURATION = 15

REDUCER_DURATION = 15

MEDKIT_HEALTH = 30

###
# MACROS
###

CLAMP = (x, min, max) ->
   Math.max(min, Math.min(x, max))

TIMER_START = (duration, func) =>
  return game.time.events.add(Phaser.Timer.SECOND * duration, func, this)

TIMER_STOP = (timer) =>
  game.time.events.remove timer

HSL_TO_RGB = (h, s, l) ->
  if s == 0
    r = g = b = l # achromatic
  else
    hue2rgb = (p, q, t) ->
      if t < 0 then t += 1
      if t > 1 then t -= 1
      if t < 1/6 then return p + (q - p) * 6 * t
      if t < 1/2 then return q
      if t < 2/3 then return p + (q - p) * (2/3 - t) * 6
      return p

    q = if l < 0.5 then l * (1 + s) else l + s - l * s
    p = 2 * l - q
    r = hue2rgb(p, q, h + 1/3)
    g = hue2rgb(p, q, h)
    b = hue2rgb(p, q, h - 1/3)

  return r: Math.floor(r * 255), g: Math.floor(g * 255), b: Math.floor(b * 255)
