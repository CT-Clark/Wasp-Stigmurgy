# CPSC565A1 - Wasps

This is the implementation of wasp nest making in NetLogo for CPSC565 Assignment 1. This displays emergence through cellular automata.

# Assignment Description

Wasps build complex, yet well structured, nests for their colonies. Each wasp species builds a structurally distinct nest using similar building materials. With no master builder, the task of nest building is distributed over all the involved wasps. How does each wasp know what to do in order to succeed in building a structurally correct and functional nest? One of the theories to explain this emergent phenomenon uses the idea of qualitative stigmergy where the wasps use visual queues (stigma) in their environment to decide on their actions. In this assignment we implement a model of wasp nest construction based on qualitative stigmergy.

In this project we had to implement 3 predetermined rulesets as well as implementing 3 novel rulesets which produce interesting results. In addition we had to provide a UI for interaction with this project.

# UI

To operate this project you must first enter the number of wasps to spawn, which ruleset you're using, and then the initial densities of of each material - red, green, or blue. After these settings have been initialized the setup button must be pressed, and then finally the go button can be pressed to run the simulation.

![e1](https://user-images.githubusercontent.com/23039052/115158684-a3bd8f80-a04c-11eb-8aeb-f140074a991c.png)

> One example setup

![e2](https://user-images.githubusercontent.com/23039052/115158689-ae782480-a04c-11eb-82d2-4eb780093c19.png)

> Another example setup

# Implementation

## Rulesets

The rulesets implement a version of cellular automata whereby local rules hopefully produce global results. The wasps move around randomly and then - if the patch underneath the wasp is devoid of any material - it examines the 8 patches surrounding the wasp. If the 8 patches correspond to a rule within the wasps' ruleset they will place a material of a particular colour at that location. 

The rulesets are of the form:
- (X1, X2, X3, X4, X5, X6, X7, X8) -> Y

Where X1 represents the space to the North of the wasp, X2 to the NE, and so on clockwise, and Y represents the material to place at the wasps' location. 

### Vespa Ruleset - Predefined

![Record3](https://user-images.githubusercontent.com/23039052/115159360-ffd5e300-a04f-11eb-8023-27fa3ff9b3fd.gif)

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
      (list (list 2 2 0 0 0 2 2 1) 2)

### Vespula - Predefined

![Record4](https://user-images.githubusercontent.com/23039052/115159414-3ca1da00-a050-11eb-869e-c6f493f97098.gif)

      (list (list 2 0 0 0 0 0 0 0) 2)
      (list (list 2 2 0 0 0 0 0 0) 2)
      (list (list 2 0 0 0 0 0 0 2) 2)
      (list (list 2 0 0 0 0 0 2 2) 2)
      (list (list 2 2 2 0 0 0 0 0) 2)
      (list (list 2 2 0 0 0 0 0 2) 2)
      (list (list 2 2 0 0 0 0 2 2) 2)
      (list (list 2 2 2 0 0 0 2 2) 2)
      
### Parachartergus - Predefined

![Record5](https://user-images.githubusercontent.com/23039052/115159494-999d9000-a050-11eb-8fe7-0133d1ca9ef7.gif)

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
      (list (list 0 0 0 2 2 2 2 2) 2)
      
### Ichneumon - Novel

![Record6](https://user-images.githubusercontent.com/23039052/115159549-e5e8d000-a050-11eb-89a2-b84f562c8bfa.gif)

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
      (list (list 2 2 0 0 0 0 0 2) 2)
      
### Bembicini - Novel

![Record7](https://user-images.githubusercontent.com/23039052/115159569-0dd83380-a051-11eb-9269-6044cba62808.gif)

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
      (list (list 2 0 1 1 2 1 1 0) 1)
      
### Affinis - Novel

![Record8](https://user-images.githubusercontent.com/23039052/115159597-32cca680-a051-11eb-894c-128a8ee850bf.gif)

      (list (list 3 0 0 0 0 0 0 0) 3)
      (list (list 2 0 0 0 0 0 0 0) 2)
      (list (list 1 0 0 0 0 0 0 0) 1)
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
      (list (list 1 0 1 0 0 0 0 0) 1)
      (list (list 2 0 2 0 0 0 0 0) 2)
      (list (list 3 0 3 0 0 0 0 0) 3)
      (list (list 3 0 0 0 3 0 0 3) 3)
      (list (list 3 0 3 0 3 0 0 0) 3)
      (list (list 2 0 0 0 2 0 0 2) 2)
      (list (list 2 0 2 0 2 0 0 0) 2)
      (list (list 1 0 0 0 1 0 0 1) 1)
      (list (list 1 0 1 0 1 0 0 0) 1)
      (list (list 3 3 0 0 0 0 0 3) 3)
      (list (list 2 2 0 0 0 0 0 2) 2)
      (list (list 1 1 0 0 0 0 0 1) 1)
      (list (list 3 3 3 3 0 3 3 3) 2)
      (list (list 2 2 2 2 0 2 2 2) 1)
      (list (list 1 1 1 1 0 1 1 1) 3)
      (list (list 0 3 3 3 0 2 2 2) 1)
      (list (list 1 3 3 3 1 2 2 2) 1)
      (list (list 1 3 3 3 0 2 2 2) 1)
      (list (list 0 2 2 2 0 1 1 1) 3)
      (list (list 3 2 2 2 3 1 1 1) 3)
      (list (list 3 2 2 2 0 1 1 1) 3)
      (list (list 0 1 1 1 0 3 3 3) 2)
      (list (list 2 1 1 1 2 3 3 3) 2)
      (list (list 2 1 1 1 0 3 3 3) 2)
