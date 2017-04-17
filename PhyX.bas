_TITLE "PhyX"
SCREEN _NEWIMAGE(800, 600, 32)

TYPE vector
    x AS SINGLE
    y AS SINGLE
END TYPE

TYPE rgbcolor
    r AS SINGLE
    g AS SINGLE
    b AS SINGLE
    a AS SINGLE
END TYPE

TYPE ___Balls
    pos AS vector
    vel AS vector
    acc AS vector
    mass AS SINGLE
    col AS rgbcolor
    radius AS SINGLE
END TYPE

CONST GRAVITY_FORCE = .05

DIM SHARED Gravity AS vector

Gravity.x = 0
Gravity.y = GRAVITY_FORCE

DIM SHARED Ball AS ___Balls

Ball.pos.x = 400
Ball.pos.y = 300
Ball.radius = 30
Ball.col.r = 255
Ball.mass = 40
Ball.vel.x = 2
Ball.vel.y = 1.1
wallYmass = 20 '40kg
wallXmass = 20
DO
    CLS
    k$ = INKEY$
    IF k$ = "w" THEN Ball.vel.y = Ball.vel.y + -3
    IF k$ = "s" THEN Ball.vel.y = Ball.vel.y + 3
    IF k$ = "a" THEN Ball.vel.x = Ball.vel.x + -3
    IF k$ = "d" THEN Ball.vel.x = Ball.vel.x + 3
    CircleFill Ball.pos.x, Ball.pos.y, Ball.radius, _RGB(Ball.col.r, Ball.col.g, Ball.col.b)
    Ball.pos.x = Ball.pos.x + Ball.vel.x
    Ball.pos.y = Ball.pos.y + Ball.vel.y
    Ball.vel.x = Ball.vel.x + Ball.acc.x
    Ball.vel.y = Ball.vel.y + Ball.acc.y
    Ball.vel.x = Ball.vel.x + Gravity.x
    Ball.vel.y = Ball.vel.y + Gravity.y
    IF Ball.pos.y > _HEIGHT - Ball.radius THEN
        f = (Ball.mass * Ball.vel.y + wallYmass) / (Ball.mass + wallYmass)
        f = -f
        IF f > 0 THEN f = 0
        Ball.vel.y = f
        Ball.acc.y = 0
        '  PRINT f
    ELSEIF Ball.pos.y < Ball.radius THEN
        f = (Ball.mass * Ball.vel.y + wallYmass) / (Ball.mass + wallYmass)
        Ball.vel.y = f
        Ball.acc.y = 0
    END IF

    IF Ball.pos.x > _WIDTH - Ball.radius THEN
        f = (Ball.mass * Ball.vel.x + wallXmass) / (Ball.mass + wallXmass)
        f = -f
        Ball.vel.x = f
        Ball.acc.x = 0
    ELSEIF Ball.pos.x < Ball.radius THEN
        f = (Ball.mass * Ball.vel.x + wallXmass) / (Ball.mass + wallXmass)
        Ball.vel.x = f
        Ball.acc.x = 0
    END IF
    _DISPLAY
    _LIMIT 120
LOOP

SUB CircleFill (CX AS LONG, CY AS LONG, R AS LONG, C AS LONG)
    'This sub from here: http://www.qb64.net/forum/index.php?topic=1848.msg17254#msg17254
    DIM Radius AS LONG
    DIM RadiusError AS LONG
    DIM X AS LONG
    DIM Y AS LONG

    Radius = ABS(R)
    RadiusError = -Radius
    X = Radius
    Y = 0

    IF Radius = 0 THEN PSET (CX, CY), C: EXIT SUB

    ' Draw the middle span here so we don't draw it twice in the main loop,
    ' which would be a problem with blending turned on.
    LINE (CX - X, CY)-(CX + X, CY), C, BF

    WHILE X > Y

        RadiusError = RadiusError + Y * 2 + 1

        IF RadiusError >= 0 THEN

            IF X <> Y + 1 THEN
                LINE (CX - Y, CY - X)-(CX + Y, CY - X), C, BF
                LINE (CX - Y, CY + X)-(CX + Y, CY + X), C, BF
            END IF

            X = X - 1
            RadiusError = RadiusError - X * 2

        END IF

        Y = Y + 1

        LINE (CX - X, CY - Y)-(CX + X, CY - Y), C, BF
        LINE (CX - X, CY + Y)-(CX + X, CY + Y), C, BF

    WEND

END SUB

