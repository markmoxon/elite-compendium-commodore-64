10 rem -------------------
20 rem c64 compendium menu
30 rem by mark moxon
40 rem -------------------

print chr$(147) : rem clear screen
poke 53280,0 : rem black border
poke 53281,0 : rem black background
poke 53272,23 : rem lower case character set

start%=12
rows%=3
o%=0
b$="                                        "
h$="+--------------------------------------+"

gosub 1000 : rem display the elite title
gosub 2000 : rem display menu options with highlight
gosub 3000 : rem process selecting an option

if o%=0 then load "elite",8,1
if o%=1 then load "universe",8,1
end

1000 rem -----------------------
1010 rem display the elite title
1020 rem -----------------------

xy=55296+14
for j=0 to 2
for i=0 to 9
poke xy+i,7 : rem yellow
next
xy=xy+40
next

xy=1024+14
for j=0 to 2
for i=0 to 9
read ch%
poke xy+i,ch% : rem character
next
xy=xy+40
next

print chr$(158); : rem yellow
a$="COMPENDIUM":x=14:y=3:gosub 8000
print chr$(30); : rem green
print
print "   Elite by Ian Bell and David Braben"
print "       Enhancements by Mark Moxon"
return

2000 rem ------------
2010 rem display menu
2020 rem ------------

x=0:y=8
print chr$(158); : rem yellow
a$=" CRSR up/down to select, SPACE for info ":gosub 8000
a$="             RETURN to play             ":gosub 8000
a$=b$:gosub 8000
a$=b$:gosub 8000

if o%=0 then print chr$(28):a1$=h$:a2$=h$ : rem highlight in red
if o%=1 then print chr$(154):a1$=b$:a2$=b$  : rem no highlight in light blue

a$=a1$:gosub 8000
a$="       Commodore 64 and 128 Elite       ":gosub 8000
a$="   The best version of Firebird Elite   ":gosub 8000
a$=a2$:gosub 8000

if o%=1 then print chr$(28):a1$=h$:a2$=h$ : rem highlight in red
if o%=0 then print chr$(154):a1$=b$:a2$=b$  : rem no highlight in light blue

a$=a1$:gosub 8000
a$="          Elite Universe Editor         ":gosub 8000
a$="   Create fully playable 3D scenarios   ":gosub 8000
a$=a2$:gosub 8000

a$=b$:gosub 8000
gosub 8000
print chr$(30); : rem green
a$="      For the Commodore 64 and 128      ":gosub 8000
return

3000 rem -----------------
3010 rem process selection
3020 rem -----------------

l%=o%+1
3040 if o%<>l% then gosub 2000 : rem update highlight
l%=o%
k$=""
3070 get k$:if k$<>"" then goto 3070
3080 get k$:if k$="" then goto 3080
k=asc(k$)
if k=17 then o%=o%+1 : rem down
if k=145 then o%=o%+1 : rem up
if o%>1 then o%=0
if o%<0 then o%=1
if k=32 then gosub 4000 : rem space to display info
if k=13 then return
goto 3040

4000 rem -------------------
4010 rem display information
4020 rem -------------------

x=0:y=8
print chr$(158); : rem yellow
a$="     SPACE for menu, RETURN to play     ":gosub 8000
a$=b$:gosub 8000

print chr$(28); : rem red
a$=h$:gosub 8000
if o%=0 then a$="       Commodore 64 and 128 Elite       ":gosub 8000
if o%=1 then a$="          Elite Universe Editor         ":gosub 8000
a$=h$:gosub 8000
a$=b$:gosub 8000

print chr$(154); : rem light blue

if o%=0 then a$="  Elite with all the bells and whistles ":gosub 8000
if o%=0 then a$=b$:gosub 8000
if o%=0 then a$="     Flicker-free ships and planets     ":gosub 8000
if o%=0 then a$="  Extended disk menu and better saving  ":gosub 8000
if o%=0 then a$="Docking computer & joystick improvements":gosub 8000
if o%=0 then a$="   Much smoother on the Commodore 128   ":gosub 8000
if o%=0 then a$="           Bug fixes and more           ":gosub 8000

if o%=1 then a$="  Create your own 3D scenarios in Elite ":gosub 8000
if o%=1 then a$=" and "+chr$(34)+"press play"+chr$(34)+" to bring them to life ":gosub 8000
if o%=1 then a$=b$:gosub 8000
if o%=1 then a$="  Comes with lots of example universes  ":gosub 8000
if o%=1 then a$="   including the iconic ship ID chart   ":gosub 8000
if o%=1 then a$=b$:gosub 8000
if o%=1 then a$=" See bbcelite.com/hacks for instructions":gosub 8000

4500 get k$:if k$<>"" then goto 4500
4510 get k$:if k$="" then goto 4510
k=asc(k$)
if k=13 then return
if k<>32 then goto 4500 : rem not space so keep checking
gosub 2000 : rem redisplay menu options with highlight
return

8000 rem -----------------
8010 rem print a$ at (x,y)
8020 rem -----------------

poke 781,y
poke 782,x
sys 65520
print a$
y=y+1
return

9000 rem ----------------------
9010 rem elite title characters
9020 rem ----------------------

data 236,126,225,32,225,32,251,126,225,226
data 236,32,225,32,225,32,225,32,225,126
data 226,126,124,126,124,32,124,32,124,226
