Forecast de Demanda Eléctrica (Argentina)
*******************************************************************************************************************************************
Descripción
Este proyecto desarrolla un modelo predictivo de demanda eléctrica diaria en Argentina utilizando variables climáticas y de calendario.
El objetivo es construir un modelo simple, interpretable y efectivo que permita capturar los principales drivers de la demanda energética.
*******************************************************************************************************************************************
Objetivo del Proyecto:
- Modelar demnanda eléctrica diaria a nivel nacional
- Analizar el impacto de la temperatura en el consumo eléctrico
- Incorporar efectos calendarios (días hábiles)
- Evaluar mejoras al incluir dependencia temporal (lag)

Dataset:
- Fuente: CAMMESA - Base histórica de demanda eléctrica nacional (2017 - 2026)
- Variables utilizadas:
    ° fecha
    ° demanda (MW)
    ° temperatura (°C)
    ° tipo_dia

- Fuentes generadas:
    ° temp2 -> captura relacón no lineal con temperatura
    ° es_habil -> dummy de día laboral
    ° lag1 -> demanda del día anterior

*******************************************************************************************************************************************
Análisis Exploratorio:
  Demanda en el tiempo:
  Se observa una fuerte estacionalidad tanto semanal como anual en el set de datos utilizado.

  Demanda vs temperatura:
  Se encuentra una relación en forma de U entre ambas variables, lo que se puede interpretar como:
    ° Alta demanda en temperaturas bajas (probablemente debido al uso de equipos para calefaccionar)
    ° Alta demanda en temperaturas altas (probablemente debido al uso de equipos para refrigerar)
  Esta relación justifica el uso del término cuadrático (temp²).

*******************************************************************************************************************************************
Modelos:
  Modelo base:
    demanda ~ temperatura + temp2 + es_habil

  Modelo mejorado:
    demanda ~ temperatura + temp2 + es_habil + lag1

*******************************************************************************************************************************************
Resultados:

Modelo          | RMSE | MAE |

Sin lag         | 1243 | 983 |

con lag (lag1)  |  751 | 582 |

La inclusión de lag1 reduce significativamente el error, capturandola inercia de la serie temporal.

Insights clave:
 - La temperatura es el principal driver de la demanda eléctrica.
 - La relación es no lineal -> modelo cuadrático resulta necesario.
 - Los días hábiles incrementan la demanda significativamente.
 - La demanda presenta fuerte autocorrelación (efecto inercia)

*******************************************************************************************************************************************
Estructura del proyecto:

forecast-demanda-energia/

│

├── 01_data/

│   ├── raw/

│   └── processed/

│

├── 02_scripts/

│   ├── 01_cleaning.R

│   ├── 02_eda.R

│   ├── 03_modeling.R

│   └── run_all.R

│

├── outputs/

│   ├── plots/

│   └── results/

│

└── README.md

Cómo correr el proyecto:

1. Clonar el repositorio:
   git clone https://github.com/rriquelme-dev/forecast-demanda-energia.git
2. Abrir en RStudio
3. Ejecutar:
   source("02_scripts/run_all.R")

*******************************************************************************************************************************************
Tecnologías utilizadas:

  ° R
  
  ° dplyr
  
  ° ggplot2
  
  ° tsibble
  
  ° Metrics
  
  ° openxlsx

Próximos pasos

  ° Incorporar modelos de series temporales (ARIMA)
  
  ° Evaluar modelos de machine learning
  
  ° Agregar variables externas (económicas / calendario)
  
  ° Implementar forecast a futuro

*******************************************************************************************************************************************
Autor:
Ramiro H. Riquelme
Data Analyst | Modelado de demanda eléctrica
