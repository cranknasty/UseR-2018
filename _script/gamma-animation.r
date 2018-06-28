library(gganimate)
library(tidyverse)
library(plotly)

# Multicollinearity
dta <- map_df(1:15, ~tibble(
  gamma = c(seq(0, 0.5, length.out = 6),
            seq(0.6, 1.2, length.out = 4)),
  lambda = exp(-1 * gamma * (.x - 1))),
  .id = "variable") %>%
  mutate(variable = as.numeric(variable))
dta_min <- with(dta, {
  data_frame(variable = max(variable), 
             gamma = unique(gamma), 
             lambda = max(lambda))
})

static_plt <- dta %>%
  ggplot(aes(variable, lambda)) +
  geom_point(aes(frame = gamma)) + 
  geom_line(group = 1, aes(frame = gamma)) +
  geom_text(aes(frame = gamma, label = paste("gamma\n", gamma)), 
            data = dta_min, nudge_x = -2, nudge_y = -0.15,
            color = "grey", size = 8) +
  labs(x = "Components", y = "Eigenvalues") +
  scale_x_continuous(breaks = unique(dta$variable))

# plt <- ggplotly(static_plt) %>% 
#   config(displayModeBar = FALSE) %>% 
#   animation_opts(
#     800, easing = "elastic", redraw = TRUE
#   ) %>% 
#   animation_button(
#     x = 1, xanchor = "right", y = 0, yanchor = "bottom",
#     borderwidth = 0, bgcolor = 'transparent',
#     font = list(family = "monospace", size = 42, color = "#afafaf")
#   ) %>%
#   animation_slider(
#     currentvalue = list(
#       x = 1, xanchor = 'right', y = 0, yanchor = 'bottom',
#       prefix = "gamma: ", font = list(color = "grey"))
#   )

# +
#   annotate(label = "lambda[i] == e^-gamma(x[i] - 1)",
#            size = 12, family = "serif", geom = "text",
#            x = Inf, y = Inf, hjust = 1, vjust = 1, parse = TRUE) +
#   annotate(label = "kappa[j] == e^-eta(y[j] - 1)",
#            size = 12, family = "serif", geom = "text",
#            x = Inf, y = Inf, hjust = 1, vjust = 2, parse = TRUE)
# ggsave(static_plt, filename = "_images/multicollinearity.pdf",
#        dpi = 300, width = 7, height = 7)
# 
# plt <- ggplot(dta, aes(
#   variable, lambda,
#   frame = paste("Degree of multicollinearity:", round(gamma, 2)))) +
#   geom_bar(stat = "identity",
#            position = "identity",
#            fill = "lightgrey") +
#   geom_point() + geom_line(group = 1) +
#   labs(x = "Variable", y = "Eigenvalues") +
#   scale_x_continuous(breaks = unique(dta$variable)) +
#   theme_bw() +
#   theme(text = element_text(size = 18)) +
#   annotate(label = "lambda[i] == e^-gamma(x[i] - 1)",
#            size = 12, family = "serif", geom = "text",
#            x = Inf, y = Inf, hjust = 1, vjust = 1, parse = TRUE) +
#   annotate(label = "kappa[j] == e^-eta(y[j] - 1)",
#            size = 12, family = "serif", geom = "text",
#            x = Inf, y = Inf, hjust = 1, vjust = 2, parse = TRUE)
# 
# gganimate(plt, "_images/multicollinearity.gif", ani.dev = "png")
