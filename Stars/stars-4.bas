mode 1

const stars = 200
const x = 0
const y = 1
const dx = 2
const dy = 3
const visible = 4
const col = 5
const cnt = 6

dim s(stars, 6)
dim ctable(2000)

for i=0 to 2000
  c = int((i > 255)*255 + (i < 256)*i)
  ctable(i) =  RGB(c,c,c)
next i

page write 1

do
  for i=0 to stars
    s(i, visible) = 1
    s(i, x) = MM.hres/2
    s(i, y) = mm.vres/2
    a = 2 * pi * rnd
    v = 1 + 5 * rnd
    s(i, dx) = v * sin(a)
    s(i, dy) = v * cos(a)
    s(i, visible) = 1
    s(i, col) = int(100+rnd*150)
  next i

  a = 2*pi*rnd
  angle_speed = 2*pi/3 + 0.05*rnd
  v =  2+3*rnd
  do
    count = 0
    page copy 1 to 0
    cls
    for i=0 to stars
      if s(i, visible) = 1 then
        count = count + 1
        s(i, x) = s(i, x) - s(i, dx)
        s(i, y) = s(i, y) - s(i, dy)
        s(i, col) = s(i, col) - 1
        if s(i, x) > mm.hres or s(i, x) < 0 or s(i, y) > mm.vres or s(i, y) < 0 or s(i, col) < 1 then
          's(i, visible) = 0
          s(i, x) = MM.hres/2
          s(i, y) = mm.vres/2
          s(i, dx) = v * sin(a)
          s(i, dy) = v * cos(a)
          s(i, col) = int(rnd*150)
          a = a + angle_speed
        else
          box s(i, x), s(i, y), 5, 5, ,ctable(s(i, col)*2) ,ctable(s(i, col)*2)
        endif
      endif
    next i
  loop while count > 0



loop