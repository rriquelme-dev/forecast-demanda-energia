
library(dplyr)
library(Metrics)

## Lectura datos limpios
data <- read.csv("data/processed/demanda_clean.csv")
data$fecha <- as.Date(data$fecha)

## Opcional
data <- readRDS("data/processed/demanda_limpia.rds")

# Split
train <- data %>% filter(fecha < as.Date("2024-01-01"))
test  <- data %>% filter(fecha >= as.Date("2024-01-01"))

# Modelo 1
modelo <- lm(demanda ~ temperatura + temp2 + es_habil, data = train)

test$pred <- predict(modelo, test)

rmse(test$demanda, test$pred)
mae(test$demanda, test$pred)

# Modelo 2 (con lag)
modelo2 <- lm(demanda ~ temperatura + temp2 + es_habil + lag1, data = train)

test$pred <- predict(modelo2, test)

rmse(test$demanda, test$pred)
mae(test$demanda, test$pred)