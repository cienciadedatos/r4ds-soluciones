# Modelos: conceptos básicos

## Paquetes necesarios


```r
library(tibble)
library(ggplot2)
library(purrr)
library(modelr)
library(tidyr)
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

1. Una forma de obtener un modelo lineal más robusto es usar una métrica 
 distinta para la distancia. Por ejemplo, en lugar de la raíz de la distancia
 media cuadrática (del inglés *root-mean-squared distance*) se podría usar la
 media de la distancia absoluta:


```r
medir_distancia <- function(modelo, datos) {
  diferencia <- datos$y - modelo1(modelo, datos)
  mean(abs(diferencia))
}
```

Usa `optim()` para ajustar este modelo a los datos simulados anteriormente y
compara el resultado con el modelo lineal.

<div class="solucion">
<h3>Solución</h3>

Usando los datos `sim1a` y `optim()` podemos encontrar los parámetros que
minimizan la desviación absoluta. Definiremos la función `modelo1()` tal como
se hizo en el libro.


```r
modelo1 <- function(a, datos) {
  a[1] + datos$x * a[2]
}

beta <- optim(c(0, 0), medir_distancia, datos = sim1a)
beta$par
```

```
## [1] 5.759926 1.522131
```

Los resultados del modelo lineal son los mismos que se obtienen si se minimiza
la desviación al cuadrado.


```r
medir_distancia_ml <- function(modelo, datos) {
  diferencia <- datos$y - (modelo[1] + modelo[2] * datos$x)
  sqrt(mean(diferencia^2))
}

beta <- optim(c(0, 0), medir_distancia_ml, datos = sim1a)
beta$par
```

```
## [1] 6.675835 1.309799
```

En la práctica no es recomendable usar `optim()` para ajustar un modelo, es
mejor utilizar implementaciones ya existentes como `rlm()` y `lqs()` que son
parte del paquete [MASS](https://CRAN.R-project.org/package=MASS).

La justificación es que estas implementaciones permiten ajustar modelos
robustos sin los múltiples problemas de carácter numérico que pueden surgir de
manera condicional a los datos al momento de usar `optim()`.
</div>

1. Un desafío al realizar optimización numérica es que únicamente garantiza
 encontrar un óptimo local. ¿Qué problema se presenta al optimizar un modelo de
 tres parámetros como el que se presenta a continuación?


```r
modelo3 <- function(a, datos) {
  a[1] + datos$x * a[2] + a[3]
}
```

<div class="solucion">
<h3>Solución</h3>

El problema es que dados los valores `a[1] = a1` y `a[3] = a3`, cualquier otra
combinación de `a[1]` y `a[3]` tal que `a[1] + a[3] == (a1 + a3)` tendrá el
mismo ajuste.


```r
medir_distancia_3_ml <- function(a, datos) {
  diferencia <- datos$y - modelo3(a, datos)
  sqrt(mean(diferencia^2))
}
```

Dependiendo de los valores inciales se van a obtener distintos valores óptimos.


```r
beta_000 <- optim(c(0, 0, 0), medir_distancia_3_ml, datos = sim1a)
beta_000$par
```

```
## [1] -7.073445  1.310212 13.747947
```


```r
beta_001 <- optim(c(0, 0, 1), medir_distancia_3_ml, datos = sim1a)
beta_001$par
```

```
## [1] 11.233987  1.310001 -4.558419
```


```r
beta_005 <- optim(c(0, 0, 5), medir_distancia_3_ml, datos = sim1a)
beta_005$par
```

```
## [1] 1.617275 1.310258 5.056499
```

Si seguimos alterando los valores inciales no es muy difícil concluir que
existen infinitos valores óptimos para este modelo.
</div>

## Visualizando modelos

### Ejercicios

1. En lugar de usar `lm()` para ajustar una línea recta, puedes usar `loess()`
 para ajustar una curva suave. Repite el proceso de ajustar el modelo,
 generar la cuadrícula, predicciones y visualización con `sim1` usando `loess()`
 en vez de `lm()`. ¿Cómo se compara el resultado a `geom_smooth()`.
 
<div class="solucion">
<h3>Solución</h3>

Usando `add_predictions()` y `add_residuals()` se pueden agregar las
predicciones y los residuos de la regresión loess a los datos `sim1a`.


```r
sim1_loess <- loess(y ~ x, data = sim1a)
sim1_lm <- lm(y ~ x, data = sim1a)

grid_loess <- sim1a %>%
  add_predictions(sim1_loess)

sim1a <- sim1a %>%
  add_residuals(sim1_lm) %>%
  add_predictions(sim1_lm) %>%
  add_residuals(sim1_loess, var = "resid_loess") %>%
  add_predictions(sim1_loess, var = "pred_loess")
```

Ahora procedemos a graficar las predicciones. La regresión loess genera un
ajuste no lineal a partir de los datos.


```r
plot_sim1_loess <- ggplot(sim1, aes(x = x, y = y)) +
  geom_point() +
  geom_line(aes(x = x, y = pred), data = grid_loess, colour = "red")

plot_sim1_loess
```

<img src="23-model-basics_files/figure-html/unnamed-chunk-17-1.png" width="672" />

Las predicciones del modelo loess son las mismas que entrega el método por
defecto de `geom_smooth()` ya que este usa `loess()` y entrega un mensaje al
respecto.


```r
plot_sim1_loess +
  geom_smooth(method = "loess", colour = "blue", se = FALSE, alpha = 0.20)
```

<img src="23-model-basics_files/figure-html/unnamed-chunk-18-1.png" width="672" />

Podemos graficar los residuos de loess (en rojo) y compararlos con los del
modelo lineal (en negro). En general, el modelo loess tiene un menor residuo
dada la muestra (fuera de la muestra no se asegura este comportamiento y no
hemos considerado la incertidumbre de la estimación).


```r
ggplot(sim1a, aes(x = x)) +
  geom_ref_line(h = 0) +
  geom_point(aes(y = resid)) +
  geom_point(aes(y = resid_loess), colour = "red")
```

<img src="23-model-basics_files/figure-html/unnamed-chunk-19-1.png" width="672" />
</div>

1. `add_predictions()` está pareada con `gather_predictions()` y
 `spread_predictions()`. ¿Cómo difieren estas tres funciones?

<div class="solucion">
<h3>Solución</h3>

Las funciones `gather_predictions()` y `spread_predictions()` permiten incluir
simultáneamente las predicciones de múltiples modelos.

Por ejemplo, se puede incluir `sim1_mod`.


```r
sim1_mod <- lm(y ~ x, data = sim1)

grid <- sim1 %>%
  data_grid(x)
```

La función `add_predictions()` permite incluir un modelo a la vez. Para agregar
dos modelos se debe encadenar con el operador `%>%`.


```r
grid %>%
  add_predictions(sim1_mod, var = "pred_lm") %>%
  add_predictions(sim1_loess, var = "pred_loess")
```

```
## # A tibble: 10 x 3
##        x pred_lm pred_loess
##    <int>   <dbl>      <dbl>
##  1     1    6.27       8.05
##  2     2    8.32       8.82
##  3     3   10.4        9.95
##  4     4   12.4       11.5 
##  5     5   14.5       13.6 
##  6     6   16.5       16.0 
##  7     7   18.6       17.1 
##  8     8   20.6       17.5 
##  9     9   22.7       18.2 
## 10    10   24.7       18.8
```

La función `gather_predictions()` incorpora predicciones de múltiples modelos
por medio de agrupar los resultados e incluir una columna con el nombre del
modelo.


```r
grid %>%
  gather_predictions(sim1_mod, sim1_loess)
```

```
## # A tibble: 20 x 3
##    model          x  pred
##    <chr>      <int> <dbl>
##  1 sim1_mod       1  6.27
##  2 sim1_mod       2  8.32
##  3 sim1_mod       3 10.4 
##  4 sim1_mod       4 12.4 
##  5 sim1_mod       5 14.5 
##  6 sim1_mod       6 16.5 
##  7 sim1_mod       7 18.6 
##  8 sim1_mod       8 20.6 
##  9 sim1_mod       9 22.7 
## 10 sim1_mod      10 24.7 
## 11 sim1_loess     1  8.05
## 12 sim1_loess     2  8.82
## 13 sim1_loess     3  9.95
## 14 sim1_loess     4 11.5 
## 15 sim1_loess     5 13.6 
## 16 sim1_loess     6 16.0 
## 17 sim1_loess     7 17.1 
## 18 sim1_loess     8 17.5 
## 19 sim1_loess     9 18.2 
## 20 sim1_loess    10 18.8
```

La función `spread_predictions()` incorpora predicciones de múltiples modelos
agregando múltiples columnas (de acuerdo al nombre de cada modelo) que contienen
las predicciones respectivas.


```r
grid %>%
  spread_predictions(sim1_mod, sim1_loess)
```

```
## # A tibble: 10 x 3
##        x sim1_mod sim1_loess
##    <int>    <dbl>      <dbl>
##  1     1     6.27       8.05
##  2     2     8.32       8.82
##  3     3    10.4        9.95
##  4     4    12.4       11.5 
##  5     5    14.5       13.6 
##  6     6    16.5       16.0 
##  7     7    18.6       17.1 
##  8     8    20.6       17.5 
##  9     9    22.7       18.2 
## 10    10    24.7       18.8
```

La función `spread_predictions()` es similar a correr `add_predictions()` para
cada modelo que se quiere incorporar y es equivalente a correr `spread()` luego
de `gather_predictions()`.


```r
grid %>%
  gather_predictions(sim1_mod, sim1_loess) %>%
  spread(model, pred)
```

```
## # A tibble: 10 x 3
##        x sim1_loess sim1_mod
##    <int>      <dbl>    <dbl>
##  1     1       8.05     6.27
##  2     2       8.82     8.32
##  3     3       9.95    10.4 
##  4     4      11.5     12.4 
##  5     5      13.6     14.5 
##  6     6      16.0     16.5 
##  7     7      17.1     18.6 
##  8     8      17.5     20.6 
##  9     9      18.2     22.7 
## 10    10      18.8     24.7
```
</div>

1. ¿Qué hace `geom_ref_line()`? ¿De qué paquete proviene? ¿Por qué es útil e importante
 incluir una línea de referencia en los gráficos que muestran residuos?

<div class="solucion">
<h3>Solución</h3>

La geometría `geom_ref_line()` agrega una línea de referencia al gráfico. Es el
equivalente a usar `geom_hline()` o `geom_vline()` con las opciones por defecto
y que nos sirven para visualizar modelos.

Agregar una línea de referencia en torno a cero para los residuos es importante
ya que un buen modelo, por lo general, tiene residuos centrados en torno a cero.
Otras características relevantes son que los errores deben tener idéntica
varianza y no estar correlacionados entre si.

La línea de referencia en torno a cero permite evaluar visualmente estas
características.
</div>

1. ¿Por qué quisieras mirar un polígono de frecuencias con los residuos absolutos? ¿Cuáles son las
 ventajas y desventajas de los residuos crudos?

<div class="solucion">
<h3>Solución</h3>

Mostrar los valores absolutos de los residuos facilita ver la magnitud del
error. El modelo lineal asume que los residuos tienen media cero y usar los
valores absolutos de los residuos permite ver lo que ocurre cuando los errores
de signos opuestos no se cancelan mutuamente.


```r
sim1_mod <- lm(y ~ x, data = sim1a)

sim1 <- sim1 %>%
  add_residuals(sim1_mod)

ggplot(sim1a, aes(x = abs(resid))) +
  geom_freqpoly(binwidth = 0.5)
```

<img src="23-model-basics_files/figure-html/unnamed-chunk-25-1.png" width="672" />

El inconveniente que aparece visualmente es que se pierde toda información
respecto de los signos de los residuos. Por lo tanto, el polígono de frecuencias
no distingue si acaso el modelo sobre-estima o sub-estima de manera consistente.
</div>

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
