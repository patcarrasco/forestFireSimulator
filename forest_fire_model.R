### Making Percolation Networks!!
library(igraph)
library(tidyverse)
# Decided to try to find at what percentage of forest density do forest fires reach an equilibria

simulations = 1
N = 30 # where N is length of lattice side
percent_alive <- seq(.5,.6, by = 0.1) # living tree proportion
# N^2 amount of nodes, round() rounds a decimal point to the nearest 
# whole number, as we dont want a node to be partially colored, rounded to 0 decimals

# TEST VARIABLE GOES HERE
test_var <- percent_alive

# Set up data collection
fire_data <- tibble()



for (sim in 1:simulations) { # start multiple sim
  sim = sim
  for (var in seq_along(test_var)) { # start 1 var model run
    
    tryCatch({
      # set up tested param 
      
      percent_alive <- test_var[var]
      Alive <- sample(1:N^2, round(N^2 * percent_alive, 0)) # these vertices will be green, 
    }, error=function(e){cat("ERROR in SET PARAMS:",conditionMessage(e), "\n")})
    
    #------------------ Make a lattice (forest) 
    g <- make_lattice(dim = 2, length = N) # dim = , nei =, circular = ,
    
    set.vertex.attribute(g, name = 'col', value = 'white')
    
    g <- set.vertex.attribute(g, 'col', index = Alive, value = 'green')
    # plot(g, vertex.color = V(g)$col, vertex.shape = 'square', vertex.label = '', vertex.size = 3)
    
    node_mid = sample(V(g))[1] # starting the fire
    V(g)$col[node_mid] = 'red' 
    
    q <- g
    
    # ---------------- Geting a fire to percolate through a forest
    f <- g
    
    # Set up internal data collection
    
    time = 0
    tree_counts <- tibble(prop_alive = percent_alive,
                          alive = length(which(V(f)$col == 'green')),
                          onfire = length(which(V(f)$col == 'red')),
                          dead = length(which(V(f)$col == 'black')), 
                          time = time, 
                          sim = sim)
    
    tryCatch({ 
      a <- which(V(f)$col == 'red') # makes a list of WHICh vertex IDS are red
      while(length(a)>0) { # When the list of Vertex IDS is more than 0, SO WHEN there are alive trees on the edge
        time = time + 1
        for( ind in 1:length(a)) { # for each in the list of Vertex IDs
          verts <- a[ind] # assign the vertex to a variable
          neigh <- neighbors(f, verts) # finds neighbors of the the vertex IDS, neighbors(graph, vertex)
          if(length(which(V(f)[neigh]$col == 'green')) > 0) { #
            liveTreeNeigh <- neigh[which(V(f)[neigh]$col == 'green')] # 
            V(f)[liveTreeNeigh]$col = 'red' # makes alive neigh red
          }
          V(f)[a]$col = "brown" # sets the burned individuals to brown
        }
        a = which(V(f)$col == 'red') # saves a list of individuals that are on fire 
        tree_counts <- tree_counts %>%
          add_row(prop_alive = percent_alive,
                  alive = length(which(V(f)$col == 'green')),
                  onfire = length(which(V(f)$col == 'red')),
                  dead = length(which(V(f)$col == 'brown')), 
                  time = time, 
                  sim = sim)
      }
    }, error=function(e){cat("ERROR in WHILE LOOP:",conditionMessage(e), "\n")})
    fire_data <- rbind(fire_data, tree_counts) 
    
  } # end 1 var model run
  fire_data <- rbind(fire_data, tree_counts) 
  
} # end multiple sims
plot(g, vertex.color = V(f)$col, layout = layout.kamada.kawai, vertex.shape = 'square', vertex.label = '', vertex.size = 4)

plot(q, vertex.color = V(q)$col, layout = layout.kamada.kawai, vertex.shape = 'square', vertex.label = '', vertex.size = 4)
