# Importación de datos




## 11.2 Comenzando{-#comenzando}

### 11.2.2 Ejercicios{-#ejercicios-1122}

1. ¿Qué función utilizarías para leer un archivo donde los campos están separados con "|"?

<div class="solucion">
<h3>Solución</h3>
La función `read_delim()` permite leer archivos delimitados por distintos tipos de caracteres. A través del argumento `delim = ` indicado cuál es el caracter que se ha utilizado en el archivo que nos interesa importar. Por ejemplo:


```r
read_delim("nombre_archivo", delim = "|")
```


</div>

2. Además de `file`, `skip` y `comment` ¿Qué otros argumentos tienen en común `read_csv()` y `read_tsv()`?

<div class="solucion">
<h3>Solución</h3>
Los argumentos que tienen en común, además de los ya mencionados, son los siguientes:
`delim`, que permite indicar el caracter de separación.
`quote`, para indicar el caracter utilizado para citar cadenas de caracteres (por ejemplo, `"` o `'`)
`escape_backslash`, para indicar si se han utilizado barras invertidas (`\`) para escapar caracteres especiales.
`escape_double`, para indicar si el archivo escapa las comillas duplicándolas (`""""`)
`col_names`, para especificar el nombre de las columnas (`TRUE`: asume la primera línea como nombre de columa; `FALSE`: genera automáticamente nombres del tipo X1, X2, X3, etc.). Si se provee un vector de caracteres, esos valores serán utilizados como nombres de columa.
`col_types`, para indicar de cómo debe definirse el tipo de columna en cada caso. El valor `NULL` es el que viene por defecto y define el tipo de columna según lo que identifica en las 1000 primeras filas. Con `cols()` se puede indicar cómo debe leerse cada columna. 
`locale`, para controlar los parámetros por defecto que varían según zona (por ejemplo, zona geográfica, codificación de caracteres, marca de decimal, nombre de días/meses, etc.)
`na`, para indicar qué cadena de caracteres se utiliza en el archivo para marcar valores faltantes.
`quoted_na`, para indicar si los valores faltantes que están dentro de una cadena de caracteres entrecomilladas deben interpretarse como tales. 
`trim_ws`, si queremos que los espacios en blanco antes y después de cada campo se eliminen previo a la segmentación del archivo en columnas. 
`n_max`, para definir el máximo de filas que se deben leer
`guess_max`, para indicar cuál es el número máximo de valores a considerar para inferir el tipo de columna (el valor por defecto es 1000)
`progress`, para indicar si queremos que se muestre una barra de progreso al importar el archivo. 
`skip_empty_rows`, para señalar que las filas en blanco deben omitirse al leer el archivo. 

</div>

3. ¿Cuáles son los argumentos más importantes de `read_fwf()`?

<div class="solucion">
<h3>Solución</h3>
`read_fwf()` es una función para leer archivos en que las columnas tienen un ancho fijo (`fwf`: fixed-width format). Es por eso que sus argumentos más importantes son las que permiten indicar la posición de las columnas: `col_positions`. A través de ella podemos elegir que adivine la posición según las columnas vacías, o definirlas indicando el ancho de cada columna o el inicio y fin de cada una.
</div>

4. Algunas veces, las cadenas de caracteres en un archivo csv contienen comas. Para evitar que causen problemas deben estar rodeadas por comillas, como `"` o `'`. Por convención, `read_csv()` asume que el caracter de separación será `"`, y si quieres cambiarlo necesitarás usar `read_delim()` en su lugar.¿Qué argumentos debes especificar para leer el siguiente texto en un data frame? 
  
    
    
    ```r
    "x,y\n1,'a,b'"
    ```

<div class="solucion">
<h3>Solución</h3>
Necesitamos indicar cuál es el caracter que se ha utilizado como delimitador.


```r
datos <- "x,y\n1,'a,b'"

read_delim(datos, delim = ",", quote = "'")
#> Rows: 1 Columns: 2
#> ── Column specification ────────────────────────────────────────────────────────
#> Delimiter: ","
#> chr (1): y
#> dbl (1): x
#> 
#> ℹ Use `spec()` to retrieve the full column specification for this data.
#> ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
#> # A tibble: 1 × 2
#>       x y    
#>   <dbl> <chr>
#> 1     1 a,b
```

</div>

5. Identifica qué está mal en cada una de los siguientes archivos csv alineados. ¿Qué pasa cuando corres el código?    

    
    ```r
    read_csv("a,b\n1,2,3\n4,5,6")
    read_csv("a,b,c\n1,2\n1,2,3,4")
    read_csv("a,b\n\"1")
    read_csv("a,b\n1,2\na,b")
    read_csv("a;b\n1;3")
    ```

<div class="solucion">
<h3>Solución</h3>
En los tres primeros casos hay problemas porque la cantidad de columnas esperadas (_expected_) y la que se encuetra en los datos (_actual_) no coincide. 
En el primer caso, se esperan dos columnas, pero las filas 1 y 2 tienen tres valores. El último, por lo tanto, se descarta.

```r
    read_csv("a,b\n1,2,3\n4,5,6")
#> Warning: One or more parsing issues, see `problems()` for details
#> Rows: 2 Columns: 2
#> ── Column specification ────────────────────────────────────────────────────────
#> Delimiter: ","
#> dbl (1): a
#> 
#> ℹ Use `spec()` to retrieve the full column specification for this data.
#> ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
#> # A tibble: 2 × 2
#>       a     b
#>   <dbl> <dbl>
#> 1     1    23
#> 2     4    56
```

En el segundo caso, en la fila 1 se esperan tres valores, pero solo hay dos, por lo que la tercera columna se completa con `NA`. En la fila dos, hay cuatro valores, por lo que el último se descarta. 

```r
    read_csv("a,b,c\n1,2\n1,2,3,4")
#> Warning: One or more parsing issues, see `problems()` for details
#> Rows: 2 Columns: 3
#> ── Column specification ────────────────────────────────────────────────────────
#> Delimiter: ","
#> dbl (2): a, b
#> 
#> ℹ Use `spec()` to retrieve the full column specification for this data.
#> ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
#> # A tibble: 2 × 3
#>       a     b     c
#>   <dbl> <dbl> <dbl>
#> 1     1     2    NA
#> 2     1     2    34
```

En el tercer caso, solo hay un valor para la primera fila, por lo que se completa la segunda columna con `NA`. Además, se indica que falta una comilla de cierre, por lo que se descarta la ue no está cerrada (`"1`).

```r
    read_csv("a,b\n\"1")
#> Rows: 0 Columns: 2
#> ── Column specification ────────────────────────────────────────────────────────
#> Delimiter: ","
#> chr (2): a, b
#> 
#> ℹ Use `spec()` to retrieve the full column specification for this data.
#> ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
#> # A tibble: 0 × 2
#> # … with 2 variables: a <chr>, b <chr>
```

En este caso, el posible problema es que, debido a que en la segunda fila `a` y `b` son caracteres, en la primera `1` y `2` también son tratados como caracteres. 

```r
    read_csv("a,b\n1,2\na,b")
#> Rows: 2 Columns: 2
#> ── Column specification ────────────────────────────────────────────────────────
#> Delimiter: ","
#> chr (2): a, b
#> 
#> ℹ Use `spec()` to retrieve the full column specification for this data.
#> ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
#> # A tibble: 2 × 2
#>   a     b    
#>   <chr> <chr>
#> 1 1     2    
#> 2 a     b
```

En el último caso se produce un problema habitual de lectura de archivos csv: que el delimitador no es una coma, sino punto y coma. Como la función `read_csv()` espera una coma como delimitador, no separa las columnas como se espera:

```r
    read_csv("a;b\n1;3")
#> Rows: 1 Columns: 1
#> ── Column specification ────────────────────────────────────────────────────────
#> Delimiter: ","
#> chr (1): a;b
#> 
#> ℹ Use `spec()` to retrieve the full column specification for this data.
#> ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
#> # A tibble: 1 × 1
#>   `a;b`
#>   <chr>
#> 1 1;3
```

En este caso, puede utilizarse `read_csv2()`, que espera un punto y coma como delimitador:


```r
    read_csv2("a;b\n1;3")
#> ℹ Using "','" as decimal and "'.'" as grouping mark. Use `read_delim()` for more control.
#> Rows: 1 Columns: 2
#> ── Column specification ────────────────────────────────────────────────────────
#> Delimiter: ";"
#> dbl (2): a, b
#> 
#> ℹ Use `spec()` to retrieve the full column specification for this data.
#> ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
#> # A tibble: 1 × 2
#>       a     b
#>   <dbl> <dbl>
#> 1     1     3
```

</div>

## 11.3 Segmentar un vector{-#segmentar-vector}

### 11.3.5 Ejercicios{-#ejercicios-1135}

1.  ¿Cuáles son los argumentos más importantes para `locale()`?

<div class="solucion">
<h3>Solución</h3>
* `date_names`, para indicar el idioma de las fechas. `es` es el código para español. 
* `date_format` y `time_format`, para indicar el formato de fecha y hora
* `decimal_mark` y `grouping_mark`, para definir el símbolo para separar decimales (`,` o `.`) y para segmentar números grandes.
* `tz`, para definir la zona horaria. 
* `encoding`, para indicar la codificación que se quiere utilizar para leer archivos. 
</div>


2.  ¿Qué pasa si pruebas y estableces `decimal_mark` y `grouping_mark` al mismo caracter? ¿Qué pasa con el valor por defecto de `grouping_mark` cuando seleccionas `decimal_mark` a `,`? ¿Qué pasa con el valor por defecto de `decimal_mark` cuando estableces `grouping_mark` a `.`?

<div class="solucion">
<h3>Solución</h3>
Si se define el mismo caracter para ambos, se genera un error que indica que deben ser diferentes:


```r
locale(decimal_mark = ",", grouping_mark = ",")
# Error: `decimal_mark` and `grouping_mark` must be different
```

Si se `decimal_mark` se define como `,` el valor por defecto de `grouping_mark` cambia a `.`. Al revés pasa lo mismo: si `grouping_mark` se define como `.` entonces `decimal_mark` cambia a `,`.


```r

locale(decimal_mark = ",")
#> <locale>
#> Numbers:  123.456,78
#> Formats:  %AD / %AT
#> Timezone: UTC
#> Encoding: UTF-8
#> <date_names>
#> Days:   Sunday (Sun), Monday (Mon), Tuesday (Tue), Wednesday (Wed), Thursday
#>         (Thu), Friday (Fri), Saturday (Sat)
#> Months: January (Jan), February (Feb), March (Mar), April (Apr), May (May),
#>         June (Jun), July (Jul), August (Aug), September (Sep), October
#>         (Oct), November (Nov), December (Dec)
#> AM/PM:  AM/PM
locale(grouping_mark = ".")
#> <locale>
#> Numbers:  123.456,78
#> Formats:  %AD / %AT
#> Timezone: UTC
#> Encoding: UTF-8
#> <date_names>
#> Days:   Sunday (Sun), Monday (Mon), Tuesday (Tue), Wednesday (Wed), Thursday
#>         (Thu), Friday (Fri), Saturday (Sat)
#> Months: January (Jan), February (Feb), March (Mar), April (Apr), May (May),
#>         June (Jun), July (Jul), August (Aug), September (Sep), October
#>         (Oct), November (Nov), December (Dec)
#> AM/PM:  AM/PM
```

</div>

3.  No discutimos las opciones `date_format` y `time_format` para `locale()`. ¿Qué hacen? Construye un ejemplo que muestre cuándo pueden ser útiles.

<div class="solucion">
<h3>Solución</h3>
Como se indicó más arriba, `date_format` y `time_format` sirven para indicar el formato de fecha y hora. 
Por defecto, están especificados como `%AD` y `%AT`. La `A` es de _automatic parser_; se segmentan automáticamente las fechas con un formato de Año-Mes-Día (`YMD`), y las horas con un formato de Hora-Minuto-Segundo (`HMS`).
Si mis datos tuviesen las fechas o las horas escritas en otro formato, podría ajustar estas opciones. Por ejemplo, en este caso el orden es día/mes/año, por lo que no reconoce que es una fecha


```r
read_csv("fecha\n01/01/2020\n01/02/2020")
#> Rows: 2 Columns: 1
#> ── Column specification ────────────────────────────────────────────────────────
#> Delimiter: ","
#> chr (1): fecha
#> 
#> ℹ Use `spec()` to retrieve the full column specification for this data.
#> ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
#> # A tibble: 2 × 1
#>   fecha     
#>   <chr>     
#> 1 01/01/2020
#> 2 01/02/2020
```

Si utilizamos `date_format`, podemos indicar que nuestros datos tienen la forma día/mes/año (`%d/%m/%Y`), lo que permite que sean interpretados como fecha y ajustados al formato `YMD`:

```r
read_csv("fecha\n01/01/2020\n01/02/2020", locale = locale(date_format = "%d/%m/%Y"))
#> Rows: 2 Columns: 1
#> ── Column specification ────────────────────────────────────────────────────────
#> Delimiter: ","
#> date (1): fecha
#> 
#> ℹ Use `spec()` to retrieve the full column specification for this data.
#> ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
#> # A tibble: 2 × 1
#>   fecha     
#>   <date>    
#> 1 2020-01-01
#> 2 2020-02-01
```


</div>

4.  Si vives fuera de EE. UU., crea un nuevo objeto locale que encapsule las opciones para los tipos de archivo que lees más comúnmente.

<div class="solucion">
<h3>Solución</h3>
El caso anterior es un ejemplo que puede resultar útil en contextos hispanoparlantes, en los que las fechas suelen representarse con el formato día/mes/año. Asimismo, podemos indicar que la marca de decimal es `,`.

Podemos crear un nuevo objeto `locale` con esas indicaciones:

```r
locale_latam <- locale(date_format = "%d/%m/%Y", decimal_mark = ",")
```

Esto permite que no se lea el `.` como decimal, sino solo como solo como símbolo para separar números grandes, y que las fechas se lean correctamente: 

```r
read_csv("fecha,valor\n01/01/2020,110.251\n01/02/2020,120.285", locale = locale_latam)
#> Rows: 2 Columns: 2
#> ── Column specification ────────────────────────────────────────────────────────
#> Delimiter: ","
#> date (1): fecha
#> 
#> ℹ Use `spec()` to retrieve the full column specification for this data.
#> ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
#> # A tibble: 2 × 2
#>   fecha       valor
#>   <date>      <dbl>
#> 1 2020-01-01 110251
#> 2 2020-02-01 120285
```

</div>

5.  ¿Cuál es la diferencia entre `read_csv()` y `read_csv2()`?
<div class="solucion">
<h3>Solución</h3>
Lo mencionamos al pasar más arriba: `read_csv()` utiliza `,` como delimitador y `read_csv2()` utiliza `;`. `read_csv2()` es muy útil en el contexto hispanoparlante, ya que utilizamos la coma como separador de decimales, no el punto. Cuando tenemos datos con ese formato, podemos usar `;` para separar los valores. 
</div>

6.  ¿Cuáles son las codificaciones más comunes empleadas en Europa? ¿Cuáles son las codificaciones más comunes utilizadas en Asia? Googlea un poco para descubrirlo. 

<div class="solucion">
<h3>Solución</h3>

</div>

7.  Genera el formato correcto para leer cada una de las siguientes fechas y horas:
    
    ```r
    d1 <- "January 1, 2010"
    d2 <- "2015-Mar-07"
    d3 <- "06-Jun-2017"
    d4 <- c("August 19 (2015)", "July 1 (2015)")
    d5 <- "12/30/14" # Dec 30, 2014
    t1 <- "1705"
    t2 <- "11:15:10.12 PM"
    ```

<div class="solucion">
<h3>Solución</h3>
Las especificaciones que necesitamos para leer las fechas son las siguientes: 


```r
parse_date(d1, "%B %d, %Y")
#> [1] "2010-01-01"
parse_date(d2, "%Y-%b-%d")
#> [1] "2015-03-07"
parse_date(d3, "%d-%b-%Y")
#> [1] "2017-06-06"
parse_date(d4, "%B %d (%Y)")
#> [1] "2015-08-19" "2015-07-01"
parse_date(d5, "%m/%d/%y")
#> [1] "2014-12-30"
parse_time(t1, "%H%M")
#> 17:05:00
parse_time(t2, "%H:%M:%OS %p")
#> 23:15:10.12
```

</div>
