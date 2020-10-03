  mode 1
  
  cls
  
  dim xpos(60,301)
  dim ypos(60,301)
  
  dim n%=59
  dim xp%(59)
  dim yp%(59)
  
  dmyt = 6.0 / 60.0
  xoffset = 400
  yoffset = 300
  scale = 1
  a = 0
  do while scale < 20
    myt = -3
    b = 0
    do while myt < 3
      myt = MYT + dmyt
      sinmyt = sin(myt)
      xpos(b, a) = scale * 18 * sinmyt *sinmyt *sinmyt
      ypos(b, a) = scale * (14 * cos(myt) - 5 * cos(2 * myt) - 3 * cos(3 * myt) - cos(4 * myt))
      b = b + 1
    loop
    scale = scale * 1.01
    a = a + 1
  loop
  
  rotate = 0
  delta_rotate = 0.02
  page write 1
  
  do
    for a= 0 to 301
      cls
      for b = 0 to 59
        xp%(b) = xoffset+xpos(b,a)* cos(rotate) + ypos(b,a)* sin(rotate)
        yp%(b) = yoffset-(ypos(b,a)* cos(rotate) - xpos(b,a)* sin(rotate))
      next b
      polygon n%, xp%(), yp%(), rgb(red), rgb(red)
      page copy 1 to 0
      rotate = rotate + delta_rotate
    next a
    
    for a= 300 to 0 step -1
      cls
      for b = 0 to 59
              xp%(b) = xoffset+xpos(b,a)* cos(rotate) + ypos(b,a)* sin(rotate)
        yp%(b) = yoffset-(ypos(b,a)* cos(rotate) - xpos(b,a)* sin(rotate))
      next b
      polygon n%, xp%(), yp%(), rgb(red), rgb(red)
      page copy 1 to 0
      rotate = rotate + delta_rotate
    next a
  loop