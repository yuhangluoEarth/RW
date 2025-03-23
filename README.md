Random Walk Simulations in R
This project includes two R scripts that simulate random walk processes under different conditions: one for a free random walk and another for a barrier-constrained random walk.

1. Free Random Walk Simulation
Objective: Simulates unrestricted movement in a homogeneous environment.
Key Features:
Each step is determined by a random direction (uniformly distributed between 0 and 2π) and a fixed step length.
The process continues for a predefined number of steps, recording the trajectory of the walker.
Visualizes the trajectory using ggplot2 or base R plotting functions.

2. Barrier-Constrained Random Walk Simulation
Objective: Simulates movement in an environment with barriers, such as roads or urban infrastructure.
Key Features:
Introduces barriers as predefined regions where movement is restricted or redirected.
If the walker encounters a barrier, it changes direction based on the barrier's properties.
Records the trajectory and calculates the success rate of reaching a target.
Visualizes the trajectory and barrier interactions using ggplot2 or base R plotting functions.
