# Flujo de trabajo: conocimientos básicos


## Práctica

1.  ¿Por qué no funciona este código?

    
    ```r
    mi_variable <- 10
    mi_varıable
    ```
    
    ```
    ## [1] 10
    ```
    
    ¡Mira detenidamente! (Esto puede parecer un ejercicio inútil, pero entrenar tu cerebro para detectar incluso las diferencias más pequeñas será muy útil cuando comiences a programar.)
    
2.  Modifica cada una de las instrucciones de R a continuación para que puedan ejecutarse correctamente:

    
    ```r
    library(tidyverse)
    
    ggplot(data = millas) + 
      geom_point(mapping = aes(x = motor, y = autopista))
    
    fliter(millas, cilindros = 8)
    filter(diamantes, quilate > 3)
    ```
    
3.  Presiona Alt + Shift + K. ¿Qué ocurrió? ¿Cómo puedes llegar al mismo lugar utilizando los menús?
