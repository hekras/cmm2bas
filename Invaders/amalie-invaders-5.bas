option explicit
mode 1,8

dim integer i=0'counter in render loop
dim integer l=0'temp variable
dim integer s=0'temp variable
dim integer xpos=400'x-pos of player ship
dim integer tick=0'counter in render loop

'invaders numbers and stuff
dim integer invaders_state
dim float invaders_xoff
DIM float invaders_yoff
dim float invaders_xmin = 800
dim float invaders_xmax = 0
dim float invaders_xoff_velocity
DIM float invaders_yoff_velocity
dim integer invaders_state_counter
dim integer invader_live(15,8)
dim integer invader_x(8,15)
dim integer invader_y(8,15)

init_sprites
init_level

page write 1
do
  page copy 1 to 0
  cls
  render_level i
  state_machine
  
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

sub state_machine
  select case invaders_state
    case 0
      if invaders_xmax > 795 then
        invaders_state = 1
        invaders_state_counter = 40
        invaders_yoff_velocity = 1
      else
        invaders_xoff = invaders_xoff + invaders_xoff_velocity
      endif
    case 1
      invaders_yoff = invaders_yoff + invaders_yoff_velocity
      invaders_state_counter = invaders_state_counter - 1
      if invaders_state_counter = 0 then
        invaders_state = 2
      end if
    case 2
      if invaders_xmin < 1 then
        invaders_state = 3
        invaders_state_counter = 40
        invaders_yoff_velocity = 1
      else
        invaders_xoff = invaders_xoff - invaders_xoff_velocity
      endif
    case 3
      invaders_yoff = invaders_yoff + invaders_yoff_velocity
      invaders_state_counter = invaders_state_counter - 1
      if invaders_state_counter = 0 then
        invaders_state = 0
      end if
  end select
end sub

sub init_level
  invaders_state = 0
  invaders_xoff = 0
  invaders_yoff = 0
  invaders_xoff_velocity = 1
  
  local integer xs
  local integer ys
  for xs = 0 to 15
    for ys = 0 to 8
      invader_live(xs, ys) = -1
    next ys
  next xs

  for xs = 0 to 5
    for ys = 0 to 4
      invader_live(xs, ys) = int(4*rnd)
    next ys
  next xs

  for xs = 6 to 6
    for ys = 0 to 4
      invader_live(xs, ys) = 4+int(4*rnd)
    next ys
  next xs

  for xs = 0 to 6
    for ys = 5 to 5
      invader_live(xs, ys) = 8 + int(4*rnd)
    next ys
  next xs

end sub

sub render_level ani
  local integer xs
  local integer ys
  local float xpos
  local float ypos
  invaders_xmin = 800
  invaders_xmax = 0
  for xs = 0 to 15
    for ys = 0 to 8
      if invader_live(xs, ys) > -1 then
        xpos = invaders_xoff+xs*41
        ypos = invaders_yoff+ys*50
        blit 15+ani*65, invader_live(xs, ys)*50, xpos, ypos, 36, 41, framebuffer
        if invaders_xmin > xpos then
          invaders_xmin = xpos
        endif
        if invaders_xmax < xpos+36 then
          invaders_xmax = xpos+36
        endif
      endif
    next ys
  next xs
end sub

sub init_sprites
  'prepare sprites and bobs
  framebuffer create 1600, 1200
  framebuffer write
  cls
  render_norm_animate_sequence 0, rgb(red), 1, 0
  render_norm_animate_sequence 50, rgb(red), 0, 1
  render_norm_animate_sequence 100, rgb(red), 1, 1
  render_norm_animate_sequence 150, rgb(red), 0, 0
  
  render_norm_animate_sequence 200, rgb(BLUE), 1, 0
  render_norm_animate_sequence 250, rgb(BLUE), 0, 1
  render_norm_animate_sequence 300, rgb(BLUE), 1, 1
  render_norm_animate_sequence 350, rgb(BLUE), 0, 0
  
  render_norm_animate_sequence 400, rgb(GREEN), 1, 0
  render_norm_animate_sequence 450, rgb(GREEN), 0, 1
  render_norm_animate_sequence 500, rgb(GREEN), 1, 1
  render_norm_animate_sequence 550, rgb(GREEN), 0, 0
  'render_cute_animate_sequence 40, rgb(yellow), 1, 1
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
end sub


sub render_norm_animate_sequence yoff, co, xeye=1, yeye=0
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