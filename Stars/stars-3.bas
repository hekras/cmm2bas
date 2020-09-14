mode 3

const stars = 200
const x = 0
const y = 1
const dx = 2
const dy = 3
const visible = 4

dim s(stars, 5)

page write 1

do

for i=0 to stars
  s(i, x) = MM.hres/2
  s(i, y) = mm.vres/2
  a = 2 * pi * rnd
  v = 1 + 5 * rnd
  s(i, dx) = v * sin(a)
  s(i, dy) = v * cos(a)
  s(i, visible) = 1
next i

do
  page copy 1 to 0 
  cls
  count = 0
  for i=0 to stars
    if s(i, visible) = 1 then
      count = count + 1
      s(i, x) = s(i, x) - s(i, dx)
      s(i, y) = s(i, y) - s(i, dy)
      if s(i, x) > mm.hres or s(i, x) < 0 or s(i, y) > mm.vres or s(i, y) < 0 then
        's(i, visible) = 0
        s(i, x) = MM.hres/2
        s(i, y) = mm.vres/2
        a = 2 * pi * rnd
        v = 1 + 5 * rnd
        s(i, dx) = v * sin(a)
        s(i, dy) = v * cos(a)
      else
        box s(i, x), s(i, y), 5, 5, ,rgb(white) ,rgb(white)
      endif
    endif
  next i
loop while count > 0

loop
