
mode 1

for i=1 to 10
  invader i*10,5, RGB(green)
next i
for i=1 to 10
  invader i*10,15, RGB(red)
next i
for i=1 to 10
  invader i*10,25, RGB(red)
next i
for i=1 to 10
  invader i*10,35, RGB(red)
next i
for i=1 to 10
  invader i*10,45, RGB(yellow)
next i

'pass xoffset, yoffset, color
SUB invader xo, yo, co
  s = 5
  xoff = s*xo
  yoff = s*yo

'body
  box xoff+2*s, yoff+0*s, s, s,,co,co
  box xoff+4*s, yoff+0*s, s, s,,co,co
  box xoff+1*s, yoff+1*s, 5*s, s,,co,co
  box xoff+0*s, yoff+2*s, s, 2*s,,co,co
  box xoff+3*s, yoff+2*s, s, 2*s,,co,co
  box xoff+6*s, yoff+2*s, s, 2*s,,co,co
  box xoff+1*s, yoff+4*s, 5*s, s,,co,co
  box xoff+2*s, yoff+5*s, s, 2*s,,co,co
  box xoff+4*s, yoff+5*s, s, 2*s,,co,co
  box xoff+1*s, yoff+7*s, 2*s, s,,co,co
  box xoff+4*s, yoff+7*s, 2*s, s,,co,co


'eyes
  box xoff+1*s, yoff+2*s, 2*s, 2*s,,RGB(white),RGB(white)
  box xoff+4*s, yoff+2*s, 2*s, 2*s,,RGB(white),RGB(white)
  box xoff+1*s, yoff+2*s, s, s,,RGB(black),RGB(black)
  box xoff+4*s, yoff+2*s, s, s,,RGB(black),RGB(black)

END SUB







