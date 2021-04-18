; Author: Cody Clark
; UCID: 30010560
; CPSC565A1

breed [ wasps wasp ]

patches-own [ material ]

globals [ rules ]

to setup
  clear-all
  set-ruleset

  ; Set patch color and material
  ask patches [
    let chance random 100
    ifelse chance < red-density
    [ set pcolor red
      set material 1 ]
    [ ifelse chance >= red-density and chance < red-density + blue-density
      [ set pcolor blue
        set material 2]
      [ ifelse chance >= red-density + blue-density and chance < green-density + red-density + blue-density
      [ set pcolor green
        set material 3 ]
      [ set pcolor white
        set material 0 ]
      ]
    ]
  ]

  ; Create Wasps
  create-wasps initial-number-wasps
  [
    set shape "bee 2"
    set color yellow
    set size 1.5
    setxy random-xcor random-ycor
  ]

  reset-ticks
end

to go
  ; Wasp actions
  ask wasps [
    move
    build
  ]

  tick
end

to move
  rt random 90
  lt random 90
  fd 1
end

to build
  foreach rules [
    ; For each rule...
    n -> if [ material ] of patch-at 0 1 = item 0 (item 0 n) [ ; Examine N patch
      if [ material ] of patch-at 1 1 = item 1 (item 0 n) [ ; Examine NE patch
        if [ material ] of patch-at 1 0 = item 2 (item 0 n) [ ; Examine E patch
          if [ material ] of patch-at 1 -1 = item 3 (item 0 n) [ ; Examine SE patch
            if [ material ] of patch-at 0 -1 = item 4 (item 0 n) [ ; Examine S patch
              if [ material ] of patch-at -1 -1 = item 5 (item 0 n) [ ; Examine SW patch
                if [ material ] of patch-at -1 0 = item 6 (item 0 n) [ ; Examine W patch
                  if [ material ] of patch-at -1 1 = item 7 (item 0 n) [ ; Examine NW patch
                    ask patch-here [ ; Change the patch the wasp is standing on
                      ;if material != item 1 n [ ; If material can cover other materials
                      if material = 0 [ ; If materials cannot cover other materials
                        set material (item 1 n)
                        if item 1 n = 1 [
                          set pcolor red
                        ]
                        if item 1 n = 2 [
                          set pcolor blue
                        ]
                        if item 1 n = 3 [
                          set pcolor green
                        ]
                        ;show "Placed a square"
                        ;show word "Rule used: " n
                      ]
                    ]
                  ]
                ]
              ]
            ]
          ]
        ]
      ]
    ]
  ]


  ; This asks each of the patches to ask their neighbor so is less in the agent-based paradigm (Also slower)
  ; Included just for posterity

  ; Go through all the rules
  ;foreach rules [
    ; For each rule...
   ; n -> ask patch-at 0 1 [
    ;  if item 0 (item 0 n) = material [
     ;   ask patch-at 1 0 [
      ;    if item 1 (item 0 n) = material [
       ;     ask patch-at 0 -1 [
        ;      if item 2 (item 0 n) = material [
         ;       ask patch-at 0 -1 [
          ;        if item 3 (item 0 n) = material [
           ;         ask patch-at -1 0 [
            ;          if item 4 (item 0 n) = material [
             ;           ask patch-at -1 0 [
              ;            if item 5 (item 0 n) = material [
               ;             ask patch-at 0 1 [
                ;              if item 6 (item 0 n) = material [
                 ;               ask patch-at 0 1 [
                  ;                if item 7 (item 0 n) = material [
                   ;                 ask patch-at 1 -1 [
                    ;                  ;if material != item 1 n [ ; If material can cover other materials
                     ;                 if material = 0 [ ; If materials cannot cover other materials
                      ;                  set material (item 1 n)
                       ;                 if item 1 n = 1 [
                        ;                  set pcolor red
                         ;               ]
                          ;              if item 1 n = 2 [
                           ;               set pcolor blue
                            ;            ]
                             ;           if item 1 n = 3 [
                              ;            set pcolor green
                               ;         ]
                                        ;show "Placed a square"
                                        ;show word "Rule used: " n
;                                      ]
;
 ;                                   ]
  ;                                ]
   ;                             ]
    ;                          ]
     ;                       ]
      ;                    ]
       ;                 ]
        ;              ]
         ;           ]
          ;        ]
           ;     ]
            ;  ]
;            ]
 ;         ]
  ;      ]
   ;   ]
    ;]
  ;]
end

; this reporter converts an asymmetric rule set into a symmetric ruleset
to-report convert-ruleset-to-symmetric [asymruleset]
  let symruleset (list)
  foreach asymruleset [ [rule] ->
    let asymrule first rule
    let result last rule

    ; Add asymmetric rule
    set symruleset lput rule symruleset

    ; Add the 3 other symmetric rules
    foreach [2 4 6] [ [sym] ->
      set symruleset lput (list (sentence (sublist asymrule sym 8) (sublist asymrule 0 sym)) result) symruleset
    ]
  ]
  report symruleset
end

to-report max-blue-density
  let result (100 - red-density - green-density)
  report result
end

to-report max-red-density
  let result (100 - blue-density - green-density)
  report result
end

to-report max-green-density
  let result (100 - blue-density - blue-density)
  report result
end

to set-ruleset
  ; Seed: 1
  if ruleset = "vespa-ruleset" [
    set rules (list
      (list (list 1 0 0 0 0 0 0 0) 2)
      (list (list 1 2 0 0 0 0 0 0) 2)
      (list (list 1 0 0 0 0 0 0 2) 2)
      (list (list 2 0 0 0 0 0 2 1) 2)
      (list (list 0 0 0 0 2 1 2 0) 2)
      (list (list 2 0 0 0 0 0 1 2) 2)
      (list (list 0 0 0 0 2 2 1 0) 2)
      (list (list 2 0 0 0 0 0 2 1) 2)
      (list (list 1 2 0 0 0 0 0 2) 2)
      (list (list 2 2 0 0 0 0 0 2) 2)
      (list (list 2 2 0 0 0 2 2 2) 2)
      (list (list 2 0 0 0 0 0 2 2) 2)
      (list (list 2 2 2 0 0 0 2 2) 2)
      (list (list 1 2 2 0 0 0 2 2) 2)
      (list (list 2 2 2 2 0 2 2 2) 2)
      (list (list 2 0 0 0 0 2 2 1) 2)
      (list (list 2 2 0 0 0 0 2 1) 2)
      (list (list 2 2 0 0 0 2 2 1) 2))
  ]

  ; Seed: 2
  if ruleset = "vespula-ruleset" [
    set rules (list
      (list (list 2 0 0 0 0 0 0 0) 2)
      (list (list 2 2 0 0 0 0 0 0) 2)
      (list (list 2 0 0 0 0 0 0 2) 2)
      (list (list 2 0 0 0 0 0 2 2) 2)
      (list (list 2 2 2 0 0 0 0 0) 2)
      (list (list 2 2 0 0 0 0 0 2) 2)
      (list (list 2 2 0 0 0 0 2 2) 2)
      (list (list 2 2 2 0 0 0 2 2) 2))
  ]

  ; Seed: 3
  if ruleset = "parachartergus-ruleset" [
    set rules (list
      (list (list 0 0 0 0 0 0 1 0) 2)
      (list (list 2 0 0 0 0 0 0 1) 2)
      (list (list 0 0 0 0 2 1 0 0) 2)
      (list (list 0 0 0 0 0 2 2 2) 2)
      (list (list 0 0 0 0 2 2 2 0) 2)
      (list (list 2 0 0 0 0 0 2 2) 2)
      (list (list 2 2 0 0 0 0 0 2) 2)
      (list (list 0 0 0 2 2 2 0 0) 2)
      (list (list 2 0 0 0 0 0 0 1) 2)
      (list (list 2 0 0 0 0 2 2 2) 2)
      (list (list 2 2 2 2 0 0 0 0) 2)
      (list (list 2 2 2 0 0 0 2 2) 2)
      (list (list 2 0 0 0 2 2 2 2) 2)
      (list (list 0 0 2 2 2 2 2 0) 2)
      (list (list 2 2 2 0 0 0 0 0) 2)
      (list (list 0 0 2 2 2 0 0 0) 2)
      (list (list 0 0 0 2 2 2 2 2) 2))
  ]

  ; Seed: 4
  if ruleset = "Ichneumon-ruleset" [
    set rules (list
      (list (list 1 0 0 0 0 0 0 0) 1)
      (list (list 1 1 0 0 0 0 0 1) 2)
      (list (list 2 0 0 0 1 0 0 0) 1)
      (list (list 1 1 0 0 1 0 0 1) 1)
      (list (list 0 2 0 0 1 0 0 2) 1)
      (list (list 1 1 2 0 0 0 2 1) 1)
      (list (list 0 2 0 0 1 0 0 0) 1)
      (list (list 0 0 0 0 1 0 0 2) 1)
      (list (list 1 1 2 0 0 0 0 1) 1)
      (list (list 1 1 0 0 0 0 2 1) 1)
      (list (list 0 1 0 0 0 0 0 1) 1)
      (list (list 2 0 0 0 0 0 0 0) 2)
      (list (list 2 2 0 0 0 0 0 2) 2))
  ]

  ; Seed 5:
  if ruleset = "Bembicini-ruleset" [
    set rules (list
      (list (list 1 0 0 0 0 0 0 0) 2)
      (list (list 0 1 0 0 0 0 0 0) 2)
      (list (list 1 0 2 0 0 0 2 0) 1)
      (list (list 2 1 1 1 2 0 0 0) 1)
      (list (list 1 2 0 0 0 0 0 2) 1)
      (list (list 2 1 1 2 0 2 1 1) 1)
      (list (list 1 2 0 2 0 2 0 2) 1)
      (list (list 1 1 2 1 1 1 2 1) 1)
      (list (list 1 1 2 1 1 0 2 1) 1)
      (list (list 0 0 0 0 2 1 1 2) 1)
      (list (list 0 2 1 1 2 1 0 0) 1)
      (list (list 0 0 2 0 1 1 2 0) 1)
      (list (list 2 0 0 0 0 2 1 1) 1)
      (list (list 0 0 0 1 2 1 0 0) 1)
      (list (list 1 2 0 0 2 0 1 2) 1)
      (list (list 1 2 0 1 2 1 0 2) 1)
      (list (list 1 0 0 0 2 0 0 0) 1)
      (list (list 0 0 1 0 0 0 2 0) 1)
      (list (list 0 0 2 1 1 1 0 0) 1)
      (list (list 0 2 1 2 0 2 1 2) 1)
      (list (list 0 2 0 0 2 0 1 2) 1)
      (list (list 2 0 1 1 2 1 1 0) 1))
  ]

  ; Seed 5:
  if ruleset = "Affinis-ruleset" [
    set rules (list
      (list (list 3 0 0 0 0 0 0 0) 3)
      (list (list 2 0 0 0 0 0 0 0) 2)
      (list (list 1 0 0 0 0 0 0 0) 1)
      ; When coloured lines meet other colours
      (list (list 0 0 1 0 0 3 3 3) 2)
      (list (list 0 0 1 0 0 3 3 0) 2)
      (list (list 0 0 1 0 0 0 3 3) 2)
      (list (list 0 0 2 0 0 3 3 3) 1)
      (list (list 0 0 2 0 0 3 3 0) 1)
      (list (list 0 0 2 0 0 0 3 3) 1)
      (list (list 0 0 1 0 0 2 2 2) 3)
      (list (list 0 0 1 0 0 2 2 0) 3)
      (list (list 0 0 1 0 0 0 2 2) 3)
      (list (list 0 0 3 0 0 2 2 2) 1)
      (list (list 0 0 3 0 0 2 2 0) 1)
      (list (list 0 0 3 0 0 0 2 2) 1)
      (list (list 0 0 3 0 0 1 1 1) 2)
      (list (list 0 0 3 0 0 1 1 0) 2)
      (list (list 0 0 3 0 0 0 1 1) 2)
      ;
      (list (list 1 0 1 0 0 0 0 0) 1)
      (list (list 2 0 2 0 0 0 0 0) 2)
      (list (list 3 0 3 0 0 0 0 0) 3)
      ;
      (list (list 3 0 0 0 3 0 0 3) 3)
      (list (list 3 0 3 0 3 0 0 0) 3)
      (list (list 2 0 0 0 2 0 0 2) 2)
      (list (list 2 0 2 0 2 0 0 0) 2)
      (list (list 1 0 0 0 1 0 0 1) 1)
      (list (list 1 0 1 0 1 0 0 0) 1)
      ;
      (list (list 3 3 0 0 0 0 0 3) 3)
      (list (list 2 2 0 0 0 0 0 2) 2)
      (list (list 1 1 0 0 0 0 0 1) 1)
      ;
      (list (list 3 3 3 3 0 3 3 3) 2)
      (list (list 2 2 2 2 0 2 2 2) 1)
      (list (list 1 1 1 1 0 1 1 1) 3)
      ;
      (list (list 0 3 3 3 0 2 2 2) 1)
      (list (list 1 3 3 3 1 2 2 2) 1)
      (list (list 1 3 3 3 0 2 2 2) 1)
      (list (list 0 2 2 2 0 1 1 1) 3)
      (list (list 3 2 2 2 3 1 1 1) 3)
      (list (list 3 2 2 2 0 1 1 1) 3)
      (list (list 0 1 1 1 0 3 3 3) 2)
      (list (list 2 1 1 1 2 3 3 3) 2)
      (list (list 2 1 1 1 0 3 3 3) 2)
    )
  ]

  ; Convert whatever ruleset selected in symmetric ruleset
  set rules convert-ruleset-to-symmetric rules
  show word "Current ruleset: " ruleset
  foreach rules [
    n -> show n
  ]
end
@#$#@#$#@
GRAPHICS-WINDOW
210
10
1011
812
-1
-1
13.0
1
10
1
1
1
0
1
1
1
-30
30
-30
30
0
0
1
ticks
30.0

BUTTON
88
10
151
43
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

BUTTON
12
10
75
43
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

INPUTBOX
11
56
166
116
initial-number-wasps
20.0
1
0
Number

CHOOSER
18
157
195
202
RULESET
RULESET
"vespa-ruleset" "vespula-ruleset" "parachartergus-ruleset" "Ichneumon-ruleset" "Bembicini-ruleset" "Affinis-ruleset"
4

SLIDER
17
225
189
258
blue-density
blue-density
0
max-blue-density
1.0
1
1
NIL
HORIZONTAL

SLIDER
20
275
192
308
red-density
red-density
0
max-red-density
1.0
1
1
NIL
HORIZONTAL

SLIDER
22
334
195
367
green-density
green-density
0
max-green-density
1.0
1
1
NIL
HORIZONTAL

@#$#@#$#@
## WHAT IS IT?

This model is a simulation of the hypothesized method by which wasps construct nests without a supervising agent: Qualitative Stimurgy. The wasps investigate their surrounds and decide where to build based on visual indicators. 

This is the first assignment of CPSC565.

## HOW IT WORKS

Each wasp moves around randomly. Every tick it investigates the 8 squares which neighbour the square it currently occupies. If the neighbouring squares correspond to an associated rule within the wasps' ruleset (indicated by the colour/material of the squares) then the wasp will place a building material on the square it currently occupies. 

Rules are of the form (A B C D E F G H) -> Y, where A-H and Y are possible building materials (They could all be the same) or lack of building materials. A-H refer to the 8 neighbouring squares such that A is the square directly north of the wasp, B is the square NE of the wasp, and so on continuing clockwise. If A-H all match the current environment then the wasp will place a material Y at its current location. In this simulation I have used materials 1, 2, and 3 which each correspond to red, blue, and green respectively, and 0 is used to indicate a lack of building materials. (The patch is white) Therefore an example of a rule might be (1 2 3 0 0 0 0 0) -> 2 which would indicate that if the patch to the N of the wasp contains material 1, the patch to the NE contains material 2, the patch to the E contains material 3, and no other patches surrounding the wasp contain any material, then the wasp would place material 2 at its current location. 

Rulesets are structured such that the first matching rule in the list of rulesets is implemented if multiple rules could apply. Each rule is also applied symmetrically, resulting in 4 rules implemented for each 1 rule written.

As written wasps are not allowed to place material upon locations which already contain material. However, by commenting and uncommenting two separate lines this can be changed.

Wasps are also not allowed to remove any building materials.  

## HOW TO USE IT

To use the model the observer will select the number of wasps to use, the ruleset, and then the starting densities of the different building materials. The densities are limited in such a way that if you have 60% density of material 1, you will only be able to have a maximum of 40% density of material 2 or 3. Having 100% density of building materials results in a lack of empty spaces. 

Then the user will click the startup button, wait for the world to load all of the patches and wasps, and then they can press go to begin the simulation.

## THINGS TO NOTICE

Seeds 1-3 are the prewritten seeds given to us for this assignment. Seeds 4-6 are self-implemented seeds. All of the seeds work best when there's an extremely low density of starting material. (Density % of 1 for each material allows the most freedom)

Seed 4 creates long red lines with blue paths branching off of them, as well as blue 'labyrinths' spawned off of individual blue blocks in open spaces.

Seed 5 creates lattices of blue materials with red materials used to fill in some gaps between blue material. Often little islands of red materials will connect, but not always.

Seed 6 creates labyrinths of each respective colour, however, whenever tendrils of one colour are one block away from a line of another colour, the tertiary colour is filled in. This way most of the labyrinths are connected, but always with an intermedeary in between. Additionally long teeth sections which can emerge from straight lines have their bases filled in with a different colour. 

## THINGS TO TRY

Alter the number of wasps and see how the speed of the simulation becoming complete doesn't change noticeably. 

See how too much beginning density of material impedes the wasps' creation efforts.

Slow down the number of ticks to more closely examine the way wasps walk and the ground that they cover.

## EXTENDING THE MODEL

Additional colours can always be implemented, but too many colours necessitates the inclusion of larger and much more complex rulesets in order to reliable build structures. Too many colours and the wasps' ability to select a nest site is overwhelmed.

The ruleset for seed 5 could be extended which would result in more space between blue posts being filled in. It would be a matter mostly of looking at all the possible arrangements of blue/red with white in the middle and filling them in with red. This would likely connect even more islands together. 

## CREDITS AND REFERENCES

Written by: Cody Clark
UCID: 30010560

Seeds 1-3 as well as the ruleset symmetry-izer provided by Cooper for this CPSC565 assignment. 
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

bee 2
true
0
Polygon -1184463 true false 195 150 105 150 90 165 90 225 105 270 135 300 165 300 195 270 210 225 210 165 195 150
Rectangle -16777216 true false 90 165 212 185
Polygon -16777216 true false 90 207 90 226 210 226 210 207
Polygon -16777216 true false 103 266 198 266 203 246 96 246
Polygon -6459832 true false 120 150 105 135 105 75 120 60 180 60 195 75 195 135 180 150
Polygon -6459832 true false 150 15 120 30 120 60 180 60 180 30
Circle -16777216 true false 105 30 30
Circle -16777216 true false 165 30 30
Polygon -7500403 true true 120 90 75 105 15 90 30 75 120 75
Polygon -16777216 false false 120 75 30 75 15 90 75 105 120 90
Polygon -7500403 true true 180 75 180 90 225 105 285 90 270 75
Polygon -16777216 false false 180 75 270 75 285 90 225 105 180 90
Polygon -7500403 true true 180 75 180 90 195 105 240 195 270 210 285 210 285 150 255 105
Polygon -16777216 false false 180 75 255 105 285 150 285 210 270 210 240 195 195 105 180 90
Polygon -7500403 true true 120 75 45 105 15 150 15 210 30 210 60 195 105 105 120 90
Polygon -16777216 false false 120 75 45 105 15 150 15 210 30 210 60 195 105 105 120 90
Polygon -16777216 true false 135 300 165 300 180 285 120 285

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
NetLogo 6.2.0
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
