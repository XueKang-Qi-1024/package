library(dplyr)
library(tidyr)
library(stringr)

library(ggplot2)
library(ggrepel)
library(patchwork)

data("iris")
head(iris)

# 1.1 Building a plot

ggplot(data = iris)

ggplot(data = iris) +
  geom_point(mapping = aes(x = Sepal.Length, y = Petal.Width))

ggplot(data = iris) +
  geom_point(mapping = aes(x = Sepal.Length, y = Petal.Width, color = Species))

# 1.2 Multiple geoms
ggplot(data = iris, mapping = aes(x = Petal.Length, y = Petal.Width)) +
  geom_point() +
  geom_smooth(method = "lm", color = "red") +
  labs(
    title = "Petal Length vs Petal Width",
    x = "Petal Length (cm)",
    y = "Petal Width (cm)"
  )

# 1.3 Using colors
ggplot(
  data = iris,
  mapping = aes(x = Petal.Length, y = Petal.Width, color = Species)
) +
  geom_point() +
  geom_smooth(method = "lm", color = "grey") +
  labs(
    title = "Petal Length vs Petal Width by Species",
    x = "Petal Length (cm)",
    y = "Petal Width (cm)"
  )

ggplot(data = iris, mapping = aes(x = Petal.Length, y = Petal.Width)) +
  geom_point(aes(color = Species)) +
  geom_smooth(method = "lm", color = "grey") +
  labs(
    title = "Petal Length vs Petal Width by Species",
    x = "Petal Length (cm)",
    y = "Petal Width (cm)"
  )

# 1.4 Aesthetic parameter
ggplot(data = iris, mapping = aes(x = Petal.Length, y = Petal.Width)) +
  geom_point(aes(color = Species), size = 3) +
  geom_smooth(method = "lm", color = "grey") +
  labs(
    title = "Petal Length vs Petal Width by Species",
    x = "Petal Length (cm)",
    y = "Petal Width (cm)"
  )

# 1.5 Aesthetic mapping
ggplot(data = iris, mapping = aes(x = Petal.Length, y = Petal.Width)) +
  geom_point(aes(color = Species, size = Sepal.Width)) +
  geom_smooth(method = "lm", color = "gray") +
  labs(
    title = "Petal Length vs Petal Width by Species",
    x = "Petal Length (cm)",
    y = "Petal Width (cm)"
  )

# 1.6 Discrete colors
ggplot(data = iris, mapping = aes(x = Petal.Length, y = Petal.Width)) +
  geom_point(aes(color = Species, size = Sepal.Width)) +
  geom_smooth(method = "lm", color = "gray") +
  labs(
    title = "Petal Length vs Petal Width by Species",
    x = "Petal Length (cm)",
    y = "Petal Width (cm)"
  ) +
  scale_color_brewer(palette = "Set1")

ggplot(data = iris, mapping = aes(x = Petal.Length, y = Petal.Width)) +
  geom_point(aes(color = Species, size = Sepal.Width)) +
  geom_smooth(method = "lm", color = "gray") +
  labs(
    title = "Petal Length vs Petal Width by Species",
    x = "Petal Length (cm)",
    y = "Petal Width (cm)"
  ) +
  scale_color_manual(values = c("red", "green", "blue"))

# 1.7 Continuous colors
ggplot(data = iris, mapping = aes(x = Petal.Length, y = Petal.Width)) +
  geom_point(aes(color = Sepal.Length)) +
  geom_smooth(method = "lm", color = "gray")

# 1.8 Titles
ggplot(data = iris, mapping = aes(x = Petal.Width, y = Petal.Length)) +
  geom_point(aes(color = Species, size = Sepal.Length)) +
  geom_smooth(method = "lm", color = "gray") +
  labs(
    title = "Title",
    subtitle = "Subtitle",
    x = "Petal Width (cm)",
    y = "Petal Length (cm)",
    caption = "Source: Iris Dataset"
  )

# 1.9 Axes modification
ggplot(data = iris, mapping = aes(x = Petal.Length, y = Petal.Width)) +
  geom_point(aes(color = Sepal.Width)) +
  geom_smooth(method = "lm") +
  scale_color_continuous(name = "New Legend Title") +
  scale_x_continuous(breaks = 1:8) +
  labs(
    title = "This Is A Title",
    subtitle = "This is a subtitle",
    x = " Petal Length",
    y = "Petal Width",
    caption = "Source: Iris Dataset"
  )

# 1.10 Faceting
ggplot(data = iris, mapping = aes(x = Petal.Length, y = Petal.Width)) +
  geom_point(aes(color = Sepal.Width)) +
  geom_smooth(method = "lm") +
  scale_color_continuous(name = "New Legend Title") +
  scale_x_continuous(breaks = 1:8) +
  labs(
    title = "This Is A Title",
    subtitle = "This is a subtitle",
    x = " Petal Length",
    y = "Petal Width",
    caption = "This is a little caption."
  ) +
  facet_wrap(~Species)

# 1.11 Themes
ggplot(data = iris, mapping = aes(x = Petal.Length, y = Petal.Width)) +
  geom_point(aes(color = Sepal.Width)) +
  geom_smooth(method = "lm") +
  scale_color_continuous(name = "New Legend Title") +
  scale_x_continuous(breaks = 1:8) +
  labs(
    title = "This Is A Title",
    subtitle = "This is a subtitle",
    x = " Petal Length",
    y = "Petal Width",
    caption = "This is a little caption."
  ) +
  facet_wrap(~Species) +
  theme_dark()
# https://ggplot2.tidyverse.org/reference/ggtheme.html

ggplot(data = iris, mapping = aes(x = Petal.Length, y = Petal.Width)) +
  geom_point(aes(color = Sepal.Width)) +
  geom_smooth(method = "lm") +
  scale_color_continuous(name = "New Legend Title") +
  scale_x_continuous(breaks = 1:8) +
  labs(
    title = "This Is A Title",
    subtitle = "This is a subtitle",
    x = " Petal Length",
    y = "Petal Width",
    caption = "This is a little caption."
  ) +
  facet_wrap(~Species) +
  theme_dark() +
  theme(
    axis.title = element_text(color = "Blue", face = "bold"),
    plot.title = element_text(color = "Green", face = "bold"),
    plot.subtitle = element_text(color = "Pink"),
    panel.grid = element_blank()
  )

# 1.12 Controlling legends
ggplot(data = iris, mapping = aes(x = Petal.Length, y = Petal.Width)) +
  geom_point(aes(color = Species, size = Sepal.Width))

ggplot(data = iris, mapping = aes(x = Petal.Length, y = Petal.Width)) +
  geom_point(aes(color = Species, size = Sepal.Width)) +
  guides(size = "none")

ggplot(data = iris, mapping = aes(x = Petal.Length, y = Petal.Width)) +
  geom_point(aes(color = Species, size = Sepal.Width), show.legend = FALSE)

ggplot(data = iris, mapping = aes(x = Petal.Length, y = Petal.Width)) +
  geom_point(aes(color = Species, size = Sepal.Width)) +
  theme(
    legend.position = "top",
    legend.justification = "right"
  )

ggplot(data = iris, mapping = aes(x = Petal.Length, y = Petal.Width)) +
  geom_point(aes(color = Species, size = Sepal.Width)) +
  guides(
    size = guide_legend(nrow = 2, byrow = TRUE),
    color = guide_legend(nrow = 3, byrow = T)
  ) +
  theme(
    legend.position = "top",
    legend.justification = "right"
  )

# 1.13 Labelling
ggplot(data = iris, mapping = aes(x = Petal.Length, y = Petal.Width)) +
  geom_point(aes(color = Species, size = Sepal.Width)) +
  geom_smooth(method = "lm") +
  labs(
    title = "This Is A Title",
    subtitle = "This is a subtitle",
    x = " Petal Length",
    y = "Petal Width",
    caption = "This is a little caption."
  ) +
  facet_wrap(~Species) +
  theme_dark() +
  theme(
    axis.title = element_text(color = "Blue", face = "bold"),
    plot.title = element_text(color = "Green", face = "bold"),
    plot.subtitle = element_text(color = "Pink"),
    panel.grid = element_blank()
  ) +
  geom_text_repel(aes(label = Species), show.legend = FALSE)

ggplot(data = iris, mapping = aes(x = Petal.Length, y = Petal.Width)) +
  geom_point(aes(color = Species)) +
  geom_label(aes(label = Species, hjust = 0), nudge_x = 0.5, size = 3)

library(ggrepel)
ggplot(data = iris, mapping = aes(x = Petal.Length, y = Petal.Width)) +
  geom_point(aes(color = Species)) +
  geom_text_repel(aes(label = Species), size = 3)

# 1.14 Annotations
ggplot(data = iris, mapping = aes(x = Petal.Length, y = Petal.Width)) +
  geom_point(aes(color = Species)) +
  geom_text_repel(aes(label = Species), size = 3) +
  annotate(
    "text",
    x = 5,
    y = 2,
    label = "This is an annotation",
    color = "red",
    size = 5
  ) +
  annotate(
    "rect",
    xmin = 4,
    xmax = 6,
    ymin = 1.5,
    ymax = 2.5,
    alpha = 0.2,
    fill = "blue"
  )

ggplot(data = iris, mapping = aes(x = Petal.Length, y = Petal.Width)) +
  geom_point(aes(color = Species)) +
  annotate("text", x = 2.5, y = 2.1, label = "There is a random line here") +
  annotate("segment", x = 2, xend = 4, y = 1.5, yend = 2)

# 1.15 Barplots
ggplot(data = iris, mapping = aes(x = Species, y = Petal.Width)) +
  geom_bar(stat = "identity", fill = "steelblue")

# 1.16 Flip axes
ggplot(data = iris, mapping = aes(x = Species, y = Petal.Width)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  coord_flip()

# 1.17 Error Bars
ggplot(data = iris, mapping = aes(x = Species, y = Petal.Width)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  geom_errorbar(
    aes(ymin = Petal.Width - 0.1, ymax = Petal.Width + 0.1),
    width = 0.2
  )

dfr <- iris %>%
  group_by(Species) %>%
  summarise(mean = mean(Sepal.Length), sd = sd(Sepal.Length)) %>%
  mutate(high = mean + sd, low = mean - sd)

ggplot(data = dfr, mapping = aes(x = Species, y = mean, color = Species)) +
  geom_point(size = 4) +
  geom_errorbar(aes(ymax = high, ymin = low), width = 0.2)


##### practice: 2 Economist Scatterplot with ggplot2 #####
# 2.1 Data
# Load the Economist dataset
ec <- read.csv(
  "~/Library/CloudStorage/OneDrive-KarolinskaInstitutet/Desktop/Raukr_local/data_economist.csv",
  header = T
)
head(ec)

# Make sure that the fields are of the correct type. The x-axis field ‘CPI’ and the y-axis field ‘HDI’ must be of numeric type. The categorical field ‘Region’ must be of Factor type.
str(ec)
?str

# Convert 'Region' to a factor
levels(ec$Region)


ec$Region <- factor(
  ec$Region,
  levels = c(
    "EU W. Europe",
    "Americas",
    "Asia Pacific",
    "East EU Cemt Asia",
    "MENA",
    "SSA"
  ),
  labels = c(
    "OECD",
    "Americas",
    "Asia &\nOceania",
    "Central &\nEastern Europe",
    "Middle East &\nNorth Africa",
    "Sub-Saharan\nAfrica"
  )
)

levels(ec$Region)

# 2.2 Points
# Provide data.frame ‘ec’ as the data and map field ‘CPI’ to the x-axis and ‘HDI’ to the y-axis. Use geom_point() to draw point geometry.
ggplot(data = ec, mapping = aes(x = CPI, y = HDI, color = Region)) +
  geom_point(shape = 21, size = 3, stroke = 0.8, fill = "white")

# 2.3 Trendline
# Add a trendline to the plot using geom_smooth() with method = "lm" and color = "red".
ggplot(data = ec, mapping = aes(x = CPI, y = HDI, color = Region)) +
  geom_point(shape = 21, size = 3, stroke = 0.8, fill = "white") +
  geom_smooth(
    method = "lm",
    formula = y ~ poly(x, 2),
    se = F,
    size = 0.6,
    color = "red"
  )

# Notice that the line in drawn over the points due to the plotting order. We want the points to be over the line.
# Change the order of the layers
# Change the order of the layers so that the points are drawn over the trendline.
ggplot(data = ec, mapping = aes(x = CPI, y = HDI, color = Region)) +
  geom_smooth(
    method = "lm",
    formula = y ~ poly(x, 2),
    se = F,
    size = 0.6,
    color = "red"
  ) +
  geom_point(shape = 21, size = 3, stroke = 0.8, fill = "white")

# or

p <- ggplot(ec, aes(x = CPI, y = HDI, color = Region)) +
  geom_smooth(
    aes(fill = "red"),
    method = "lm",
    formula = y ~ poly(x, 2),
    se = F,
    color = "red",
    size = 0.6
  ) +
  geom_point(shape = 21, size = 3, stroke = 0.8, fill = "white")
p

# 2.4 Text Labels
# Add text labels to the points using geom_text_repel() with the label set to 'Country'.
library(ggrepel)
ggplot(data = ec, mapping = aes(x = CPI, y = HDI, color = Region)) +
  geom_smooth(
    method = "lm",
    formula = y ~ poly(x, 2),
    se = F,
    size = 0.6,
    color = "red"
  ) +
  geom_point(shape = 21, size = 3, stroke = 0.8, fill = "white") +
  geom_text_repel(aes(label = Country), size = 3)

# or

labels <- c(
  "Congo",
  "Afghanistan",
  "Sudan",
  "Myanmar",
  "Iraq",
  "Venezuela",
  "Russia",
  "Argentina",
  "Brazil",
  "Italy",
  "South Africa",
  "Cape Verde",
  "Bhutan",
  "Botswana",
  "Britian",
  "New Zealand",
  "Greece",
  "China",
  "India",
  "Rwanda",
  "Spain",
  "France",
  "United States",
  "Japan",
  "Norway",
  "Singapore",
  "Barbados",
  "Germany"
)

p +
  geom_text(
    data = subset(ec, Country %in% labels),
    aes(label = Country),
    color = "black"
  )

# 2.5 Custom Font
library(extrafont)
font_import(pattern = "Arial", prompt = FALSE)
# load fonts for pdf
loadfonts()
# list available fonts in R
fonts()

p +
  geom_text(
    data = subset(ec, Country %in% labels),
    aes(label = Country),
    color = "black",
    family = "Tahoma"
  )

# 2.6 Label Overlap

library(ggrepel)
p <- p +
  geom_text_repel(
    data = subset(ec, Country %in% labels),
    aes(label = Country),
    color = "black",
    box.padding = unit(1, "lines"),
    segment.size = 0.25,
    size = 3,
    family = "Gidole"
  )
p

# 2.7 Axes
p <- p +
  scale_x_continuous(
    name = "Corruption Perceptions Index, 2011 (10=least corrupt)",
    breaks = 1:10,
    limits = c(1, 10)
  ) +
  scale_y_continuous(
    name = "Human Development Index, 2011 (1=best)",
    breaks = seq(from = 0, to = 1, by = 0.1),
    limits = c(0.2, 1)
  )
p

# 2.8 Scale Colors
p <- p +
  scale_color_manual(
    values = c("#23576E", "#099FDB", "#29B00E", "#208F84", "#F55840", "#924F3E")
  ) +
  scale_fill_manual(
    name = "trend",
    values = "red",
    labels = expression(paste(R^2, "=52%"))
  )
p

# 2.9 Title
p <- p +
  labs(
    title = "Corruption and human development",
    caption = "Sources: Transparency International; UN Human Development Report"
  )
p

# 2.10 Theme
p <- p +
  guides(color = guide_legend(nrow = 1)) +
  theme_bw(base_family = "Gidole") +
  theme(legend.position = "top")
p

p +
  theme(
    panel.grid.minor = element_blank(),
    panel.grid.major.x = element_blank(),
    panel.background = element_blank(),
    panel.border = element_blank(),
    legend.title = element_blank(),
    axis.title = element_text(face = "italic"),
    axis.ticks.y = element_blank(),
    axis.ticks.x = element_line(color = "grey60"),
    plot.title = element_text(face = "bold"),
    plot.caption = element_text(hjust = 0, size = 8)
  )

########################################
########################################
########################################
########################################
########################################
### The full script for this challenge is summarized here:
# read data
ec <- read.csv(
  "~/Library/CloudStorage/OneDrive-KarolinskaInstitutet/Desktop/Raukr_local/data_economist.csv",
  header = T
)
# refactor
ec$Region <- factor(
  ec$Region,
  levels = c(
    "EU W. Europe",
    "Americas",
    "Asia Pacific",
    "East EU Cemt Asia",
    "MENA",
    "SSA"
  ),
  labels = c(
    "OECD",
    "Americas",
    "Asia &\nOceania",
    "Central &\nEastern Europe",
    "Middle East &\nNorth Africa",
    "Sub-Saharan\nAfrica"
  )
)

# labels
labels <- c(
  "Congo",
  "Afghanistan",
  "Sudan",
  "Myanmar",
  "Iraq",
  "Venezuela",
  "Russia",
  "Argentina",
  "Brazil",
  "Italy",
  "South Africa",
  "Cape Verde",
  "Bhutan",
  "Botswana",
  "Britian",
  "New Zealand",
  "Greece",
  "China",
  "India",
  "Rwanda",
  "Spain",
  "France",
  "United States",
  "Japan",
  "Norway",
  "Singapore",
  "Barbados",
  "Germany"
)

# plotting
p1 <- ggplot(ec, aes(x = CPI, y = HDI, color = Region)) +
  geom_smooth(
    aes(fill = "red"),
    method = "lm",
    formula = y ~ poly(x, 2),
    se = F,
    color = "red",
    size = 0.6
  ) +
  geom_point(shape = 21, size = 3, stroke = 0.8, fill = "white") +
  geom_text_repel(
    data = subset(ec, Country %in% labels),
    aes(label = Country),
    color = "black",
    box.padding = unit(1, "lines"),
    segment.size = 0.25,
    size = 3,
    family = "Gidole"
  ) +
  scale_x_continuous(
    name = "Corruption Perceptions Index, 2011 (10=least corrupt)",
    breaks = 1:10,
    limits = c(1, 10)
  ) +
  scale_y_continuous(
    name = "Human Development Index, 2011 (1=best)",
    breaks = seq(from = 0, to = 1, by = 0.1),
    limits = c(0.2, 1)
  ) +
  scale_color_manual(
    values = c("#23576E", "#099FDB", "#29B00E", "#208F84", "#F55840", "#924F3E")
  ) +
  scale_fill_manual(
    name = "trend",
    values = "red",
    labels = expression(paste(R^2, "=52%"))
  ) +
  labs(
    title = "Corruption and human development",
    caption = "Sources: Transparency International; UN Human Development Report"
  ) +
  guides(color = guide_legend(nrow = 1)) +
  theme_bw(base_family = "Gidole") +
  theme(
    legend.position = "top",
    panel.grid.minor = element_blank(),
    panel.grid.major.x = element_blank(),
    panel.background = element_blank(),
    panel.border = element_blank(),
    legend.title = element_blank(),
    axis.title = element_text(face = "italic"),
    axis.ticks.y = element_blank(),
    axis.ticks.x = element_line(color = "grey60"),
    plot.title = element_text(face = "bold"),
    plot.caption = element_text(hjust = 0, size = 8)
  )
p1
