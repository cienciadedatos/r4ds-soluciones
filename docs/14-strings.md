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

Estas funciones son equivalentes a `str_c()`. Esta función por defecto no agrega un espacio entre los elementos concatenados, por lo que si queremos incluirlo es necesario explicitarlo con el argumento `sep = `:


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

str_c(x, sep = "-")
#> [1] "uno"  "dos"  "tres"
str_c(x, collapse = "-")
#> [1] "uno-dos-tres"

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
#> [1] "   Lorem ipsum dolor sit amet,\nconsectetur adipiscing elit. Mauris\nin risus magna. Nulla consequat\nimperdiet nisl sit amet euismod. Sed\nnec molestie velit, non cursus neque.\nSuspendisse dapibus, justo at convallis\npulvinar, nibh neque congue lectus, nec\nsollicitudin libero lacus eget nisl.\nVivamus cursus turpis id quam aliquam,\net fermentum tellus lacinia. Aliquam a\neros nunc. Pellentesque habitant morbi\ntristique senectus et netus et malesuada\nfames ac turpis egestas. Nunc finibus\nauctor auctor."
```

</div> 


5.  ¿Qué hace `str_trim()`? (_trim_ = recortar) ¿Cuál es el opuesto de `str_trim()`?

<div class="solucion">
<h3>Solución</h3>
`str_trim()` permite eliminar espacios en blanco al inicio y al final de una cadena de caracteres:


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
    la cadena `a, b y c`. Piensa con detención qué debería hacer 
    dado un vector de largo 0, 1, o 2.

<div class="solucion">
<h3>Solución</h3>

Necesitamos crear una función que tome un vector de caracteres y lo convierta en una oración enumerativa. Cuando el vector tiene un largo mayor a 2, deberá separar los elementos con coma, excepto el último, que debe separarse con "y". Por ejemplo: `a, b, c, d y e`. Si su largo es 2, solo los deberá separar con "y": `a y b`. Si su largo es 1, solo debería devolver ese único elemento: `a`. Si es de largo 0, debería devolver una cadena vacía: `""`.


```r

y <- c("a", "b", "c", "d")

str_enumeracion <- function(x, delim = ",") {
  n <- length(x)
  if (n == 0) {
    ""
  } else if (n == 1) {
    x
  } else if (n == 2) {
    # solo separar con "y"
    str_c(x[[1]], "y", x[[2]], sep = " ")
  } else {
    # separar con comas todos los elementos, excepto los dos último, que llevan una "y"
    str_c(c(str_c(x[seq_len(n - 2)], delim), 
            str_c(x[[n-1]], "y", x[[n]], sep = " ")), 
          collapse = " ")
  }
}
```

Ahora, probemos la función con `c("a", "b", "c")`:


```r
str_enumeracion(c("a", "b", "c"))
#> [1] "a, b y c"
```

Veamos qué pasa cuando son menos y cuando son más elementos en la cadena:


```r
str_enumeracion("")
#> [1] ""
str_enumeracion("a")
#> [1] "a"
str_enumeracion(c("a", "b"))
#> [1] "a y b"
str_enumeracion(c("a", "b", "c", "d", "e"))
#> [1] "a, b, c, d y e"
```


</div> 


### 14.2.6 Buscar coincidencia de patrones con expresiones regulares{-#coincidencia}


#### 14.2.7.1 Ejercicios{-#ejercicios-14271}

1.  Explica por qué cada una de estas cadenas no coincide con `\`: `"\"`, `"\\"`, `"\\\"`.

<div class="solucion">
<h3>Solución</h3>

Como se menciona en el capítulo, tenemos que distinguir entre expresiones regulares y las cadenas de caracteres que la representan. La expresión regular que permite buscar una coincidencia con `\` es `\\`, ya que tenemos que escapar la barra invertida con otra barra invertida para que sea interpretada de manera literal. Pero para que R interprete esas dos barras como la expresión regular para coincidir con `\` en una cadena de caracteres, tenemos que escapar ambas, es decir `"\\\\"`.

Usar una sola barra invertida dentro de una cadena escapa el siguiente caracter. 


```r
writeLines("una comilla\"")
#> una comilla"
```

Dos barras invertidas se interpretan como una expresión regular que escapará el siguiente caracter. 


```r
x <- "¿aló?"
str_view(x, "\\?")
```

```{=html}
<div id="htmlwidget-ac96cb3ee4656e2e9ec3" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-ac96cb3ee4656e2e9ec3">{"x":{"html":"<ul>\n  <li>¿aló<span class='match'>?<\/span><\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
```

Tres barras invertidas en una cadena permiten escapar una barra y el siguiente caracter escapado para poder coincidir con este último:


```r
y <- "una barra seguida de una comilla: \\\""

str_view(y, "\\\"")
```

```{=html}
<div id="htmlwidget-e5c8c404fe174e4c81bd" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-e5c8c404fe174e4c81bd">{"x":{"html":"<ul>\n  <li>una barra seguida de una comilla: \\<span class='match'>\"<\/span><\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
```

</div> 


2.  ¿Cómo harías coincidir la secuencia `"'\`?

<div class="solucion">
<h3>Solución</h3>

Primero, para generar esa secuencia tenemos que escapar las comillas y la barra invertida usando barras invertidas:

```r
x <- "\"'\\"
writeLines(x)
#> "'\
```

Para buscar la coincidencia:

```r
str_view(x, "\\\"'\\\\")
```

```{=html}
<div id="htmlwidget-36aa3d2a04d42bbc2145" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-36aa3d2a04d42bbc2145">{"x":{"html":"<ul>\n  <li><span class='match'>\"'\\<\/span><\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
```


</div> 


3.  ¿Con qué patrones coincidiría la expresión regular`\..\..\..`? 
    ¿Cómo la representarías en una cadena?

<div class="solucion">
<h3>Solución</h3>

Esa expresión regular repite tres veces el mismo patrón: escapa un punto para que sea interpretado de manera literal y luego utiliza un punto para hacer coincidir cualquier caracter. Por lo tanto, coincidiría con patrones como: `.a.b.c`, `.1.r.3`, `.#. .!`.


```r
x <- c("abc.d.e.f", ".1. .3", ".a.b.c", "\\.\\.\\.")
str_view(x, "\\..\\..\\..")
```

```{=html}
<div id="htmlwidget-febe03efa1a2d8d52a86" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-febe03efa1a2d8d52a86">{"x":{"html":"<ul>\n  <li>abc<span class='match'>.d.e.f<\/span><\/li>\n  <li><span class='match'>.1. .3<\/span><\/li>\n  <li><span class='match'>.a.b.c<\/span><\/li>\n  <li>\\.\\.\\.<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
```

</div> 


### 14.2.8 Anclas{-#anclas}


#### 14.2.8.1 Ejercicios{-#ejercicios-14281}

1.  ¿Cómo harías coincidir la cadena `"$^$"` de manera literal?

<div class="solucion">
<h3>Solución</h3>


```r
x <- "$^$"
str_view(x, "\\$\\^\\$")
```

```{=html}
<div id="htmlwidget-1fb4450895fe099f74a1" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-1fb4450895fe099f74a1">{"x":{"html":"<ul>\n  <li><span class='match'>$^$<\/span><\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
```


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

Las palabras que empiezan con "y" podemos buscarlas utilizando el ancla de inicio de cadena:


```r
str_view(palabras, "^y", match = TRUE)
```

```{=html}
<div id="htmlwidget-10b3b7155e8045a1b2ad" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-10b3b7155e8045a1b2ad">{"x":{"html":"<ul>\n  <li><span class='match'>y<\/span><\/li>\n  <li><span class='match'>y<\/span>a<\/li>\n  <li><span class='match'>y<\/span>o<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
```

Las palabras que terminen con "z" podemos buscarlas utilizando el ancla de final de cadena:

```r
str_view(palabras, "z$", match = TRUE)
```

```{=html}
<div id="htmlwidget-4018eef1a407a0df6b52" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-4018eef1a407a0df6b52">{"x":{"html":"<ul>\n  <li>capa<span class='match'>z<\/span><\/li>\n  <li>die<span class='match'>z<\/span><\/li>\n  <li>gonzále<span class='match'>z<\/span><\/li>\n  <li>jue<span class='match'>z<\/span><\/li>\n  <li>lópe<span class='match'>z<\/span><\/li>\n  <li>lu<span class='match'>z<\/span><\/li>\n  <li>pa<span class='match'>z<\/span><\/li>\n  <li>rodrígue<span class='match'>z<\/span><\/li>\n  <li>ve<span class='match'>z<\/span><\/li>\n  <li>vo<span class='match'>z<\/span><\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
```

Las que tienen una extensión de 3 letras podemos buscarlas usando tres `.`. Pero para que solo coincida con aquellas que tienen una extensión igual a 3, tenemos que usar anclas al inicio y final de la cadena:

```r
str_view(palabras, "^...$", match = TRUE)
```

```{=html}
<div id="htmlwidget-5b1b2f4ad92281566982" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-5b1b2f4ad92281566982">{"x":{"html":"<ul>\n  <li><span class='match'>ahí<\/span><\/li>\n  <li><span class='match'>año<\/span><\/li>\n  <li><span class='match'>así<\/span><\/li>\n  <li><span class='match'>aun<\/span><\/li>\n  <li><span class='match'>aún<\/span><\/li>\n  <li><span class='match'>con<\/span><\/li>\n  <li><span class='match'>dan<\/span><\/li>\n  <li><span class='match'>dar<\/span><\/li>\n  <li><span class='match'>del<\/span><\/li>\n  <li><span class='match'>día<\/span><\/li>\n  <li><span class='match'>dio<\/span><\/li>\n  <li><span class='match'>don<\/span><\/li>\n  <li><span class='match'>dos<\/span><\/li>\n  <li><span class='match'>era<\/span><\/li>\n  <li><span class='match'>esa<\/span><\/li>\n  <li><span class='match'>ese<\/span><\/li>\n  <li><span class='match'>eso<\/span><\/li>\n  <li><span class='match'>etc<\/span><\/li>\n  <li><span class='match'>fin<\/span><\/li>\n  <li><span class='match'>fue<\/span><\/li>\n  <li><span class='match'>han<\/span><\/li>\n  <li><span class='match'>has<\/span><\/li>\n  <li><span class='match'>hay<\/span><\/li>\n  <li><span class='match'>hoy<\/span><\/li>\n  <li><span class='match'>iba<\/span><\/li>\n  <li><span class='match'>las<\/span><\/li>\n  <li><span class='match'>les<\/span><\/li>\n  <li><span class='match'>ley<\/span><\/li>\n  <li><span class='match'>los<\/span><\/li>\n  <li><span class='match'>luz<\/span><\/li>\n  <li><span class='match'>mal<\/span><\/li>\n  <li><span class='match'>mar<\/span><\/li>\n  <li><span class='match'>más<\/span><\/li>\n  <li><span class='match'>mes<\/span><\/li>\n  <li><span class='match'>mil<\/span><\/li>\n  <li><span class='match'>mis<\/span><\/li>\n  <li><span class='match'>muy<\/span><\/li>\n  <li><span class='match'>nos<\/span><\/li>\n  <li><span class='match'>oro<\/span><\/li>\n  <li><span class='match'>paz<\/span><\/li>\n  <li><span class='match'>pie<\/span><\/li>\n  <li><span class='match'>por<\/span><\/li>\n  <li><span class='match'>que<\/span><\/li>\n  <li><span class='match'>qué<\/span><\/li>\n  <li><span class='match'>rey<\/span><\/li>\n  <li><span class='match'>río<\/span><\/li>\n  <li><span class='match'>san<\/span><\/li>\n  <li><span class='match'>sea<\/span><\/li>\n  <li><span class='match'>ser<\/span><\/li>\n  <li><span class='match'>sin<\/span><\/li>\n  <li><span class='match'>sol<\/span><\/li>\n  <li><span class='match'>son<\/span><\/li>\n  <li><span class='match'>soy<\/span><\/li>\n  <li><span class='match'>sur<\/span><\/li>\n  <li><span class='match'>sus<\/span><\/li>\n  <li><span class='match'>tal<\/span><\/li>\n  <li><span class='match'>tan<\/span><\/li>\n  <li><span class='match'>una<\/span><\/li>\n  <li><span class='match'>uno<\/span><\/li>\n  <li><span class='match'>uso<\/span><\/li>\n  <li><span class='match'>van<\/span><\/li>\n  <li><span class='match'>ver<\/span><\/li>\n  <li><span class='match'>vez<\/span><\/li>\n  <li><span class='match'>vía<\/span><\/li>\n  <li><span class='match'>vio<\/span><\/li>\n  <li><span class='match'>voy<\/span><\/li>\n  <li><span class='match'>voz<\/span><\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
```

Para buscar palabras con 8 letras o más, podemos seguir la misma lógica del caso anterior, pero esta vez sin las anclas:


```r
str_view(palabras, "........", match = TRUE)
```

```{=html}
<div id="htmlwidget-25c3e940e6859592f801" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-25c3e940e6859592f801">{"x":{"html":"<ul>\n  <li><span class='match'>acciones<\/span><\/li>\n  <li><span class='match'>activida<\/span>d<\/li>\n  <li><span class='match'>activida<\/span>des<\/li>\n  <li><span class='match'>adelante<\/span><\/li>\n  <li><span class='match'>administ<\/span>ración<\/li>\n  <li><span class='match'>alrededo<\/span>r<\/li>\n  <li><span class='match'>ambiente<\/span><\/li>\n  <li><span class='match'>análisis<\/span><\/li>\n  <li><span class='match'>animales<\/span><\/li>\n  <li><span class='match'>anterior<\/span><\/li>\n  <li><span class='match'>aquellas<\/span><\/li>\n  <li><span class='match'>aquellos<\/span><\/li>\n  <li><span class='match'>argentin<\/span>a<\/li>\n  <li><span class='match'>artículo<\/span><\/li>\n  <li><span class='match'>asimismo<\/span><\/li>\n  <li><span class='match'>asociaci<\/span>ón<\/li>\n  <li><span class='match'>aspectos<\/span><\/li>\n  <li><span class='match'>atención<\/span><\/li>\n  <li><span class='match'>autorida<\/span>des<\/li>\n  <li><span class='match'>barcelon<\/span>a<\/li>\n  <li><span class='match'>bastante<\/span><\/li>\n  <li><span class='match'>cantidad<\/span><\/li>\n  <li><span class='match'>capacida<\/span>d<\/li>\n  <li><span class='match'>carácter<\/span><\/li>\n  <li><span class='match'>caracter<\/span>ísticas<\/li>\n  <li><span class='match'>comercio<\/span><\/li>\n  <li><span class='match'>comisión<\/span><\/li>\n  <li><span class='match'>compañía<\/span><\/li>\n  <li><span class='match'>comunica<\/span>ción<\/li>\n  <li><span class='match'>comunida<\/span>d<\/li>\n  <li><span class='match'>concepto<\/span><\/li>\n  <li><span class='match'>concienc<\/span>ia<\/li>\n  <li><span class='match'>condicio<\/span>nes<\/li>\n  <li><span class='match'>congreso<\/span><\/li>\n  <li><span class='match'>conjunto<\/span><\/li>\n  <li><span class='match'>conocimi<\/span>ento<\/li>\n  <li><span class='match'>consecue<\/span>ncia<\/li>\n  <li><span class='match'>consegui<\/span>r<\/li>\n  <li><span class='match'>consider<\/span>a<\/li>\n  <li><span class='match'>constitu<\/span>ción<\/li>\n  <li><span class='match'>construc<\/span>ción<\/li>\n  <li><span class='match'>contenid<\/span>o<\/li>\n  <li><span class='match'>contrari<\/span>o<\/li>\n  <li><span class='match'>creación<\/span><\/li>\n  <li><span class='match'>crecimie<\/span>nto<\/li>\n  <li><span class='match'>cualquie<\/span>r<\/li>\n  <li><span class='match'>cuestión<\/span><\/li>\n  <li><span class='match'>cultural<\/span><\/li>\n  <li><span class='match'>decisión<\/span><\/li>\n  <li><span class='match'>demasiad<\/span>o<\/li>\n  <li><span class='match'>democrac<\/span>ia<\/li>\n  <li><span class='match'>derechos<\/span><\/li>\n  <li><span class='match'>desarrol<\/span>lo<\/li>\n  <li><span class='match'>diciembr<\/span>e<\/li>\n  <li><span class='match'>diferenc<\/span>ia<\/li>\n  <li><span class='match'>diferent<\/span>es<\/li>\n  <li><span class='match'>direcció<\/span>n<\/li>\n  <li><span class='match'>director<\/span><\/li>\n  <li><span class='match'>distinta<\/span>s<\/li>\n  <li><span class='match'>distinto<\/span>s<\/li>\n  <li><span class='match'>diversas<\/span><\/li>\n  <li><span class='match'>diversos<\/span><\/li>\n  <li><span class='match'>economía<\/span><\/li>\n  <li><span class='match'>económic<\/span>a<\/li>\n  <li><span class='match'>económic<\/span>o<\/li>\n  <li><span class='match'>educació<\/span>n<\/li>\n  <li><span class='match'>ejército<\/span><\/li>\n  <li><span class='match'>eleccion<\/span>es<\/li>\n  <li><span class='match'>electora<\/span>l<\/li>\n  <li><span class='match'>elemento<\/span>s<\/li>\n  <li><span class='match'>empresas<\/span><\/li>\n  <li><span class='match'>encontra<\/span>r<\/li>\n  <li><span class='match'>encuentr<\/span>a<\/li>\n  <li><span class='match'>encuentr<\/span>an<\/li>\n  <li><span class='match'>encuentr<\/span>o<\/li>\n  <li><span class='match'>enfermed<\/span>ad<\/li>\n  <li><span class='match'>entonces<\/span><\/li>\n  <li><span class='match'>esfuerzo<\/span><\/li>\n  <li><span class='match'>española<\/span><\/li>\n  <li><span class='match'>españole<\/span>s<\/li>\n  <li><span class='match'>especial<\/span><\/li>\n  <li><span class='match'>especial<\/span>mente<\/li>\n  <li><span class='match'>estructu<\/span>ra<\/li>\n  <li><span class='match'>estudios<\/span><\/li>\n  <li><span class='match'>existenc<\/span>ia<\/li>\n  <li><span class='match'>experien<\/span>cia<\/li>\n  <li><span class='match'>expresió<\/span>n<\/li>\n  <li><span class='match'>exterior<\/span><\/li>\n  <li><span class='match'>fernando<\/span><\/li>\n  <li><span class='match'>finalmen<\/span>te<\/li>\n  <li><span class='match'>formació<\/span>n<\/li>\n  <li><span class='match'>francisc<\/span>o<\/li>\n  <li><span class='match'>generale<\/span>s<\/li>\n  <li><span class='match'>gobierno<\/span><\/li>\n  <li><span class='match'>gonzález<\/span><\/li>\n  <li><span class='match'>haciendo<\/span><\/li>\n  <li><span class='match'>hicieron<\/span><\/li>\n  <li><span class='match'>historia<\/span><\/li>\n  <li><span class='match'>hospital<\/span><\/li>\n  <li><span class='match'>imágenes<\/span><\/li>\n  <li><span class='match'>importan<\/span>cia<\/li>\n  <li><span class='match'>importan<\/span>te<\/li>\n  <li><span class='match'>importan<\/span>tes<\/li>\n  <li><span class='match'>imposibl<\/span>e<\/li>\n  <li><span class='match'>industri<\/span>a<\/li>\n  <li><span class='match'>informac<\/span>ión<\/li>\n  <li><span class='match'>instituc<\/span>iones<\/li>\n  <li><span class='match'>institut<\/span>o<\/li>\n  <li><span class='match'>interese<\/span>s<\/li>\n  <li><span class='match'>interior<\/span><\/li>\n  <li><span class='match'>internac<\/span>ional<\/li>\n  <li><span class='match'>investig<\/span>ación<\/li>\n  <li><span class='match'>izquierd<\/span>a<\/li>\n  <li><span class='match'>justicia<\/span><\/li>\n  <li><span class='match'>lenguaje<\/span><\/li>\n  <li><span class='match'>libertad<\/span><\/li>\n  <li><span class='match'>mantener<\/span><\/li>\n  <li><span class='match'>material<\/span><\/li>\n  <li><span class='match'>mediante<\/span><\/li>\n  <li><span class='match'>miembros<\/span><\/li>\n  <li><span class='match'>mientras<\/span><\/li>\n  <li><span class='match'>militare<\/span>s<\/li>\n  <li><span class='match'>millones<\/span><\/li>\n  <li><span class='match'>minister<\/span>io<\/li>\n  <li><span class='match'>ministro<\/span><\/li>\n  <li><span class='match'>momentos<\/span><\/li>\n  <li><span class='match'>movimien<\/span>to<\/li>\n  <li><span class='match'>nacional<\/span><\/li>\n  <li><span class='match'>naturale<\/span>za<\/li>\n  <li><span class='match'>necesari<\/span>o<\/li>\n  <li><span class='match'>necesida<\/span>d<\/li>\n  <li><span class='match'>nosotros<\/span><\/li>\n  <li><span class='match'>noviembr<\/span>e<\/li>\n  <li><span class='match'>nuestras<\/span><\/li>\n  <li><span class='match'>nuestros<\/span><\/li>\n  <li><span class='match'>objetivo<\/span><\/li>\n  <li><span class='match'>obstante<\/span><\/li>\n  <li><span class='match'>ocasione<\/span>s<\/li>\n  <li><span class='match'>operació<\/span>n<\/li>\n  <li><span class='match'>oposició<\/span>n<\/li>\n  <li><span class='match'>organiza<\/span>ción<\/li>\n  <li><span class='match'>paciente<\/span><\/li>\n  <li><span class='match'>paciente<\/span>s<\/li>\n  <li><span class='match'>palabras<\/span><\/li>\n  <li><span class='match'>particip<\/span>ación<\/li>\n  <li><span class='match'>particul<\/span>ar<\/li>\n  <li><span class='match'>partidos<\/span><\/li>\n  <li><span class='match'>película<\/span><\/li>\n  <li><span class='match'>personal<\/span><\/li>\n  <li><span class='match'>personas<\/span><\/li>\n  <li><span class='match'>població<\/span>n<\/li>\n  <li><span class='match'>política<\/span><\/li>\n  <li><span class='match'>política<\/span>s<\/li>\n  <li><span class='match'>político<\/span><\/li>\n  <li><span class='match'>político<\/span>s<\/li>\n  <li><span class='match'>posibili<\/span>dad<\/li>\n  <li><span class='match'>posibili<\/span>dades<\/li>\n  <li><span class='match'>posición<\/span><\/li>\n  <li><span class='match'>práctica<\/span><\/li>\n  <li><span class='match'>precisam<\/span>ente<\/li>\n  <li><span class='match'>pregunta<\/span><\/li>\n  <li><span class='match'>presenci<\/span>a<\/li>\n  <li><span class='match'>presenta<\/span><\/li>\n  <li><span class='match'>presente<\/span><\/li>\n  <li><span class='match'>presiden<\/span>te<\/li>\n  <li><span class='match'>primeras<\/span><\/li>\n  <li><span class='match'>primeros<\/span><\/li>\n  <li><span class='match'>principa<\/span>l<\/li>\n  <li><span class='match'>principa<\/span>les<\/li>\n  <li><span class='match'>principi<\/span>o<\/li>\n  <li><span class='match'>principi<\/span>os<\/li>\n  <li><span class='match'>problema<\/span><\/li>\n  <li><span class='match'>problema<\/span>s<\/li>\n  <li><span class='match'>producci<\/span>ón<\/li>\n  <li><span class='match'>producto<\/span><\/li>\n  <li><span class='match'>producto<\/span>s<\/li>\n  <li><span class='match'>profesio<\/span>nal<\/li>\n  <li><span class='match'>programa<\/span><\/li>\n  <li><span class='match'>programa<\/span>s<\/li>\n  <li><span class='match'>propuest<\/span>a<\/li>\n  <li><span class='match'>proyecto<\/span><\/li>\n  <li><span class='match'>proyecto<\/span>s<\/li>\n  <li><span class='match'>realidad<\/span><\/li>\n  <li><span class='match'>realizar<\/span><\/li>\n  <li><span class='match'>recuerdo<\/span><\/li>\n  <li><span class='match'>recursos<\/span><\/li>\n  <li><span class='match'>relación<\/span><\/li>\n  <li><span class='match'>relacion<\/span>es<\/li>\n  <li><span class='match'>repúblic<\/span>a<\/li>\n  <li><span class='match'>respecto<\/span><\/li>\n  <li><span class='match'>respuest<\/span>a<\/li>\n  <li><span class='match'>resultad<\/span>o<\/li>\n  <li><span class='match'>resultad<\/span>os<\/li>\n  <li><span class='match'>revoluci<\/span>ón<\/li>\n  <li><span class='match'>rodrígue<\/span>z<\/li>\n  <li><span class='match'>santiago<\/span><\/li>\n  <li><span class='match'>secretar<\/span>io<\/li>\n  <li><span class='match'>sectores<\/span><\/li>\n  <li><span class='match'>segurida<\/span>d<\/li>\n  <li><span class='match'>septiemb<\/span>re<\/li>\n  <li><span class='match'>servicio<\/span><\/li>\n  <li><span class='match'>servicio<\/span>s<\/li>\n  <li><span class='match'>siguient<\/span>e<\/li>\n  <li><span class='match'>siguient<\/span>es<\/li>\n  <li><span class='match'>silencio<\/span><\/li>\n  <li><span class='match'>siquiera<\/span><\/li>\n  <li><span class='match'>sistemas<\/span><\/li>\n  <li><span class='match'>situació<\/span>n<\/li>\n  <li><span class='match'>sociales<\/span><\/li>\n  <li><span class='match'>socialis<\/span>ta<\/li>\n  <li><span class='match'>sociedad<\/span><\/li>\n  <li><span class='match'>solament<\/span>e<\/li>\n  <li><span class='match'>solución<\/span><\/li>\n  <li><span class='match'>suficien<\/span>te<\/li>\n  <li><span class='match'>superior<\/span><\/li>\n  <li><span class='match'>supuesto<\/span><\/li>\n  <li><span class='match'>televisi<\/span>ón<\/li>\n  <li><span class='match'>términos<\/span><\/li>\n  <li><span class='match'>trabajad<\/span>ores<\/li>\n  <li><span class='match'>trabajar<\/span><\/li>\n  <li><span class='match'>tratamie<\/span>nto<\/li>\n  <li><span class='match'>tribunal<\/span><\/li>\n  <li><span class='match'>universi<\/span>dad<\/li>\n  <li><span class='match'>victoria<\/span><\/li>\n  <li><span class='match'>violenci<\/span>a<\/li>\n  <li><span class='match'>voluntad<\/span><\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
```

</div> 

### 14.2.9 Clases de caracteres y alternativas{-#clases-caracteres}

#### 14.2.9.1 Ejercicios{-#ejercicios-14291}

1.  Crea una expresión regular que encuentre todas las palabras que:

    1. Empiecen con una vocal.
    1. Solo contengan consonantes. (Pista: piensa en cómo buscar coincidencias para 
       "no"-vocales.)
    1. Terminen en `ón`, pero no en `ión`.
    1. Terminen con `ndo` o `ado`.

<div class="solucion">
<h3>Solución</h3>

Para buscar todas las palabras que empiecen con vocal utilizaremos `str_subset()` porque son muchos resultados:

```r
str_subset(palabras, "^[aáeéiíoóuúü]")
#>   [1] "a"              "abril"          "acción"         "acciones"      
#>   [5] "acerca"         "actitud"        "actividad"      "actividades"   
#>   [9] "acto"           "actual"         "acuerdo"        "adelante"      
#>  [13] "además"         "administración" "afirmó"         "agua"          
#>  [17] "ahí"            "ahora"          "aire"           "al"            
#>  [21] "algo"           "alguien"        "algún"          "alguna"        
#>  [25] "algunas"        "algunos"        "allá"           "allí"          
#>  [29] "alrededor"      "alta"           "alto"           "ambiente"      
#>  [33] "ambos"          "américa"        "amigo"          "amigos"        
#>  [37] "amor"           "análisis"       "animales"       "ante"          
#>  [41] "anterior"       "antes"          "antonio"        "año"           
#>  [45] "años"           "aparece"        "apenas"         "apoyo"         
#>  [49] "aquel"          "aquella"        "aquellas"       "aquellos"      
#>  [53] "aquí"           "área"           "argentina"      "armas"         
#>  [57] "arriba"         "arte"           "artículo"       "así"           
#>  [61] "asimismo"       "asociación"     "aspecto"        "aspectos"      
#>  [65] "asunto"         "atención"       "atrás"          "aumento"       
#>  [69] "aun"            "aún"            "aunque"         "autor"         
#>  [73] "autoridades"    "ayer"           "ayuda"          "e"             
#>  [77] "economía"       "económica"      "económico"      "edad"          
#>  [81] "educación"      "efecto"         "efectos"        "ejemplo"       
#>  [85] "ejército"       "el"             "él"             "elecciones"    
#>  [89] "electoral"      "elementos"      "ella"           "ellas"         
#>  [93] "ello"           "ellos"          "embargo"        "empresa"       
#>  [97] "empresas"       "en"             "encima"         "encontrar"     
#> [101] "encuentra"      "encuentran"     "encuentro"      "energía"       
#> [105] "enero"          "enfermedad"     "entonces"       "entrada"       
#> [109] "entrar"         "entre"          "época"          "equipo"        
#> [113] "era"            "eran"           "es"             "esa"           
#> [117] "esas"           "escuela"        "ese"            "esfuerzo"      
#> [121] "eso"            "esos"           "espacio"        "españa"        
#> [125] "español"        "española"       "españoles"      "especial"      
#> [129] "especialmente"  "especie"        "espera"         "esta"          
#> [133] "está"           "ésta"           "estaba"         "estaban"       
#> [137] "estado"         "estados"        "estamos"        "están"         
#> [141] "estar"          "estas"          "este"           "éste"          
#> [145] "estilo"         "esto"           "estos"          "estoy"         
#> [149] "estructura"     "estudio"        "estudios"       "estuvo"        
#> [153] "etapa"          "etc"            "europa"         "europea"       
#> [157] "evitar"         "ex"             "existe"         "existen"       
#> [161] "existencia"     "éxito"          "experiencia"    "explicó"       
#> [165] "expresión"      "exterior"       "i"              "iba"           
#> [169] "idea"           "ideas"          "iglesia"        "igual"         
#> [173] "ii"             "imagen"         "imágenes"       "importancia"   
#> [177] "importante"     "importantes"    "imposible"      "incluso"       
#> [181] "industria"      "información"    "informe"        "instituciones" 
#> [185] "instituto"      "interés"        "intereses"      "interior"      
#> [189] "internacional"  "investigación"  "ir"             "izquierda"     
#> [193] "o"              "objetivo"       "objeto"         "obra"          
#> [197] "obras"          "obstante"       "ocasión"        "ocasiones"     
#> [201] "ocho"           "octubre"        "oficial"        "ojos"          
#> [205] "operación"      "opinión"        "oposición"      "orden"         
#> [209] "organización"   "origen"         "oro"            "otra"          
#> [213] "otras"          "otro"           "otros"          "u"             
#> [217] "última"         "último"         "últimos"        "un"            
#> [221] "una"            "unas"           "única"          "único"         
#> [225] "unidad"         "unidos"         "unión"          "universidad"   
#> [229] "uno"            "unos"           "uso"            "usted"
```

Para buscar palabras que solo tienen consonantes buscamos no-vocales que se repitan una o más veces (`+`) y anclamos el inicio y fin de la cadena. `datos::palabras` incluye algunas abreviaciones (por ejemplo, pp = páginas), por lo que junto con "y" es lo único que encontraremos. 

```r
str_view(palabras, "^[^aáeéiíoóuúü]+$", match = TRUE)
```

```{=html}
<div id="htmlwidget-3f27c09be0c60bb52829" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-3f27c09be0c60bb52829">{"x":{"html":"<ul>\n  <li><span class='match'>b<\/span><\/li>\n  <li><span class='match'>c<\/span><\/li>\n  <li><span class='match'>d<\/span><\/li>\n  <li><span class='match'>g<\/span><\/li>\n  <li><span class='match'>j<\/span><\/li>\n  <li><span class='match'>m<\/span><\/li>\n  <li><span class='match'>n<\/span><\/li>\n  <li><span class='match'>p<\/span><\/li>\n  <li><span class='match'>pp<\/span><\/li>\n  <li><span class='match'>r<\/span><\/li>\n  <li><span class='match'>s<\/span><\/li>\n  <li><span class='match'>y<\/span><\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
```

Palabras que terminan en `ón`, pero no en `ión`.
    

```r
str_view(palabras, "[^i]ón$", match = TRUE)
```

```{=html}
<div id="htmlwidget-416566eb193bf50d04e6" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-416566eb193bf50d04e6">{"x":{"html":"<ul>\n  <li>cora<span class='match'>zón<\/span><\/li>\n  <li>ra<span class='match'>zón<\/span><\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
```

Palabras que terminan con `ndo` o `ado`:


```r
str_view(palabras, "(n|a)do", match = TRUE)
```

```{=html}
<div id="htmlwidget-72cbf064100ce560a04c" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-72cbf064100ce560a04c">{"x":{"html":"<ul>\n  <li>cua<span class='match'>ndo<\/span><\/li>\n  <li>d<span class='match'>ado<\/span><\/li>\n  <li>demasi<span class='match'>ado<\/span><\/li>\n  <li>est<span class='match'>ado<\/span><\/li>\n  <li>est<span class='match'>ado<\/span>s<\/li>\n  <li>ferna<span class='match'>ndo<\/span><\/li>\n  <li>fo<span class='match'>ndo<\/span><\/li>\n  <li>gr<span class='match'>ado<\/span><\/li>\n  <li>hacie<span class='match'>ndo<\/span><\/li>\n  <li>l<span class='match'>ado<\/span><\/li>\n  <li>llam<span class='match'>ado<\/span><\/li>\n  <li>lleg<span class='match'>ado<\/span><\/li>\n  <li>merc<span class='match'>ado<\/span><\/li>\n  <li>mu<span class='match'>ndo<\/span><\/li>\n  <li>pas<span class='match'>ado<\/span><\/li>\n  <li>result<span class='match'>ado<\/span><\/li>\n  <li>result<span class='match'>ado<\/span>s<\/li>\n  <li>segu<span class='match'>ndo<\/span><\/li>\n  <li>sie<span class='match'>ndo<\/span><\/li>\n  <li>trabaj<span class='match'>ado<\/span>res<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
```

</div> 
    

2.  ¿Siempre a una "q" la sigue una "u"?

<div class="solucion">
<h3>Solución</h3>

Podemos buscar las "q" y ver qué las sigue:

```r
str_subset(palabras, "q.")
#>  [1] "aquel"     "aquella"   "aquellas"  "aquellos"  "aquí"      "aunque"   
#>  [7] "cualquier" "equipo"    "izquierda" "pequeña"   "pequeño"   "porque"   
#> [13] "que"       "qué"       "queda"     "quedó"     "quería"    "quien"    
#> [19] "quién"     "quienes"   "quiere"    "quiero"    "quizá"     "siquiera"
```

O podemos buscar al revés: si a alguna "q" la sigue algo que no sea una "u":

```r
str_subset(palabras, "q[^u]")
#> character(0)
```


</div> 


3.  Escribe una expresión regular que permita buscar un verbo que haya sido escrito usando voseo en segunda persona plural  
    (por ejemplo, _queréis_ en vez de _quieren_).

<div class="solucion">
<h3>Solución</h3>




```r
segunda_persona <- c("queréis", "quieren")
str_view(segunda_persona, "éis$", match = TRUE)
```

```{=html}
<div id="htmlwidget-d11fc4360aa0230696d7" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-d11fc4360aa0230696d7">{"x":{"html":"<ul>\n  <li>quer<span class='match'>éis<\/span><\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
```


</div> 


4.  Crea una expresión regular que coincida con la forma en que habitualmente 
    se escriben los números de teléfono en tu país.

<div class="solucion">
<h3>Solución</h3>
La respuesta varía según país y a veces dentro de un mismo país no siempre se usa un mismo formato. Para este ejercicio trataremos de encontrar este patrón: "(XX) XXX XX XX", es decir, un código de ciudad entre paréntesis y el número separado en bloques de 3-2-2 dígitos con un espacio entre medio. Los dígitos pueden representarse como `[0-9]` o `\\d`


```r
telefonos <- c("(32) 281 91 76", "(32)2819176", "(32)281 9176")
str_view(telefonos, "\\(\\d\\d\\) \\d\\d\\d \\d\\d \\d\\d")
```

```{=html}
<div id="htmlwidget-21c7483268bafca56cec" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-21c7483268bafca56cec">{"x":{"html":"<ul>\n  <li><span class='match'>(32) 281 91 76<\/span><\/li>\n  <li>(32)2819176<\/li>\n  <li>(32)281 9176<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
```

Este código podría simplificarse si es que utilizáramos algún modificador que nos permita controlar la repetición de patrones. En la próxima sesión se aborda este tema. 

</div> 

    
5. En inglés existe una regla que dice que la letra i va siempre antes de la e, excepto cuando está después de una c". Verifica empíricamente esta regla utilizando las palabras contenidas en `stringr::words`. 

<div class="solucion">
<h3>Solución</h3>

Para comprobar esta regla primero podríamos buscar si existe el patrón: `cie`

```r
str_subset(words, "cie")
#> [1] "science" "society"
```
¡Hay dos palabras que indicarían que la excepción no se cumple siempre!
¿Y hay casos en los que la letra i va después de la e sin que esté precedida de una c?


```r
str_subset(words, "[^c]ei")
#> [1] "weigh"
```
Hay uno. 
Puede que estas sean excepciones, así que para ver qué tan frecuente es el patrón que indica la regla, busquemos las palabras en que sí se cumple


```r
str_subset(words, "[^c]ie|cei")
#>  [1] "achieve"    "believe"    "brief"      "client"     "die"       
#>  [6] "experience" "field"      "friend"     "lie"        "piece"     
#> [11] "quiet"      "receive"    "tie"        "view"
```
Son muchas más.


</div> 

### 14.2.10 Repetición{-#repeticion}

#### 14.2.10.1 Ejercicios{-#ejercicios-142101}

1.  Describe los equivalentes de `?`, `+`, `*` en el formato `{m,n}`.

<div class="solucion">
<h3>Solución</h3>

`?` = `{0,1}` = una sola coincidencia

`+` = `{1,}` = uno o más coincidencias

`*` = `{0,}`= cero o más coincidencias


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

`^.*$`: es una expresión regular que coincidiría con cualquier cadena de caracteres, incluso si no tiene nada en su interior. La expresión regular buscar cualquier caracter (`.`) que aparezca 0 o más veces (`*`) al inicio (`^`) o al final `$` de una cadena de caracteres:


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

`"\\{.+\\}"`: es la cadena que representa una expresión regular coincidiría con `{}` y lo que tengan dentro, siempre que tenga al menos un caracter (`.+`):


```r
cadena <- c("uno {dos} tres", "uno {} tres", "uno {2} tres")

str_view(cadena, "\\{.+\\}")
```

```{=html}
<div id="htmlwidget-1834a22cd196f3aa03a1" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-1834a22cd196f3aa03a1">{"x":{"html":"<ul>\n  <li>uno <span class='match'>{dos}<\/span> tres<\/li>\n  <li>uno {} tres<\/li>\n  <li>uno <span class='match'>{2}<\/span> tres<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
```


La expresión regular `\d{4}-\d{2}-\d{2}` coincide con secuencias de 4, 2 y 2 dígitos separados por un guión.


```r
numeros <- c("4444-22-22", "333-22-22", "88888888")
str_view(numeros, "\\d{4}-\\d{2}-\\d{2}")
```

```{=html}
<div id="htmlwidget-28515d92cb327f90c9eb" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-28515d92cb327f90c9eb">{"x":{"html":"<ul>\n  <li><span class='match'>4444-22-22<\/span><\/li>\n  <li>333-22-22<\/li>\n  <li>88888888<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
```

La cadena "\\\\{4}" coincidiría con una barra invertida repetida 4 veces:


```r
barras <- c("\\", "\\\\", "\\\\\\", "\\\\\\\\")
str_view(barras, "\\\\{4}")
```

```{=html}
<div id="htmlwidget-0caf26d4e3c00206b0c5" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-0caf26d4e3c00206b0c5">{"x":{"html":"<ul>\n  <li>\\<\/li>\n  <li>\\\\<\/li>\n  <li>\\\\\\<\/li>\n  <li><span class='match'>\\\\\\\\<\/span><\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
```

</div> 


3.  Crea expresiones regulares para buscar todas las palabras que:

    1. Empiecen con dos consonantes.
    1. Tengan tres o más vocales seguidas.
    1. Tengan tres o más pares de vocal-consonante seguidos. 


<div class="solucion">
<h3>Solución</h3>

Para buscar palabras que empiecen con dos consonantes buscaremos la repetición de no-vocales al inicio de una cadena:


```r
str_view(palabras, "^[^aáeéiíoóuúü]{2}", match = TRUE)
```

```{=html}
<div id="htmlwidget-da0b268a2927f570ebf3" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-da0b268a2927f570ebf3">{"x":{"html":"<ul>\n  <li><span class='match'>bl<\/span>anca<\/li>\n  <li><span class='match'>bl<\/span>anco<\/li>\n  <li><span class='match'>ch<\/span>ile<\/li>\n  <li><span class='match'>cl<\/span>aro<\/li>\n  <li><span class='match'>cl<\/span>ase<\/li>\n  <li><span class='match'>cl<\/span>ub<\/li>\n  <li><span class='match'>cr<\/span>eación<\/li>\n  <li><span class='match'>cr<\/span>ecimiento<\/li>\n  <li><span class='match'>cr<\/span>eo<\/li>\n  <li><span class='match'>cr<\/span>isis<\/li>\n  <li><span class='match'>fl<\/span>ores<\/li>\n  <li><span class='match'>fr<\/span>ancia<\/li>\n  <li><span class='match'>fr<\/span>ancisco<\/li>\n  <li><span class='match'>fr<\/span>ente<\/li>\n  <li><span class='match'>gr<\/span>acias<\/li>\n  <li><span class='match'>gr<\/span>ado<\/li>\n  <li><span class='match'>gr<\/span>an<\/li>\n  <li><span class='match'>gr<\/span>ande<\/li>\n  <li><span class='match'>gr<\/span>andes<\/li>\n  <li><span class='match'>gr<\/span>upo<\/li>\n  <li><span class='match'>gr<\/span>upos<\/li>\n  <li><span class='match'>ll<\/span>ama<\/li>\n  <li><span class='match'>ll<\/span>amado<\/li>\n  <li><span class='match'>ll<\/span>ega<\/li>\n  <li><span class='match'>ll<\/span>egado<\/li>\n  <li><span class='match'>ll<\/span>egar<\/li>\n  <li><span class='match'>ll<\/span>egó<\/li>\n  <li><span class='match'>ll<\/span>eva<\/li>\n  <li><span class='match'>ll<\/span>evar<\/li>\n  <li><span class='match'>pl<\/span>an<\/li>\n  <li><span class='match'>pl<\/span>aza<\/li>\n  <li><span class='match'>pl<\/span>azo<\/li>\n  <li><span class='match'>pp<\/span><\/li>\n  <li><span class='match'>pr<\/span>áctica<\/li>\n  <li><span class='match'>pr<\/span>ecio<\/li>\n  <li><span class='match'>pr<\/span>ecios<\/li>\n  <li><span class='match'>pr<\/span>ecisamente<\/li>\n  <li><span class='match'>pr<\/span>egunta<\/li>\n  <li><span class='match'>pr<\/span>emio<\/li>\n  <li><span class='match'>pr<\/span>ensa<\/li>\n  <li><span class='match'>pr<\/span>esencia<\/li>\n  <li><span class='match'>pr<\/span>esenta<\/li>\n  <li><span class='match'>pr<\/span>esente<\/li>\n  <li><span class='match'>pr<\/span>esidente<\/li>\n  <li><span class='match'>pr<\/span>imer<\/li>\n  <li><span class='match'>pr<\/span>imera<\/li>\n  <li><span class='match'>pr<\/span>imeras<\/li>\n  <li><span class='match'>pr<\/span>imero<\/li>\n  <li><span class='match'>pr<\/span>imeros<\/li>\n  <li><span class='match'>pr<\/span>incipal<\/li>\n  <li><span class='match'>pr<\/span>incipales<\/li>\n  <li><span class='match'>pr<\/span>incipio<\/li>\n  <li><span class='match'>pr<\/span>incipios<\/li>\n  <li><span class='match'>pr<\/span>oblema<\/li>\n  <li><span class='match'>pr<\/span>oblemas<\/li>\n  <li><span class='match'>pr<\/span>oceso<\/li>\n  <li><span class='match'>pr<\/span>oducción<\/li>\n  <li><span class='match'>pr<\/span>oduce<\/li>\n  <li><span class='match'>pr<\/span>oducto<\/li>\n  <li><span class='match'>pr<\/span>oductos<\/li>\n  <li><span class='match'>pr<\/span>ofesional<\/li>\n  <li><span class='match'>pr<\/span>ograma<\/li>\n  <li><span class='match'>pr<\/span>ogramas<\/li>\n  <li><span class='match'>pr<\/span>onto<\/li>\n  <li><span class='match'>pr<\/span>opia<\/li>\n  <li><span class='match'>pr<\/span>opio<\/li>\n  <li><span class='match'>pr<\/span>opios<\/li>\n  <li><span class='match'>pr<\/span>opuesta<\/li>\n  <li><span class='match'>pr<\/span>óximo<\/li>\n  <li><span class='match'>pr<\/span>oyecto<\/li>\n  <li><span class='match'>pr<\/span>oyectos<\/li>\n  <li><span class='match'>pr<\/span>ueba<\/li>\n  <li><span class='match'>ps<\/span>oe<\/li>\n  <li><span class='match'>tr<\/span>abajadores<\/li>\n  <li><span class='match'>tr<\/span>abajar<\/li>\n  <li><span class='match'>tr<\/span>abajo<\/li>\n  <li><span class='match'>tr<\/span>as<\/li>\n  <li><span class='match'>tr<\/span>ata<\/li>\n  <li><span class='match'>tr<\/span>atamiento<\/li>\n  <li><span class='match'>tr<\/span>avés<\/li>\n  <li><span class='match'>tr<\/span>es<\/li>\n  <li><span class='match'>tr<\/span>ibunal<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
```

Palabras con tres o más vocales seguidas

```r
str_view(palabras, "[aáeéiíoóuúü]{3,}", match = TRUE)
```

```{=html}
<div id="htmlwidget-0ed12bb554391c49c2e3" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-0ed12bb554391c49c2e3">{"x":{"html":"<ul>\n  <li>alg<span class='match'>uie<\/span>n<\/li>\n  <li>cualq<span class='match'>uie<\/span>r<\/li>\n  <li>izq<span class='match'>uie<\/span>rda<\/li>\n  <li>q<span class='match'>uie<\/span>n<\/li>\n  <li>q<span class='match'>uié<\/span>n<\/li>\n  <li>q<span class='match'>uie<\/span>nes<\/li>\n  <li>q<span class='match'>uie<\/span>re<\/li>\n  <li>q<span class='match'>uie<\/span>ro<\/li>\n  <li>sig<span class='match'>uie<\/span>nte<\/li>\n  <li>sig<span class='match'>uie<\/span>ntes<\/li>\n  <li>siq<span class='match'>uie<\/span>ra<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
```

Palabras que tengan tres o más pares de vocal-consonante seguidos:


```r
str_view(palabras, "([aáeéiíoóuúü][^aáeéiíoóuúü]){3,}", match = TRUE)
```

```{=html}
<div id="htmlwidget-ec658d41f8c4f2d124e9" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-ec658d41f8c4f2d124e9">{"x":{"html":"<ul>\n  <li>act<span class='match'>ividad<\/span><\/li>\n  <li>act<span class='match'>ividades<\/span><\/li>\n  <li><span class='match'>adelan<\/span>te<\/li>\n  <li><span class='match'>además<\/span><\/li>\n  <li>alr<span class='match'>ededor<\/span><\/li>\n  <li><span class='match'>améric<\/span>a<\/li>\n  <li><span class='match'>amigos<\/span><\/li>\n  <li><span class='match'>análisis<\/span><\/li>\n  <li><span class='match'>animales<\/span><\/li>\n  <li><span class='match'>aparec<\/span>e<\/li>\n  <li><span class='match'>apenas<\/span><\/li>\n  <li><span class='match'>asimis<\/span>mo<\/li>\n  <li>a<span class='match'>utoridades<\/span><\/li>\n  <li>c<span class='match'>alidad<\/span><\/li>\n  <li>c<span class='match'>apacidad<\/span><\/li>\n  <li>c<span class='match'>apital<\/span><\/li>\n  <li>c<span class='match'>omunicac<\/span>ión<\/li>\n  <li>c<span class='match'>omunidad<\/span><\/li>\n  <li>c<span class='match'>onocer<\/span><\/li>\n  <li>c<span class='match'>onocim<\/span>iento<\/li>\n  <li>c<span class='match'>orazón<\/span><\/li>\n  <li>d<span class='match'>iferen<\/span>cia<\/li>\n  <li>d<span class='match'>iferen<\/span>tes<\/li>\n  <li>d<span class='match'>ifícil<\/span><\/li>\n  <li>d<span class='match'>ólares<\/span><\/li>\n  <li><span class='match'>econom<\/span>ía<\/li>\n  <li><span class='match'>económic<\/span>a<\/li>\n  <li><span class='match'>económic<\/span>o<\/li>\n  <li><span class='match'>educac<\/span>ión<\/li>\n  <li><span class='match'>elemen<\/span>tos<\/li>\n  <li>esp<span class='match'>añoles<\/span><\/li>\n  <li><span class='match'>evitar<\/span><\/li>\n  <li>g<span class='match'>eneral<\/span><\/li>\n  <li>g<span class='match'>enerales<\/span><\/li>\n  <li>h<span class='match'>umanos<\/span><\/li>\n  <li><span class='match'>imagen<\/span><\/li>\n  <li><span class='match'>imágenes<\/span><\/li>\n  <li>int<span class='match'>ereses<\/span><\/li>\n  <li>j<span class='match'>óvenes<\/span><\/li>\n  <li>m<span class='match'>ayores<\/span><\/li>\n  <li>m<span class='match'>edidas<\/span><\/li>\n  <li>m<span class='match'>ejores<\/span><\/li>\n  <li>m<span class='match'>ilitar<\/span><\/li>\n  <li>m<span class='match'>ilitares<\/span><\/li>\n  <li>m<span class='match'>inutos<\/span><\/li>\n  <li>m<span class='match'>ujeres<\/span><\/li>\n  <li>n<span class='match'>atural<\/span><\/li>\n  <li>n<span class='match'>aturalez<\/span>a<\/li>\n  <li>n<span class='match'>ecesar<\/span>io<\/li>\n  <li>n<span class='match'>ecesidad<\/span><\/li>\n  <li>n<span class='match'>iveles<\/span><\/li>\n  <li><span class='match'>operac<\/span>ión<\/li>\n  <li><span class='match'>oposic<\/span>ión<\/li>\n  <li>org<span class='match'>anizac<\/span>ión<\/li>\n  <li><span class='match'>origen<\/span><\/li>\n  <li>part<span class='match'>icipac<\/span>ión<\/li>\n  <li>part<span class='match'>icular<\/span><\/li>\n  <li>p<span class='match'>elícul<\/span>a<\/li>\n  <li>p<span class='match'>esetas<\/span><\/li>\n  <li>p<span class='match'>odemos<\/span><\/li>\n  <li>p<span class='match'>olític<\/span>a<\/li>\n  <li>p<span class='match'>olíticas<\/span><\/li>\n  <li>p<span class='match'>olític<\/span>o<\/li>\n  <li>p<span class='match'>olíticos<\/span><\/li>\n  <li>p<span class='match'>opular<\/span><\/li>\n  <li>p<span class='match'>osibilidad<\/span><\/li>\n  <li>p<span class='match'>osibilidades<\/span><\/li>\n  <li>pr<span class='match'>ecisamen<\/span>te<\/li>\n  <li>pr<span class='match'>esiden<\/span>te<\/li>\n  <li>pr<span class='match'>imeras<\/span><\/li>\n  <li>pr<span class='match'>imeros<\/span><\/li>\n  <li>princ<span class='match'>ipales<\/span><\/li>\n  <li>r<span class='match'>azones<\/span><\/li>\n  <li>re<span class='match'>alidad<\/span><\/li>\n  <li>re<span class='match'>alizar<\/span><\/li>\n  <li>r<span class='match'>égimen<\/span><\/li>\n  <li>r<span class='match'>evoluc<\/span>ión<\/li>\n  <li>s<span class='match'>eguridad<\/span><\/li>\n  <li>s<span class='match'>emanas<\/span><\/li>\n  <li>s<span class='match'>olamen<\/span>te<\/li>\n  <li>t<span class='match'>elevis<\/span>ión<\/li>\n  <li>t<span class='match'>enemos<\/span><\/li>\n  <li>tr<span class='match'>abajadores<\/span><\/li>\n  <li>tr<span class='match'>abajar<\/span><\/li>\n  <li>tr<span class='match'>ibunal<\/span><\/li>\n  <li><span class='match'>unidad<\/span><\/li>\n  <li><span class='match'>unidos<\/span><\/li>\n  <li><span class='match'>univer<\/span>sidad<\/li>\n  <li>v<span class='match'>alores<\/span><\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
```

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

La expresión regular `(.)\1\1` coincide con cualquier caracter repetido tres veces seguidas.


```r
str_view(c("a", "aa", "aaa", "aaaa"), "(.)\\1\\1")
```

```{=html}
<div id="htmlwidget-6b83523733b890d61edc" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-6b83523733b890d61edc">{"x":{"html":"<ul>\n  <li>a<\/li>\n  <li>aa<\/li>\n  <li><span class='match'>aaa<\/span><\/li>\n  <li><span class='match'>aaa<\/span>a<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
```

La cadena `"(.)(.)\\2\\1"` coincide con los dos caracteres capturados seguidos de los mismos dos caracteres pero en orden inverso:


```r
str_view(c("abba", "abab"), "(.)(.)\\2\\1")
```

```{=html}
<div id="htmlwidget-b3f7c917b6c8ff580948" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-b3f7c917b6c8ff580948">{"x":{"html":"<ul>\n  <li><span class='match'>abba<\/span><\/li>\n  <li>abab<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
```

La expresión regular `(..)\1` coincide con un par de letras que se repite dos veces:


```r
str_view(c("abba", "abab"), "(..)\\1")
```

```{=html}
<div id="htmlwidget-d258b2ee1c304ebe1664" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-d258b2ee1c304ebe1664">{"x":{"html":"<ul>\n  <li>abba<\/li>\n  <li><span class='match'>abab<\/span><\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
```

La cadena `"(.).\\1.\\1"` coicide con la secuencia: caracter capturado, otro caracter, caracter capturado, otro caracter, caracter capturado: 



```r
str_view(c("babab", "babeb", "abab"), "(.).\\1.\\1")
```

```{=html}
<div id="htmlwidget-b8f31ebacaee3527bb86" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-b8f31ebacaee3527bb86">{"x":{"html":"<ul>\n  <li><span class='match'>babab<\/span><\/li>\n  <li><span class='match'>babeb<\/span><\/li>\n  <li>abab<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
```

La cadena `"(.)(.)(.).*\\3\\2\\1"` coincide con los tres caracteres capturados, cero o más de otros caracteres y luego los tres caracteres capturados en orden inverso:



```r
str_view(c("abcdefgcba", "abccba", "abcabc"), "(.)(.)(.).*\\3\\2\\1")
```

```{=html}
<div id="htmlwidget-b25b670b028f478bf741" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-b25b670b028f478bf741">{"x":{"html":"<ul>\n  <li><span class='match'>abcdefgcba<\/span><\/li>\n  <li><span class='match'>abccba<\/span><\/li>\n  <li>abcabc<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
```

</div> 


2.  Construye una expresión regular que coincida con palabras que: 

    1. Empiecen y terminen con el mismo caracter. 
    
    1. Contengan un par de letras repetido
       (p. ej. "nacional" tiene "na" repetidos dos veces.)
    
    1. Contengan una letra repetida en al menos tres lugares
       (p. ej. "característica" tiene tres "a".)

<div class="solucion">
<h3>Solución</h3>

Para buscar palabras que empiecen y terminen con el mismo caracter:


```r
str_subset(palabras, "^(.).*\\1$")
#>  [1] "acerca"        "agua"          "ahora"         "alguna"       
#>  [5] "alta"          "américa"       "aquella"       "argentina"    
#>  [9] "arriba"        "ayuda"         "entre"         "ese"          
#> [13] "especialmente" "especie"       "este"          "existe"       
#> [17] "ii"            "local"         "ningún"        "objetivo"     
#> [21] "objeto"        "ocho"          "oro"           "otro"         
#> [25] "pp"            "realizar"      "sectores"      "seis"         
#> [29] "semanas"       "servicios"     "siguientes"    "sistemas"     
#> [33] "sociales"      "somos"         "sus"
```

Si bien el código permite encontrar lo que buscábamos, lo cierto es que ese patrón busca cadenas de caracteres que empiecen y terminen con el mismo caracter, no necesariamente una letra. Es decir, también coincidería con `#455#`. Si quisiéramos que solo encontrara letras:


```r
str_subset(palabras, "^([:alpha:]).*\\1$")
#>  [1] "acerca"        "agua"          "ahora"         "alguna"       
#>  [5] "alta"          "américa"       "aquella"       "argentina"    
#>  [9] "arriba"        "ayuda"         "entre"         "ese"          
#> [13] "especialmente" "especie"       "este"          "existe"       
#> [17] "ii"            "local"         "ningún"        "objetivo"     
#> [21] "objeto"        "ocho"          "oro"           "otro"         
#> [25] "pp"            "realizar"      "sectores"      "seis"         
#> [29] "semanas"       "servicios"     "siguientes"    "sistemas"     
#> [33] "sociales"      "somos"         "sus"
```


Palabras que contienen un par de letras repetido:


```r
str_subset(palabras, "([:alpha:][:alpha:]).*\\1")
#>  [1] "alrededor"       "análisis"        "asociación"      "características"
#>  [5] "ciencia"         "conciencia"      "condiciones"     "crisis"         
#>  [9] "desde"           "económico"       "encuentra"       "encuentran"     
#> [13] "encuentro"       "españoles"       "intereses"       "internacional"  
#> [17] "meses"           "nacional"        "nosotros"        "participación"  
#> [21] "particular"      "respuesta"       "tercera"         "tienen"         
#> [25] "vivir"
```

    
Palabras que contienen una letra repetida en al menos tres lugares:


```r
str_subset(palabras, "([:alpha:]).*\\1.*\\1")
#>  [1] "administración"  "campaña"         "capacidad"       "características"
#>  [5] "carrera"         "comunicación"    "conciencia"      "conocimiento"   
#>  [9] "consecuencia"    "construcción"    "diferentes"      "elecciones"     
#> [13] "elementos"       "encuentran"      "enfermedad"      "especialmente"  
#> [17] "especie"         "experiencia"     "generales"       "instituciones"  
#> [21] "instituto"       "intereses"       "internacional"   "investigación"  
#> [25] "mañana"          "ministerio"      "naturaleza"      "ningún"         
#> [29] "ninguna"         "nosotros"        "palabra"         "palabras"       
#> [33] "participación"   "posibilidad"     "posibilidades"   "precisamente"   
#> [37] "presente"        "presidente"      "principio"       "principios"     
#> [41] "septiembre"      "sistemas"        "trabajadores"    "trabajar"       
#> [45] "tratamiento"
```

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

Para encontrar todas las palabras que empiezan o terminan con `y` con una sola expresión regular:


```r
str_view(palabras, "^y|y$", match = TRUE)
```

```{=html}
<div id="htmlwidget-46d1193f7ba074d981c8" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-46d1193f7ba074d981c8">{"x":{"html":"<ul>\n  <li>esto<span class='match'>y<\/span><\/li>\n  <li>ha<span class='match'>y<\/span><\/li>\n  <li>ho<span class='match'>y<\/span><\/li>\n  <li>le<span class='match'>y<\/span><\/li>\n  <li>mu<span class='match'>y<\/span><\/li>\n  <li>re<span class='match'>y<\/span><\/li>\n  <li>so<span class='match'>y<\/span><\/li>\n  <li>vo<span class='match'>y<\/span><\/li>\n  <li><span class='match'>y<\/span><\/li>\n  <li><span class='match'>y<\/span>a<\/li>\n  <li><span class='match'>y<\/span>o<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
```

Con múltiples llamadas a `str_detect()`:

```r
palabras[str_detect(palabras, "^y") | str_detect(palabras, "y$")]
#>  [1] "estoy" "hay"   "hoy"   "ley"   "muy"   "rey"   "soy"   "voy"   "y"    
#> [10] "ya"    "yo"
```

    
Para encontrar todas las palabras que empiezan con una vocal y terminan con una consonante con una expresión regular:


```r
palabras %>% 
    str_subset("^[aáeéiíoóuúü].*[^aáeéiíoóuúü]$") %>% 
    head(n = 10) # son muchas así que miraremos las 10 primeras
#>  [1] "abril"          "acción"         "acciones"       "actitud"       
#>  [5] "actividad"      "actividades"    "actual"         "además"        
#>  [9] "administración" "al"
```

Con múltiples llamadas a `str_detect()`:


```r
palabras[str_detect(palabras, "^[aáeéiíoóuú]") & str_detect(palabras, "[^aáeéiíoóuú]$")][1:10]
#>  [1] "abril"          "acción"         "acciones"       "actitud"       
#>  [5] "actividad"      "actividades"    "actual"         "además"        
#>  [9] "administración" "al"
```

¿Existen palabras que tengan todas las vocales? Para resolver esto con una sola expresión regular:


```r
palabras[str_detect(palabras, "(?=.*(a|á))(?=.*(e|é))(?=.*(i|í))(?=.*(o|o))(?=.*(u|ú|ü))")]
#> [1] "autoridades"  "consecuencia"
```

Con varias llamas a `str_detect()`


```r
palabras[str_detect(palabras, "a|á") &
  str_detect(palabras, "e|é") &
  str_detect(palabras, "i|í") &
  str_detect(palabras, "o|o") &
  str_detect(palabras, "u|ú|ü")]
#> [1] "autoridades"  "consecuencia"
```

</div> 


2.  ¿Qué palabra tiene el mayor número de vocales? ¿Qué palabra tiene la mayor
    proporción de vocales? (Pista: ¿cuál es el denominador?)

<div class="solucion">
<h3>Solución</h3>

Para responder esta pregunta tenemos que contar la cantidad de vocales y además calcular su proporción respecto del total de letras de la palabra. Hay varias formas de resolver esto. La que usaremos acá será crear un tibble y usar las funciones de **stringr** dentro de `mutate`:


```r
df <- palabras %>% 
    tibble(palabra = .) %>% 
    mutate(largo = str_length(palabra)) %>% 
    mutate(vocales = str_count(palabra, "[aáeéiíoóuúü]")) %>% 
    mutate(prop_vocales = vocales / largo)
```

Ahora podemos responder las preguntas. Las palabras con más vocales en este set de datos tienen 6 en total. Son 15:


```r
top_n(df, 1, vocales)
#> # A tibble: 15 × 4
#>   palabra         largo vocales prop_vocales
#>   <chr>           <int>   <int>        <dbl>
#> 1 administración     14       6        0.429
#> 2 asociación         10       6        0.6  
#> 3 autoridades        11       6        0.545
#> 4 características    15       6        0.4  
#> 5 comunicación       12       6        0.5  
#> 6 conocimiento       12       6        0.5  
#> # … with 9 more rows
```

Hay palabras solo compuestas por vocales. Cuatro son efectivamente palabras (una preposición y tres conjunciones) y dos son vocales que se usan para numerar ("i", "ii"):

```r
top_n(df, 1, prop_vocales)
#> # A tibble: 6 × 4
#>   palabra largo vocales prop_vocales
#>   <chr>   <int>   <int>        <dbl>
#> 1 a           1       1            1
#> 2 e           1       1            1
#> 3 i           1       1            1
#> 4 ii          2       2            1
#> 5 o           1       1            1
#> 6 u           1       1            1
```


</div> 


### 14.3.3 Extraer coincidencias{-#extraer-coincidencias}


#### 14.3.3.1 Ejercicios{-#ejercicios-14331}

1.  Te habrás dado cuenta que en el ejemplo anterior la expresión regular
    que utilizamos también devolvió como resultado "arrojo" y "azulejos", 
    que no son nombres de colores. Modifica la expresión regular para 
    resolver ese problema.
    
<div class="solucion">
<h3>Solución</h3>

En principio, para asegurarnos que solo busque nuestro patrón de manera exacta podríamos indicar límites de palabra con `\\b`. Con el inicio no tendríamos problemas y eso eliminaría "arrojo". Sin embargo, si ponemos el límite de final de palabra no solo eliminaría "azulejo" sino también "verdes". Para este ejemplo en particular no importa porque estamos buscando más de una coincidencia por cadena y "verdes" está en la misma cadena que azulajos (es decir, al eliminar esta última palabra queda un solo color en la cadena y por tanto que no responde a lo que estamos buscando). Pero si hubiese otro caso de color en plural sí tendríamos que modificar nuestro patrón.
Una manera de resolver esto sería que nuestro patrón busque también las versiones en plural de los colores que indicamos. Y para hacerlo mejor aún, que busque también cuando el adjetivo sea femenino o masculino:


```r
# agregamos la opción de plural
colores <- c("roj(a|o)s*", "amarill(a|o)s*", "verde", "azul(es)*", "marr(o|ó)n")

# agregamos límites de palabra al inicio y al final
coincidencia_color <- str_c("\\b(", str_c(colores, collapse = "|"), ")\\b")
tiene_color <- str_subset(oraciones, coincidencia_color)
mas <- oraciones[str_count(oraciones, coincidencia_color) > 1]
str_view_all(mas, coincidencia_color)
```

```{=html}
<div id="htmlwidget-382a200f56fb8e6a1fd3" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-382a200f56fb8e6a1fd3">{"x":{"html":"<ul>\n  <li>Las hojas se vuelven de color <span class='match'>marrón<\/span> y <span class='match'>amarillo<\/span> en el otoño.<\/li>\n  <li>La luz <span class='match'>verde<\/span> en la caja <span class='match'>marrón<\/span> parpadeaba.<\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>

# chequear que encuentra también colores en plural y adjetivos femeninos en otros ejemplos:

otras_oraciones <- c("amarillas y rojas", "rojas y azules")
otras_oraciones[str_count(otras_oraciones, coincidencia_color) > 1]
#> [1] "amarillas y rojas" "rojas y azules"
```


</div> 

2.  De `datos::oraciones` extrae:

    1. La primera palabra de cada oración.
    1. Todas las palabras que terminen en `ción`.
    1. Todos los plurales.

<div class="solucion">
<h3>Solución</h3>

Como cada oración es una cadena, podemos extraer la primera palabra de cada oración con `\\w`, que busca cualquier caracter de palabra con un ancla al inicio y un límite de palabra al final. Otra forma de buscar solo caracteres de palabras es con `[:alpha:]`:


```r
str_extract(oraciones, "^(\\w+)\\b")
#>  [1] "Las"         "La"          "El"          "Agrega"      "Nueve"      
#>  [6] "Pega"        "Instalaron"  "Si"          "Dos"         "El"         
#> [11] "Una"         "Las"         "Él"          "La"          "Había"      
#> [16] "El"          "El"          "El"          "Podían"      "El"         
#> [21] "Una"         "Los"         "El"          "La"          "El"         
#> [26] "La"          "El"          "Recuéstate"  "El"          "Marca"      
#> [31] "El"          "La"          "Ofreció"     "Un"          "El"         
#> [36] "Una"         "Dibuja"      "La"          "Pinta"       "Despiértate"
#> [41] "La"          "Puso"        "El"          "Corta"       "Llovieron"  
#> [46] "El"          "El"          "La"          "El"          "Cada"
str_extract(oraciones, "^([:alpha:]+)\\b")
#>  [1] "Las"         "La"          "El"          "Agrega"      "Nueve"      
#>  [6] "Pega"        "Instalaron"  "Si"          "Dos"         "El"         
#> [11] "Una"         "Las"         "Él"          "La"          "Había"      
#> [16] "El"          "El"          "El"          "Podían"      "El"         
#> [21] "Una"         "Los"         "El"          "La"          "El"         
#> [26] "La"          "El"          "Recuéstate"  "El"          "Marca"      
#> [31] "El"          "La"          "Ofreció"     "Un"          "El"         
#> [36] "Una"         "Dibuja"      "La"          "Pinta"       "Despiértate"
#> [41] "La"          "Puso"        "El"          "Corta"       "Llovieron"  
#> [46] "El"          "El"          "La"          "El"          "Cada"
```

Es posible encontrar también el siguiente patrón para representar caracteres de palabras: `[a-z]` o `[A-Za-z]` (para que busque mayúsculas también)- Sin embargo, hay que tener cuidado con su utilización en español, ya que no reconoce tildes. En este mismo ejemplo, nos devuelve `NA` en todas las palabras en las que hay tildes:


```r
str_extract(oraciones, "^([A-Za-z]+)\\b")
#>  [1] "Las"        "La"         "El"         "Agrega"     "Nueve"     
#>  [6] "Pega"       "Instalaron" "Si"         "Dos"        "El"        
#> [11] "Una"        "Las"        NA           "La"         NA          
#> [16] "El"         "El"         "El"         NA           "El"        
#> [21] "Una"        "Los"        "El"         "La"         "El"        
#> [26] "La"         "El"         NA           "El"         "Marca"     
#> [31] "El"         "La"         NA           "Un"         "El"        
#> [36] "Una"        "Dibuja"     "La"         "Pinta"      NA          
#> [41] "La"         "Puso"       "El"         "Corta"      "Llovieron" 
#> [46] "El"         "El"         "La"         "El"         "Cada"
```

</div> 

### 14.3.4 Coincidencias agrupadas{-#coincidencias-agrupadas}

#### 14.3.4.1 Ejercicios{-#ejercicios-14341}

1. Busca en `datos::oraciones` todas las palabras que vengan después de un "número", como "un(o|a)", "dos", "tres", etc.
   Extrae tanto el número como la palabra.

<div class="solucion">
<h3>Solución</h3>

Responderemos esta pregunta para números del 1 al 10 utilizando las dos formas recién vistas: `str_match()` y `tidyr::extract()`:


```r
numero_palabra <- "(una*o*|dos|tres|cuatro|cinco|seis|siete|ocho|nueve|diez) ([^ ]+)"

str_match(oraciones, numero_palabra)
#>       [,1]             [,2]   [,3]        
#>  [1,] NA               NA     NA          
#>  [2,] NA               NA     NA          
#>  [3,] NA               NA     NA          
#>  [4,] NA               NA     NA          
#>  [5,] "dos para"       "dos"  "para"      
#>  [6,] NA               NA     NA          
#>  [7,] NA               NA     NA          
#>  [8,] NA               NA     NA          
#>  [9,] NA               NA     NA          
#> [10,] NA               NA     NA          
#> [11,] NA               NA     NA          
#> [12,] NA               NA     NA          
#> [13,] NA               NA     NA          
#> [14,] NA               NA     NA          
#> [15,] NA               NA     NA          
#> [16,] NA               NA     NA          
#> [17,] NA               NA     NA          
#> [18,] "dos pastillas." "dos"  "pastillas."
#> [19,] NA               NA     NA          
#> [20,] NA               NA     NA          
#> [21,] "una ave"        "una"  "ave"       
#> [22,] NA               NA     NA          
#> [23,] NA               NA     NA          
#> [24,] "una llama"      "una"  "llama"     
#> [25,] NA               NA     NA          
#> [26,] NA               NA     NA          
#> [27,] "diez años."     "diez" "años."     
#> [28,] NA               NA     NA          
#> [29,] NA               NA     NA          
#> [30,] "un cartel"      "un"   "cartel"    
#> [31,] NA               NA     NA          
#> [32,] NA               NA     NA          
#> [33,] "tres gráficos." "tres" "gráficos." 
#> [34,] "un suéter"      "un"   "suéter"    
#> [35,] NA               NA     NA          
#> [36,] NA               NA     NA          
#> [37,] NA               NA     NA          
#> [38,] NA               NA     NA          
#> [39,] NA               NA     NA          
#> [40,] NA               NA     NA          
#> [41,] NA               NA     NA          
#> [42,] NA               NA     NA          
#> [43,] NA               NA     NA          
#> [44,] "una delgada"    "una"  "delgada"   
#> [45,] "dos lados."     "dos"  "lados."    
#> [46,] NA               NA     NA          
#> [47,] NA               NA     NA          
#> [48,] NA               NA     NA          
#> [49,] NA               NA     NA          
#> [50,] NA               NA     NA

tibble(oracion = oraciones) %>% 
    tidyr::extract(
        oracion, c("numero", "palabra"), numero_palabra,
        remove = FALSE
    ) %>% 
    filter(!is.na(palabra)) # solo ver las filas con resultados
#> # A tibble: 10 × 3
#>   oracion                                                   numero palabra   
#>   <chr>                                                     <chr>  <chr>     
#> 1 Nueve hombres fueron contratados para excavar las ruinas. dos    para      
#> 2 El médico lo curó con estas dos pastillas.                dos    pastillas.
#> 3 Una grulla azul es una ave zancuda y alta.                una    ave       
#> 4 La lámpara brillaba con una llama verde y continua.       una    llama     
#> 5 El lazo púrpura tenía diez años.                          diez   años.     
#> 6 Marca el lugar con un cartel pintado de rojo.             un     cartel    
#> # … with 4 more rows
```

Para definir lo que es una palabra utilizamos la misma heurística propuesta en esta sección del libro, es decir, todo lo que no es un espacio. Sin embargo, esto hace que se extraigan también los puntos. Una manera de evitarlo es utilizar `\\w`:


```r
numero_palabra2 <- "(una*o*|dos|tres|cuatro|cinco|seis|siete|ocho|nueve|diez) (\\w+)"

tibble(oracion = oraciones) %>% 
    tidyr::extract(
        oracion, c("numero", "palabra"), numero_palabra2,
        remove = FALSE
    ) %>% 
    filter(!is.na(palabra)) # solo ver las filas con resultados
#> # A tibble: 10 × 3
#>   oracion                                                   numero palabra  
#>   <chr>                                                     <chr>  <chr>    
#> 1 Nueve hombres fueron contratados para excavar las ruinas. dos    para     
#> 2 El médico lo curó con estas dos pastillas.                dos    pastillas
#> 3 Una grulla azul es una ave zancuda y alta.                una    ave      
#> 4 La lámpara brillaba con una llama verde y continua.       una    llama    
#> 5 El lazo púrpura tenía diez años.                          diez   a        
#> 6 Marca el lugar con un cartel pintado de rojo.             un     cartel   
#> # … with 4 more rows
```

</div> 


2. En español a veces se utiliza el guión para unir adjetivos, establecer relaciones entre conceptos o para unir gentilicios (p. ej., _teórico-práctico_, _precio-calidad_, _franco-porteño_). ¿Cómo podrías encontrar esas palabras y separar lo que viene antes y después del guión?

<div class="solucion">
<h3>Solución</h3>

Para separar las palabras podemos utilizar la función `str_split()`

```r

compuestas <- c("teórico-práctico", "precio-calidad", "franco-porteño")
tiene_guion <- "\\w+-\\w+"

str_extract(compuestas, tiene_guion) %>% 
    str_split("-")
#> [[1]]
#> [1] "teórico"  "práctico"
#> 
#> [[2]]
#> [1] "precio"  "calidad"
#> 
#> [[3]]
#> [1] "franco"  "porteño"
```

Si quisiéramos hacer esto mismo en el contexto de un _data frame_, podríamos utilizar la función `tidyr::separate`:


```r
tibble(palabras_compuestas = compuestas) %>% 
    tidyr::separate(palabras_compuestas, 
        c("palabra1", "palabra2"), 
        sep = "-", 
        remove = FALSE) # para no eliminar la columna original
#> # A tibble: 3 × 3
#>   palabras_compuestas palabra1 palabra2
#>   <chr>               <chr>    <chr>   
#> 1 teórico-práctico    teórico  práctico
#> 2 precio-calidad      precio   calidad 
#> 3 franco-porteño      franco   porteño
```

</div> 


### 14.3.5 Remplazar coincidencias{-#remplazar-coincidencias}

#### 14.3.5.1 Ejercicios{-#ejercicios-14351}

1.   Remplaza en una cadena todas las barras por barras invertidas.

<div class="solucion">
<h3>Solución</h3>


```r
barras <- "una /, dos barras //, tres ///"
str_replace_all(barras, "/", "\\\\") %>% 
    writeLines()
#> una \, dos barras \\, tres \\\
```

</div> 


2.   Implementa una versón simple de `str_to_lower()` (_a minúsculas_) usando `replace_all()`.

<div class="solucion">
<h3>Solución</h3>

Una manera sería buscar todas las mayúsculas y remplazarlas por su versión en minúcula. 

```r
# Crear un vector con todos los remplazos:

a_minuscula <- c(  "A" = "a", "Á" = "á", "B" = "b", "C" = "c", "D" = "d", "E" = "e", "É" = "é","F" = "f", "G" = "g", "H" = "h", "I" = "i", "Í" = "í", "J" = "j", "K" = "k", "L" = "l", "M" = "m", "N" = "n", "Ñ" = "ñ","O" = "o", "Ó" = "ó", "P" = "p", "Q" = "q", "R" = "r", "S" = "s", "T" = "t", "U" = "u", "Ú" = "ú","V" = "v", "W" = "w", "X" = "x", "Y" = "y", "Z" = "z")

mayusculas <- c("Hola", "Buenos días", "Adiós")

str_replace_all(mayusculas, pattern = a_minuscula)
#> [1] "hola"        "buenos días" "adiós"
```

</div> 


3.   Cambia la primera y la última letra en `palabras`. ¿Cuáles de esas cadenas
     siguen siendo palabras?

<div class="solucion">
<h3>Solución</h3>

Primero, cambiemos la primera y la última letra. Para esto podemos utilizar grupos de captura y referencias previas.

El patrón que queremos buscar son nuestros tres grupos de captura tendría que ser: 
1. la primera letra (`^([:alpha:])`)
2. de la segunda a la penúltima letra (`(.*)`)
3. la última letra (`([:alpha:])$`)

Luego, remplazamos con nuestro patrón con el primer y el último grupo invertido: `"\\3\\2\\1"`


```r
invertidas <- str_replace_all(palabras, "^([:alpha:])(.*)([:alpha:])$", "\\3\\2\\1") 

head(invertidas)
#> [1] "a"        "lbria"    "nccióa"   "sccionea" "acerca"   "dctitua"
```

La segunda pregunta es un poco amplia e implicaría revisar las 1000 palabras y evaluar en cada caso si es o no una palabra de nuestra lengua. Lo que sí podemos hacer es chequear si sigue siendo una palabra contenida en nuestro dataset `palabras`. Para ello, podemos utilizar `dplyr::interset`. Para eliminar las palabras y abreviaciones que tienen una sola letra ("y", "a", "o", etc.), podemos comparar `invertidas` solo con las palabras de dos o más letras: 


```r
intersect(invertidas, palabras[str_length(palabras) > 1])
#>  [1] "acerca"        "agua"          "ahora"         "la"           
#>  [5] "alguna"        "alta"          "américa"       "aquella"      
#>  [9] "argentina"     "arriba"        "ayuda"         "le"           
#> [13] "entre"         "se"            "ese"           "especialmente"
#> [17] "especie"       "este"          "existe"        "ii"           
#> [21] "al"            "el"            "local"         "sol"          
#> [25] "ningún"        "son"           "objetivo"      "objeto"       
#> [29] "ocho"          "oro"           "otro"          "pp"           
#> [33] "realizar"      "es"            "sectores"      "seis"         
#> [37] "semanas"       "servicios"     "siguientes"    "sistemas"     
#> [41] "sociales"      "los"           "somos"         "nos"          
#> [45] "sus"
```


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

El ejemplo que aparece en el libro muestra uno de los problemas de `" "`: no elimina la puntuación. Es decir, no es capaz de indentificar claramente los límites de una palabra. `boundary("word")` no tiene ese problema.

```r
x <- "Esta es una oración. Esta es otra oración"
str_split(x, " ")[[1]]
#> [1] "Esta"     "es"       "una"      "oración." "Esta"     "es"       "otra"    
#> [8] "oración"
str_split(x, boundary("word"))[[1]]
#> [1] "Esta"    "es"      "una"     "oración" "Esta"    "es"      "otra"   
#> [8] "oración"
```


</div> 

3.  ¿Qué pasa si dividimos con una cadena vacía (`""`)? Experimenta y
    luego lee la documentación

<div class="solucion">
<h3>Solución</h3>

Experimentemos:

```r
str_split("palabra", "")[[1]]
#> [1] "p" "a" "l" "a" "b" "r" "a"
str_split("una frase", "")[[1]]
#> [1] "u" "n" "a" " " "f" "r" "a" "s" "e"
```

Una cadena vacía `""` divide cada caracter de la cadena.

</div> 

## 14.4 Otro tipo de patrones {-#otros-patrones144}

### 14.4.1 Ejercicios{-#ejercicios-1441}

1.  ¿Cómo buscarías todas las cadenas que contienen `\` con `regex()` vs.
    con `fixed()`?

<div class="solucion">
<h3>Solución</h3>

La diferencia se encuentra en la cadena que representa la expresión regular:

```r
barras <- "una barra \\, dos barras \\\\, tres barras \\\\\\"
writeLines(barras)
#> una barra \, dos barras \\, tres barras \\\


str_view_all(barras, regex("\\\\"))
```

```{=html}
<div id="htmlwidget-da403bf8187c892ade73" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-da403bf8187c892ade73">{"x":{"html":"<ul>\n  <li>una barra <span class='match'>\\<\/span>, dos barras <span class='match'>\\<\/span><span class='match'>\\<\/span>, tres barras <span class='match'>\\<\/span><span class='match'>\\<\/span><span class='match'>\\<\/span><\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>

str_view_all(barras, fixed("\\"))
```

```{=html}
<div id="htmlwidget-756e3bf13eb93ebd21f9" style="width:960px;height:100%;" class="str_view html-widget"></div>
<script type="application/json" data-for="htmlwidget-756e3bf13eb93ebd21f9">{"x":{"html":"<ul>\n  <li>una barra <span class='match'>\\<\/span>, dos barras <span class='match'>\\<\/span><span class='match'>\\<\/span>, tres barras <span class='match'>\\<\/span><span class='match'>\\<\/span><span class='match'>\\<\/span><\/li>\n<\/ul>"},"evals":[],"jsHooks":[]}</script>
```


</div> 

2.  ¿Cuáles son las cinco palabras más comunes en `oraciones`?

<div class="solucion">
<h3>Solución</h3>
Para resolver esta pregunta tenemos que extraer cada palabra de forma individual y luego contar su frecuencia. 

Podemos extraer todas las palabras de forma individual utilizando el código al final de esta sección. Luego, podemos convertir eso en un tibble y contar. No hay que olvidar convertir todas las mayúsculas a minúsculas con `str_to_lower`


```r
str_extract_all(oraciones, boundary("word")) %>%
  unlist() %>% # convertimos la lista en vector
  tibble(palabra = .) %>%  #creamos un tibble
  count(str_to_lower(palabra)) %>% # contamos
  top_n(5) # buscamos las cinco más frecuentes
#> Selecting by n
#> # A tibble: 5 × 2
#>   `str_to_lower(palabra)`     n
#>   <chr>                   <int>
#> 1 de                         26
#> 2 el                         29
#> 3 en                         16
#> 4 la                         30
#> 5 y                          14
```

Como era de esperar, las palabras más frecuentes son palabras de función como preposiciones, artículos y conjunciones.

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

