# CPSC565A1

This is the implementation of wasp nest making in NetLogo for CPSC565 Assignment 1. 

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
