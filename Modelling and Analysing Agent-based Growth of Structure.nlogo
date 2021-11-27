breed[children child ]  ;; creating a population of children to move around within the world
breed [copies copy]  ;; creating copies of a child and hatch a copy
globals [generationstep   patch-count ] ; creating global variables for generationstep and patch-count
patches-own [left-pcolor center-pcolor right-pcolor];;;; the following patch variables refer to the colors of the 3 focal patches in a neighborhood

to setup  ;; creates a function called setup
  clear-all ;; this clears the world
  reset-ticks ;; this resets the tick counter
  set generationstep 1 ;; set desired number of generations to 1
  ;; uncomment to for go-once procedure to work
;    create-turtles 1 [set color white  ;; sets the color of the turtle to white
;                    set size 2 ;; set size of turtle to 2
;                    setxy (max-pxcor / 2) (max-pycor - 1) ;; setting start poisiton in the world
;                    set pcolor green ;; setting patch colour to green
;                    hatch-children 1 [set color white set size 0.5 set heading 0 set shape "circle" ]
;                    produces-copy;; calling produce-copy procedure
;                     die ]
end
to plot-patch-numbers ;; plot-patch-numbers procedure
  set-current-plot "Patch-plot"
  plotxy generationstep patch-count
end
to go ;; to go procedure initialises model 2
   set generationstep generationstep + 1 ;; set and check the desired number of generations is reached
   if generationstep < #generations [
    create-cell-bodies
    replicate-cell-bodies
   ]
  end
to  create-cell-bodies ;; create turtles
  ifelse count turtles = 0 [
    ask patch (max-pxcor / 2) max-pycor [
      set pcolor green
      sprout 1 [

        set shape "circle"
        set size 0.5
        set color white

      ]
    ]
  ]
  [
   ask turtles with
    [
      color = white
    ]
    [
      if [pcolor] of patch-here = green
      [

      hatch-copies 1 [
        set shape "circle"
        set size 0.5
        set color yellow
        set heading -135

      ]
        hatch-copies 1 [
        set shape "circle"
        set size 0.5
        set color yellow
        set heading 135
      ]

    ]
  ]
  ]


end

to replicate-cell-bodies ;; move turtles
  ask turtles with [color = yellow] [
    fd sqrt 2
    ifelse count turtles-here with
    [
      color = white] > 0 [die]
    [
      ask patch-here
      [
        ifelse pcolor = black [
          set pcolor green
        ]
        [
          set pcolor red
        ]
      ]
    ]
  ]
  ask patches [if count turtles-here with
    [ color = yellow] > 1 [
    ask one-of turtles-here [die]
    set pcolor red ]
  ]
  ask turtles [set color white]
end

;; uncomment everything  and recomment create-cell-bodies, to go procedure,  move-cell-bodies for go-once procedure to work
to go-once ;; initialises model 1
;  tick
;    if generationstep < #generations [
;
;  set generationstep generationstep + 1 ;; set and check the desired number of generations is reached
;  ask children[move]
;  stop
;      ]
end
;to move ;; to move procedure
; replicate
; die
;end
;to mark-and-breed ;; mark-and-breed procedure
;  ifelse pcolor != green [set pcolor green produces-copy][die]
;  set color white
;  hatch 1
;end
;to Show-Patch-Colors ;; patch procedure
;  ;; assign values to patch variables based on current state of the row
;  set left-pcolor [pcolor] of patch-at -1 0
;  set center-pcolor pcolor
;  set right-pcolor [pcolor] of patch-at 1 0
; ifelse ((left-pcolor = green and center-pcolor = green and right-pcolor = green) or
;    (left-pcolor = green and center-pcolor = red and right-pcolor = green) or
;    (left-pcolor = red and center-pcolor = green and right-pcolor = red) or
;    (left-pcolor = red and center-pcolor = red and right-pcolor = red))
;    [ ask patch-at 0 -1[ set pcolor green] ]
;    [ ask patch-at  0  -1 [ set pcolor red] ]
;
;end
;to replicate ;; to replicate procedure
;  hatch-children 1 [move-to-lower-left set color white set size 0.5 set heading 0 set shape "circle"]
;  hatch-children 1 [move-to-lower-right set color white set size 0.5 set heading 0 set shape "circle"]
;end
;;
;to produces-copy ;; to produce-copy procedure
;  hatch-copies 1 [
;    set pcolor green
;    set color white
;    set size 0.5
;    set heading 0
;    set shape "circle"
;  ]
;end
;to move-to-lower-left ;; to move-to-lower-left procedure
;  bk 1
;  lt 90
;  fd 1
;  mark-and-breed
;
;end
;to move-to-lower-right ;; to move-to-lower-right procedure
;  bk 1
;  rt 90
;  fd 1
; mark-and-breed
;end
@#$#@#$#@
GRAPHICS-WINDOW
210
10
1194
995
-1
-1
16.0
1
10
1
1
1
0
1
1
1
0
60
0
60
0
0
1
ticks
30.0

BUTTON
130
46
194
79
NIL
Setup\n
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
54
45
117
78
NIL
Go\n
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
22
437
194
470
#generations
#generations
0
100
29.0
1
1
NIL
HORIZONTAL

SWITCH
22
403
185
436
show-patch-colors?
show-patch-colors?
1
1
-1000

BUTTON
43
87
121
120
NIL
Clear-All\n
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

PLOT
0
130
200
280
Patch-Plot
GenerationStep
Number of Patches
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"Count turtles" 1.0 0 -16777216 true "" "plot count turtles"
"Count copies" 1.0 0 -7500403 true "" "plot count copies"
"Count children" 1.0 0 -2674135 true "" "plot count children"

MONITOR
0
288
80
333
Patch-count
count turtles
17
1
11

MONITOR
84
287
177
332
NIL
Count children
17
1
11

MONITOR
0
332
85
377
NIL
Count copies
17
1
11

BUTTON
127
88
207
121
NIL
Go-Once\n
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

@#$#@#$#@
## WHAT IS IT?

This project shows the visual version of model 2  sierpinskis triangle which show population growth by cell division. 

## HOW IT WORKS

Starting point of the development is an initial parent cell, depicted below as a rectangle with a nucleus at the centre, which first divides horizontally in an upper and a lower halve. The lower part then divides vertically in two daughter cells of the same size. The left-hand daughter cell moves downward and to the left; the right-hand cells  moves  downward  and  to  the  right.  These  movements  are  to  circumvent  competition  for  space  and resources which would otherwise hamper the next stage, the expansion of the daughter cells to their full size (i.e. attaining the size of the initial parent cell).

# Model 1: 

In the simplest model, this gap is somehow filled up by a fourth cell, but it is not easy to come up with a biological plausible mechanism that explains how such a cell is generated.

# Model 2 :
Therefore a slightly more elaborate model is pursued. The procedures described above are repeated for each of the two daughter cells (which thereby become the parents of the next generation) without filling up the gap. But an anomaly occurs when the daughter cells are dividing: the right-hand clone of the leftward daughter cell and the left-hand clone of the rightward daughter cell move to a shared patch position and, due to competition, cannot expand to full size. The rule for this particular system is that such cells merge into a single cell. However, by doing so the merged cell loses the capacity to split and thereafter does not divide anymore.

## HOW TO USE IT

# Buttons:
Setup: When Setup is pressed then the model is initialised with a single cell in the center

# Go-Once: 
When go-once is pressed then it  displays a top-down pyramid shown in model 1 of the cw1 answer sheet on netlogo. 
#Go: 
When go is pressed then it begins running the model with the set rule for in this case is sierpinski triangle shown in model 2 of the cw1 answer sheet on netlogo. 
# Clear-All :
 Clears the world of all turtles.

# Sliders
#Generations: Adjust generations to view changes to model.

# Monitors
Patch-Count: Displays patch-count of number of turtles. 
Count-Children: Displays patch-count of number of children. 
Count-Copies: Displays patch-count of number of copies. 
Plot:
Shows number of patches against number of generations. 


## THINGS TO NOTICE

Model 1 is displayed on the interface upon pressing go-once. 
Model 2 is displayed on the interface upon pressing go. 


## THINGS TO TRY


Change the values in the show-patch procedure to view changes to the interface for either model. 

move sliders for #Generations to view changes to model. 


## EXTENDING THE MODEL
Get the switch to work so you can view model 1 and model 2 simultaneously. 

# Uncomment sections of code:
;   set generationstep generationstep + 1 ;; set and check the desired number of generations is reached
;   if generationstep < #generations [
;    create-cell-bodies 
;    move-cell-bodies
;   ]

 ;   create-turtles 1 [set color white  ;; sets the color of the turtle to white
             ;       set shape "circle" ;; sets shape of turtle to circle
            ;        set size 2 ;; set size of turtle to 2
            ;       setxy (max-pxcor / 2) (max-pycor - 1) ;; setting start poisiton in ;the world
            ;        set pcolor green ;; setting patch colour to green
            ;        hatch-children 1 [set color white set size 0.5 set heading 0 set ;hape "circle" ]
                  ;  produces-copy;; calling produce-copy procedure
                ;     die ]
;to go-once ;; initialises model 1
  ;  if generationstep < #generations [
 ;   tick
 ; set generationstep generationstep + 1 ;; set and check the desired number of ;generations is reached
 ; ask children[move]
 ; stop
    
 ; ]
;end
;to move ;; to move procedure
; replicate
; die
;end
;to mark-and-breed ;; mark-and-breed procedure
;  ifelse pcolor != green [set pcolor green produces-copy][die]
 ; set color white
 ; hatch 1
;end
;to Show-Patch-Colors ;; patch procedure
 ; ;; assign values to patch variables based on current state of the row
 ; set left-pcolor [pcolor] of patch-at -1 0
 ; set center-pcolor pcolor
 ; set right-pcolor [pcolor] of patch-at 1 0
 ;ifelse ((left-pcolor = green and center-pcolor = green and right-pcolor = green) or
  ;  (left-pcolor = green and center-pcolor = red and right-pcolor = green) or
  ;  (left-pcolor = red and center-pcolor = green and right-pcolor = red) or
  ;  (left-pcolor = red and center-pcolor = red and right-pcolor = red))
  ;  [ ask patch-at 0 -1[ set pcolor green] ]
  ;  [ ask patch-at  0  -1 [ set pcolor red] ]

;end
;to replicate ;; to replicate procedure
;  hatch-children 1 [move-to-lower-left set color white set size 0.5 set heading 0 set ;shape "circle"]
 ; hatch-children 1 [move-to-lower-right set color white set size 0.5 set heading 0 set ;shape "circle"]
;end
;;
;to produces-copy ;; to produce-copy procedure
 ; hatch-copies 1 [
 ;  set pcolor green
 ;   set color white
  ;  set size 0.5
 ;   set heading 0
  ;  set shape "circle"
 ; ]
;end
;to move-to-lower-left ;; to move-to-lower-left procedure
; bk 1
 ; lt 90
 ; fd 1
  ;mark-and-breed

;end
;to move-to-lower-right ;; to move-to-lower-right procedure
 ; bk 1
 ; rt 90
 ; fd 1
 ;mark-and-breed
;end

# Recomment:
to create-cell-bodies
end
to move-cell-bodies
end
to go
end 

The Go-Once : press the button then view model 1. 

## NETLOGO FEATURES

This model used breeds to implement the population of children and copies to form each model. 

## RELATED MODELS

CA 1D Rule 90 - the basic rule 90 model

## CREDITS AND REFERENCES
Wilensky, U. (2002). NetLogo CA 1D Rule 90 model. http://ccl.northwestern.edu/netlogo/models/CA1DRule90. Center for Connected Learning and Computer-Based Modeling, Northwestern University, Evanston, IL.

Rene.2020. Practical 3 Population Growth by cell divison  https://herts.instructure.com/courses/77620/files/2351766?module_item_id=1320622 Date Accessed: 10/11/2020 

Rene.2020.Design Program Population Growth by cell divison.https://herts.instructure.com/courses/77620/files/2370872?module_item_id=1328164 Date Accessed : 10/11/2020
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.1.1
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
