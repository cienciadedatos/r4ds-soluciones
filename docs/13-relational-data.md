# Datos relacionales


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
library(datos)
```

## datos {#nycflights13-relational}

### Ejercicios

1. Imagina que necesitas dibujar (aproximadamente) la ruta que cada avión vuela desde su origen
   hasta el destino. ¿Qué variables necesitas? ¿Qué tablas necesitas combinar?

1. Olvidamos incluir la relación entre `clima` y `aeropuertos`. ¿Cuál es la relación y cómo debe
   aparecer en el diagrama?

1. `clima` únicamente contiene información de los aeropuertos de origen (Nueva York).
    Si contuviera registros para todos los aeropuertos de EEUU, ¿Qué relación tendría con `vuelos`?

1. Sabemos que hay días "especiales" en el año y pocas personas vuelan esos días.
   ¿Cómo se representarían en un data frame? ¿Cuáles serían las llaves primarias de esa tabla?
   ¿Cómo se conectaría con las tablas existentes?

## Llaves


### Ejercicios

1. Agrega una llave sustituta a `vuelos`.

1. Identifica las llaves en los siguientes conjuntos de datos

 1. `datos::bateadores`
 1. `datos::nombres`
 1. `datos::atmosfera`
 1. `datos::vehiculos`
 1. `datos::diamantes`
  
 (Puede que necesites leer un poco de documentación.)

1. Dibuja un diagrama que ilustre las conexiones entre las tablas `bateadores`,
  `personas` y `salarios` en el paquete datos. Dibuja otro diagrama que muestre la
  relación entre `personas`, `dirigentes` y `premios_dirigentes`.

  ¿Cómo caracterizarías las relación entre `bateadores`, `lanzadores` y `fildeo`?

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
 
1. Agrega la ubicación de origen _y_ destino (e.g. `latitud` y `longitud`) 
   a `vuelos`.

1. ¿Existe una relación entre la antiguedad de un avión y sus atrasos?

1. ¿Qué condiciones climáticas hacen más probables los atrasos?

1. ¿Qué sucedió el día 13 de junio de 2013? Muestra el patrón espacial de los atrasos, 
   luego usa un buscador para encontrar referencias cruzadas con el clima.

 


## Uniones de filtro {#filtering-joins}

### Ejercicios

1. ¿Qué significa que in vuelo no tenga `codigo_cola`? ¿Qué tienen en común los códigos 
   de cola que no tienen registros coincidentes en `aviones`? (Pista: Una variable explica 
   ~90% de los problemas.)

1. Filtra los vuelos para mostrar únicamente los aviones que han realizado al menos cien
   viajes

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

