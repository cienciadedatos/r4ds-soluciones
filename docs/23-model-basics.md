# Modelos: conceptos básicos

## Paquetes necesarios


```r
library(tibble)
library(ggplot2)
library(purrr)
library(datos)
```

## Un modelo simple

### Ejercicios

1. Una desventaja del modelo lineal es ser sensible a valores inusuales
 debido a que la distancia incorpora un término al cuadrado. Ajusta un
 modelo a los datos simulados que se presentan a continuación y visualiza
 los resultados. Corre el modelo varias veces para generar diferentes conjuntos
 de datos simulados. ¿Qué puedes observar respecto del modelo?

 
 ```r
 sim1a <- tibble(
  x = rep(1:10, each = 3),
  y = x * 1.5 + 6 + rt(length(x), df = 2)
 )
 ```

<div class="solucion">

<h3>Solución</h3>

Se puede correr una vez y graficar los resultados.


```r
ggplot(sim1a, aes(x = x, y = y)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE)
```

<img src="23-model-basics_files/figure-html/unnamed-chunk-3-1.png" width="672" />

Para sistematizarlo, se pueden generar varias simulaciones y luego graficar
las líneas.


```r
simt <- function(i) {
  tibble(
    x = rep(1:10, each = 3),
    y = x * 1.5 + 6 + rt(length(x), df = 2),
    .id = i
  )
}

sims <- map_df(1:12, simt)

ggplot(sims, aes(x = x, y = y)) +
  geom_point() +
  geom_smooth(method = "lm", colour = "red") +
  facet_wrap(~.id, ncol = 4)
```

<img src="23-model-basics_files/figure-html/unnamed-chunk-4-1.png" width="672" />

El ejercicio usa la función `rt()` la cual entrega
un muestreo a partir de una distribución t-Student, la cual tiene colas más
largas que la distribución normal (`rnorm()`), por lo tanto asigna una mayor
probabilidad a los valores fuera del centro de la distribución.

¿Qué ocurre si usamos una distribución normal?


```r
sim_norm <- function(i) {
  tibble(
    x = rep(1:10, each = 3),
    y = x * 1.5 + 6 + rnorm(length(x)),
    .id = i
  )
}

simdf_norm <- map_df(1:12, sim_norm)

ggplot(simdf_norm, aes(x = x, y = y)) +
  geom_point() +
  geom_smooth(method = "lm", colour = "red") +
  facet_wrap(~.id, ncol = 4)
```

<img src="23-model-basics_files/figure-html/unnamed-chunk-5-1.png" width="672" />

Al usar distribución normal no hay tantos valores extremos y las pendientes
son más similares.

Para el caso de la distribución normal con media cero y desviación estándar uno,
la probabilidad de que un valor sea mayor a dos se obtiene con `pnorm()`.


```r
pnorm(2, lower.tail = FALSE)
```

```
## [1] 0.02275013
```

Para el caso de la distribución t-Student con dos grados de libertad, la
probabilidad es más del triple del caso anterior y se obtiene con `pt()`.


```r
pt(2, df = 2, lower.tail = FALSE)
```

```
## [1] 0.09175171
```

Podemos concluir que el modelo es sensible a valores extremos y en general a
la distribución que siguen los datos.
</div>

1. Una forma de obtener un modelo lineal más robusto es usar una métrica distinta
 para la distancia. Por ejemplo, en lugar de la raíz de la distancia media cuadrática
 (del inglés *root-mean-squared distance*) se podría usar la media de la distancia absoluta:

 
 ```r
 measure_distance <- function(mod, data) {
  diff <- data$y - model1(mod, data)
  mean(abs(diff))
 }
 ```

 Usa `optim()` para ajustar este modelo a los datos simulados anteriormente y
 compara el resultado con el modelo lineal.

1. Un desafío al realizar optimización numérica es que únicamente garantiza
 encontrar un óptimo local. ¿Qué problema se presenta al optimizar un modelo de
 tres parámetros como el que se presenta a continuación?

 
 ```r
 model1 <- function(a, data) {
  a[1] + data$x * a[2] + a[3]
 }
 ```

## Visualizando modelos

### Ejercicios

1. En lugar de usar `lm()` para ajustar una línea recta, puedes usar `loess()`
 para ajustar una curva suave. Repite el proceso de ajustar el modelo,
 generar la cuadrícula, predicciones y visualización con `sim1` usando `loess()`
 en vez de `lm()`. ¿Cómo se compara el resultado a `geom_smooth()`.

1. `add_predictions()` está pareada con `gather_predictions()` y
 `spread_predictions()`. ¿Cómo difieren estas tres funciones?

1. ¿Qué hace `geom_ref_line()`? ¿De qué paquete proviene? ¿Por qué es útil e importante
 incluir una línea de referencia en los gráficos que muestran residuos?

1. ¿Por qué quisieras mirar un polígono de frecuencias con los residuos absolutos? ¿Cuáles son las
 ventajas y desventajas de los residuos crudos?

## Fórmulas y familias de modelos

### Ejercicios

1. ¿Qué pasa si repites el análisis de `sim2` usando un modelo sin intercepto? ¿Qué ocurre con la
 ecuación del modelo? ¿Qué ocurre con las predicciones?

1. Usa `model_matrix()` para explorar las ecuaciones generadas por los modelos ajustados a `sim3` y
 `sim4`. ¿Por qué `*` es un atajo para la interacción?

1. Usando los principios básicos, convierte las fórmulas de los siguientes modelos en funciones.
 (Sugerencia: comienza por convertir las variables categóricas en ceros y unos.)

 
 ```r
 mod1 <- lm(y ~ x1 + x2, data = sim3)
 mod2 <- lm(y ~ x1 * x2, data = sim3)
 ```

1. Para `sim4`, ¿Es mejor `mod1` o `mod2`? Yo creo que `mod2` es ligeramente mejor
 removiendo las tendencias, pero es bastante sutil. ¿Puedes generar un gráfico
 que de sustento a esta hipótesis?
