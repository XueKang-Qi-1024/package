install.packages("renv")
library(renv)

#https://rstudio.github.io/renv/#renv

renv::init(force = TRUE) # Initialize a new project with renv
renv::snapshot() # Snapshot the current state of the project
renv::restore() # Restore the project to the state captured in the snapshot

renv::dependencies() # List the dependencies of the project

#########################above is day1 code, below is day 2 code#########################

# quarto
# https://quarto.org/docs/get-started/hello/rstudio.html
# https://nbisweden.github.io/raukr-2025/labs/quarto-site/
install.packages("tidyverse")
install.packages("palmerpenguins")

install.packages("quarto")
quarto::quarto_render("hello.qmd")

library(ggplot2)
library(dplyr)
library(stringr)

install.packages("knitr")
install.packages("rmarkdown")
install.packages("yaml")
library(knitr)
library(rmarkdown)
library(yaml)

###################
#wrapper function#
my_awesome_plot <- function(x, ...) {
  plot(x, col = "red", pch = 19, cex.axis = .7, ...)
}

my_awesome_plot(1:5, col = "blue")

#1 R Functions_1

SekToUsd <- function(x) {
  x * 0.10
}
SekToUsd(100)
values <- c(10, 20, 30, 40, 50, 60, 70, 80, 90, 100)
converted <- SekToUsd(values)

# Plot values vs. converted amounts
plot(
  values,
  converted,
  type = "b", # both points and lines
  main = "SEK to USD Conversion",
  xlab = "SEK",
  ylab = "USD",
  col = "blue",
  pch = 19
)

#1 R Functions_2
SekOrUsd <- function(x) {
  if (x > 0.1) {
    print("chooseSek")
  } else {
    print("chooseUsd")
  }
}
SekOrUsd(0.2)
values <- c(0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1)

# Option 1: Use a loop
for (v in values) {
  SekOrUsd(v)
}

# Option 2: Vectorized with sapply
sapply(values, SekOrUsd)

#1 R Functions_3
function_name <- function(param1, param2 = "Lucy") {
  if (param2 == "Lucy") {
    output <- paste("Lucy in the sky with ", param1, "\n", sep = "")
  } else {
    output <- paste(param1, " in the ocean with ", param2, "\n", sep = "")
  }
  return(cat(output))
}
function_name("fish")
function_name("Fish", "John")

#1 R Functions_4
for (i in seq(0, 10, by = 0.1)) {
  SekOrUsd(i)
  SekToUsd(i)
}

for (i in c("Tom", "Mary", "Mahesh", "Henrik")) {
  function_name(param1 = i, param2 = "Brad")
  function_name(param1 = i, param2 = "Lucy")
}
# data.frame
data.frame(a = c(1, 2, 3))
data.frame(a = c(1, 2, 3), b = c(4, 5, 6))

my_plot <- function(...) {
  plot(c(1, 2, 3), c(1, 2, 3), ...)
}

#####2 R Scripts#####
# Example of a small script
mydata = rnorm(1000)
print(summary(mydata))

#####3 Passing and parsing arguments#####
#!/usr/bin/env Rscript
firstarg = as.numeric(commandArgs(trailingOnly = TRUE)[1])
mydata = rnorm(1000, mean = firstarg)
print(summary(mydata))

#!/usr/bin/env Rscript

# don't say "Loading required package: optparse" every time
suppressPackageStartupMessages(require(optparse))

option_list = list(
  make_option(c("-m", "--mean"), default = 0)
  # you could put the next option here
)
options = parse_args(OptionParser(option_list = option_list))
my_mean = as.numeric(options$mean)

mydata = rnorm(1000, mean = my_mean)
print(summary(mydata))

#####4 Standard in and out#####
#!/usr/bin/env Rscript (run at Docker)
input_con <- file("stdin")
open(input_con)
oneline <- readLines(con = input_con, n = 1, warn = FALSE)
close(input_con)
mean = as.numeric(oneline)
mydata = rnorm(1000, mean = mean)
print(summary(mydata))

# R and AI
#this part is going to visualize the palmer penguins dataset
# using ggplot2
library(palmerpenguins)
library(ggplot2)
#load the dataset
data("penguins")
# Create a scatter plot of flipper length vs. body mass
q <- ggplot(
  penguins,
  aes(x = flipper_length_mm, y = body_mass_g, color = species)
) +
  geom_point() +
  labs(
    title = "Penguin Flipper Length vs Body Mass",
    x = "Flipper Length (mm)",
    y = "Body Mass (g)"
  ) +
  theme_minimal()
# Print the plot
print(q)

# plot the density of body mass for eah species
q_density <- ggplot(penguins, aes(x = body_mass_g, fill = species)) +
  geom_density(alpha = 0.5) +
  labs(
    title = "Density of Penguin Body Mass by Species",
    x = "Body Mass (g)",
    y = "Density"
  ) +
  theme_minimal()
# Print the density plot
print(q_density)

library(ellmer)
