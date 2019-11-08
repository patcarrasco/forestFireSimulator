### File list:
- Forest fire simulation model (.R)
- Data obtained from model (.csv)
- Plots created from obtained data (HTML, ipynb)

# Forest Fire Simulation Using Percolation

## Model Structure and Parameters
- 100 x 100 lattice (2-Dimensional)
- Lattice is randomly populated by 'trees'
- One tree is randomly chosen to be the origin of fire
- Model runs until there are no more burning trees
- Trees burn for one timestep
- A live tree directly in contact with a burning tree will catch fire
- 100 iterations for each tested parameter

![1_vAsuQI9blUrhawxGWep2Tg](https://user-images.githubusercontent.com/39533889/56918309-a7d0fb00-6a8b-11e9-80b7-0515b2b16e19.png)

From 1 simulation of N= 30, percent_alive = .6 : START

![1_3hxHjjMdTPP6lKqoyCduSw](https://user-images.githubusercontent.com/39533889/56918310-aa335500-6a8b-11e9-9c8a-df1be5a3d878.png)

From 1 simulation of N= 30, percent_alive = .6 : END
