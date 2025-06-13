install.packages("renv")
library(renv)
renv::init()  # Initialize a new project with renv
renv::snapshot()  # Snapshot the current state of the project
renv::restore()  # Restore the project to the state captured in the snapshot

renv::dependencies()
##################Best Coding Practices#####################

################Task: Obscure Code.################
Iteractor_max <- 5
col_num = 10
row_num = 10
A <- matrix(rep(1, col_num * row_num),nrow = row_num)
for(i in 1:col_num){
  for(j in 1:row_num) {
    if(i >= Iteractor_max){
      A [i, j] <- NA
    }
  }
}
A
?matrix()
?rep
###############Task: Better Formatting.#############
simulate_genotype <- function(q, N = 100) {
  if (length(q) == 1) {
    p <- (1 - q)
    f_gt <- c(p^2, (2 * p * q), q^2) # AA, AB, BB
  } else {
    f_gt <- q
  }
  sample(c('AA', 'AB', 'BB'), 
         size = N, 
         prob = f_gt, 
         replace = TRUE)
}
simulate_genotype(q = 0.3, N = 10)

###############Task: Hidden Variable.###############
# If we do not know the length of the vector
.my_months <- rev(rev(month.abb)[1:3])

# or
.my_months <- month.abb[(length(month.abb)-2):length(month.abb)]
###############

###############Task: Better Formatting.#############
# If we do not know the length of the vector
.my_months <- rev(rev(month.abb)[1:3])

# or
.my_months <- month.abb[(length(month.abb)-2):length(month.abb)]


##################Debugging, Profiling and Optimization	Marcin Kierczak###############

#####1.1 Task: Code Correctness####
input <- sample(1:1000, size = 1000, replace = T)
currmin <- Inf
for (i in input) {
  if (i < currmin) {
    currmin <- i
    print(paste0("The new minimum is: ", currmin))
  }
}

input <- sample(1:1000, size = 1000, replace = T)
currmin <- 0
for (i in input) {
  if (i > currmin) {
    currmin <- i
    print(paste0("The new maximum is: ", currmin))
  }
}

for (cnt in 1:100) {
  if (cnt > 12) {
    print("12+")
  } else {
    print("Not 12+")
  }
}

result <- logical(10)
input <- sample(1:10, size = 10, replace = T)
for (i in 1:length(input)) {
  if (input[i] >= 5) {
    result[i] <- TRUE
  } #else {
  #result[i] <- FALSE
  #}
}
print(input)
print(result)

#####1.3 Task: Floating-point Arithmetics####

vec <- seq(0.1, 0.9, by=0.1)
vec == 0.7
epsilon <- 0.001
abs(vec-0.7) <= epsilon


# One way is to use epsilon
# Check machine's floating point representation
vec <- seq(0.1, 0.9, by=0.1)

# Make a custom function that uses machines' epsilon for comparing
# values
is_equal <- function(x, y) {
  isEqual <- F
  if (abs(x - y) < unlist(.Machine)['double.eps']) {
    isEqual <- T
  }
  isEqual
}

# Some tests
0.7 == 0.6 + 0.1
is_equal(0.7, 0.6 + 0.1)
0.7 == 0.8 - 0.1
is_equal(0.7, 0.8 - 0.1)


# Now you can use the is_equal to fix the code!
vec <- seq(0.1, 0.9, by=0.1)

is_equal <- function(x, y, tol = .Machine$double.eps^0.5) {
  abs(x - y) < tol
} 

# vec is a vector of 9 numbers: 0.1, 0.2, ..., 0.9
# But x - y is a vector, so the condition inside if() has length > 1, 
# and if() in R requires a single TRUE or FALSE.

is_equal (vec, 0.7)

head(unlist(.Machine))

#####2 Profiling-- 2.1 Task: Filling A Large Matrix####
N <- 10e3 * 10e3

# By row
t1 <- proc.time()
M <- matrix(sample(1:42, size = N, replace = T), nrow = sqrt(N), byrow = T)
t2 <- proc.time()
(t2 - t1)

# By column
t1 <- proc.time()
M <- matrix(sample(1:42, size = N, replace = T), nrow = sqrt(N), byrow = F)
t2 <- proc.time()
(t2 - t1)

#---->no.93

system.time(rnorm(n = 10e6))

timing <- double(100)
for (i in 1:100) {
  st <- system.time(rnorm(n = 10e6))
  timing[i] <- st[3]
}
boxplot(timing) 
mean(timing)
var(timing)

st2 <- system.time(replicate(n = 100, rnorm(n = 10e6)))
# Error: vector memory limit of 16.0 Gb reached, see mem.maxVSize()
# Timing stopped at: 27.28 5.082 68.55


#####2.3 Task: Microbenchmarking--- 2.3.1 Checking System Time#####
library(microbenchmark)
install.packages("microbenchmark")
microbenchmark::get_nanotime()

timing <- double(100)
for (i in 1:100) {
  st <- system.time(rnorm(n = 10e6))
  timing[i] <- st[3]
}
boxplot(timing)
mean(timing)
var(timing)


library(microbenchmark)
timing <- double(100)
for (i in 1:100) {
  nanotime_start <- get_nanotime()
  rnorm(n = 10e6)
  nanotime_stop <- get_nanotime()
  timing[i] <- nanotime_stop - nanotime_start
}
mean(timing)
var(timing)
boxplot(timing)

#####2.3.2 Microtiming Precision#####
precision <- microbenchmark::microtiming_precision()
mean(precision)
var(precision)

# In version 1.4-4 of the package, all three ways give different results!
microbenchmark::microtiming_precision()
precision <- microbenchmark::microtiming_precision()
?microbenchmark::microtiming_precision

#####2.3.3 The Microbenchmark Way#####
install.packages("ggplot2")
library(ggplot2)
require(microbenchmark)
require(ggplot2)
mb <- microbenchmark(rnorm(n = 10e6))
autoplot(mb)
boxplot(mb)
summary(mb)
f <- function() {}
mb2 <- microbenchmark(f(), pi, 2+2)
summary(mb2)
autoplot(mb2)
