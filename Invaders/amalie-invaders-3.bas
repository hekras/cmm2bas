option explicit
mode 1,8

dim integer i=0'counter in render loop
dim integer l=0'temp variable
dim integer s=0'temp variable
dim integer xpos=400'x-pos of player ship
dim integer tick=0'counter in render loop

'invaders numbers and stuff
dim integer invader_live(8,15)
dim integer invader_x(8,15)
dim integer invader_y(8,15)

'prepare sprites and bobs
framebuffer create 1600, 1200
framebuffer write
cls
render_norm_animate_sequence 0, rgb(red), 1, 0
render_cute_animate_sequence 40, rgb(yellow), 1, 1
page write 0
cls
circle 10,10,3,,,rgb(yellow),rgb(yellow)
sprite close all
for s=1 to 63
  sprite read s,7,7,10,10
next s
cls
box 0,10,54,10,,rgb(white),rgb(white)
box 22,0,10,10,,rgb(white),rgb(white)
sprite read 64,0,0,54,20
cls

page write 1
do
  page copy 1 to 0
  cls
  for l=0 to 10
    blit i*65, 40, l*50, 0, 50, 41, framebuffer
  next l
  for l=0 to 10
    blit 15+i*65, 0, l*41, 50, 36, 41, framebuffer
    blit 15+i*65, 0, l*41, 100, 36, 41, framebuffer
    blit 15+i*65, 0, l*41, 150, 36, 41, framebuffer
    blit 15+i*65, 0, l*41, 200, 36, 41, framebuffer
    blit 15+i*65, 0, l*41, 250, 36, 41, framebuffer
    blit 15+i*65, 0, l*41, 300, 36, 41, framebuffer
    blit 15+i*65, 0, l*41, 350, 36, 41, framebuffer
  next l

  for s=1 to 39
    sprite write s,100 + 20*(s mod 20),100+20*int(s/20)
  next s

  sprite write 64,xpos,580

  s=keydown(0)
  for l=1 to s
    if keydown(l)=130 then
      xpos=xpos-1
    elseif keydown(l)=131 then
      xpos=xpos+1
    endif
  next l
  text 700,0,str$(s)

  tick=tick+1
  if (tick mod 4)=0 then
    i=i+1
    if i>15 then
      i=0
    endif
  endif
loop
end

sub Render_norm_animate_sequence yoff, co, xeye=1, yeye=0
  local integer i
  local float a
  for i=0 to 15
    a=2*i*pi/16
    render_invader 5, 16+i*65,yoff+1, co, xeye, yeye, a
  next i
end sub

sub render_cute_animate_sequence yoff, co, xeye=1, yeye=0
  local integer i
  local float a
  for i=0 to 15
    a=2*i*pi/16
    render_cute_invader 3, 15+i*65,yoff+1, co, xeye, yeye, a
  next i
end sub

sub render_invader s, xoff, yoff, co, xeye=0, yeye=0, ani
'body
  box xoff+2*s, yoff+0*s, s, s,,co,co
  box xoff+4*s, yoff+0*s, s, s,,co,co
  box xoff+1*s, yoff+1*s, 5*s, s,,co,co
  box xoff+0*s, yoff+2*s, 7*s, 2*s,,co,co
  box xoff+1*s, yoff+4*s, 5*s, s,,co,co
local yy
  yy=1+sin(ani)
  box xoff+2*s, yoff+5*s, s, s*yy,,co,co
  box xoff+4*s, yoff+5*s, s, s*yy,,co,co
  box xoff+1*s, yoff+(5+yy)*s, 2*s, s,,co,co
  box xoff+4*s, yoff+(5+yy)*s, 2*s, s,,co,co

'eyes
  box xoff+1*s, yoff+2*s, 2*s, 2*s,,RGB(white),RGB(white)
  box xoff+4*s, yoff+2*s, 2*s, 2*s,,RGB(white),RGB(white)
  box xoff+(1+xeye)*s, yoff+(2+yeye)*s, s, s,,RGB(black),RGB(black)
  box xoff+(4+xeye)*s, yoff+(2+yeye)*s, s, s,,RGB(black),RGB(black)
end sub

sub render_cute_invader s, xoff, yoff, co, xeye=0, yeye=0, ani
  local float xx
  xx = 3*s*sin(ani)
  local integer xmin, ymin, h, w
  xmin=xoff-3*s
  w=13*s

  'box xmin, yoff, w, 8*s,1,rgb(white)'white frame
  box xoff+1*s, yoff+0*s, 5*s, s,,co,co
  box xoff+0*s, yoff+1*s, 7*s, 4*s,,co,co
  box xoff+1*s, yoff+1*s, 2*s, 3*s,,RGB(white),RGB(white)
  box xoff+(1+xeye)*s, yoff+(1+yeye)*s, s, 2*s,,RGB(black),RGB(black)
  box xoff+4*s, yoff+1*s, 2*s, 3*s,,RGB(white),RGB(white)
  box xoff+(4+xeye)*s, yoff+(1+yeye)*s, s, 2*s,,RGB(black),RGB(black)
  box xoff+xx, yoff+4*s, 3*s, 4*s,,co,co
  box xoff+xx+s*4, yoff+4*s, 3*s, 4*s,,co,co
end sub