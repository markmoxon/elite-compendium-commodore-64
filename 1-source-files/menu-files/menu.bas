10 print chr$(147);"press 1 or 2"
20 get n$
30 if n$="1" then load "elite",8,1
40 if n$="2" then load "universe",8,1
50 goto 20