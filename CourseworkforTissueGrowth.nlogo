breed [children child];; creating a population of children to move around within the world
breed [copies copy] ;; creating copies of a child and hatch a copy
globals [AMPL  big-list Expected-AMPL  clustering coefficient CC Expected-Clustering-Coefficient generationstep Average-Degree degree] ; creating global variables for generationstep, ampl , CC and patch-count
copies-own [state]
extensions [nw]
;network extension

directed-link-breed [red-links red-link] ;  this defines a directed-link-breed

to setup ; creates a function called  setup
  ca
  nw:set-context turtles links
  clear-output


 set show-patch-color TRUE
 set generationstep 1
 crt 1
  [
   setxy (max-pxcor / 2) (max-pycor)
   mark-and-breed
  ]
 reset-ticks
end

to go-once ; creates a function to go-once
   clear-all
    if  show-circle?
   [
     make-circle

  ]
    compute-metrics
end

to mark-and-breed ; creates a function to mark-and-breed
  ifelse (pcolor != green)
    [set pcolor green replicate]
    [set pcolor red]
  die
end

to replicate ; to replicate function to move turtles
  hatch-children 1
     [
      set size 0.75
      set color orange
      set shape "triangle"
      if pcolor =  green [make-copy]
     ]
end

to make-circle ; creates a make-circle function
 layout-circle turtles (world-width / 2 - 20)
end

to make-copy ; creates a make-copy function
 hatch-copies 2
   [
    set size 0.25
    set shape "circle"
    set color white
    if who mod 2 = 0 [set state  "L"]
   ]
end

to-report provisional-path ; created a report procedure called provisional-path (temp)
 report nw:mean-path-length
end

to-report max-links ; created a report procedure called max-links
 report min (list (#generations * (#generations - 1) / 2) 1000)
end
to go ; creates a go function
  set generationstep generationstep + 1
  ask copies
    [
      ifelse pcolor != red
        [move mark-and-breed]  [die]
    ]
  if generationstep = #generations
   [
    ask copies [die]
    stop
   ]
  if show-patch-color = FALSE
  [
    clear-patches
  ]
  tick
  if not show-patch-color
  [ cp
     if show-circle?
    [ layout-circle turtles (world-width / 2 - 20)
         if  #generations > 1 [ set  #generations num-links ]
      while [count links < #generations]
        [ask one-of turtles
          [ create-link-with one-of other turtles ]
    ]
     ]
   ]
  compute-metrics ; CALLS compute-metrics function

end

to move ; creates a move function
   ifelse state = "L"
    [setxy (xcor - 1) (ycor - 1)]
    [setxy (xcor + 1) (ycor - 1)]
end

to compute-metrics ; creates a compute-metrics function
  set Average-Degree mean [degree] of turtles

  nw:set-context turtles links
  set AMPL nw:mean-path-length
  set CC mean [nw:clustering-coefficient] of turtles
end

to make-scatterplot ; creates a procedure for scatterplot
  set-current-plot "AMPL AND CC VS GENERATIONS "
  clear-plot
ASK PATCHES [
  plotxy AMPL CC
]
end


;---------------------------------------------------------------------
to make-links ; creates a make-link function
  if pcolor != red [ create-links-with children-on neighbors with [pycor < [pycor] of myself]]

  let a link-neighbors with [ycor < [ycor] of myself]
  if count a > 1 [ask a [ create-link-with turtle item 0 [who] of other a]]

;  ask turtles with [label = 0][create-links-with other turtles]
;  ask turtles with [label = 1][create-link-with turtle 2]
;  create-links-with turtles with [pcolor = green]
;;  --------------------------------------------------
;  ask turtle 0 [ create-links-with other turtles ]
;  ask turtle 0 [ create-link-with turtle 1 ]
;  ask turtle 2 [ create-link-with turtle 1 ]
;;  -------------------------------------------------
;  ask turtle 0 [ create-red-links-to other turtles with [pcolor = green] ]
;  ask turtle 0 [ create-red-links-from other turtles with [pcolor = green]]
;;  -----------------------------------------------------------------------
;  ask turtles [
; if not any? turtles-on neighbors with [pcolor = green]
; [create-links-with other turtles]
;  ]
end
@#$#@#$#@
GRAPHICS-WINDOW
247
10
1191
1109
-1
-1
15.355
1
10
1
1
1
0
0
0
1
0
60
0
70
1
1
1
ticks
30.0

BUTTON
43
34
106
67
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
21
133
144
166
#generations
#generations
0
26
25.0
1
1
NIL
HORIZONTAL

BUTTON
43
79
105
112
go-once
go\n\n
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
113
80
176
113
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SWITCH
23
203
147
236
show-patch-color
show-patch-color
0
1
-1000

SWITCH
23
240
146
273
show-circle?
show-circle?
1
1
-1000

PLOT
1201
11
1535
161
coverage
generation
#cells
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"# reproductive cells" 1.0 0 -10899396 true "" "plot count patches with [pcolor = green]"
"# nonreproducing cells" 1.0 0 -2674135 true "" "plot count patches with [pcolor = red]"
"# children" 1.0 0 -3844592 true "" "plot count children"

MONITOR
1
443
217
488
Average Minimal Path Length (AMPL)
AMPL
3
1
11

MONITOR
16
491
177
536
Clustering Coefficient (CC)
CC
3
1
11

MONITOR
0
390
90
435
# nodes
count children
17
1
11

MONITOR
95
391
152
436
# links
count links
17
1
11

PLOT
1229
247
1510
367
AMPL AND CC VS GENERATIONS 
AMPL 
CC
0.0
26.0
0.0
1.0
false
true
"" ""
PENS
"AMPL " 1.0 2 -16777216 true "" "plotxy AMPL CC "

SLIDER
21
168
149
201
num-links
num-links
0
max-links
25.0
1
1
NIL
HORIZONTAL

BUTTON
112
35
176
70
NIL
make-links\n
NIL
1
T
TURTLE
NIL
NIL
NIL
NIL
1

MONITOR
1272
191
1377
236
Average-Degree
Average-Degree
17
1
11

MONITOR
1387
189
1574
234
Expected Clustering Coefficient
Average-Degree / #generations
17
1
11

MONITOR
2
340
102
385
Expected-AMPL
(((ln #generations) - 0.577) / ln Average-Degree) + 0.5
17
1
11

@#$#@#$#@
## WHAT IS IT?

This project shows the visual version of   sierpinskis triangle which show population growth by cell division. 

## HOW IT WORKS

The biological notion is  that of growth and structure formation by a cell (containing a “nucleus”) that reproduces by splitting off daughter cells, which are formed at defined positions (lower left and lower right of the parent cell). After this, they behave as parent cells and repeat the cycle of separation and positioning. However, daughter cells  that end up at the same location experience competition for space and resources and as a result become infertile.  The outcome of the process is a tree-shaped “tissue” of green and red patches (respectively reproducing and non-reproducing cells).  For more details, see the description of the first course work.

# Visulisation of the Network 

Linking the essential agents in such a way that the flow of instructed actions becomes visible as a network.

# Characterisation of the network

Monitors The structure of the network is to be characterised by two parameters, the Average Minimal Path Length (AMPL) and the Clustering Coefficient (CC). Their computed values should show up in the monitors of that name (already on the Interface) during a run of the simulation. 

## HOW TO USE IT

# Buttons:
Setup: When Setup is pressed then the model is initialised with a single cell in the center

# Go-Once: 
When go-once is pressed then it  displays a top-down pyramid shown in model 2 of the cw3 answer sheet on netlogo. 

#Go: 
When go is pressed then it begins running the model with the set rule for in this case is sierpinski triangle  of the cw3 answer sheet on netlogo. 

# Clear-All :
 Clears the world of all turtles.

# Sliders
#Generations: Adjust generations to view changes to model.


# Switch 
show-patch-color: The switch shows the patch color when switched on.
show-circle?: The switch shows the circle at the centre of the nucleus. 

# Monitors
Patch-Count: Displays patch-count of number of turtles. 
Count-Children: Displays patch-count of number of children. 
Count-Copies: Displays patch-count of number of copies. 
Plot:
Shows number of patches against number of generations. 



## THINGS TO NOTICE

Adjust the #generations and num-links to collect data on the network. 

#GENERATIONS: 5, 10 , 15 , 20 , 25
#num-links: 5 , 10 , 15 , 20 , 25

Adjust the values for #generations and num-links accordingly then press the go button which will automatically run the model. After, press make-links to link sibling to sibling and switch off patch-color to notice values changing in Monitor AMPL: Nodes, links and CC. 

Adjust the values for #generations and num-links accordingly and press go to run the model then switch off patch-color , press go. Adjust num-links accordingly and notice changes to the model. 



## THINGS TO TRY

Run the model once, then switch the show-patch-color off and have show-circle on to notice different results.  

Second run:

Run the model once, then press the make-links button after switching the show-patch-color off and switch off the show-circle to notice different results that affect the main model.   

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

try uncommenting the code and giving running the code below. 
to make-links
;  ask turtles with [label = 0][create-links-with other turtles]
;  ask turtles with [label = 1][create-link-with turtle 2]
;  create-links-with turtles with [pcolor = green]
;;  --------------------------------------------------
;  ask turtle 0 [ create-links-with other turtles ]
;  ask turtle 0 [ create-link-with turtle 1 ]
;  ask turtle 2 [ create-link-with turtle 1 ]
;;  -------------------------------------------------
;  ask turtle 0 [ create-red-links-to other turtles with [pcolor = green] ]
;  ask turtle 0 [ create-red-links-from other turtles with [pcolor = green]]
;;  -----------------------------------------------------------------------
;  ask turtles [
; if not any? turtles-on neighbors with [pcolor = green]
; [create-links-with other turtles]
;  ]

end
(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

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
<experiments>
  <experiment name="experiment SierpinskyTurtle" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <metric>generation</metric>
    <metric>patch-count</metric>
    <enumeratedValueSet variable="#generations">
      <value value="25"/>
    </enumeratedValueSet>
  </experiment>
</experiments>
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
