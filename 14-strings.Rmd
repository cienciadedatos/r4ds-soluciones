# Cadenas de caracteres


## Cadenas: elementos básicos


### Ejercicios

1.  En ejemplos de código en los que no se utiliza __stringr__, verás usualmente `paste()` y `paste0()` (_paste_ = pegar).
    ¿Cuál es la diferencia entre estas dos funciones? ¿A qué función de __stringr__ son equivalentes? ¿Cómo difieren estas dos funciones respecto de su manejo de los
    `NA`?
    
1.  Describe con tus propias palabras la diferencia entre los argumentos `sep` y `collapse`
    de la función `str_c()`.

1.  Utiliza `str_length()` y `str_sub()` para extraer el caracter del medio de una cadena. ¿Qué harías si el número de caracteres es par?

1.  ¿Qué hace `str_wrap()`? (_wrap_ = envolver) ¿Cuándo podrías querer utilizarla?

1.  ¿Qué hace `str_trim()`? (_trim_ = recortar) ¿Cuál es el opuesto de `str_trim()`?

1.  Escribe una función que convierta, por ejemplo, el vector `c("a", "b", "c")` en
    la cadena `a, b, y c`. Piensa con detención qué debería hacer 
    dado un vector de largo 0, 1, o 2.

### Buscar coincidencia de patrones con expresiones regulares


#### Ejercicios

1.  Explica por qué cada una de estas cadenas no coincide con `\`: `"\"`, `"\\"`, `"\\\"`.

1.  ¿Cómo harías coincidir la secuencia `"'\`?

1.  ¿Con qué patrones coincidiría la expresión regular`\..\..\..`? 
    ¿Cómo la representarías en una cadena?

### Anclas


#### Ejercicios

1.  ¿Cómo harías coincidir la cadena `"$^$"` de manera literal?

1.  Dado el corpus de palabras comunes en `datos::palabras`, crea una expresión
    regular que busque palabras que:
    
    1. Empiecen con "y".
    1. Terminen con "x"
    1. Tengan una extensión de exactamente tres letras. (¡No hagas trampa usando `str_length()`!)
    1. Tengan siete letras o más. 

    Dado que esta será una lista larga, podrías quere usar el argumento `match` en
    `str_view()` para mostrar solo las palabras que coincidan o no coincidan. 

### Clases de caracteres y alternativas

#### Ejercicios

1.  Crea una expresión regular que encuentre todas las palabras que:

    1. Empiecen con una vocal.

    1. Solo contengan consonantes. (Pista: piensa en cómo buscar coincidencias para 
       "no"-vocales.)

    1. Terminen en `ón`, pero no en `ión`.
    
    1. Terminen con `ndo` or `ado`.
    

1.  ¿Siempre a una "q" la sigue una "u"?

1.  Escribe una expresión regular que permita buscar un verbo que haya sido escrito usando voseo en segunda persona plural  
    (por ejemplo, _queréis_ en vez de _quieren_).

1.  Crea una expresión regular que coincida con la forma en que habitualmente 
    se escriben los números de teléfono en tu país.
    
1. En inglés existe una regla que dice que la letra i va siempre antes de la e, excepto cuando está después de una c". Verifica empíricamente esta regla utilizando las palabras contenidas en `stringr::words`. 


### Repetición

#### Ejercicios

1.  Describe los equivalentes de `?`, `+`, `*` en el formato `{m,n}`.

1.  Describe en palabras con qué coincidiría cada una de estas expresiones regulares:
    (lee con atención para ver si estamos utilizando una expresión regular o una cadena
    que define una expresión regular.)

    1. `^.*$`
    1. `"\\{.+\\}"`
    1. `\d{4}-\d{2}-\d{2}`
    1. `"\\\\{4}"`

1.  Crea expresiones regulares para buscar todas las palabras que:

    1. Empiecen con dos consonantes.
    1. Tengan tres o más vocales seguidas.
    1. Tengan tres o más pares de vocal-consonante seguidos. 

### Agrupamiento y referencias previas

#### Ejercicios

1.  Describe en palabras con qué coinciden estas expresiones: 

    1. `(.)\1\1`
    1. `"(.)(.)\\2\\1"`
    1. `(..)\1`
    1. `"(.).\\1.\\1"`
    1. `"(.)(.)(.).*\\3\\2\\1"`

1.  Construye una expresión regular que coincida con palabras que: 

    1. Empiecen y terminen con el mismo caracter. 
    
    1. Contengan un par de letras repetido
       (p. ej. "nacional" tiene "na" repetidos dos veces.)
    
    1. Contengan una letra repetida en al menos tres lugares
       (p. ej. "característica" tiene tres "a".)

## Herramientas



### Ejercicios

1.  Para cada uno de los siguientes desafíos, intenta buscar una solución utilizando tanto una 
    expresión regular simple como una combinación de múltiples llamadas a `str_detect()`.
    
    1.  Encuentra todas las palabras que empiezan o terminan con `y`.
    
    1.  Encuentra todas las palabras que empiezan con una vocal y terminan con una consonante.
    
    1.  ¿Existen palabras que tengan todas las vocales?

1.  ¿Qué palabra tiene el mayor número de vocales? ¿Qué palabra tiene la mayor
    proporción de vocales? (Pista: ¿cuál es el denominador?)

### Extraer coincidencias


#### Ejercicios

1.  Te habrás dado cuenta que en el ejemplo anterior la expresión regular
    que utilizamos también devolvió como resultado "arrojo" y "azulejos", 
    que no son nombres de colores. Modifica la expresión regular para 
    resolver ese problema.
    

1.  De `datos::oraciones` extrae:

    1. La primera palabra de cada oración.
    1. Todas las palabras que terminen en `ción`.
    1. Todos los plurales.

### Coincidencias agrupadas


#### Ejercicios

1. Busca en `datos::oraciones` todas las palabras que vengan después de un "número", como "un(o|a)", "dos", "tres", etc.
   Extrae tanto el número como la palabra.

1. En español a veces se utiliza el guión para unir adjetivos, establecer relaciones entre conceptos o para unir gentilicios (p. ej., _teórico-práctico_, _precio-calidad_, _franco-porteño_). ¿Cómo podrías encontrar esas palabras y separar lo que viene antes y después del guión?

### Remplazar coincidencias


#### Ejercicios

1.   Remplaza en una cadena todas las barras por barras invertidas.

1.   Implementa una versón simple de `str_to_lower()` (_a minúsculas_) usando `replace_all()`.

1.   Cambia la primera y la última letra en `palabras`. ¿Cuáles de esas cadenas
     siguen siendo palabras?

### Divisiones


#### Ejercicios

1.  Divide una cadena como `"manzanas, peras y bananas"` en elementos
    individuales.
    
1.  ¿Por qué es mejor dividir utilizando `boundary("word")` en vez de `" "`?

1.  ¿Qué pasa si dividimos con una cadena vacía (`""`)? Experimenta y
    luego lee la documentación


## Otro tipo de patrones

### Ejercicios

1.  ¿Cómo buscarías todas las cadenas que contienen `\` con `regex()` vs.
    con `fixed()`?

1.  ¿Cuáles son las cinco palabras más comunes en `oraciones`?


## stringi


### Ejercicios

1.  Busca la función de __stringi__ que:

    1. Cuenta el número de palabras.
    1. Busca cadenas duplicadas.
    1. Genera texto aleatorio.

1.  ¿Cómo puedes controlar qué lengua usa `stri_sort()` para ordenar?
