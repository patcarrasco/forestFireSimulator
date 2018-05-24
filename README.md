#### File list:
- Forest fire simulation model (.R)
- Data obtained from model (.csv)
- Plots created from obtained data (HTML, ipynb)

# Forest Fire Simulation

## 1. Model Structure and Parameters
- 100 x 100 lattice (2-Dimensional)
- Lattice is randomly populated by 'trees'
- One tree is randomly chosen to be the origin of fire
- Model runs until there are no more burning trees
- Trees burn for one timestep
- A live tree directly in contact with a burning tree will catch fire
- 100 iterations for each tested parameter
