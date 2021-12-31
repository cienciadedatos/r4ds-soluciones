# Horas y fechas




## 16.2 Creando horas/fechas{-#crear-horas}

### 16.2.4 Ejercicios{-#ejercicios-1624}

1. ¿Qué sucede si analizas una cadena de caracteres que contiene fechas inválidas?

 
 ```r
 ymd(c("2010-10-10", "bananas"))
 ```

<div class="solucion">
<h3>Solución</h3>
Las cadenas de caracteres que contienen cadenas inválidas se convierten en `NA` y R arroja un mensaje de advertencia en el que se indica la candidad de veces que se encontró con este error:

```
[1] "2010-10-10" NA          
Warning message:
 1 failed to parse. 
```

</div>

2. ¿Qué hace el argumento `tzone` (del inglés, _huso horario_ abreviado) para `today()`? ¿Por qué es importante?

<div class="solucion">
<h3>Solución</h3>
El argumento `tzone` permite indicar en qué huso horarios queremos la fecha actual. Por defecto entrega la de tu sistema, pero si queremos la de una zona horaria específica, podemos ajustarla con ese argumento:


```r
today()
#> [1] "2021-12-31"
today ("UTC")
#> [1] "2021-12-31"
today(tzone = "Australia/Sydney")
#> [1] "2022-01-01"
today(tzone = "Pacific/Honolulu")
#> [1] "2021-12-31"
```

</div>

3. Usa la función de __lubridate__ apropiada para analizar las siguientes fechas:

 
 ```r
 d1 <- "Enero 1, 2010"
 d2 <- "2015-Mar-07"
 d3 <- "06-Jun-2017"
 d4 <- c("Agosto 19 (2015)", "Julio 1 (2015)")
 d5 <- "12/30/14" # Diciembre 30, 2014
 ```

<div class="solucion">
<h3>Solución</h3>


```r
mdy(d1)
#> Warning: All formats failed to parse. No formats found.
#> [1] NA
ymd(d2)
#> [1] "2015-03-07"
dmy(d3)
#> [1] "2017-06-06"
mdy(d4)
#> Warning: All formats failed to parse. No formats found.
#> [1] NA NA
mdy(d5)
#> [1] "2014-12-30"
```

</div>


## 16.3 Componentes fecha-hora{-#componentes-fecha}

### 16.3.4 Ejercicios{-#ejercicios-1634}

1. ¿Cómo cambia la distribución de las horas de los vuelos dentro de un día, a lo largo del año?

<div class="solucion">
<h3>Solución</h3>

</div>


2. Compara `horario_salida`, `salida_programada` and `atraso_salida`. ¿Son consistentes? Explica tus hallazgos.

<div class="solucion">
<h3>Solución</h3>

</div>


3. Compara `tiempo_vuelo` con la duración entre la salida y la llegada. Explica tus hallazgos. (Pista: considera la ubicación del aeropuerto).

<div class="solucion">
<h3>Solución</h3>

</div>


4. ¿Cómo cambia la demora promedio durante el curso de un día? ¿Deberías usar `horario_salida` o `salida_programada`? ¿Por qué?

<div class="solucion">
<h3>Solución</h3>

</div>


5. ¿En qué día de la semana deberías salir, si quieres minimizar las posibilidades de una demora?

<div class="solucion">
<h3>Solución</h3>

</div>


6. ¿Qué hace que la distribución de `diamantes$quilate` y `vuelos$salida_programada` sean similares?

<div class="solucion">
<h3>Solución</h3>

</div>


7. Confirma mi hipótesis de que salidas programas en los minutos 20-30 y 50-60 están casuadas por los vuelos programados que salen más temprano. Pista: crea una variable binaria que te diga si un vuelo tuvo o no demora.

<div class="solucion">
<h3>Solución</h3>

</div>

## 16.4 Lapsos de tiempo{-#lapsos-tiempo}

### 16.4.5 Ejercicios{-#ejercicios-1645}

1. ¿Por qué hay `months()` pero no `dmonths()` (_días del mes_)?

<div class="solucion">
<h3>Solución</h3>

</div>

2. Explica `days(nocturno * 1)` a alguien que apenas comienza a aprender R. ¿Cómo funciona?


<div class="solucion">
<h3>Solución</h3>

</div>

3. Crea un vector de fechas dando el primer día de cada mes en 2015. Crea un vector de fechas dando el primer día de cada mes del año _actual_.

<div class="solucion">
<h3>Solución</h3>

Una manera de resolver la primera pregunta sería obtener el primer día del primer mes y luego sumarle 11 meses:

```r
ymd("2015-01-01") + months(0:11)
#>  [1] "2015-01-01" "2015-02-01" "2015-03-01" "2015-04-01" "2015-05-01"
#>  [6] "2015-06-01" "2015-07-01" "2015-08-01" "2015-09-01" "2015-10-01"
#> [11] "2015-11-01" "2015-12-01"
```

La segunda pregunta podemos resolverla de las misma manera, pero obteniendo el primer día del año actual. Como queremos que esta respuesta sirva el próximo año, tenemos que generar ese primer día de manera automática (y no solo escribiendo `"2020-01-01"`). Para ello, podemos redondear hacia abajo la fecha actual. `floor_date()` permite indicar el criterio de redondeo:


```r

floor_date(today(), "year")
#> [1] "2021-01-01"
```

Ahora que obtuvimos el primer día del año actual, podemos sumarle los meses:



```r
floor_date(today(), "year") + months(0:11)
#>  [1] "2021-01-01" "2021-02-01" "2021-03-01" "2021-04-01" "2021-05-01"
#>  [6] "2021-06-01" "2021-07-01" "2021-08-01" "2021-09-01" "2021-10-01"
#> [11] "2021-11-01" "2021-12-01"
```

</div>


4. Crea una función en la cual, dado tu cumpleaños (como una fecha), retorne cuán viejo eres en años.

<div class="solucion">
<h3>Solución</h3>

</div>


5. ¿Por qué no puedes hacer funcionar a `(today() %--% (today() + years(1)) / months(1)` ?

<div class="solucion">
<h3>Solución</h3>

</div>
