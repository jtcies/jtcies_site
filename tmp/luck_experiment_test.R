library(tidyverse)
library(gganimate)

set.seed(2018)

# set the environment variables
n = 1000 # number of individuals
c = 10 # starting captial
m = 0.6 # mean talent
sd = 0.1 # std dev talent
i = 80 - 1 # number of iterations (years times two for each six months,
# minus 1 because time zero is already incorporated)
ne = 500 # number of lucky/unlucky events
pl = 0.5 # probability of lucky events

t = rnorm(n, m, sd) # talent
e = sample(c(-1,1), ne, prob = c(1 - pl, pl), replace = TRUE) # events

# set the coordinates for the invididuals and events
nx <- sample.int(100, size = n, replace = TRUE)
ny <- sample.int(100, size = n, replace = TRUE)

qplot(nx, ny) # make sure spread of individuals looks good

agents <- data.frame(nx, ny, t, c)

ex <- sample.int(100, size = ne, replace = TRUE)
ey <- sample.int(100, size = ne, replace = TRUE)


ggplot(data.frame(ex, ey, e), aes(ex, ey, color = factor(e))) +
  geom_point() # make sure events look good

# now try with multiple random walks

rand_walk <- function(xstart, ystart, xwalks, ywalks){
  xwalks <- c(xstart, xwalks) %>% cumsum()
  ywalks <- c(ystart, ywalks) %>% cumsum()
  cbind(xwalks, ywalks)
}

walks <- data.frame(
  a = sample(c(-1, 1), ne * i, TRUE),
  b = sample(c(-1, 1), ne * i, TRUE)
) %>% 
  split(1:ne)

event_walks <- data.frame(ex, ey) %>% 
  split(1:ne) %>% 
  map2(walks, ~ rand_walk(.x$ex, .x$ey, .y$a, .y$b)) %>% 
  map_df(~ transform(.x, step = 0:i)) %>% 
  mutate(event_num = rep(1:ne, each = i + 1),
         luck = rep(e, each = i + 1))

sample_events <- sample(c(1:500), 10)

event_walks %>% 
  filter(event_num %in% sample_events) %>% 
  ggplot(aes(xwalks, ywalks, color = factor(event_num * luck), 
             group = event_num, alpha = step)) +
  geom_path()


intersect <- function(x) {
  for (i in 0:i + 1) {
    
    this_step <- event_walks[event_walks$step == i, ]
    
    agents <- left_join(agents, this_step, 
                        by = c("nx" = "xwalks", "ny" = "ywalks"))
    
    agents <- agents %>% 
      replace_na(replace = list(luck = 0)) %>% 
      mutate(
        c = case_when(
          luck == 1  & runif(1) < t ~ c * 2,
          luck == -1 & runif(1) > t ~ c / 2,
          TRUE                      ~ c)
      ) %>% 
      select(nx, ny, t, c) %>% 
      distinct(nx, ny, .keep_all = TRUE)
  }
  agents
}

experiment <- intersect()

summary(experiment$c)
events <- data.frame(ex, ey, luck = e)

agents <- data.frame(nx, ny, c)

match_2 <- function(agents, events, rep) {
  
  walk <- function(a) {
    a <- a + sample(c(-1, 1), 1)
    a
  }
  
  for (i in 1:rep) {
    # match up the agents and events that intersect
    ret <- left_join(agents, events, by = c("nx" = "ex", "ny" = "ey"))
    ret$luck <- ifelse(is.na(ret$luck), 0, ret$luck)
    ret$c <- ifelse(ret$luck == 1 & runif(1) >= 0.5, ret$c * 2, ret$c)
    ret$c <- ifelse(ret$luck == -1 & runif(1) < 0.5, ret$c / 2, ret$c)
    agents <- select(ret, nx, ny, c)
    
    # # duplicate some of the events that are lucky
    ret$dup <- ifelse(ret$luck == 1 & runif(1) >= 0.75, 2, 1)
    duplicate <- select(ret, ex = nx, ey = ny, dup)
    events <- left_join(events, duplicate, by = c("ex", "ey"))
    events$dup <- ifelse(is.na(events$dup), 1, events$dup)
    events <- events[rep(1:nrow(events), events$dup), ]
    events <- select(events, -dup)

    # walk the events
    events$ex <- map_dbl(events$ex, walk)
    events$ey <- map_dbl(events$ex, walk)
  }
  agents 
}


match_2(agents, events, 20)
