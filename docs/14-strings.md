# Cadenas de caracteres




## 14.2 Cadenas: elementos básicos{-#cadena-basics}


### 14.2.5 Ejercicios{-#ejercicios-1425}

1.  En ejemplos de código en los que no se utiliza __stringr__, verás usualmente `paste()` y `paste0()` (_paste_ = pegar).
    ¿Cuál es la diferencia entre estas dos funciones? ¿A qué función de __stringr__ son equivalentes? ¿Cómo difieren estas dos funciones respecto de su manejo de los
    `NA`?
    
<div class="solucion">
<h3>Solución</h3>

`paste()` y `paste0()` se diferencian en la opción por defecto para separar los elementos que se concatenan. `paste()` deja un espacio; `paste0()` no.


```r
paste("uno", "dos", "tres")
#> [1] "uno dos tres"
paste0("uno", "dos", "tres")
#> [1] "unodostres"
```

Estas funciones son equivalentes a `str_c()`. Esta función por defecto no agrega un espacio entre los elementos concatenados, por lo que si queremoos que lo incluya tenemos que explicitarlo en el argumento `sep = `:


```r
str_c("uno", "dos", "tres")
#> [1] "unodostres"
str_c("uno", "dos", "tres", sep = " ")
#> [1] "uno dos tres"
```

Si `str_c()` se encuentra un `NA` entrega como resultado `NA`. `paste()`, en cambio, `paste()` y `paste0()` lo concatenan.


```r
str_c("uno", "dos", NA, sep = " ")
#> [1] NA
paste("uno", "dos", NA)
#> [1] "uno dos NA"
```

</div> 

2.  Describe con tus propias palabras la diferencia entre los argumentos `sep` y `collapse`
    de la función `str_c()`.

<div class="solucion">
<h3>Solución</h3>

`sep` define el caracter que se inserta entre los elementos a concatenar. `collapse`, por su parte, es el caracter para combinar entre los elementos a concatenar para generar un vector de extensión 1: 

```r
x <- c("uno", "dos", "tres")
y <- c("cuatro", "cinco", "seis")

str_c(x, y, sep = "-")
#> [1] "uno-cuatro" "dos-cinco"  "tres-seis"
str_c(x, y, collapse = "-")
#> [1] "unocuatro-doscinco-tresseis"
```


</div> 


3.  Utiliza `str_length()` y `str_sub()` para extraer el caracter del medio de una cadena. ¿Qué harías si el número de caracteres es par?

<div class="solucion">
<h3>Solución</h3>


```r
x <- c("uno", "dos", "tres")
largo <- str_length(x)
mitad <- ceiling(largo / 2)
str_sub(x, start = mitad, end = mitad)
#> [1] "n" "o" "r"
```

</div> 


4.  ¿Qué hace `str_wrap()`? (_wrap_ = envolver) ¿Cuándo podrías querer utilizarla?

<div class="solucion">
<h3>Solución</h3>
`str_wrap()` permite formatear párrafos indicando el ancho en cantidad de caracteres que queremos que tenga. El valor por defecto es 80. 


```r
texto <- "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris in risus magna. Nulla consequat imperdiet nisl sit amet euismod. Sed nec molestie velit, non cursus neque. Suspendisse dapibus, justo at convallis pulvinar, nibh neque congue lectus, nec sollicitudin libero lacus eget nisl. Vivamus cursus turpis id quam aliquam, et fermentum tellus lacinia. Aliquam a eros nunc. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nunc finibus auctor auctor."

str_wrap(texto)
#> [1] "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris in risus magna.\nNulla consequat imperdiet nisl sit amet euismod. Sed nec molestie velit, non\ncursus neque. Suspendisse dapibus, justo at convallis pulvinar, nibh neque\ncongue lectus, nec sollicitudin libero lacus eget nisl. Vivamus cursus turpis\nid quam aliquam, et fermentum tellus lacinia. Aliquam a eros nunc. Pellentesque\nhabitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.\nNunc finibus auctor auctor."
str_wrap(texto, width = 40)
#> [1] "Lorem ipsum dolor sit amet, consectetur\nadipiscing elit. Mauris in risus magna.\nNulla consequat imperdiet nisl sit amet\neuismod. Sed nec molestie velit, non\ncursus neque. Suspendisse dapibus, justo\nat convallis pulvinar, nibh neque congue\nlectus, nec sollicitudin libero lacus\neget nisl. Vivamus cursus turpis id quam\naliquam, et fermentum tellus lacinia.\nAliquam a eros nunc. Pellentesque\nhabitant morbi tristique senectus et\nnetus et malesuada fames ac turpis\negestas. Nunc finibus auctor auctor."
str_wrap(texto, width = 40, indent = 3)
#> [1] "   Lorem ipsum dolor sit amet, consectetur\nadipiscing elit. Mauris in risus magna.\nNulla consequat imperdiet nisl sit amet\neuismod. Sed nec molestie velit, non\ncursus neque. Suspendisse dapibus, justo\nat convallis pulvinar, nibh neque congue\nlectus, nec sollicitudin libero lacus\neget nisl. Vivamus cursus turpis id quam\naliquam, et fermentum tellus lacinia.\nAliquam a eros nunc. Pellentesque\nhabitant morbi tristique senectus et\nnetus et malesuada fames ac turpis\negestas. Nunc finibus auctor auctor."
```

</div> 


5.  ¿Qué hace `str_trim()`? (_trim_ = recortar) ¿Cuál es el opuesto de `str_trim()`?

<div class="solucion">
<h3>Solución</h3>
`str_trim()` permite eliminar espacios en blancos al inicio y al final de una cadena de caracteres:


```r
str_trim(" palabra ")
#> [1] "palabra"
str_trim(" palabra ", side = "left")
#> [1] "palabra "
str_trim(" palabra ", side = "right")
#> [1] " palabra"
```

La función opuesta es `str_pad()`:


```r
str_pad("palabra", width = 15)
#> [1] "        palabra"
str_pad("palabra", width = 15, side = "right")
#> [1] "palabra        "
str_pad("palabra", width = 15, side = "both")
#> [1] "    palabra    "
```

</div> 


6.  Escribe una función que convierta, por ejemplo, el vector `c("a", "b", "c")` en
    la cadena `a, b, y c`. Piensa con detención qué debería hacer 
    dado un vector de largo 0, 1, o 2.

<div class="solucion">
<h3>Solución</h3>

</div> 


### 14.2.6 Buscar coincidencia de patrones con expresiones regulares{-#coincidencia}


#### 14.2.7.1 Ejercicios{-#ejercicios-14271}

1.  Explica por qué cada una de estas cadenas no coincide con `\`: `"\"`, `"\\"`, `"\\\"`.

<div class="solucion">
<h3>Solución</h3>

</div> 


2.  ¿Cómo harías coincidir la secuencia `"'\`?

<div class="solucion">
<h3>Solución</h3>


```r
str_view("\"'\\", "\"'\\\\", match = TRUE)
```

<!--html_preserve--><div id="htmlwidget-ac96cb3ee4656e2e9ec3" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-ac96cb3ee4656e2e9ec3">{"x":{"html":"<ul>\n  <li><span class='match'>\"'\\<\/span><\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->

</div> 


3.  ¿Con qué patrones coincidiría la expresión regular`\..\..\..`? 
    ¿Cómo la representarías en una cadena?

<div class="solucion">
<h3>Solución</h3>

</div> 


### 14.2.8 Anclas{-#anclas}


#### 14.2.8.1 Ejercicios{-#ejercicios-14281}

1.  ¿Cómo harías coincidir la cadena `"$^$"` de manera literal?

<div class="solucion">
<h3>Solución</h3>




</div> 


2.  Dado el corpus de palabras comunes en `datos::palabras`, crea una expresión
    regular que busque palabras:
    
    1. Empiecen con "y".
    1. Terminen con "x"
    1. Tengan una extensión de exactamente tres letras. (¡No hagas trampa usando `str_length()`!)
    1. Tengan siete letras o más. 

    Dado que esta será una lista larga, podrías quere usar el argumento `match` en
    `str_view()` para mostrar solo las palabras que coincidan o no coincidan. 

<div class="solucion">
<h3>Solución</h3>

</div> 


### 14.2.9 Clases de caracteres y alternativas{-#clases-caracteres}

#### 14.2.9.1 Ejercicios{-#ejercicios-14291}

1.  Crea una expresión regular que encuentre todas las palabras que:

    1. Empiecen con una vocal.
    1. Solo contengan consonantes. (Pista: piensa en cómo buscar coincidencias para 
       "no"-vocales.)
    1. Terminen en `ón`, pero no en `ión`.
    1. Terminen con `ndo` or `ado`.

<div class="solucion">
<h3>Solución</h3>




</div> 
    

2.  ¿Siempre a una "q" la sigue una "u"?

<div class="solucion">
<h3>Solución</h3>

</div> 


3.  Escribe una expresión regular que permita buscar un verbo que haya sido escrito usando voseo en segunda persona plural  
    (por ejemplo, _queréis_ en vez de _quieren_).

<div class="solucion">
<h3>Solución</h3>

</div> 


4.  Crea una expresión regular que coincida con la forma en que habitualmente 
    se escriben los números de teléfono en tu país.

<div class="solucion">
<h3>Solución</h3>

</div> 

    
5. En inglés existe una regla que dice que la letra i va siempre antes de la e, excepto cuando está después de una c". Verifica empíricamente esta regla utilizando las palabras contenidas en `stringr::words`. 

<div class="solucion">
<h3>Solución</h3>

</div> 

### 14.2.10 Repetición{-#repeticion}

#### 14.2.10.1 Ejercicios{-#ejercicios-142101}

1.  Describe los equivalentes de `?`, `+`, `*` en el formato `{m,n}`.

<div class="solucion">
<h3>Solución</h3>

`?` = `{0,1}`

`+` = `{1,}`

`*` = `{0,}`


</div> 


2.  Describe en palabras con qué coincidiría cada una de estas expresiones regulares:
    (lee con atención para ver si estamos utilizando una expresión regular o una cadena
    que define una expresión regular.)

    1. `^.*$`
    1. `"\\{.+\\}"`
    1. `\d{4}-\d{2}-\d{2}`
    1. `"\\\\{4}"`

<div class="solucion">
<h3>Solución</h3>

`^.*$`: coincidiría con cualquier cadena de caracteres, incluso si no tiene nada en su interior. La expresión regular buscar cualquier caracter (`.`) que aparezca 0 o más veces (`*`) al inicio (`^`) o al final `$` de una cadena de caracteres:


```r
cadena <- c("123", "una palabra", "estas son cuatro palabras", " ", "")

str_match(cadena, "^.*$")
#>      [,1]                       
#> [1,] "123"                      
#> [2,] "una palabra"              
#> [3,] "estas son cuatro palabras"
#> [4,] " "                        
#> [5,] ""
```

`"\\{.+\\}"`: coincidiría con `{}` y lo que tengan dentro, siempre que tenga al menos un caracter (`.+`):


```r
cadena <- c("uno {dos} tres", "uno {} tres", "uno {2} tres")

str_view(cadena, "\\{.+\\}")
```

<!--html_preserve--><div id="htmlwidget-ac96cb3ee4656e2e9ec3" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-ac96cb3ee4656e2e9ec3">{"x":{"html":"<ul>\n  <li>uno <span class='match'>{dos}<\/span> tres<\/li>\n  <li>uno {} tres<\/li>\n  <li>uno <span class='match'>{2}<\/span> tres<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script><!--/html_preserve-->


</div> 


3.  Crea expresiones regulares para buscar todas las palabras que:

    1. Empiecen con dos consonantes.
    1. Tengan tres o más vocales seguidas.
    1. Tengan tres o más pares de vocal-consonante seguidos. 


<div class="solucion">
<h3>Solución</h3>

</div> 

### 14.2.11 Agrupamiento y referencias previas{-#agrupamiento}

#### 14.2.11.1 Ejercicios{-#ejercicios-142111}

1.  Describe en palabras con qué coinciden estas expresiones: 

    1. `(.)\1\1`
    1. `"(.)(.)\\2\\1"`
    1. `(..)\1`
    1. `"(.).\\1.\\1"`
    1. `"(.)(.)(.).*\\3\\2\\1"`

<div class="solucion">
<h3>Solución</h3>

</div> 


2.  Construye una expresión regular que coincida con palabras que: 

    1. Empiecen y terminen con el mismo caracter. 
    
    1. Contengan un par de letras repetido
       (p. ej. "nacional" tiene "na" repetidos dos veces.)
    
    1. Contengan una letra repetida en al menos tres lugares
       (p. ej. "característica" tiene tres "a".)

<div class="solucion">
<h3>Solución</h3>

</div> 


## 14.3 Herramientas{-#herramientas}

### 14.3.2 Ejercicios{-#ejercicios-1432}

1.  Para cada uno de los siguientes desafíos, intenta buscar una solución utilizando tanto una 
    expresión regular simple como una combinación de múltiples llamadas a `str_detect()`.
    
    1.  Encuentra todas las palabras que empiezan o terminan con `y`.
    
    1.  Encuentra todas las palabras que empiezan con una vocal y terminan con una consonante.
    
    1.  ¿Existen palabras que tengan todas las vocales?

<div class="solucion">
<h3>Solución</h3>

</div> 


2.  ¿Qué palabra tiene el mayor número de vocales? ¿Qué palabra tiene la mayor
    proporción de vocales? (Pista: ¿cuál es el denominador?)

<div class="solucion">
<h3>Solución</h3>

</div> 


### 14.3.3 Extraer coincidencias{-#extraer-coincidencias}


#### 14.3.3.1 Ejercicios{-#ejercicios-14331}

1.  Te habrás dado cuenta que en el ejemplo anterior la expresión regular
    que utilizamos también devolvió como resultado "arrojo" y "azulejos", 
    que no son nombres de colores. Modifica la expresión regular para 
    resolver ese problema.
    
<div class="solucion">
<h3>Solución</h3>

</div> 

2.  De `datos::oraciones` extrae:

    1. La primera palabra de cada oración.
    1. Todas las palabras que terminen en `ción`.
    1. Todos los plurales.

<div class="solucion">
<h3>Solución</h3>

</div> 


### 14.3.4 Coincidencias agrupadas{-#coincidencias-agrupadas}

#### 14.3.4.1 Ejercicios{-#ejercicios-14341}

1. Busca en `datos::oraciones` todas las palabras que vengan después de un "número", como "un(o|a)", "dos", "tres", etc.
   Extrae tanto el número como la palabra.

<div class="solucion">
<h3>Solución</h3>

</div> 


2. En español a veces se utiliza el guión para unir adjetivos, establecer relaciones entre conceptos o para unir gentilicios (p. ej., _teórico-práctico_, _precio-calidad_, _franco-porteño_). ¿Cómo podrías encontrar esas palabras y separar lo que viene antes y después del guión?

<div class="solucion">
<h3>Solución</h3>

</div> 


### 14.3.5 Remplazar coincidencias{-#remplazar-coincidencias}

#### 14.3.5.1 Ejercicios{-#ejercicios-14351}

1.   Remplaza en una cadena todas las barras por barras invertidas.

<div class="solucion">
<h3>Solución</h3>

</div> 


2.   Implementa una versón simple de `str_to_lower()` (_a minúsculas_) usando `replace_all()`.

<div class="solucion">
<h3>Solución</h3>

</div> 


3.   Cambia la primera y la última letra en `palabras`. ¿Cuáles de esas cadenas
     siguen siendo palabras?

<div class="solucion">
<h3>Solución</h3>

</div> 


### 14.3.6  Divisiones{-#divisiones}

#### 14.3.6.1 Ejercicios{-#ejercicios-14361}

1.  Divide una cadena como `"manzanas, peras y bananas"` en elementos
    individuales.

<div class="solucion">
<h3>Solución</h3>


```r
x <- c("manzanas, peras y bananas")
str_split(x, "(, )|( y )")
#> [[1]]
#> [1] "manzanas" "peras"    "bananas"
```


</div> 

2.  ¿Por qué es mejor dividir utilizando `boundary("palabra")` en vez de `" "`?

<div class="solucion">
<h3>Solución</h3>

</div> 

3.  ¿Qué pasa si dividimos con una cadena vacía (`""`)? Experimenta y
    luego lee la documentación

<div class="solucion">
<h3>Solución</h3>

</div> 

## 14.4 Otro tipo de patrones {-#otros-patrones144}

### 14.4.1 Ejercicios{-#ejercicios-1441}

1.  ¿Cómo buscarías todas las cadenas que contienen `\` con `regex()` vs.
    con `fixed()`?

<div class="solucion">
<h3>Solución</h3>

</div> 

2.  ¿Cuáles son las cinco palabras más comunes en `oraciones`?

<div class="solucion">
<h3>Solución</h3>

</div> 

## 14.6 stringi{-#stringi}

### 14.6.1 Ejercicios{-#ejercicios-1461}

1.  Busca la función de __stringi__ que:

    1. Cuenta el número de palabras.
    1. Busca cadenas duplicadas.
    1. Genera texto aleatorio.

<div class="solucion">
<h3>Solución</h3>

Las funciones que nos sirven en cada uno de estos casos son:


```r
stringi::stri_count_words()
stringi::stri_duplicated(palabras)
stringi::stri_rand_lipsum()
```


</div> 


2.  ¿Cómo puedes controlar qué lengua usa `stri_sort()` para ordenar?

<div class="solucion">
<h3>Solución</h3>

Podemos controlar la lengua que se utiliza en `stri_sort()` con el argumento `locale`. El archivo de ayuda de esta función propone el siguiente ejemplo para ilustrar este comportamiento:


```r
stringi::stri_sort(c("hladny", "chladny"), locale="pl_PL")
#> [1] "chladny" "hladny"
stringi::stri_sort(c("hladny", "chladny"), locale="sk_SK")
#> [1] "hladny"  "chladny"
```

</div> 

