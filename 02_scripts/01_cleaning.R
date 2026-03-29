

library(dplyr)
library(lubridate)
library(openxlsx)
library(tsibble)

# Leer datos
data_raw <- read.xlsx(
  "data/raw/Base Demanda Diaria 2017 2026.xlsx",
  sheet = "Datos Región",
  startRow = 5
)

# Selección y rename
data <- data_raw[, c(
  "AÑO", "MES", "Fecha", "Tipo.día",
  "DEMANDA.TOTAL", "TEMPERATURA.REFERENCIA.MEDIA.GBA.°C"
)]

colnames(data) <- c("anio", "mes", "fecha", "tipo_dia", "demanda", "temperatura")

# Formato fechas
data$fecha <- as.Date(data$fecha, origin = "1899-12-30")

# Orden
data <- data %>% arrange(fecha)

# Features
data <- data %>%
  mutate(
    temp2 = temperatura^2,
    es_habil = ifelse(grepl("habil", tipo_dia, ignore.case = TRUE), 1, 0),
    lag1 = lag(demanda, 1)
  )

# Serie temporal
data_ts <- as_tsibble(data, index = fecha)

## Guarda set de datos limpio
write.csv(data, "data/processed/demanda_clean.csv", row.names = FALSE)

# Guarda archivo de trabajo para llegar a dataset limpio
saveRDS(data, "data/processed/demanda_limpia.rds")