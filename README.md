# CPSC565A1 - Wasps

## What Is It

Wasps build complex, yet well structured, nests for their colonies. Each wasp species builds a structurally distinct nest using similar building materials. With no master builder, the task of nest building is distributed over all the involved wasps. How does each wasp know what to do in order to succeed in building a structurally correct and functional nest? One of the theories to explain this emergent phenomenon uses the idea of qualitative stigmergy where the wasps use visual queues (stigma) in their environment to decide on their actions. In this assignment we implement a model of wasp nest construction based on qualitative stigmergy.

This model is a simulation of the hypothesized method by which wasps construct nests without a supervising agent: Qualitative Stimurgy. The wasps investigate their surrounds and decide where to build based on visual indicators.

## How It Works

Each wasp moves around randomly. Every tick it investigates the 8 squares which neighbour the square it currently occupies. If the neighbouring squares correspond to an associated rule within the wasps’ ruleset (indicated by the colour/material of the squares) then the wasp will place a building material on the square it currently occupies.
Rules are of the form (A B C D E F G H) -> Y, where A-H and Y are possible building materials (They could all be the same) or lack of building materials. A-H refer to the 8 neighbouring squares such that A is the square directly north of the wasp, B is the square NE of the wasp, and so on continuing clockwise. If A-H all match the current environment then the wasp will place a material Y at its current location. In this simulation I have used materials 1, 2, and 3 which each correspond to red, blue, and green respectively, and 0 is used to indicate a lack of building materials. (The patch is white) Therefore an example of a rule might be (1 2 3 0 0 0 0 0) -> 2 which would indicate that if the patch to the N of the wasp contains material 1, the patch to the NE contains material 2, the patch to the E contains material 3, and no other patches surrounding the wasp contain any material, then the wasp would place material 2 at its current location.

Rulesets are structured such that the first matching rule in the list of rulesets is implemented if multiple rules could apply. Each rule is also applied symmetrically, resulting in 4 rules implemented for each 1 rule written.

As written wasps are not allowed to place material upon locations which already contain material. However, by commenting and uncommenting two separate lines this can be changed.

Wasps are also not allowed to remove any building materials.

## How To Use It

To use the model the observer will select the number of wasps to use, the ruleset, and then the starting densities of the different building materials. The densities are limited in such a way that if you have 60% density of material 1, you will only be able to have a maximum of 40% density of material 2 or 3. Having 100% density of building materials results in a lack of empty spaces.

Then the user will click the startup button, wait for the world to load all of the patches and wasps, and then they can press go to begin the simulation.

![e1](https://user-images.githubusercontent.com/23039052/115158684-a3bd8f80-a04c-11eb-8aeb-f140074a991c.png)

> One example setup

![e2](https://user-images.githubusercontent.com/23039052/115158689-ae782480-a04c-11eb-82d2-4eb780093c19.png)

> Another example setup

# Implementation

## Rulesets

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

# Analysis

## Things To Notice

Seeds 1-3 are the prewritten seeds given to us for this assignment. Seeds 4-6 are self-implemented seeds. All of the seeds work best when there’s an extremely low density of starting material. (Density % of 1 for each material allows the most freedom)

Seed 4 creates long red lines with blue paths branching off of them, as well as blue ‘labyrinths’ spawned off of individual blue blocks in open spaces.

Seed 5 creates lattices of blue materials with red materials used to fill in some gaps between blue material. Often little islands of red materials will connect, but not always.

Seed 6 creates labyrinths of each respective colour, however, whenever tendrils of one colour are one block away from a line of another colour, the tertiary colour is filled in. This way most of the labyrinths are connected, but always with an intermedeary in between. Additionally long teeth sections which can emerge from straight lines have their bases filled in with a different colour.

## Things To Try

Alter the number of wasps and see how the speed of the simulation becoming complete doesn’t change noticeably.

See how too much beginning density of material impedes the wasps’ creation efforts.

Slow down the number of ticks to more closely examine the way wasps walk and the ground that they cover.

## Extending The Model

Additional colours can always be implemented, but too many colours necessitates the inclusion of larger and much more complex rulesets in order to reliable build structures. Too many colours and the wasps’ ability to select a nest site is overwhelmed.

The ruleset for seed 5 could be extended which would result in more space between blue posts being filled in. It would be a matter mostly of looking at all the possible arrangements of blue/red with white in the middle and filling them in with red. This would likely connect even more islands together.

# Credits/Other

Written by: Cody Clark UCID: 30010560
Seeds 1-3 as well as the ruleset symmetry-izer provided by Cooper for this CPSC565 assignment.
