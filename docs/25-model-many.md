# Muchos modelos

## Paquetes necesarios


```r
library(dplyr)
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
library(tidyr)
library(datos)
```

## gapminder

### Ejercicios

1. Una tendencia lineal parece ser demasiado simple para la tendencia general.
 ¿Puedes hacerlo mejor con un polinomio cuadrático? ¿Cómo puedes interpretar
 el coeficiente del término cuadrático? (Pista: puedes querer transformar
 `year` para que tenga media cero.)

1. Explora otros métodos para visualizar la distribución del $R^2$ por
 continente. Puedes querer probar el paquete __ggbeeswarm__, que provee
 métodos similares para evitar superposiciones como jitter, pero usa métodos
 determinísticos.

1. Para crear el último gráfico (mostrando los datos para los países con los
 peores ajustes del modelo), precisamos dos pasos: creamos un _data frame_ con
 una fila por país y después hicimos un _semi-join_ (del inglés _semi juntar_) (TODO: deberíamos aclarar algo?) al conjunto de datos original.
 Es posible evitar este _join_ si usamos `unnest()` en lugar de
 `unnest(.drop = TRUE)`. ¿Cómo?


## Creando columnas-lista


### Ejercicios

1. Lista todas las funciones en las que puedas pensar que tomen como _input_ un vector atómico y
 retornen una lista.

1. Piensa en funciones de resumen útiles que, como `quantile()`, retornen
 múltiples valores.

1. ¿Qué es lo que falta en el siguiente _data frame_? ¿Cómo `quantile()` retorna
 eso que falta? ¿Por qué eso no es tan útil aquí?


```r
mtautos %>%
  group_by(cilindros) %>%
  summarise(q = list(quantile(millas))) %>%
  unnest()
```

```
## # A tibble: 15 x 2
##    cilindros     q
##        <dbl> <dbl>
##  1         4  21.4
##  2         4  22.8
##  3         4  26  
##  4         4  30.4
##  5         4  33.9
##  6         6  17.8
##  7         6  18.6
##  8         6  19.7
##  9         6  21  
## 10         6  21.4
## 11         8  10.4
## 12         8  14.4
## 13         8  15.2
## 14         8  16.2
## 15         8  19.2
```

1. ¿Qué hace este código? ¿Por qué podría ser útil?


```r
mtautos %>%
  group_by(cilindros) %>%
  summarise_each(funs(list))
```

## Simplificando columnas-lista


### Ejercicios

1. ¿Por qué podría ser útil la función `lengths()` para crear columnas de
 vectores atómicos a partir de columnas-lista?

1. Lista los tipos de vectores más comúnes que se encuentran en un _data frame_. ¿Qué hace que las
 listas sean diferentes?

