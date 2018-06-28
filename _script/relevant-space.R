library(grid)
col_vec <- rev(RColorBrewer::brewer.pal(3, "YlGnBu"))
# rel_col <- col_vec[2] 
rel_col <- "#4899B9"
irrel_col <- "#FBFDEC"

y_x0 <- 0.02
y_y0 <- 0.2

y_width <- 0.2
x_width <- 0.6

x_x0 <- y_x0 + y_width + 0.15
x_y0 <- 0.2

y_height <- x_height <- 0.55

## Rectangles for X and Y variables ----
y_grob <- rectGrob(x = y_x0,
          y = y_y0,
          height = y_height,
          width = y_width,
          hjust = 0, vjust = 0,
          gp = gpar(fill = irrel_col))
x_grob <- rectGrob(x = x_x0,
          y = x_y0,
          height = x_height,
          width = x_width,
          hjust = 0, vjust = 0,
          gp = gpar(fill = irrel_col))


## Relevant space in Y space ----
df_y <- data.frame(
  x = c(0.05, 0.05, 0.05, y_width) + y_x0,
  y = c(0.05, 0.05, 0.05, y_height) + y_y0
)
rel_y_grob <- xsplineGrob(
  x = rep(df_y$x, 2),
  y = rep(rev(df_y$y), 2),
  gp = gpar(fill = rel_col, alpha = 0.5, lwd = 2),
  shape = 1, open = FALSE
)

## Relevant space in X space ----
df_x <- data.frame(
  x = c(0.05, 0.05, 0.05, x_width) + x_x0,
  y = c(0.05, 0.05, 0.05, x_height) + y_y0
)
rel_x_grob <- xsplineGrob(
  x = rep(df_x$x, 2),
  y = rep(rev(df_x$y), 2),
  gp = gpar(fill = rel_col, alpha = 0.5, lwd = 2),
  shape = 1, open = FALSE
)

## Title of the diagram ----
title_grob <- textGrob(x = y_x0, y = 0.95, label = "Relevant space within a model", 
          hjust = 0, gp = gpar(cex = 1.6))
## Subtitle of the diagram ----
subtitle_grob <- textGrob(x = y_x0, y = 0.88, hjust = 0, gp = gpar(cex = 0.9),
          label = "A concept behind reduction of regression model")

## Labels on top of the X and Y boxes ----
ylab_grob <- textGrob(x = y_x0 + y_width/2, 
          y = y_y0 + y_height, 
          label = "Response (Y)", 
          vjust = -1,
          gp = gpar(cex = 1))
xlab_grob <- textGrob(x = x_x0 + x_width/2 , 
          y = x_y0 + x_height, 
          label = "Predictor (X)", 
          vjust = -1, 
          gp = gpar(cex = 1))

## Labels inside the X and Y boxes ----
y_inlab_grob <- textGrob(x = y_x0 + y_width/2, 
          y = y_y0 + y_height, 
          vjust = 1.5,
          label = "Redudent Y\ninformation",
          gp = gpar(cex = 0.8))
x_inlab_grob <- textGrob(x = x_x0 + x_width/2 , 
          y = x_y0 + x_height, 
          vjust = 1.5,
          gp = gpar(cex = 0.8),
          label = "Irrelevant X-Space\n redudent information and noise")

## Big arror from X to Y to represent their connection ----
big_arrow <- function(lw = 22, color = "grey40"){
  segmentsGrob(x0 = x_x0 - 0.03, 
               x1 = y_x0 + y_width + 0.05, 
               y0 = x_y0 + x_height/2, 
               y1 = x_y0 + x_height/2,
               arrow = arrow(length = unit(0.2, "inches")),
               gp = gpar(lwd = lw, 
                         linejoin = "mitre", 
                         lineend = "butt",
                         col = color))
}

# grid.draw(big_arrow(25, "grey50"))
# grid.draw(big_arrow(20, "grey90"))

## Arrows to annotate relevant X and Y spaces ----
y_ann_grob <- segmentsGrob(x0 = c(y_x0 + y_width/2, x_x0 + x_width/2), 
              x1 = c(y_x0 + y_width/2, x_x0 + x_width/2),
              y0 = c(y_y0 - 0.1, y_y0 - 0.1), 
              y1 = c(y_x0 + 0.23, y_x0 + 0.23),
              arrow = arrow(length = unit(0.09, "inches")),
              gp = gpar(lty = 1, lwd = 2, col = "grey40"))
x_ann_grob <- segmentsGrob(x0 = y_x0 + y_width/2, 
              y0 = y_y0 - 0.1, 
              x1 = x_x0 + x_width/2, 
              y1 = y_y0 - 0.1)

## Text annotation for relevant X and Y space ----
bottom_ann_grob <- textGrob(x = x_x0, y = x_y0 - 0.14, gp = gpar(cex = 0.9),
          label = "X and Y envelope/\n Relevant Spaces",
          vjust = -0.1)

## Collecting Grobs ----
rect_box <- gList(y_grob, x_grob)
rel_space <- gList(rel_y_grob, rel_x_grob)
titles <- gList(title_grob, subtitle_grob)
labels <- gList(ylab_grob, xlab_grob)
in_labels <- gList(y_inlab_grob, x_inlab_grob)
arrow_ann <- gList(y_ann_grob, x_ann_grob, big_arrow(25, "grey50"), big_arrow(20, "grey90"))

## Plotting Grobs ----
plt <- gList(rect_box, rel_space, titles, labels, in_labels, arrow_ann, bottom_ann_grob)

# grid.newpage()
# grid.draw(plt)
# ggsave(filename = "Presentation/_images/relevant-space.svg", plot = plt, width = 7, height = 4)
# ggsave(filename = "Presentation/_images/relevant-space.pdf", plot = plt, width = 7, height = 4)