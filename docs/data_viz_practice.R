library(tidyverse)
library(here)
library(janitor)
library(patchwork)
library(ggrepel)
library(ggimage)
library(jpeg)
library(ggplot2)
library(ggpubr)
library(extrafont)

space_launches <- read_csv(here::here("data", "space_launches.csv"))
kittens <- readJPEG(here::here("figs", "ragdoll_kittens.jpg"))

launch_count <- space_launches |>
  group_by(agency_type, launch_year) |>
  summarize(count = n())

ggplot(data = launch_count, aes(x = count, y = launch_year)) +
  geom_line(aes(color = agency_type)) +
  scale_color_discrete(type = c("#462749", "#DF2935", "#FED766", "#F0386B"))


ggplot(data = space_launches, aes(x = state_code, y = launch_year))+
  background_image(kittens) +
  geom_boxplot(color = "green",
               fill = "orange",
               alpha = 0.5) +
  scale_y_continuous(limits = c(1960, 2020),
                     breaks = seq(from = 1955, to = 2022, by = 2)) +
  labs(x = "STATES!",
       y = "YEARS!",
       title = "Kittens in Space: \nAn exploration into anyone's best guess\n")+
  theme(plot.background = element_rect(fill = "purple"),
        panel.background = element_rect(color = "red",
                                        linewidth = 200),
        axis.text.x = element_text(color = "orange"),
        axis.text.y = element_text(color = "red"),
        axis.title.x = element_text(family = "mono",
                                    size = 30),
        axis.title.y = element_text(family = "sans",
                                    size = 10),
        title = element_text(family = "mono",
                             size = 15))  

ggsave(here::here("figs", "kittens_in_space.png"))  
  

