# Transformación de datos {#transform}

## Introducción


```r
library(tidyverse)
library(datos)
```


## 5.2 Filtrar filas con `filter()` {-#filter} 

### 5.2.4 Ejercicios{-#ejercicios-524} 


1.  Encuentra todos los vuelos que:

   1. Tuvieron un retraso de llegada de dos o más horas
 
<div class="solucion">
<h3>Solución</h3>


```r
filter(vuelos, atraso_llegada >= 120)
#> # A tibble: 10,200 × 19
#>    anio   mes   dia horario_salida salida_programada atraso_salida
#>   <int> <int> <int>          <int>             <int>         <dbl>
#> 1  2013     1     1            811               630           101
#> 2  2013     1     1            848              1835           853
#> 3  2013     1     1            957               733           144
#> 4  2013     1     1           1114               900           134
#> 5  2013     1     1           1505              1310           115
#> 6  2013     1     1           1525              1340           105
#> # … with 10,194 more rows, and 13 more variables: horario_llegada <int>,
#> #   llegada_programada <int>, atraso_llegada <dbl>, aerolinea <chr>,
#> #   vuelo <int>, codigo_cola <chr>, origen <chr>, destino <chr>,
#> #   tiempo_vuelo <dbl>, distancia <dbl>, hora <dbl>, minuto <dbl>,
#> #   fecha_hora <dttm>
```


</div>

   2. Volaron a Houston (`IAH` o` HOU`)
 
 <div class="solucion">
<h3>Solución</h3>


```r
#Opcion 1
filter(vuelos, destino %in% c("IAH", "HOU"))
#> # A tibble: 9,313 × 19
#>    anio   mes   dia horario_salida salida_programada atraso_salida
#>   <int> <int> <int>          <int>             <int>         <dbl>
#> 1  2013     1     1            517               515             2
#> 2  2013     1     1            533               529             4
#> 3  2013     1     1            623               627            -4
#> 4  2013     1     1            728               732            -4
#> 5  2013     1     1            739               739             0
#> 6  2013     1     1            908               908             0
#> # … with 9,307 more rows, and 13 more variables: horario_llegada <int>,
#> #   llegada_programada <int>, atraso_llegada <dbl>, aerolinea <chr>,
#> #   vuelo <int>, codigo_cola <chr>, origen <chr>, destino <chr>,
#> #   tiempo_vuelo <dbl>, distancia <dbl>, hora <dbl>, minuto <dbl>,
#> #   fecha_hora <dttm>

#Opción 2
filter(vuelos,destino == "IAH" | destino ==  "HOU" )
#> # A tibble: 9,313 × 19
#>    anio   mes   dia horario_salida salida_programada atraso_salida
#>   <int> <int> <int>          <int>             <int>         <dbl>
#> 1  2013     1     1            517               515             2
#> 2  2013     1     1            533               529             4
#> 3  2013     1     1            623               627            -4
#> 4  2013     1     1            728               732            -4
#> 5  2013     1     1            739               739             0
#> 6  2013     1     1            908               908             0
#> # … with 9,307 more rows, and 13 more variables: horario_llegada <int>,
#> #   llegada_programada <int>, atraso_llegada <dbl>, aerolinea <chr>,
#> #   vuelo <int>, codigo_cola <chr>, origen <chr>, destino <chr>,
#> #   tiempo_vuelo <dbl>, distancia <dbl>, hora <dbl>, minuto <dbl>,
#> #   fecha_hora <dttm>
```


</div>
   
   3. Fueron operados por United, American o Delta
  
<div class="solucion">
<h3>Solución</h3>

Los códigos de estas aerolíneas son `UA`, `AA` y `DL`.


```r
filter(vuelos, aerolinea %in% c("UA", "AA", "DL"))
#> # A tibble: 139,504 × 19
#>    anio   mes   dia horario_salida salida_programada atraso_salida
#>   <int> <int> <int>          <int>             <int>         <dbl>
#> 1  2013     1     1            517               515             2
#> 2  2013     1     1            533               529             4
#> 3  2013     1     1            542               540             2
#> 4  2013     1     1            554               600            -6
#> 5  2013     1     1            554               558            -4
#> 6  2013     1     1            558               600            -2
#> # … with 139,498 more rows, and 13 more variables: horario_llegada <int>,
#> #   llegada_programada <int>, atraso_llegada <dbl>, aerolinea <chr>,
#> #   vuelo <int>, codigo_cola <chr>, origen <chr>, destino <chr>,
#> #   tiempo_vuelo <dbl>, distancia <dbl>, hora <dbl>, minuto <dbl>,
#> #   fecha_hora <dttm>
```

</div>
 
   4. Partieron en el invierno del hemisferio sur (julio, agosto y septiembre)

<div class="solucion">
<h3>Solución</h3>


```r
filter(vuelos, mes %in% c(7, 8, 9))
#> # A tibble: 86,326 × 19
#>    anio   mes   dia horario_salida salida_programada atraso_salida
#>   <int> <int> <int>          <int>             <int>         <dbl>
#> 1  2013     7     1              1              2029           212
#> 2  2013     7     1              2              2359             3
#> 3  2013     7     1             29              2245           104
#> 4  2013     7     1             43              2130           193
#> 5  2013     7     1             44              2150           174
#> 6  2013     7     1             46              2051           235
#> # … with 86,320 more rows, and 13 more variables: horario_llegada <int>,
#> #   llegada_programada <int>, atraso_llegada <dbl>, aerolinea <chr>,
#> #   vuelo <int>, codigo_cola <chr>, origen <chr>, destino <chr>,
#> #   tiempo_vuelo <dbl>, distancia <dbl>, hora <dbl>, minuto <dbl>,
#> #   fecha_hora <dttm>
```

</div>

  
   5. Llegaron más de dos horas tarde, pero no salieron tarde

<div class="solucion">
<h3>Solución</h3>


```r
filter(vuelos, atraso_salida <= 0 & atraso_llegada > 120)
#> # A tibble: 29 × 19
#>    anio   mes   dia horario_salida salida_programada atraso_salida
#>   <int> <int> <int>          <int>             <int>         <dbl>
#> 1  2013     1    27           1419              1420            -1
#> 2  2013    10     7           1350              1350             0
#> 3  2013    10     7           1357              1359            -2
#> 4  2013    10    16            657               700            -3
#> 5  2013    11     1            658               700            -2
#> 6  2013     3    18           1844              1847            -3
#> # … with 23 more rows, and 13 more variables: horario_llegada <int>,
#> #   llegada_programada <int>, atraso_llegada <dbl>, aerolinea <chr>,
#> #   vuelo <int>, codigo_cola <chr>, origen <chr>, destino <chr>,
#> #   tiempo_vuelo <dbl>, distancia <dbl>, hora <dbl>, minuto <dbl>,
#> #   fecha_hora <dttm>
```


</div>
  
   6. Se retrasaron por lo menos una hora, pero repusieron más de 30 minutos en vuelo

<div class="solucion">
<h3>Solución</h3>

```r
filter(vuelos, atraso_salida >= 60 & atraso_salida - atraso_llegada > 30)
#> # A tibble: 1,844 × 19
#>    anio   mes   dia horario_salida salida_programada atraso_salida
#>   <int> <int> <int>          <int>             <int>         <dbl>
#> 1  2013     1     1           2205              1720           285
#> 2  2013     1     1           2326              2130           116
#> 3  2013     1     3           1503              1221           162
#> 4  2013     1     3           1839              1700            99
#> 5  2013     1     3           1850              1745            65
#> 6  2013     1     3           1941              1759           102
#> # … with 1,838 more rows, and 13 more variables: horario_llegada <int>,
#> #   llegada_programada <int>, atraso_llegada <dbl>, aerolinea <chr>,
#> #   vuelo <int>, codigo_cola <chr>, origen <chr>, destino <chr>,
#> #   tiempo_vuelo <dbl>, distancia <dbl>, hora <dbl>, minuto <dbl>,
#> #   fecha_hora <dttm>
```

</div>
   
   7. Partieron entre la medianoche y las 6 a.m. (incluyente)

<div class="solucion">
<h3>Solución</h3>


```r
filter(vuelos,horario_salida %in% c(1:600) | horario_salida == 2400 )
#> # A tibble: 9,373 × 19
#>    anio   mes   dia horario_salida salida_programada atraso_salida
#>   <int> <int> <int>          <int>             <int>         <dbl>
#> 1  2013     1     1            517               515             2
#> 2  2013     1     1            533               529             4
#> 3  2013     1     1            542               540             2
#> 4  2013     1     1            544               545            -1
#> 5  2013     1     1            554               600            -6
#> 6  2013     1     1            554               558            -4
#> # … with 9,367 more rows, and 13 more variables: horario_llegada <int>,
#> #   llegada_programada <int>, atraso_llegada <dbl>, aerolinea <chr>,
#> #   vuelo <int>, codigo_cola <chr>, origen <chr>, destino <chr>,
#> #   tiempo_vuelo <dbl>, distancia <dbl>, hora <dbl>, minuto <dbl>,
#> #   fecha_hora <dttm>
```


</div>

2.  Otra función de **dplyr** útil para usar filtros es `between()`. ¿Qué hace? ¿Puedes usarlo para simplificar el código necesario para responder a los desafíos anteriores?

<div class="solucion">
<h3>Solución</h3>

Esta función del paquete __dplyr__ permite abreviar la escritura de código que tiene esta estructura `x >= derecha & x <= izquierda` por `between(x, derecha, izquierda)`.

Podemos reescribir el código para encontrar los vuelos que partieron en el invierno del hemisferio sur así:


```r
filter(vuelos, between(mes, 7, 9))
#> # A tibble: 86,326 × 19
#>    anio   mes   dia horario_salida salida_programada atraso_salida
#>   <int> <int> <int>          <int>             <int>         <dbl>
#> 1  2013     7     1              1              2029           212
#> 2  2013     7     1              2              2359             3
#> 3  2013     7     1             29              2245           104
#> 4  2013     7     1             43              2130           193
#> 5  2013     7     1             44              2150           174
#> 6  2013     7     1             46              2051           235
#> # … with 86,320 more rows, and 13 more variables: horario_llegada <int>,
#> #   llegada_programada <int>, atraso_llegada <dbl>, aerolinea <chr>,
#> #   vuelo <int>, codigo_cola <chr>, origen <chr>, destino <chr>,
#> #   tiempo_vuelo <dbl>, distancia <dbl>, hora <dbl>, minuto <dbl>,
#> #   fecha_hora <dttm>
```

</div>


3. ¿Cuántos vuelos tienen datos faltantes de `horario_salida`? ¿Qué otras variables tienen valores faltantes? ¿Qué representan estas filas?

<div class="solucion">
<h3>Solución</h3>

Podemos buscar datos faltantes con la función `is.na`. 


```r
filter(vuelos, is.na(horario_salida))
#> # A tibble: 8,255 × 19
#>    anio   mes   dia horario_salida salida_programada atraso_salida
#>   <int> <int> <int>          <int>             <int>         <dbl>
#> 1  2013     1     1             NA              1630            NA
#> 2  2013     1     1             NA              1935            NA
#> 3  2013     1     1             NA              1500            NA
#> 4  2013     1     1             NA               600            NA
#> 5  2013     1     2             NA              1540            NA
#> 6  2013     1     2             NA              1620            NA
#> # … with 8,249 more rows, and 13 more variables: horario_llegada <int>,
#> #   llegada_programada <int>, atraso_llegada <dbl>, aerolinea <chr>,
#> #   vuelo <int>, codigo_cola <chr>, origen <chr>, destino <chr>,
#> #   tiempo_vuelo <dbl>, distancia <dbl>, hora <dbl>, minuto <dbl>,
#> #   fecha_hora <dttm>
```

Los vuelos que tienen `NA` en su horario de salida, también lo tienen en el horario de llegada, por lo que se puede inferir que son vuelos que fueron cancelados. 
</div>

4. ¿Por qué `NA ^ 0` no es faltante? ¿Por qué `NA | TRUE` no es faltante? ¿Por qué `FALSE & NA` no es faltante? ¿Puedes descubrir la regla general? (¡`NA * 0` es un contraejemplo complicado!)

<div class="solucion">
<h3>Solución</h3>



```r
x <- c(NA) 

is.na(x)
#> [1] TRUE
```

La función `is.na()` determina si falta un valor y devuelve un valor lógico `TRUE` en los casos en que es NA (Not Available). 


```r
x^0
#> [1] 1
```

Dado que el NA podría tomar cualquier valor, es práctico pensar que cualquier número (aunque sea muy grande) a la potencia cero es igual a 1.


```r
x | TRUE
#> [1] TRUE
```

Es igual a TRUE pues el NA se entiende como un valor lógico (`TRUE` or `FALSE`) y por lógica proposicional `TRUE` | `TRUE`  y  `FALSE` | `TRUE` es siempre igual a `TRUE`.


```r
x & FALSE
#> [1] FALSE
```
Es igual a `TRUE` pues el NA se entiende como un valor lógico (`TRUE` or `FALSE`) y por lógica proposicional `TRUE`&`FALSE` y `FALSE`&`FALSE` es siempre `FALSE`.

El contraejemplo a la regla general:


```r
x * 0
#> [1] NA
```


```r
Inf*0
#> [1] NaN
```

En este contraejemplo puede ser útil pensar que el `NA` puede tomar cualquier valor, incluso podría ser un número muy grande; el cual al multiplicarse por cero nos da una indeterminación que `R` define como `NaN` (Not a Number). Por otro lado, si el `NA` fuese un valor pequeño, entonces `NA*0` sería igual a cero. Luego, es mejor pensar en `x*0` como un `NA` porque no sabemos en cual de los dos casos anteriores estamos.
 
</div>


## 5.3 Reordenar las filas con `arrange()` {-#arrange} 

### 5.3.1 Ejercicios{-#ejercicios-531} 


1. ¿Cómo podrías usar `arrange()` para ordenar todos los valores faltantes al comienzo? (Sugerencia: usa `is.na()`).

<div class="solucion">
<h3>Solución</h3>


```r
arrange(vuelos,desc(is.na(tiempo_vuelo)))
#> # A tibble: 336,776 × 19
#>    anio   mes   dia horario_salida salida_programada atraso_salida
#>   <int> <int> <int>          <int>             <int>         <dbl>
#> 1  2013     1     1           1525              1530            -5
#> 2  2013     1     1           1528              1459            29
#> 3  2013     1     1           1740              1745            -5
#> 4  2013     1     1           1807              1738            29
#> 5  2013     1     1           1939              1840            59
#> 6  2013     1     1           1952              1930            22
#> # … with 336,770 more rows, and 13 more variables: horario_llegada <int>,
#> #   llegada_programada <int>, atraso_llegada <dbl>, aerolinea <chr>,
#> #   vuelo <int>, codigo_cola <chr>, origen <chr>, destino <chr>,
#> #   tiempo_vuelo <dbl>, distancia <dbl>, hora <dbl>, minuto <dbl>,
#> #   fecha_hora <dttm>
```

Se usa la variable `tiempo_vuelo` porque es la que contiene mayor número de NA´s. 

</div>

2. Ordena `vuelos` para encontrar los vuelos más retrasados. Encuentra los vuelos que salieron más temprano.

<div class="solucion">
<h3>Solución</h3>

Vuelos que salieron con más retraso

```r
arrange(vuelos, desc(atraso_salida))
#> # A tibble: 336,776 × 19
#>    anio   mes   dia horario_salida salida_programada atraso_salida
#>   <int> <int> <int>          <int>             <int>         <dbl>
#> 1  2013     1     9            641               900          1301
#> 2  2013     6    15           1432              1935          1137
#> 3  2013     1    10           1121              1635          1126
#> 4  2013     9    20           1139              1845          1014
#> 5  2013     7    22            845              1600          1005
#> 6  2013     4    10           1100              1900           960
#> # … with 336,770 more rows, and 13 more variables: horario_llegada <int>,
#> #   llegada_programada <int>, atraso_llegada <dbl>, aerolinea <chr>,
#> #   vuelo <int>, codigo_cola <chr>, origen <chr>, destino <chr>,
#> #   tiempo_vuelo <dbl>, distancia <dbl>, hora <dbl>, minuto <dbl>,
#> #   fecha_hora <dttm>
```

Vuelos que salieron más temprano

```r
arrange(vuelos, atraso_salida)
#> # A tibble: 336,776 × 19
#>    anio   mes   dia horario_salida salida_programada atraso_salida
#>   <int> <int> <int>          <int>             <int>         <dbl>
#> 1  2013    12     7           2040              2123           -43
#> 2  2013     2     3           2022              2055           -33
#> 3  2013    11    10           1408              1440           -32
#> 4  2013     1    11           1900              1930           -30
#> 5  2013     1    29           1703              1730           -27
#> 6  2013     8     9            729               755           -26
#> # … with 336,770 more rows, and 13 more variables: horario_llegada <int>,
#> #   llegada_programada <int>, atraso_llegada <dbl>, aerolinea <chr>,
#> #   vuelo <int>, codigo_cola <chr>, origen <chr>, destino <chr>,
#> #   tiempo_vuelo <dbl>, distancia <dbl>, hora <dbl>, minuto <dbl>,
#> #   fecha_hora <dttm>
```

</div>

3. Ordena `vuelos` para encontrar los vuelos más rápidos.

<div class="solucion">
<h3>Solución</h3>

Si se considera que la velocidad es igual a `distancia`/`tiempo_vuelo` (distancia recorrida por minuto).

Los datos ordenados de forma descendente nos dará como resultado los vuelos más rápidos primero.


```r
arrange(vuelos,desc(distancia/tiempo_vuelo))
#> # A tibble: 336,776 × 19
#>    anio   mes   dia horario_salida salida_programada atraso_salida
#>   <int> <int> <int>          <int>             <int>         <dbl>
#> 1  2013     5    25           1709              1700             9
#> 2  2013     7     2           1558              1513            45
#> 3  2013     5    13           2040              2025            15
#> 4  2013     3    23           1914              1910             4
#> 5  2013     1    12           1559              1600            -1
#> 6  2013    11    17            650               655            -5
#> # … with 336,770 more rows, and 13 more variables: horario_llegada <int>,
#> #   llegada_programada <int>, atraso_llegada <dbl>, aerolinea <chr>,
#> #   vuelo <int>, codigo_cola <chr>, origen <chr>, destino <chr>,
#> #   tiempo_vuelo <dbl>, distancia <dbl>, hora <dbl>, minuto <dbl>,
#> #   fecha_hora <dttm>
```

</div>

4. ¿Cuáles vuelos viajaron más lejos? ¿Cuál viajó menos cerca?

<div class="solucion">
<h3>Solución</h3>

Vuelos que viajaron más lejos (considerando la distancia en millas entre aeropuertos):

```r
arrange(vuelos,desc(distancia))
#> # A tibble: 336,776 × 19
#>    anio   mes   dia horario_salida salida_programada atraso_salida
#>   <int> <int> <int>          <int>             <int>         <dbl>
#> 1  2013     1     1            857               900            -3
#> 2  2013     1     2            909               900             9
#> 3  2013     1     3            914               900            14
#> 4  2013     1     4            900               900             0
#> 5  2013     1     5            858               900            -2
#> 6  2013     1     6           1019               900            79
#> # … with 336,770 more rows, and 13 more variables: horario_llegada <int>,
#> #   llegada_programada <int>, atraso_llegada <dbl>, aerolinea <chr>,
#> #   vuelo <int>, codigo_cola <chr>, origen <chr>, destino <chr>,
#> #   tiempo_vuelo <dbl>, distancia <dbl>, hora <dbl>, minuto <dbl>,
#> #   fecha_hora <dttm>
```

Vuelos que viajaron más cerca (considerando la distancia en millas entre aeropuertos):

```r
arrange(vuelos,distancia)
#> # A tibble: 336,776 × 19
#>    anio   mes   dia horario_salida salida_programada atraso_salida
#>   <int> <int> <int>          <int>             <int>         <dbl>
#> 1  2013     7    27             NA               106            NA
#> 2  2013     1     3           2127              2129            -2
#> 3  2013     1     4           1240              1200            40
#> 4  2013     1     4           1829              1615           134
#> 5  2013     1     4           2128              2129            -1
#> 6  2013     1     5           1155              1200            -5
#> # … with 336,770 more rows, and 13 more variables: horario_llegada <int>,
#> #   llegada_programada <int>, atraso_llegada <dbl>, aerolinea <chr>,
#> #   vuelo <int>, codigo_cola <chr>, origen <chr>, destino <chr>,
#> #   tiempo_vuelo <dbl>, distancia <dbl>, hora <dbl>, minuto <dbl>,
#> #   fecha_hora <dttm>
```

</div>


## 5.4 Seleccionar columnas con `select()` {-#select}


### 5.4.1 Ejercicios{-#ejercicios-541} 

1. Haz una lluvia de ideas de tantas maneras como sea posible para seleccionar `horario_salida`,` atraso_salida`,`horario_llegada`, y` atraso_llegada` de `vuelos`.

<div class="solucion">
<h3>Solución</h3>

Una primera opción sería seleccionaras por su nombre:

```r
select(vuelos, horario_salida, atraso_salida, horario_llegada, atraso_llegada)
#> # A tibble: 336,776 × 4
#>   horario_salida atraso_salida horario_llegada atraso_llegada
#>            <int>         <dbl>           <int>          <dbl>
#> 1            517             2             830             11
#> 2            533             4             850             20
#> 3            542             2             923             33
#> 4            544            -1            1004            -18
#> 5            554            -6             812            -25
#> 6            554            -4             740             12
#> # … with 336,770 more rows
```

Otra forma es seleccionando las variables que empiezan con "horario" y "atraso" con la función `starts_with()` ("empieza con") del paquete __dplyr__:


```r
select(vuelos, starts_with("horario"), starts_with("atraso"))
#> # A tibble: 336,776 × 4
#>   horario_salida horario_llegada atraso_salida atraso_llegada
#>            <int>           <int>         <dbl>          <dbl>
#> 1            517             830             2             11
#> 2            533             850             4             20
#> 3            542             923             2             33
#> 4            544            1004            -1            -18
#> 5            554             812            -6            -25
#> 6            554             740            -4             12
#> # … with 336,770 more rows
```

También es útil en este caso utilizar la función `ends_with()`:

```r
select(vuelos,ends_with("llegada"),ends_with("salida"))
#> # A tibble: 336,776 × 4
#>   horario_llegada atraso_llegada horario_salida atraso_salida
#>             <int>          <dbl>          <int>         <dbl>
#> 1             830             11            517             2
#> 2             850             20            533             4
#> 3             923             33            542             2
#> 4            1004            -18            544            -1
#> 5             812            -25            554            -6
#> 6             740             12            554            -4
#> # … with 336,770 more rows
```

Y una manera adicional es usando la función `contains()`:

```r
select(vuelos,contains("horario"),contains("atraso"))
#> # A tibble: 336,776 × 4
#>   horario_salida horario_llegada atraso_salida atraso_llegada
#>            <int>           <int>         <dbl>          <dbl>
#> 1            517             830             2             11
#> 2            533             850             4             20
#> 3            542             923             2             33
#> 4            544            1004            -1            -18
#> 5            554             812            -6            -25
#> 6            554             740            -4             12
#> # … with 336,770 more rows
```


</div>

2. ¿Qué sucede si incluyes el nombre de una variable varias veces en una llamada `select()`?

<div class="solucion">
<h3>Solución</h3>
A diferencia de lo que podría pensarse inicialmente, aunque se incluya más de una vez una variable al utilizar `select()` esta solo se considerará una vez:

```r
select(vuelos, horario_salida, horario_salida, horario_salida)
#> # A tibble: 336,776 × 1
#>   horario_salida
#>            <int>
#> 1            517
#> 2            533
#> 3            542
#> 4            544
#> 5            554
#> 6            554
#> # … with 336,770 more rows
```

</div>

3. ¿Qué hace la función `one_of()`? ¿Por qué podría ser útil en conjunto con este vector?


```r
vars <- c ("anio", "mes", "dia", "atraso_salida", "atraso_llegada")
```

<div class="solucion">
<h3>Solución</h3>

Con la función `one_of()` podemos indicar las variables que queremos seleccionar con el nombre del vector que las contiene.

La función `one_of()` selecciona todas las variables que están en el vector `vars`:


```r
select(vuelos, one_of(vars))
#> # A tibble: 336,776 × 5
#>    anio   mes   dia atraso_salida atraso_llegada
#>   <int> <int> <int>         <dbl>          <dbl>
#> 1  2013     1     1             2             11
#> 2  2013     1     1             4             20
#> 3  2013     1     1             2             33
#> 4  2013     1     1            -1            -18
#> 5  2013     1     1            -6            -25
#> 6  2013     1     1            -4             12
#> # … with 336,770 more rows
```

Sin embargo, es posible también hacerlo de la siguiente forma (Siempre y cuando no exista una variable que se llame `vars` en el set de datos):


```r
select(vuelos,vars)
#> Note: Using an external vector in selections is ambiguous.
#> ℹ Use `all_of(vars)` instead of `vars` to silence this message.
#> ℹ See <https://tidyselect.r-lib.org/reference/faq-external-vector.html>.
#> This message is displayed once per session.
#> # A tibble: 336,776 × 5
#>    anio   mes   dia atraso_salida atraso_llegada
#>   <int> <int> <int>         <dbl>          <dbl>
#> 1  2013     1     1             2             11
#> 2  2013     1     1             4             20
#> 3  2013     1     1             2             33
#> 4  2013     1     1            -1            -18
#> 5  2013     1     1            -6            -25
#> 6  2013     1     1            -4             12
#> # … with 336,770 more rows
```

</div>

4. ¿Te sorprende el resultado de ejecutar el siguiente código? ¿Cómo tratan por defecto las funciones auxiliares de `select()` a las palabras en mayúsculas o en minúsculas? ¿Cómo puedes cambiar ese comportamiento predeterminado?


```r
select(vuelos, contains("SALIDA"))
```

<div class="solucion">
<h3>Solución</h3>
La función `contains()` ("contiene") no distingue entre mayúsculas y minúsculas, por eso puede identificar sin problema todas las variables que contienen "salida". Si queremos cambiar este comportamiento y que sí las diferencie, entonces debemos agregar el argumento `ignore.case = FALSE` (por defecto, es TRUE):


```r
select(vuelos, contains("SALIDA", ignore.case = FALSE))
#> # A tibble: 336,776 × 0
```

</div>


## 5.5 Añadir nuevas variables con `mutate()` {-#mutate} 


### 5.5.2 Ejercicios{-#ejercicios-552} 



1. Las variables `horario_salida` y `salida_programada` tienen un formato conveniente para leer, pero es difícil realizar cualquier cálculo con ellas porque no son realmente números continuos. Transfórmalas a un formato más conveniente, como número de minutos desde la medianoche.

<div class="solucion">
<h3>Solución</h3>
Los datos de estas variables son de tal forma que las 6:59 AM toman el valor 659. Luego, el número de horas desde la media noche es:


```r
659%/%100 #division entera
#> [1] 6
```
La cantidad de minutos en esas 6 horas:


```r
659%/%100 *60
#> [1] 360
```

Solo queda sumar los 59 minutos:


```r
659 %% 100 #resto
#> [1] 59
```

Entonces, el número de minutos transcurridos desde las 00:00 hasta las 6:59 AM son:


```r
659 %/% 100 * 60 + 659 %% 100 
#> [1] 419
```

Sin embargo, la medianoche toma el valor 24:00 con lo cual el número de minutos desde la medianoche es 1440 en lugar de 0. Para resolver esto usamos nuevamente `%%`.


```r
(659 %/% 100 * 60 + 659 %% 100) %% 1440 #mismo resultado anterior
#> [1] 419

(2400 %/% 100 * 60 + 2400 %% 100) %% 1440 #cero minutos desde la medianoche
#> [1] 0
```


```r
mutate(vuelos, salida_programada_min = (salida_programada %/% 100 * 60 + salida_programada %% 100) %% 1440)
#> # A tibble: 336,776 × 20
#>    anio   mes   dia horario_salida salida_programada atraso_salida
#>   <int> <int> <int>          <int>             <int>         <dbl>
#> 1  2013     1     1            517               515             2
#> 2  2013     1     1            533               529             4
#> 3  2013     1     1            542               540             2
#> 4  2013     1     1            544               545            -1
#> 5  2013     1     1            554               600            -6
#> 6  2013     1     1            554               558            -4
#> # … with 336,770 more rows, and 14 more variables: horario_llegada <int>,
#> #   llegada_programada <int>, atraso_llegada <dbl>, aerolinea <chr>,
#> #   vuelo <int>, codigo_cola <chr>, origen <chr>, destino <chr>,
#> #   tiempo_vuelo <dbl>, distancia <dbl>, hora <dbl>, minuto <dbl>,
#> #   fecha_hora <dttm>, salida_programada_min <dbl>

mutate(vuelos, horario_salida_min = (horario_salida %/% 100 * 60 + horario_salida %% 100) %% 1440)
#> # A tibble: 336,776 × 20
#>    anio   mes   dia horario_salida salida_programada atraso_salida
#>   <int> <int> <int>          <int>             <int>         <dbl>
#> 1  2013     1     1            517               515             2
#> 2  2013     1     1            533               529             4
#> 3  2013     1     1            542               540             2
#> 4  2013     1     1            544               545            -1
#> 5  2013     1     1            554               600            -6
#> 6  2013     1     1            554               558            -4
#> # … with 336,770 more rows, and 14 more variables: horario_llegada <int>,
#> #   llegada_programada <int>, atraso_llegada <dbl>, aerolinea <chr>,
#> #   vuelo <int>, codigo_cola <chr>, origen <chr>, destino <chr>,
#> #   tiempo_vuelo <dbl>, distancia <dbl>, hora <dbl>, minuto <dbl>,
#> #   fecha_hora <dttm>, horario_salida_min <dbl>
```


</div>

2. Compara `tiempo_vuelo` con `horario_llegada - horario_salida`. ¿Qué esperas ver? ¿Qué ves? ¿Qué necesitas hacer para arreglarlo?

<div class="solucion">
<h3>Solución</h3>
Lo que se espera es que `tiempo_vuelo` = `horario_llegada` - `horario_salida`.

</div>

3. Compara `horario_salida`, `salida_programada`, y `atraso_salida`. ¿Cómo esperarías que esos tres números estén relacionados?

<div class="solucion">
<h3>Solución</h3>

</div>

4. Encuentra los 10 vuelos más retrasados utilizando una función de ordenamiento. ¿Cómo quieres manejar los empates? Lee atentamente la documentación de `min_rank()`.

<div class="solucion">
<h3>Solución</h3>

</div>

5. ¿Qué devuelve `1:3 + 1:10`? ¿Por qué?

<div class="solucion">
<h3>Solución</h3>

</div>

6. ¿Qué funciones trigonométricas proporciona R?

<div class="solucion">
<h3>Solución</h3>

</div>

## 5.6 Resúmenes agrupados con `summarise()` {-#sumamarise} 

### 5.6.7 Ejercicios{-#ejercicios-567} 


1.   Haz una lluvia de ideas de al menos 5 formas diferentes de evaluar las características de un retraso típico de un grupo de vuelos. Considera los siguientes escenarios:
 
    *Un vuelo llega 15 minutos antes 50% del tiempo, y 15 minutos tarde 50% del tiempo.

    *Un vuelo llega siempre 10 minutos tarde.

    *Un vuelo llega 30 minutos antes 50% del tiempo, y 30 minutos tarde 50% del tiempo.

    *Un vuelo llega a tiempo en el 99% de los casos. 1% de las veces llega 2 horas tarde.
    
    ¿Qué es más importante: retraso de la llegada o demora de salida?

<div class="solucion">
<h3>Solución</h3>

</div>


2.  Sugiere un nuevo enfoque que te dé el mismo *output* que `no_cancelados %>% count(destino)` y
`no_cancelado %>% count(codigo_cola, wt = distancia)` (sin usar `count()`).

<div class="solucion">
<h3>Solución</h3>

</div>

3.  Nuestra definición de vuelos cancelados (`is.na(atraso_salida) | is.na (atraso_llegada)`) es un poco subóptima. ¿Por qué? ¿Cuál es la columna más importante?

<div class="solucion">
<h3>Solución</h3>

</div>

4. Mira la cantidad de vuelos cancelados por día. ¿Hay un patrón? ¿La proporción de vuelos cancelados está relacionada con el retraso promedio?

<div class="solucion">
<h3>Solución</h3>

</div>

5. ¿Qué compañía tiene los peores retrasos? Desafío: ¿puedes desenredar el efecto de malos aeropuertos vs. el efecto de malas aerolíneas? ¿Por qué o por qué no? (Sugerencia: piensa en `vuelos %>% group_by(aerolinea, destino) %>% summarise(n())`)

<div class="solucion">
<h3>Solución</h3>

</div>

6. ¿Qué hace el argumento `sort` a `count()`. ¿Cuándo podrías usarlo?

<div class="solucion">
<h3>Solución</h3>

</div>

## 5.7 Transformaciones agrupadas (y filtros) {-#mutate-filter}

### 5.7.1 Ejercicios {-#ejercicios-571}

1. Remítete a las listas de funciones útiles de mutación y filtrado. Describe cómo cambia cada operación cuando las combinas con la agrupación.

<div class="solucion">
<h3>Solución</h3>

</div>

2. ¿Qué avión (`codigo_cola`) tiene el peor registro de tiempo?

<div class="solucion">
<h3>Solución</h3>

</div>

3. ¿A qué hora del día deberías volar si quieres evitar los retrasos lo más posible?

<div class="solucion">
<h3>Solución</h3>

</div>

4. Para cada destino, calcula los minutos totales de demora. Para cada vuelo, calcula la proporción de la demora total para su destino.

<div class="solucion">
<h3>Solución</h3>

</div>

5. Los retrasos suelen estar temporalmente correlacionados: incluso una vez que el problema que causó el retraso inicial se ha resuelto, los vuelos posteriores se retrasan para permitir que salgan los vuelos anteriores. Usando `lag()`, explora cómo el retraso de un vuelo está relacionado con el retraso del vuelo inmediatamente anterior.

<div class="solucion">
<h3>Solución</h3>

</div>

6. Mira cada destino. ¿Puedes encontrar vuelos sospechosamente rápidos? (es decir, vuelos que representan un posible error de entrada de datos). Calcula el tiempo en el aire de un vuelo relativo al vuelo más corto a ese destino. ¿Cuáles vuelos se retrasaron más en el aire?

<div class="solucion">
<h3>Solución</h3>

</div>

7. Encuentra todos los destinos que son volados por al menos dos operadores. Usa esta información para clasificar a las aerolíneas.

<div class="solucion">
<h3>Solución</h3>

</div>

8. Para cada avión, cuenta el número de vuelos antes del primer retraso de más de 1 hora.

<div class="solucion">
<h3>Solución</h3>

</div>
