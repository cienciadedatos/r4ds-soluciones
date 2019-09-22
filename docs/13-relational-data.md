# Datos relacionales

## Paquetes necesarios


```r
library(dplyr)
library(ggplot2)
library(datos)
```

## datos {#nycflights13-relational}

### Ejercicios

1. Imagina que necesitas dibujar (aproximadamente) la ruta que cada avión vuela 
 desde su origen hasta el destino. ¿Qué variables necesitas? ¿Qué tablas
 necesitas combinar?

<div class="solucion">
<h3>Solución</h3>

Necesitas combinar `aeropuertos` con `vuelos` ya que el dataset `aeropuertos` 
con tiene las coordenadas de los aeropuertos. Puedes unir las tablas por medio
de la variable `codigo_aeropuerto` en `aeropuertos` y `origen` y `destino` en
`vuelos`.


```r
vuelos %>%
  left_join(aeropuertos, by = c("origen" = "codigo_aeropuerto",
                                "destino" = "codigo_aeropuerto"))
```

```
## # A tibble: 336,776 x 26
##     anio   mes   dia horario_salida salida_programa… atraso_salida
##    <int> <int> <int>          <int>            <int>         <dbl>
##  1  2013     1     1            517              515             2
##  2  2013     1     1            533              529             4
##  3  2013     1     1            542              540             2
##  4  2013     1     1            544              545            -1
##  5  2013     1     1            554              600            -6
##  6  2013     1     1            554              558            -4
##  7  2013     1     1            555              600            -5
##  8  2013     1     1            557              600            -3
##  9  2013     1     1            557              600            -3
## 10  2013     1     1            558              600            -2
## # … with 336,766 more rows, and 20 more variables: horario_llegada <int>,
## #   llegada_programada <int>, atraso_llegada <dbl>, aerolinea <chr>,
## #   vuelo <int>, codigo_cola <chr>, origen <chr>, destino <chr>,
## #   tiempo_vuelo <dbl>, distancia <dbl>, hora <dbl>, minuto <dbl>,
## #   fecha_hora <dttm>, nombre <chr>, latitud <dbl>, longitud <dbl>,
## #   altura <int>, zona_horaria <dbl>, horario_verano <chr>,
## #   zona_horaria_iana <chr>
```
</div>

1. Olvidamos incluir la relación entre `clima` y `aeropuertos`. ¿Cuál es la
 relación y cómo debe aparecer en el diagrama?

<div class="solucion">
<h3>Solución</h3>

De manera similar al ejercicio anterior, se pueden unir mediante
`codigo_aeropuerto` en `aeropuertos` y `origen` en `clima`.
</div>

1. `clima` únicamente contiene información de los aeropuertos de origen 
 (Nueva York). Si contuviera registros para todos los aeropuertos de EEUU, ¿Qué
 relación tendría con `vuelos`?

<div class="solucion">
<h3>Solución</h3>

Puedes conectar `clima` con `vuelos` usando la columna `destino` e incluir el
clima de los aeropuertos de EEUU que están presentes en la tabla `vuelos`.
</div>

1. Sabemos que hay días "especiales" en el año y pocas personas vuelan esos
 días. ¿Cómo se representarían en un data frame? ¿Cuáles serían las llaves
 primarias de esa tabla? ¿Cómo se conectaría con las tablas existentes?
   
<div class="solucion">
<h3>Solución</h3>

Una posibilidad es contar con un dataset de los días festivos en EEUU indicando
mes y día. Esta información se puede unir con cada vuelo en la tabla `vuelos` y
y a la vez con el dataset `clima`.
</div>

## Llaves

### Ejercicios

1. Agrega una llave sustituta a `vuelos`.

<div class="solucion">
<h3>Solución</h3>


```r
vuelos %>%
  mutate(id = row_number(anio)) %>%
  select(id, everything())
```

```
## # A tibble: 336,776 x 20
##       id  anio   mes   dia horario_salida salida_programa… atraso_salida
##    <int> <int> <int> <int>          <int>            <int>         <dbl>
##  1     1  2013     1     1            517              515             2
##  2     2  2013     1     1            533              529             4
##  3     3  2013     1     1            542              540             2
##  4     4  2013     1     1            544              545            -1
##  5     5  2013     1     1            554              600            -6
##  6     6  2013     1     1            554              558            -4
##  7     7  2013     1     1            555              600            -5
##  8     8  2013     1     1            557              600            -3
##  9     9  2013     1     1            557              600            -3
## 10    10  2013     1     1            558              600            -2
## # … with 336,766 more rows, and 13 more variables: horario_llegada <int>,
## #   llegada_programada <int>, atraso_llegada <dbl>, aerolinea <chr>,
## #   vuelo <int>, codigo_cola <chr>, origen <chr>, destino <chr>,
## #   tiempo_vuelo <dbl>, distancia <dbl>, hora <dbl>, minuto <dbl>,
## #   fecha_hora <dttm>
```
</div>

1. Identifica las llaves en los siguientes conjuntos de datos

 1. `datos::bateadores`
 1. `datos::nombres`
 1. `datos::atmosfera`
 1. `datos::vehiculos`
 1. `datos::diamantes`
  
 (Puede que necesites leer un poco de documentación.)

<div class="solucion">
<h3>Solución</h3>

 1. En `datos::bateadores` corresponde a `id_jugador`.
 1. En `datos::nombres` corresponde a la combinación de `anio` y `nombre`,
  con esto se puede unir cada par año-nombre con las otras tablas.
 1. En `datos::atmosfera` corresponde a  latitud`, `longitud`, `anio` y `mes`,
  lo cual identifica de manera única un lugar en el tiempo.
 1. En `datos::vehiculos` corresponde a `id`.
 1. En `datos::diamantes` no hay llaves ya que estas tienen sentido en datos
 relacionales, es decir cuando existen otras tablas para combinar información.
</div>

1. Dibuja un diagrama que ilustre las conexiones entre las tablas `bateadores`,
  `personas` y `salarios` en el paquete datos. Dibuja otro diagrama que muestre la
  relación entre `personas`, `dirigentes` y `premios_dirigentes`.

  ¿Cómo caracterizarías las relación entre `bateadores`, `lanzadores` y `fildeo`?

<div class="solucion">
<h3>Solución</h3>

Es directo. Las tres tablas contienen los campos `id_jugador` y `anio` y cada
tabla contiene información que complementa las demás. La relación es uno a uno.
</div>

## Uniones de transformación {#mutating-joins}

### Ejercicios

1. Calcula el atraso promedio por destino, luego une los datos en `aeropuertos` 
   para que puedas mostrar la distribución espacial de los atrasos. Te presentamos 
   una forma fácil de dibujar un mapa de los Estados Unidos:

 
 ```r
 aeropuertos %>%
  semi_join(vuelos, c("codigo_aeropuerto" = "destino")) %>%
  ggplot(aes(longitud, latitud)) +
  borders("state") +
  geom_point() +
  coord_quickmap()
 ```

  (No te preocupes si no entiendes que hace `semi_join()`. 
  Lo aprenderás a continuación.)
  
  Quizás quieras usar `size` o `colour` para editar los puntos y mostrar 
  el atraso promedio de cada aeropuerto.
  
<div class="solucion">
<h3>Solución</h3>

```r
atraso_promedio_destino <- vuelos %>%
   group_by(destino) %>%
   # los vuelos con NA en atraso_llegada son vuelos cancelados
   summarise(atraso = mean(atraso_llegada, na.rm = TRUE)) %>%
   inner_join(aeropuertos, by = c(destino = "codigo_aeropuerto"))
```


```r
atraso_promedio_destino %>%
  ggplot(aes(longitud, latitud, colour = atraso)) +
  borders("state") +
  geom_point() +
  coord_quickmap()
```

<img src="13-relational-data_files/figure-html/unnamed-chunk-6-1.png" width="672" />
</div>
 
1. Agrega la ubicación de origen _y_ destino (e.g. `latitud` y `longitud`) 
   a `vuelos`.

<div class="solucion">
<h3>Solución</h3>

Es posible realizar varias uniones. Si hay variables duplicadas, dplyr va a
distinguirlas agregando `.x` y `.y` al nombre de la variable para resolver
los nombres duplicados.


```r
ubicacion_aeropuertos <- aeropuertos %>%
  select(codigo_aeropuerto, latitud, longitud)

vuelos %>%
  select(anio:dia, hora, origen, destino) %>%
  left_join(
    ubicacion_aeropuertos,
    by = c("origen" = "codigo_aeropuerto")
  ) %>%
  left_join(
    ubicacion_aeropuertos,
    by = c("destino" = "codigo_aeropuerto")
  )
```

```
## # A tibble: 336,776 x 10
##     anio   mes   dia  hora origen destino latitud.x longitud.x latitud.y
##    <int> <int> <int> <dbl> <chr>  <chr>       <dbl>      <dbl>     <dbl>
##  1  2013     1     1     5 EWR    IAH          40.7      -74.2      30.0
##  2  2013     1     1     5 LGA    IAH          40.8      -73.9      30.0
##  3  2013     1     1     5 JFK    MIA          40.6      -73.8      25.8
##  4  2013     1     1     5 JFK    BQN          40.6      -73.8      NA  
##  5  2013     1     1     6 LGA    ATL          40.8      -73.9      33.6
##  6  2013     1     1     5 EWR    ORD          40.7      -74.2      42.0
##  7  2013     1     1     6 EWR    FLL          40.7      -74.2      26.1
##  8  2013     1     1     6 LGA    IAD          40.8      -73.9      38.9
##  9  2013     1     1     6 JFK    MCO          40.6      -73.8      28.4
## 10  2013     1     1     6 LGA    ORD          40.8      -73.9      42.0
## # … with 336,766 more rows, and 1 more variable: longitud.y <dbl>
```

Es una buena práctica tener nombres indicativos para las variables. Usaremos
el sufijo `_destino` y `_origen` para especificar a qué aeropuerto nos referimos.


```r
vuelos %>%
  select(anio:dia, hora, origen, destino) %>%
  left_join(
    ubicacion_aeropuertos,
    by = c("origen" = "codigo_aeropuerto")
  ) %>%
  left_join(
    ubicacion_aeropuertos,
    by = c("destino" = "codigo_aeropuerto"),
    suffix = c("_origen", "_destino")
  )
```

```
## # A tibble: 336,776 x 10
##     anio   mes   dia  hora origen destino latitud_origen longitud_origen
##    <int> <int> <int> <dbl> <chr>  <chr>            <dbl>           <dbl>
##  1  2013     1     1     5 EWR    IAH               40.7           -74.2
##  2  2013     1     1     5 LGA    IAH               40.8           -73.9
##  3  2013     1     1     5 JFK    MIA               40.6           -73.8
##  4  2013     1     1     5 JFK    BQN               40.6           -73.8
##  5  2013     1     1     6 LGA    ATL               40.8           -73.9
##  6  2013     1     1     5 EWR    ORD               40.7           -74.2
##  7  2013     1     1     6 EWR    FLL               40.7           -74.2
##  8  2013     1     1     6 LGA    IAD               40.8           -73.9
##  9  2013     1     1     6 JFK    MCO               40.6           -73.8
## 10  2013     1     1     6 LGA    ORD               40.8           -73.9
## # … with 336,766 more rows, and 2 more variables: latitud_destino <dbl>,
## #   longitud_destino <dbl>
```
</div>

1. ¿Existe una relación entre la antiguedad de un avión y sus atrasos?

<div class="solucion">
<h3>Solución</h3>

Ya que no se indica si se refiere a atrasos de salida o llegada, se explorará
el atraso en la salida, quedando el otro caso como ejercicio.

Para comparar la antiguedad de un avión con sus atrasos, hay que unir
`vuelos` con `aviones`, esta última tabla contiene la variable `anio` que se
refiere al año de fabricación del avión.

Dado que hay pocos aviones de más de 25 años, truncaremos los datos y luego
vamos a calcular el promedio de llegada y salida dada la antiguedad.


```r
atrasos_por_antiguedad <- inner_join(vuelos,
   select(aviones, codigo_cola, anio_fabricacion = anio), by = "codigo_cola") %>%
   mutate(antiguedad = anio - anio_fabricacion) %>%
   filter(!is.na(antiguedad)) %>%
   mutate(antiguedad = if_else(antiguedad > 25, 25L, antiguedad)) %>%
   group_by(antiguedad) %>%
   summarise(
      prom_atraso_salida = mean(atraso_salida, na.rm = TRUE),
      desv_est_atraso_salida = sd(atraso_salida, na.rm = TRUE),
      nro_vuelos_atrasados_salida = sum(!is.na(atraso_salida))
   )
```

Ahora podemos explorar la reglación entre los atrasos en la salida y la
antiguedad.

El atraso en la salida es creciente en relación a la antiguedad para los
aviones de hasta de 10 años. Luego este atraso decae.

La reducción de los atrasos en la salida en relación a la antiguedad puede
deberse a que en los aviones más antiguos se planfica la mantención para evitar
tales atrasos y desperfectos mecánicos.


```r
ggplot(atrasos_por_antiguedad, aes(x = antiguedad, y = prom_atraso_salida)) +
  geom_point() +
  scale_x_continuous("Antiguedad del avión (años)", breaks = seq(0, 30, by = 10)) +
  scale_y_continuous("Atraso promedio en la salida (minutos)")
```

<img src="13-relational-data_files/figure-html/unnamed-chunk-10-1.png" width="672" />
</div>

1. ¿Qué condiciones climáticas hacen más probables los atrasos?

<div class="solucion">
<h3>Solución</h3>

Las lluvias están asociadas con los atrasos. Sin embargo, para un nivel 
mayor a 0.02 pulgadas de lluvia no hay una tendencia fuerte.


```r
vuelo_clima <- vuelos %>%
  inner_join(clima, by = c(
    "origen",
    "anio",
    "mes",
    "dia",
    "hora"
  ))

vuelo_clima %>%
  group_by(precipitacion) %>%
  summarise(atraso = mean(atraso_salida, na.rm = TRUE)) %>%
  ggplot(aes(x = precipitacion, y = atraso)) +
  geom_line() +
  geom_point()
```

<img src="13-relational-data_files/figure-html/unnamed-chunk-11-1.png" width="672" />
</div>

1. ¿Qué sucedió el día 13 de junio de 2013? Muestra el patrón espacial de los atrasos, 
   luego usa un buscador para encontrar referencias cruzadas con el clima.

 

<div class="solucion">
<h3>Solución</h3>

Hubo una serie de tormentas en el sureste de los EEUU (consulta la [Wikipedia](https://en.wikipedia.org/wiki/June_12%E2%80%9313,_2013_derecho_series)).

El siguiente gráfico muestra que los mayores atrasos se presentaron en
Tennessee (Nashville), el sureste y medio oeste es donde ocurrieron las
tormentas.


```r
vuelos %>%
  filter(anio == 2013, mes == 6, dia == 13) %>%
  group_by(destino) %>%
  summarise(atraso = mean(atraso_salida, na.rm = TRUE)) %>%
  inner_join(aeropuertos, by = c("destino" = "codigo_aeropuerto")) %>%
  ggplot(aes(y = latitud, x = longitud, size = atraso, colour = atraso)) +
  borders("state") +
  geom_point() +
  coord_quickmap() +
  scale_colour_viridis_c()
```

```
## Warning: Removed 3 rows containing missing values (geom_point).
```

<img src="13-relational-data_files/figure-html/unnamed-chunk-13-1.png" width="672" />
</div>

## Uniones de filtro {#filtering-joins}

### Ejercicios

1. ¿Qué significa que un vuelo no tenga `codigo_cola`? ¿Qué tienen en común los códigos 
   de cola que no tienen registros coincidentes en `aviones`? (Pista: Una variable explica 
   ~90% de los problemas.)

<div class="solucion">
<h3>Solución</h3>

Los vuelos que no registran código cola tampoco registran hora de llegada, por
lo que son vuelos cancelados.


```r
vuelos %>%
  filter(is.na(codigo_cola), !is.na(horario_llegada)) %>%
  nrow()
```

```
## [1] 0
```

Muchos de los vuelos sin código cola en `aviones` pertenecen a
American Airlines (AA) o Envoy Airlines (EQ) como se detalla en la documentación.


```r
vuelos %>%
  anti_join(aviones, by = "codigo_cola") %>%
  count(aerolinea, sort = TRUE) %>%
  mutate(p = n / sum(n))
```

```
## # A tibble: 10 x 3
##    aerolinea     n        p
##    <chr>     <int>    <dbl>
##  1 MQ        25397 0.483   
##  2 AA        22558 0.429   
##  3 UA         1693 0.0322  
##  4 9E         1044 0.0198  
##  5 B6          830 0.0158  
##  6 US          699 0.0133  
##  7 FL          187 0.00355 
##  8 DL          110 0.00209 
##  9 F9           50 0.000950
## 10 WN           38 0.000722
```

Sin embargo, no todos los códigos que aparecen en `vuelos` están perdidos en
`aviones`.


```r
vuelos %>%
  distinct(aerolinea, codigo_cola) %>%
  left_join(aviones, by = "codigo_cola") %>%
  group_by(aerolinea) %>%
  summarise(total_aviones = n(),
            faltan_en_aviones = sum(is.na(modelo))) %>%
  mutate(porcentaje_perdidos = faltan_en_aviones / total_aviones) %>%
  arrange(desc(porcentaje_perdidos))
```

```
## # A tibble: 16 x 4
##    aerolinea total_aviones faltan_en_aviones porcentaje_perdidos
##    <chr>             <int>             <int>               <dbl>
##  1 MQ                  238               234             0.983  
##  2 AA                  601               430             0.715  
##  3 F9                   26                 3             0.115  
##  4 FL                  129                12             0.0930 
##  5 UA                  621                23             0.0370 
##  6 US                  290                 9             0.0310 
##  7 DL                  629                10             0.0159 
##  8 B6                  193                 3             0.0155 
##  9 WN                  583                 3             0.00515
## 10 9E                  204                 1             0.00490
## 11 AS                   84                 0             0      
## 12 EV                  316                 0             0      
## 13 HA                   14                 0             0      
## 14 OO                   28                 0             0      
## 15 VX                   53                 0             0      
## 16 YV                   58                 0             0
```
</div>

1. Filtra los vuelos para mostrar únicamente los aviones que han realizado al menos cien
   viajes.

1. Combina `vehiculos` y `comunes` para encontrar los registros de los 
   modelos más comunes.

1. Encuentra las 48 horas (en el transcurso del año) que tengan los peores atrasos. Haz 
   una referencia cruzada con la tabla `clima`. ¿Puedes observar patrones?

1. ¿Qué te indica `anti_join(vuelos, aeropuertos, by = c("destino" = "codigo_aeropuerto"))`?
   ¿Qué te indica `anti_join(aeropuertos, vuelos, by = c("codigo_aeropuerto" = "destino"))`?

1. Puedes esperar que exista una relación implícita entre aviones y aerolíneas, dado que cada 
   avión es operado por una única aerolínea. Confirma o descarta esta hipótesis usando las 
   herramientas que aprendiste más arriba.

## Problemas de las uniones

Los datos con los que has estado trabajando en este capítulo han sido limpiados de modo que tengas el mínimo de problemas posibles. Tus propios datos difícilmente estarán tan ordenados, por lo que hay algunas consideraciones y pasos a tener en cuenta para que las uniones sobre tus propios datos funcionen adecuadamente.

1. Comienza identificando las variables que forman las llaves primarias en cada tabla.
   Usualmente debieras hacerlo basado en tus conocimientos de los datos, no observando 
   empíricamente las combinaciones de variables que resultan en un identificador único. 
   Si te centras en las variables sin pensar en sus significados, puedes tener la mala 
   suerte de encontrar una combinación única en tus datos pero dicha relación puede no ser válida en general.

   Por ejemplo, la altura y la longitud identifican de manera única cada aeropuerto, ¡pero 
   no son buenos identificadores!

 
 ```r
 aeropuertos %>% count(altura, longitud) %>% filter(n > 1)
 ```
 
 ```
 ## # A tibble: 0 x 3
 ## # … with 3 variables: altura <int>, longitud <dbl>, n <int>
 ```

1. Verifica que ninguna de las variables en la llave primaria esté perdida. 
   ¡Si un valor está perdido no puede identificar una observación!

1. Verifica que las llaves foráneas coinciden con las llaves primarias en 
   otra tabla. La mejor forma de hacerlo es mediante `anti_join()`. Es común 
   que las llaves no coincidan debido a errores en la entrada de datos. Arreglar 
   este problema requiere mucho trabajo.

   Si tienes llaves perdidas, debes ser cuidadoso respecto del uso de unión interior 
   versus unión exterior y considerar cuidadosamente si quieres descartar las observaciones 
   que no tienen coincidencias.
   
   Ten en cuenta que verificiar el número de filas antes y después de unir no es suficiente para asegurar 
   que la unión funcionó de forma exitosa. Si tienes una unión interior con llaves duplicadas en ambas tablas, 
   puedes tener la mala suerte de que el número de filas descartadas sea igual al número de filas duplicadas.

