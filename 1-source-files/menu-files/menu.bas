print chr$(147) : rem clear screen
poke 53280,0 : rem black border
poke 53281,0 : rem black background

start%=12
rows%=3
o%=0
b$="                                        "
h1$="+--------------------------------------+"
h2$="+--------------------------------------+"

gosub 1000 : rem display the elite title
gosub 2000 : rem display menu options with highlight
gosub 3000 : rem process selecting an option

if o%=0 then load "elite",8,1
if o%=1 then load "universe",8,1
end

1000 rem display the elite title

x=14:y=0
for j=0 to 2
for i=0 to 9
read ch%
poke 55296+x+(40*y), 7
poke 1024+x+(40*y), ch%
x=x+1
next i
y=y+1
x=14
next j
print chr$(158); : rem yellow
a$="compendium":gosub 8000
print chr$(30); : rem green
print
print "   elite by ian bell and david braben"
print "       enhancements by mark moxon"
return

2000 rem display menu options with highlight

x=0:y=8
print chr$(158); : rem yellow
a$=" crsr up/down to select, space for info ":gosub 8000
a$="          press return to play          ":gosub 8000
a$=b$:gosub 8000
a$=b$:gosub 8000

if o%=0 then print chr$(28):a1$=h1$:a2$=h2$ : rem highlight in red
if o%=1 then print chr$(154):a1$=b$:a2$=b$  : rem no highlight in light blue

a$=a1$:gosub 8000
a$="       commodore 64 and 128 elite       ":gosub 8000
a$="   the best version of firebird elite   ":gosub 8000
a$=a2$:gosub 8000

if o%=1 then print chr$(28):a1$=h1$:a2$=h2$ : rem highlight in red
if o%=0 then print chr$(154):a1$=b$:a2$=b$  : rem no highlight in light blue

a$=a1$:gosub 8000
a$="          elite universe editor         ":gosub 8000
a$="   create fully playable 3d scenarios   ":gosub 8000
a$=a2$:gosub 8000

a$=b$:gosub 8000
gosub 8000
print chr$(30); : rem green
a$="      for the commodore 64 and 128      ":gosub 8000
return

3000 rem process selecting an option

l%=o%+1
3020 if o%<>l% then gosub 2000 : rem update highlight
l%=o%
k$=""
3050 get k$:if k$="" then goto 3050
k=asc(k$)
if k=17 then o%=o%+1 : rem down
if k=145 then o%=o%+1 : rem up
if o%>1 then o%=0
if o%<0 then o%=1
if k=32 then gosub 4000 : rem space to display info
if k=13 then return
goto 3020

4000 rem display extended information for a menu option

x=0:y=8
print chr$(158); : rem yellow
a$="  press space for menu, return to play  ":gosub 8000
a$=b$:gosub 8000

print chr$(28); : rem red
a$=h1$:gosub 8000
if o%=0 then a$="       commodore 64 and 128 elite       ":gosub 8000
if o%=1 then a$="          elite universe editor         ":gosub 8000
a$=h2$:gosub 8000
a$=b$:gosub 8000

print chr$(154); : rem light blue

if o%=0 then a$="  elite with all the bells and whistles ":gosub 8000
if o%=0 then a$=b$:gosub 8000
if o%=0 then a$="     flicker-free ships and planets     ":gosub 8000
if o%=0 then a$="  extended disk menu and better saving  ":gosub 8000
if o%=0 then a$="      docking computer improvements     ":gosub 8000
if o%=0 then a$="   much smoother on the commodore 128   ":gosub 8000
if o%=0 then a$="           bug fixes and more           ":gosub 8000

if o%=1 then a$="  create your own 3d scenarios in elite ":gosub 8000
if o%=1 then a$=" and "+chr$(34)+"press play"+chr$(34)+" to bring them to life ":gosub 8000
if o%=1 then a$=b$:gosub 8000
if o%=1 then a$="  comes with lots of example universes  ":gosub 8000
if o%=1 then a$="   including the iconic ship id chart   ":gosub 8000
if o%=1 then a$=b$:gosub 8000
if o%=1 then a$=" see bbcelite.com/hacks for instructions":gosub 8000

4500 get k$:if k$="" then goto 4500
k=asc(k$)
if k=13 then return
if k<>32 then goto 4500 : rem not space so keep checking
gosub 2000 : rem redisplay menu options with highlight
return

8000 rem print a$ at (x,y) and increment y
poke 781,y
poke 782,x
sys 65520
print a$
y=y+1
return

9000 rem elite title characters
data 236,126,225,32,225,32,251,126,225,226
data 236,32,225,32,225,32,225,32,225,126
data 226,126,124,126,124,32,124,32,124,226
