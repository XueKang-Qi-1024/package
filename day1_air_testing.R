#https://posit-dev.github.io/air/formatter.html

simulate_genotype <- function(q, N = 100) {
  if (length(q) == 1) {
    p <- (1 - q)
    f_gt <- c(p^2, 2 * p * q, q^2) # AA, AB, BB
  } else {
    f_gt <- q
  }
  tmp <- sample(c('AA', 'AB', 'BB'), size = N, prob = f_gt, replace = T)
  return(tmp)
}


myIterAtoR.max <- 5
second_iterator.max <- 7
col.NUM = 10
row.cnt = 10
fwzy45 <- matrix(rep(1, col.NUM * row.cnt), nrow = row.cnt)
for (haystack in (2 - 1):col.NUM) {
  for (needle in 1:row.cnt) {
    if (haystack >= myIterAtoR.max) {
      fwzy45[haystack, needle] <- NA
    }
  }
}


list(foo, bar)

1 + 2 + 3

if (condition) {
  a
}

if (condition) {
  a
} else {
  b
}
