# NETLOGO_VIRUS
Netlogo Virus Agent-Based-Model (ABM) with Social Distancing Component.

You can grab the NetLogo file and either use it with the Desktop Application of NetLogo tested in version 6.1.1 or upload the file to the browser based version **which is a lot slower**, and run directly.
https://netlogoweb.org/




WHAT IS IT?
This model simulates the transmission and perpetuation of a virus in a human population.

This follows the original NetLogo VIRUS model by * Wilensky, U. (1998), but extends it by a few parameters heavily discussed in the context of COVID-19; such as SOCIAL-DISTANCING

HOW IT WORKS
A random population is set-up, with an initial infected percentage, over time the population moves, with the potential to infect others. A life cycle of healthy, infected, sick, immune is generall followed. The Social Distancing parameters prevents people who adhere to it from moving to the same patch as others, which is the condition for transmission of a disease from an infected (NO symptoms showing) or sick person (symptoms showing).

HOW TO USE IT
Each "tick" represents a day in the time scale of this model.

The INFECTIOUSNESS slider determines how great the chance is that virus transmission will occur when an infected person and susceptible person occupy the same patch. For instance, when the slider is set to 50, the virus will spread roughly once every two chance encounters.

The IMMUNITY-DURATION slider determines the number of days that a formerly sick individual retains immunity.

The CHANCE-RECOVER slider controls the likelihood that an infection will end in recovery/immunity. When this slider is set at zero, for instance, the infection is always deadly.

The SYMPTOM-FREE-PERIOD-DAYS slider controls how long it takes for an individual to start exhibiting symptoms of sickness.SICK-DURATION is hardcoded to 20 days after which a decision on recovery or death is made.

The ADHERENCE-TO-SOCIAL-DISTANCING slider determines the general percentage of people keeping their distance. The remainder is still able to spread the disease further by moving to the same patch as another.

*The HANDWASHING slider determines the overall likelihood of people "washing their hands" (i.e. agents wash the patch) after reaching a patch that has been contaminated by another infected or sick individual. Whoever does not wash their hands becomes infected in this model.*

The SETUP button resets the graphics and plots and randomly distributes NUMBER-PEOPLE in the view. All but 10% of the people are set to be "green" HEALTHY people and 10% "blue" INFECTED people (of randomly distributed ages). The GO button starts the simulation and the plotting function.

The TURTLE-SHAPE chooser controls whether the people are visualized as person shapes or as circles.

Four output monitors show the percent of the population that is infected, the percent that is immune, percentage that is sick and the number of days that have passed. The plot shows (in their respective colors) the number of healthy, infected, sick, and immune people. It also shows the number of individuals in the total population in black.

THINGS TO NOTICE
This is not meant to a scientifically accurate model of COVID-19, rather it should give an indication of social distancing and allows you to plug in a few realistic parameters of this Coronavirus as they become known

THINGS TO TRY
Compare how the distribution of the disease over time is affected by ADHERENCE-TO-SOCIAL-DISTANCING by setting it high or low.

RELATED MODELS
HIV
Virus on a Network
Virus
CREDITS AND REFERENCES
Wilensky, U. (1998). NetLogo Virus model. http://ccl.northwestern.edu/netlogo/models/Virus. Center for Connected Learning and Computer-Based Modeling, Northwestern University, Evanston, IL.

Wilensky, U. (1999). NetLogo. http://ccl.northwestern.edu/netlogo/. Center for Connected Learning and Computer-Based Modeling, Northwestern University, Evanston, IL.

COPYRIGHT AND LICENSE
Copyright 2020 Stefan and Lenard Grossmann.

This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 License. To view a copy of this license, visit https://creativecommons.org/licenses/by-nc-sa/3.0/ or send a letter to Creative Commons, 559 Nathan Abbott Way, Stanford, California 94305, USA.
