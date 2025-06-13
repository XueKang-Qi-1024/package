library(tidyverse)
library(magrittr)
data("iris")
head(iris)

# 1 General exercises
## 1.1 Pipes
### 1.1.1 Chunk 1
mtcars
my_cars <- mtcars[, c(1:4, 10)]
my_cars <- my_cars[my_cars$disp > mean(my_cars$disp), ]
my_cars <- colMeans(my_cars)

mtcars %>%
  select (c(1:4,10)) %>%
  filter(disp > mean(disp) %>%
  colMeans()-> my_cars
  
### 1.1.2 Chunk 2
cars%T>% {print(summary(.))} %>% colSums()
cars%T>% print(summary()) %>% colSums()

### 1.1.3 Chunk 3
mtcars %$% cor(gear, mpg)
mtcars %>%
  
### 1.1.4 Chunk 4

  dim_summary <- function(nrows, ncols) {
    print(
      paste0('Matrix M has: ', nrows, ' rows and ', ncols, ' columns.')
    )
  }

M<- rnorm(16) %>%
  matrix(ncol=4) %T>%
  plot() %>%
  '+'(.,sample(.)) %>%
  {dim_summary(nrow(.), ncol(.))}

## 1.2 Tibbles
### 1.2.1 Chunk 1
# 1
vehicles <- mtcars %>% as_tibble()
vehicles
# 2
vehicles [['disp']]
vehicles [[3]]
vehicles$disp
# 3
vehicles %T>%
  {print (.[['disp']])} %T>%
  {print (.[[3]])} %>%
  .$disp
# 4
print (vehicles)
vehicles
# 5
head(vehicles, n=30)
?head
vehicles %>% head (n=30)

# 6
options(tibble.print_min = 15, tibble.print_max = 30)

# 7
vehicles %>% head(n = 30)

# 8
automobiles <- as.data.frame(vehicles)

## 1.2.2 Chunk 2
tab <- tribble(
  ~id, ~event, ~date,
  1, 'success', '24-04-2017',
  2, 'failed', '25-04-2017',
  3, 'failed', '25-04-2017',
  4, 'success', '27-04-2017'
)

## 1.2.3 Chunk 3
tst <- replicate(30, sample(100), simplify = TRUE)
colnames(tst) = paste0(rep('col', times = dim(tst)[2]), 1:dim(tst)[2])
microbenchmark::microbenchmark(
  as.data.frame(tst),
  as_data_frame(tst),
  as_tibble(tst)
)

## 1.2.4 Chunk 4
tibble(x = sample(1:10, size = 10, replace = T), y = log10(x))


### 1.3 Parsing
vec1 <- c(1, 7.2, 3.84, -5.23)
vec2 <- c('2', '3,45', '?', '-7,28')
vec3 <- c('2', '3,45', '?', '-7.28')
vec4 <- c('barrel: 432.7$', 'liter: 15.42PLN', 'gallon costs approx 32.1SEK', 'sunny, wind gusts up till 55m/s')
vec5 <- "25 Dec 2015"

parse_double(vec1)
parse_integer(vec1)

rounded_int <- as.integer(round(vec1))
rounded_int

as.integer(round(vec1))

parse_double(vec2)
parse_double(vec2, na = '?', locale = locale(decimal_mark = ','))

parse_number(vec3, na = '?', locale = locale(decimal_mark = '.'))

guess_parser(vec4)
parse_guess(vec4)

parse_number(vec4)

guess_parser(vec5)
parse_date(vec5, format = '%d %b %Y')

parse_date("10_Jul_1410")
parse_date("10_Jul_1410", format="%d%.%b%.%Y")

#######################

seq_along()

h <- function(x) {
  sum <- 0
  for (i in seq_along(x)) {
    Sys.sleep(1.0)   # one-second delay
    sum <- sum + x[i]
  }
  sum
}

h(1:10)

# install.packages("future")
library(future)
plan(multisession)

a %<-% h(x[1:5])
b %<-% h(x[6:10])
y <- a + b

# install.packages("futureverse", dependencies = TRUE)
library(futureverse)

# Task 1

tic <- function() {
  tic_start <<- base::Sys.time()
}

toc <- function() {
  dt <- base::difftime(base::Sys.time(), tic_start)
  dt <- round(dt, digits = 1L)
  message(paste(format(dt), "since tic()"))
}

tic()
Sys.sleep(1.5)
toc()

Sys.sleep(4.0)
toc()

slow_sum <- function(x) {
  sum <- 0
  for (value in x) {
    Sys.sleep(1.0)     ## one-second slowdown per value
    sum <- sum + value
  }
  sum
}

tic()
y <- slow_sum(1:10)
y
toc()

# Task 2

tic()
f <- future(slow_sum(1:10))
y <- value(f)
toc()

# Task 3
tic()
f <- future(slow_sum(1:10))
toc()
y <- value(f)
toc()
y
toc()

# Task 4
plan(multisession, workers = 2)
tic()
f <- future(slow_sum(1:10))
toc()
y <- value(f)
toc()
y
toc()

# Task 5
fa <- future(slow_sum(1:5))
a <- value(fa)
fb <- future(slow_sum(6:10))
b <- value(fb)
y <- a + b
y

tic()
fa <- future(slow_sum(1:5))
toc()
a <- value(fa)
toc()
fb <- future(slow_sum(6:10))
toc()
b <- value(fb)
toc()
y <- a + b
toc()
y
toc()

# 

library(future) 
plan(multisession) 
tic() 
a %<-% slow_sum(x[1:5])
b %<-% slow_sum(x[6:10])

y <- a + b
toc()

library(future)
plan(multisession)

tic() 
a %<-% slow_sum(x[1:5])
toc() 
b %<-% slow_sum(x[6:10])
toc() 
y <- a + b
toc() 


tic() 
fa <- future( slow_sum(x[1:5])  )
toc() 
fb <- future( slow_sum(x[6:10]) )
toc() 
y <- value(fa) + value(fb)
toc()

xs <- list(1:25, 26:50, 51:75, 76:100)
ys <- list()

for (i in seq_along(xs)) {
  ys[[i]] <- slow_sum(xs[[i]])
}

lobstr::ast(ys <- lapply(xs, slow_sum))
lobstr::ast(ys <- xs |> lapply(slow_sum))

?Map
ys <- xs |> map(slow_sum) 
ys <- xs |> future_map(slow_sum)

### Your turn: Concurrent for-loop to concurrent map
# Create futures
tic()
fs <- list()
for (i in seq_along(xs)) {
  fs[[i]] <- future( slow_sum(xs[[i]]) )
}
toc()
# Collect values
ys <- list()
for (i in seq_along(xs)) {
  ys[[i]] <- value( fs[[i]] ) 
}
toc()

library(purrr)

library(future)
plan(multisession, workers = 4)
xs <- c(1, 2, -3, 4)
bs <- c(4, 3, 2, 1)

g <- function(x, b = 2) {
  message("x = ", x)
  if (b <= 0) stop("Argument 'b' must be a positive scalar: ", b)
  Sys.sleep(3.0)
  sqrt(b * x)
}

ys <- purrr::map2(xs, bs, g)

library(furrr)
ys <- future_map2(xs, bs, g)

 