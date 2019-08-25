# Datos ordenados


```r
library(tibble)
```

## Datos ordenados

### Ejercicios

1. Usando prosa, describe como las variables y observaciones se organizan en las tablas de ejemplo.

1. Calcula la `tasa` para las tablas `tabla2` y `tabla4a` + `tabla4b`.
 Necesitarás las siguientes operaciones:

 1. Extrae el número de casos de tuberculosis por país y año.
 1. Extrae la población por país y año.
 1. Divide los casos por la población y multiplica por 10000.
 1. Inserta los datos en el lugar adecuado.

 ¿Cuál representación es más fácil de trabajar? ¿Cuál es la más difícil? ¿Por qué?

1. Recrea el gráfico que muestra el cambio en el número de casos usando la `tabla2` en lugar de la `tabla1`. ¿Qué debes hacer en primer lugar?

## Reunir y Esparcir

### Ejercicios

1. ¿Por qué `gather()` y `spread()` no son perfectamente simétricas?
 Observa cuidadosamente el siguiente ejemplo:


```r
acciones <- tibble(
  anio = c(2015, 2015, 2016, 2016),
  semestre = c(1, 2, 1, 2),
  retorno = c(1.88, 0.59, 0.92, 0.17)
)
acciones %>%
  spread(anio, retorno) %>%
  gather("anio", "retorno", `2015`:`2016`)
```

 (Pista: observa los tipos de variables y piensa en los nombres de las columnas)

 Tanto `spread()` como `gather()` tienen el argumento `convert` (convertir). ¿Qué hace dicho argumento?

1. ¿Por qué falla el siguiente código?


```r
tabla4a %>%
  gather(`1999`, `2000`, key = "anio", value = "casos")
```

```
## Error in tabla4a %>% gather(`1999`, `2000`, key = "anio", value = "casos"): could not find function "%>%"
```

1. ¿Por qué no se puede extender la siguiente tabla? ¿Cómo agregarias una nueva columna para resolver el problema?


```r
personas <- tribble(
  ~nombre, ~clave, ~valor,
  #-----------------|--------|------
  "Phillip Woods", "edad", 45,
  "Phillip Woods", "estatura", 186,
  "Phillip Woods", "edad", 50,
  "Jessica Cordero", "edad", 37,
  "Jessica Cordero", "estatura", 156
)
```

1. Ordena la siguiente tabla. ¿Necesitas extenderla o contraerla? ¿Cuáles son las variables?


```r
embarazo <- tribble(
  ~embarazo, ~hombre, ~mujer,
  "sí", NA, 10,
  "no", 20, 12
)
```

## Separar y unir

### Ejercicios

1. ¿Qué hacen los argumentos `extra` y `fill` en `separate()`?
 Experimenta con las diversas opciones a partir de los siguientes datasets de ejemplo.

 
 ```r
 tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>%
  separate(x, c("one", "two", "three"))
 
 tibble(x = c("a,b,c", "d,e", "f,g,i")) %>%
  separate(x, c("one", "two", "three"))
 ```

1. Tanto `unite()` como `separate()` tienen un argumento `remove`. ¿Qué es lo que hace?
¿Por qué lo dejarías en `FALSE`?

1. Compara y contrasta `separate()` y `extract()`. ¿Por qué existen tres variaciones de
separación (por posición, separador y grupos), pero solo una forma de unir?

## Valores faltantes

### Ejercicios

1. Compara y contrasta el argumento `fill` que se usa en `spread()` con `complete()`.

1. ¿Qué hace el argumento de dirección en `fill()`?

## Estudio de caso

### Ejercicios

1. En este caso de estudio fijamos `na.rm = TRUE` para simplificar la verificación de que tenemos los valores correctos. ¿Es esto razonable? Piensa en como los valores faltantes están representados en este dataset. ¿Existen valores faltantes implícitos? ¿Cuál es la diferencia entre `NA` y cero?

1. ¿Qué ocurre si omites la aplicación de `mutate()`?
 (`mutate(llave = stringr::str_replace(llave, "nuevosrecaida", "nuevos_recaida"))`)

1. Afirmamos que `iso2` e `iso3` son redundantes respecto a `pais`. Confirma esta premisa.

1. Para cada país, año y sexo calcula el total del número de casos de tuberculosis. Crea una visualización informativa de los datos.

## Datos no ordenados

Antes de pasar a otros tópicos, es conveniente referirse brevemente a datos no ordenados. Anteriormente en el capítulo, usamos el término peyorativo "desordenados" para referirnos a datos no ordenados. Esto es una sobresimplificación: existen múltiples estructuras de datos debidamente fundamentadas que no corresponden a datos ordenados. Existen dos principales razones para usar otras estructuras de datos:

* Las representaciones alternativas pueden traer ventajas importantes en términos de desempeño o tamaño.

* Algunos áreas especializadas han evolucionado y tienen sus propias convenciones para almacenar datos, las que pueden diferir respecto de las convenciones de datos ordenados.

Cada uno de estas razones significa que necesitarás algo distinto a un tibble (o data frame). Si tus datos naturalmente se ajustan a una estructura rectangular compuesta de observaciones y variables, pensamos que datos ordenados debería ser tu elección por defecto. Sin embargo, existen buenas razones para usar otras estructuras; datos ordenados no es la única forma.

Si quieres aprender más acerca de datos no ordenados, recomendamos fuertemente este artículo del blog de Jeff Leek:
 <http://simplystatistics.org/2016/02/17/non-tidy-data/>
