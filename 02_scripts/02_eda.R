
library(ggplot2)
library(dplyr)

## Lectura datos limpios
data <- read.csv("data/processed/demanda_clean.csv")
data$fecha <- as.Date(data$fecha)

## Opcional
data <- readRDS("data/processed/demanda_limpia.rds")

# Gráfico principal
ggplot(data, aes(x = fecha, y = demanda)) +
  geom_line()

# Estacionalidad semanal
data %>%
  mutate(dia_semana = weekdays(fecha)) %>%
  group_by(dia_semana) %>%
  summarise(promedio = mean(demanda)) %>%
  ggplot(aes(x = dia_semana, y = promedio)) +
  geom_col()

# Relación temperatura
ggplot(data, aes(x = temperatura, y = demanda)) +
  geom_point(alpha = 0.3) +
  geom_smooth()