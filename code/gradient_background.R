library(ggplot2)

library(scales) # for color map tools
library(png) # for readPNG()
library(grid) # for grob()

source('~/projects/parula/code/parula.R')
setwd('~/projects/gradient-ggplot2-bg/')

# get matrix of values corresponding to the range
# of the desired color map
M <- outer(50:0, 0:50, function(x,y) { sqrt( x^2 + y^2 ) })
pal <- gradient_n_pal(parula(6), 
                      values = c(min(M), median(M), max(M)),
                      space = 'Lab')
cols <- matrix(pal(M), nrow(M))


# save background image
png("./img/bg1.png", width = 500, height = 500)
grid::grid.raster(cols)
dev.off()

# load background image
img <- readPNG("./img/bg1.png")
my_grob <- rasterGrob(cols, interpolate = TRUE)

# generate random data for plotting
n <- 20
data <- data.frame(my_x = runif(n), 
                   my_y = runif(n),
                   my_name = 1:n)

# begin plot
png("./img/test_plot1.png", width = 500, height = 500)
ggplot(data, aes(x = my_x, y = my_y, label = my_name)) + 
  annotation_custom(my_grob, xmin = -Inf, xmax = Inf, ymin = -Inf, ymax = Inf) +
  scale_x_continuous(limits = c(0,1)) +
  scale_y_continuous(limits = c(0,1)) +
  geom_point(size = 10, alpha = 0.3) +
  geom_text(color = 'white', size = 4) +
  # the sizing isn't perfect, so we remove the default
  # background panel 
  theme_bw() +
  theme(
    panel.border = element_blank(),
    panel.grid = element_blank()
  )
dev.off()











