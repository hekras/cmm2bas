Const nbr = 18000 ' set the number of stars
Dim p(nbr,2) ' array for star’s coordinates
Cls ' clear the screen
Do
 For i = 1 To nbr ' step through every star
 Pixel p(i, 1), p(i, 2), 0 ' erase the previous star
 x = Rnd * MM.HRes : y = Rnd * MM.VRes ' get a random coordinate
 p(i, 1) = x : p(i, 2) = y ' and save its location
 do ' get a random 3 bit colour
 c = RGB(255 * (Rnd > 0.5), 255 * (Rnd > 0.5), 255 * (Rnd > 0.5))
 Loop Until c <> 0
 Pixel x, y, c ' turn on the new star
 Count% = Count% + 1 ' increment the count
 Text MM.HRes/2, MM.VRes/2, Str$(Count%), "CM" ' display the count
 Next i
Loop ' loop forever