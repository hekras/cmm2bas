mode 1

cls
for i = 0 to 255
  x = 20*(i mod 16)
  y = 20*int(i/16)
  box x, y, 20, 20, ,map(i) ,map(i)
next i

