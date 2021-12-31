# Flujo de trabajo: conocimientos básicos

## 4.4 Ejercicios{-#ejercicios-41} 

1.  ¿Por qué no funciona este código?

    
    ```r
    mi_variable <- 10
    mi_varıable
    #> Error in eval(expr, envir, enclos): object 'mi_varıable' not found
    ```
    
    ¡Mira detenidamente! (Esto puede parecer un ejercicio inútil, pero entrenar tu cerebro para detectar incluso las diferencias más pequeñas será muy útil cuando comiences a programar.)
    
<div class="solucion">
<h3>Solución</h3>

En la segunda línea de código la letra "i" no tiene punto. Si bien a primera vista se ven similares, al mirar detenidamente podemos ver que `mi_variable` no es igual a `mi_variable`

</div>
    
2.  Modifica cada una de las instrucciones de R a continuación para que puedan ejecutarse correctamente:

    
    ```r
    library(tidyverse)
    library(datos)
    
    ggplot(dota = millas) + 
      geom_point(mapping = aes(x = motor, y = autopista))
    
    fliter(millas, cilindros = 8)
    filter(diamante, quilate > 3)
    ```
    
<div class="solucion">
<h3>Solución</h3>

En los tres casos hay problemas de tipeo. En el primero, dice `dota = millas` y debería decir `data = millas`:

    
    ```r
    ggplot(data = millas) + 
      geom_point(mapping = aes(x = motor, y = autopista))
    ```


En el segundo, hay un problema en la forma en que se escribió el nombre de la función. Dice `fliter` en vez de `filter`:

    
    ```r
    filter(millas, cilindros = 8)
    ```


En el tercero, es necesario corregir la forma en que se escribió el nombre del conjunto de datos. Debiese estar en plural, es decir, `diamantes`.
    
    ```r
    filter(diamantes, quilate > 3)
    ```


</div>

3.  Presiona Alt + Shift + K. ¿Qué ocurrió? ¿Cómo puedes llegar al mismo lugar utilizando los menús?

<div class="solucion">
<h3>Solución</h3>

`Alt + Shift + K` es el comando abreviado o _shortcut_ para ver la lista de comandos abreviados de RStudio. Al presionarlo se abre una nueva ventana con todos los comandos disponibles. 
Para llegar a esa misma lista utilizando los menús, tienes que ir a `Tools > Keyboard Shortcuts Help`.

</div>
