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

emission_data <- read_csv(here::here("data", "San_Francisco_Communitywide_Greenhouse_Gas_Inventory.csv")) |>
  clean_names()

annual_emissions <- emission_data |>
  group_by(sector_general) |>
  summarize(total_annual_ghg_emissions = sum(emissions_mt_co2e, na.rm = TRUE))

yearly_emissions <- emission_data |>
  group_by(calendar_year, commodity_type) |>
  summarise(total_annual_ghg_emissions = sum(emissions_mt_co2e, na.rm = TRUE))

modern_emissions <- emission_data |>
  dplyr::filter(str_detect(sector_detail2, "PG&E")) |>
  select(c(calendar_year, sector_detail2, emissions_mt_co2e))


graph_emissions <- emission_data |>
  group_by(calendar_year, sector_general) |>
  summarize(total_annual_ghg_emissions = sum(emissions_mt_co2e, na.rm = TRUE))


ggplot(data = graph_emissions, aes(y = sector_general, x = total_annual_ghg_emissions)) +
  geom_jitter(height = 0.25,
              aes(color = calendar_year),
              size = 4,
              alpha = 0.75) +
  scale_color_steps(name = "Year",
                    low = "green", high = "black",
                    breaks = c(1990, 2000, 2005, 2010, 2012, 2015, 2016, 2017, 2018, 2019)) +
  labs(x = "Total Annual Greenhouse Gas Emissions\n(metric tons of carbon dioxide equivalents)\n",
       y = "Sector",
       title = "Annual San Francisco Greenhouse Gas Emissions (1990 - 2019)",
       caption = "Data: San Francisco Communitywide Greenhouse Gas Inventory") +
  theme_bw()

ggsave(here::here("figs", "decent_data_viz.png"))  














