# Tibbles


```r
library(tibble)
```

## Ejercicios

1. ¿Cómo puedes saber si un objeto es un tibble? (Sugerencia: imprime `mtautos` en consola, que es un data frame clásico).

1. Compara y contrasta las siguientes operaciones aplicadas a un `data.frame` y a un tibble equivalente. ¿Qué es diferente? ¿Por qué podría causarte problemas el comportamiento por defecto del data frame?

 
 ```r
 df <- data.frame(abc = 1, xyz = "a")
 df$x
 df[, "xyz"]
 df[, c("abc", "xyz")]
 ```

1. Si tienes el nombre de una variable guardada en un objeto, p.e., `var <- "mpg"`, ¿cómo puedes extraer esta variable de un tibble?

1. Practica referenciar nombres no sintácticos en el siguiente data frame:

 1. Extrayendo la variable llamada `1`.

 1. Generando un gráfico de dispersión de `1` vs `2`.

 1. Creando una nueva columna llamada `3` que sea el resultado de la división de `2` por `1`.

 1. Renombrando las columnas como `uno`, `dos` y `tres`.

 
 ```r
 molesto <- tibble(
  `1` = 1:10,
  `2` = `1` * 2 + rnorm(length(`1`))
 )
 ```

1. ¿Qué hace `tibble::enframe()`? ¿Cuándo lo usarías?

1. ¿Qué opción controla cuántos nombres de columnas adicionales se muestran al pie de un tibble?
