### Happy Valentines Day!

## check if packages are installed
if ("tidyverse" %in% rownames(installed.packages()) == 'FALSE') install.packages('tidyverse') 
if ("broom" %in% rownames(installed.packages()) == 'FALSE') install.packages('broom') 
if ("gganimate" %in% rownames(installed.packages()) == 'FALSE') install.packages('gganimate') 
if ("beepr" %in% rownames(installed.packages()) == 'FALSE') install.packages('beepr') 

# load the packages
library(tidyverse)
library(broom)
library(gganimate)
library(beepr)

# dataframe for the heart
d <- tibble(t = seq(-pi, 0, .01),
            x1 = 16 * (sin(t)) ^ 2,
            x2 = -x1,
            y = 13 * cos(t) -
              5 * cos(2 * t) -
              2 * cos(3 * t) -
              cos(4 * t)) %>%
  gather(side, x, x1, x2)

heart <- d %>%
  crossing(t1 = max(d$t) + seq_len(20)) %>%
  arrange(((side == "x2") - 1) * t)

# plot the heart as an animations
g <- ggplot(d, aes(x, y)) +
  geom_path(aes(group = side)) +
  geom_polygon(aes(alpha = t1), data = heart, fill = "red", show.legend = FALSE) +
  geom_text(aes(x = 0, y = 0, label = "I love R!", alpha = t1),
            data = heart, size = 8, color = "white", show.legend = FALSE) +
  coord_equal() +theme_void()+
  transition_reveal(y) 

g
beep("fanfare")
# code modified from: https://rpubs.com/dgrtwo/valentine