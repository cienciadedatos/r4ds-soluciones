# Datos ordenados




## 12.2 Datos ordenados{-#datos-ordenados122}

### 12.2.1 Ejercicios{-#ejercicios-1221}

1. Usando prosa, describe como las variables y observaciones se organizan en las tablas de ejemplo.

<div class="solucion">
<h3>Solución</h3>

</div>


2. Calcula la `tasa` para las tablas `tabla2` y `tabla4a` + `tabla4b`.
 Necesitarás las siguientes operaciones:

   1. Extrae el número de casos de tuberculosis por país y año.
   2. Extrae la población por país y año.
   3. Divide los casos por la población y multiplica por 10000.
   4. Inserta los datos en el lugar adecuado.

 ¿Cuál representación es más fácil de trabajar? ¿Cuál es la más difícil? ¿Por qué?

<div class="solucion">
<h3>Solución</h3>

</div>


2. Recrea el gráfico que muestra el cambio en el número de casos usando la `tabla2` en lugar de la `tabla1`. ¿Qué debes hacer en primer lugar?


<div class="solucion">
<h3>Solución</h3>

</div>

## 12.3 Pivotar{-#pivotar}

### 12.3.3 Ejercicios{-#ejercicios-1233}

1. ¿Por qué `pivot_longer()` y `pivot_wider()` no son perfectamente simétricas?
 Observa cuidadosamente el siguiente ejemplo:


```r
acciones <- tibble(
  anio = c(2015, 2015, 2016, 2016),
  semestre = c(1, 2, 1, 2),
  retorno = c(1.88, 0.59, 0.92, 0.17)
)
acciones %>%
  pivot_wider(names_from = anio, values_from = retorno) %>%
  pivot_longer(`2015`:`2016`, names_to = "anio", values_to = "retorno")
```

 (Pista: observa los tipos de variables y piensa en los nombres de las columnas)

`pivot_longer()` y `pivot_wider()` tienen el argumento `names_ptype`. Por ejemplo, `names_ptype = list(year = double())`. ¿Qué es lo que hace dicho argumento?

<div class="solucion">
<h3>Solución</h3>

</div>

2. ¿Por qué falla el siguiente código?


```r
tabla4a %>%
  pivot_longer(c(1999, 2000), names_to = "anio", values_to = "casos")
#> Error: Can't subset columns that don't exist.
#> [31mx[39m Locations 1999 and 2000 don't exist.
#> [34mℹ[39m There are only 3 columns.
```

<div class="solucion">
<h3>Solución</h3>

El código falla porque los nombres de las columnas `1999` y `2000` deben escribirse rodeados de tildes graves, ya que son nombres "no sintácticos":


```r
tabla4a %>%
  pivot_longer(c(`1999`, `2000`), names_to = "anio", values_to = "casos")
#> # A tibble: 6 x 3
#>   pais       anio   casos
#>   <chr>      <chr>  <int>
#> 1 Afganistán 1999     745
#> 2 Afganistán 2000    2666
#> 3 Brasil     1999   37737
#> 4 Brasil     2000   80488
#> 5 China      1999  212258
#> 6 China      2000  213766
```


</div>

3. ¿Por qué no se puede extender la siguiente tabla? ¿Cómo agregarías una nueva columna para resolver el problema?


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

<div class="solucion">
<h3>Solución</h3>

</div>

4. Ordena la siguiente tabla. ¿Necesitas extenderla o contraerla? ¿Cuáles son las variables?


```r
embarazo <- tribble(
  ~embarazo, ~hombre, ~mujer,
  "sí", NA, 10,
  "no", 20, 12
)
```

<div class="solucion">
<h3>Solución</h3>

La tabla muestra la cantidad de embarazon por género. Las variables serían `embarazo`, `genero` y una tercera a la que podemos llamar `n`. Para que la tabla quede ordenada tenemos que "alargarla":


```r
embarazo %>% 
  pivot_longer(c(hombre, mujer), names_to = "genero", values_to = "n")
#> # A tibble: 4 x 3
#>   embarazo genero     n
#>   <chr>    <chr>  <dbl>
#> 1 sí       hombre    NA
#> 2 sí       mujer     10
#> 3 no       hombre    20
#> 4 no       mujer     12
```


</div>

## 12.4 Separar y unir{-#separar-unir}

### 12.4.3 Ejercicios{-#ejercicios-1243}

1. ¿Qué hacen los argumentos `extra` y `fill` en `separate()`?
 Experimenta con las diversas opciones a partir de los siguientes datasets de ejemplo.

 
 ```r
 tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>%
  separate(x, c("one", "two", "three"))
 
 tibble(x = c("a,b,c", "d,e", "f,g,i")) %>%
  separate(x, c("one", "two", "three"))
 ```

<div class="solucion">
<h3>Solución</h3>

</div>


2. Tanto `unite()` como `separate()` tienen un argumento `remove`. ¿Qué es lo que hace?
¿Por qué lo dejarías en `FALSE`?

<div class="solucion">
<h3>Solución</h3>

</div>


3. Compara y contrasta `separate()` y `extract()`. ¿Por qué existen tres variaciones de
separación (por posición, separador y grupos), pero solo una forma de unir?

<div class="solucion">
<h3>Solución</h3>

</div>


## 12.5 Valores faltantes{-#valores-faltantes125}

### 12.5.1 Ejercicios{-#ejercicios-1251}

1. Compara y contrasta el argumento `fill` que se usa en `spread()` con `complete()`.

<div class="solucion">
<h3>Solución</h3>

</div>


2. ¿Qué hace el argumento de dirección en `fill()`?

<div class="solucion">
<h3>Solución</h3>

</div>


## 12.6 Estudio de caso{-#estudio-caso}

### 12.6.1 Ejercicios{-#ejercicios-1261}

1. En este caso de estudio fijamos `na.rm = TRUE` para simplificar la verificación de que tenemos los valores correctos. ¿Es esto razonable? Piensa en como los valores faltantes están representados en este dataset. ¿Existen valores faltantes implícitos? ¿Cuál es la diferencia entre `NA` y cero?

<div class="solucion">
<h3>Solución</h3>

</div>


2. ¿Qué ocurre si omites la aplicación de `mutate()`?
 (`mutate(clave = stringr::str_replace(clave, "nuevosrecaida", "nuevos_recaida"))`)

<div class="solucion">
<h3>Solución</h3>

</div>


3. Afirmamos que `iso2` e `iso3` son redundantes respecto a `pais`. Confirma esta premisa.

<div class="solucion">
<h3>Solución</h3>

</div>

4. Para cada país, año y sexo calcula el total del número de casos de tuberculosis. Crea una visualización informativa de los datos.

<div class="solucion">
<h3>Solución</h3>

</div>
