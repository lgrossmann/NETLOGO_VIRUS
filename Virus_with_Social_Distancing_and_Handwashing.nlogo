turtles-own
  [ sick?                ;; if true, the turtle is infectious and symptomatic
    infected?            ;; if true, the turtle is infectious but not yet symptomatic
    remaining-immunity   ;; how many days of immunity the turtle has left
    sick-time            ;; how long, in days, the turtle has been infectious
    number-asymptomatic-days ;; how long in days before an infected turtle gets sick
    age                  ;; in days
    d                    ;; distance to other turtles
 ]

patches-own 
[ infectious-time ]     ;; how long a patch is already infectious until patch-survival threshold.
                        ;; PATCH COLORS: Violet: infectious. Black: neutral.

globals
  [ %infected            ;; what % of the population is infected and infectious
    %immune              ;; what % of the population is immune
    %sick                ;; what % of the population is sick and infectious
    lifespan             ;; the lifespan of a turtle
    chance-newcomer      ;; the probability of a turtle generating a random lifespan, infected turtle each tick
    carrying-capacity    ;; the number of turtles that can be in the world at one time
    sick-duration        ;; how long from the onset of sickness with symptoms to the heal or die decision point
    ;;handwashing          ;; probability of a healthy person cleaning the current patch from the germs left by an infected individual
    ;infectious-time
    patch-survival
   ]

;; The setup is divided into four procedures
to setup
  clear-all
  setup-constants
  setup-turtles
  setup-patches
  update-global-variables
  update-display
  reset-ticks
  ;;export-interface "C:/Users/Lenard/Downloads/NLOGOEXPORT/NetLogoExported.png"
end

;; We create a variable number of turtles of which 10 percent are infectious,
;; and distribute them randomly
to setup-turtles
  create-turtles number-people
    [ setxy random-xcor random-ycor
      set age random lifespan
      set sick-time 0
      set infected? false
      set remaining-immunity 0
      set number-asymptomatic-days 0
      set size 1.5  ;; easier to see
      get-healthy ]
  ask n-of (number-people / 10) turtles
    [ get-infected ]
end

to setup-patches
  ask patches [
  set infectious-time 0
    set pcolor black ]
end
  
to get-infected ;; turtle procedure
  set infected? true
  set remaining-immunity 0
  set number-asymptomatic-days 1
end

to get-sick ;; turtle procedure
  set sick? true
  set infected? false
  set remaining-immunity 0
end

to get-healthy ;; turtle procedure
  set sick? false
  set remaining-immunity 0
  set sick-time 0
end

to become-immune ;; turtle procedure
  set sick? false
  set sick-time 0
  set remaining-immunity immunity-duration
end

;; This sets up basic constants of the model.
to setup-constants
  set lifespan 70 * 52 * 7       ;; 70 times 52 weeks * 7 days = 70 years
  set carrying-capacity 300      ;; max no turtles
  set chance-newcomer 0.5        ;; set to 0 if no reproduction desired
  set sick-duration 40           ;; how long one stays sick in this model
  set patch-survival 30

end

to go
  ask turtles [
    get-older
    move
    if sick? [ recover-or-die ]
    ifelse infected? [ infect ] [ add-newcomer ]
 ]
  ask patches with [pcolor = violet]  
      [ ifelse infectious-time > patch-survival [ set pcolor black set infectious-time 0 ] [ set infectious-time infectious-time + 1 ] ]
  
  update-global-variables
  update-display

  tick
end

to update-global-variables
  if count turtles > 0
    [ set %infected (count turtles with [ infected? ] / count turtles) * 100
      set %sick (count turtles with [ sick? ] / count turtles) * 100
      set %immune (count turtles with [ immune? ] / count turtles) * 100 ]
end

to update-display
  ask turtles
    [ if shape != turtle-shape [ set shape turtle-shape ]
      set color ifelse-value infected? [blue] [ifelse-value sick? [ red ] [ ifelse-value immune? [ grey ] [ green ] ] ]]
end

;;Turtle counting variables are advanced.
to get-older ;; turtle procedure
  ;; Turtles die of old age once their age exceeds the
  ;; lifespan (set at 70 years in this model).
  set age age + 1  ;; measured in days
  if age > lifespan [ die ]
  if immune? [ set remaining-immunity remaining-immunity - 1 ]
  if infected? and number-asymptomatic-days < symptom-free-period-days [set number-asymptomatic-days number-asymptomatic-days + 1]
  if infected? and number-asymptomatic-days >= symptom-free-period-days
    [get-sick]
  if sick? [ set sick-time sick-time + 1 ]
end

;; Turtles move about at random.
to move ;; turtle procedure
  ;; If move leads to be on same patch as anyone, don't do it % of the time.
  set d 0
  ask other turtles
    [ set d min-one-of turtles [DISTANCE myself] ]

  if d <= 1 and random-float 100 > adherence-to-social-distancing
  ;; move regardless, otherwise don't move at all
    [
    rt random 100
    lt random 100
    fd 1]
  ;; safe to move around
  if d >= 1
    [
    rt random 100
    lt random 100
    fd 1]
  ;;infected or sick person leaves an infected patch behind.
  ask turtles with [ sick? or infected? ] ;; ask infected and sick ones
    [ if pcolor = black [set pcolor violet] ]

  ;;The turtles are asked if their patch is infected. If so, either their "wash their hands" or get infected
  ask turtles with [ not sick? and not infected? ]
    [ if pcolor = violet and random-float 100 < handwashing [set pcolor black]
      if pcolor = violet and random-float 100 > handwashing [get-infected] ]
end
  
;; If a turtle is sick or infected, it infects other turtles on the same patch.
;; Immune turtles don't get sick.
to infect ;; turtle procedure
  ask other turtles-here with [ not sick? and not immune? and not infected? ] ;; ask the healthy, not immune ones
    [ if random-float 100 < infectiousness
      [ get-infected ]
    ]
end

;; Once the turtle has been sick long enough, it
;; either recovers (and becomes immune) or it dies.
to recover-or-die ;; turtle procedure
  if sick-time > sick-duration                     ;; If the turtle has survived past the desease's live-or-die duration, then
    [ ifelse random-float 100 < chance-recover   ;; either become healthy and immune or die
      [ become-immune ]
      [ die ] ]
end

;; If there are less turtles than the carrying-capacity
;; then add newcomer.
to add-newcomer
  if count turtles < carrying-capacity and random-float 100 < chance-newcomer
    [ hatch 1
      [ set age random lifespan
        lt 45 fd 1
        if random-float 100 < infectiousness
      [ get-infected ]
       ] ]
end

to-report immune?
  report remaining-immunity > 0
end

to startup
  setup-constants ;; so that carrying-capacity can be used as upper bound of number-people slider
end
