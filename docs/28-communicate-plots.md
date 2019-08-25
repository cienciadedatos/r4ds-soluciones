# Comunicar con gráficos

## Paquetes necesarios


```r
library(ggplot2)
library(datos)
```

## Etiquetas

### Ejercicios

1. Crea un gráfico partiendo de los datos de economía de combustible con etiquetas para `title` , `subtitle`, `caption`, `x`, `y` y `color` personalizadas.

2. La función `geom_smooth()` es un poco engañosa porque `autopista` está sesgada positivamente para motores grandes, debido a la inclusión de autos deportivos livianos con motores grandes. Usa tus herramientas de modelado para ajustar y mostrar un modelo mejor.

3. Elige un gráfico exploratorio que hayas creado en el último mes y agrégale títulos informativos para volverlo más fácil de comprender para otros.

## Anotaciones

### Ejercicios

1. Usa las infinitas posiciones que permite `geom_text()` para colocar texto en cada una de las cuatro esquinas del gráfico.

2. Lee la documentación de la función `annotate()`. ¿Cómo puedes usarla para agregar una etiqueta de texto a un gráfico sin tener que crear un tibble?

3. ¿Cómo interactúan las etiquetas producidas por `geom_text()` con la separación en facetas? ¿Cómo puedes agregar una etiqueta a una sola faceta? ¿Cómo puedes poner una etiqueta diferente en cada faceta? (Sugerencia: piensa en los datos subyacentes).

4. ¿Qué argumentos para `geom_label()` controlan la apariencia de la caja que se ve atrás?

5. ¿Cuáles son los cuatro argumentos de `arrow()`? ¿Cómo funcionan? Crea una serie
 de gráficos que demuestren las opciones más importantes.

## Escalas

### Ejercicios

1. ¿Por qué el siguiente código no reemplaza la escala predeterminada?

 
 ```r
 ggplot(df, aes(x, y)) +
  geom_hex() +
  scale_colour_gradient(low = "white", high = "red") +
  coord_fixed()
 ```

2. ¿Cuál es el primer argumento para cada escala? ¿Cómo se compara con `labs()`?

3. Cambia la visualización de los términos presidenciales de las siguientes maneras:

I.	Combinando las dos variantes que se muestran arriba.
II.	Mejorando la visualización del eje y.
III.	Etiquetando cada término con el nombre del presidente.
IV.	Agregandoetiquetas informativas al gráfico.
V.	Poniendo intervalos de 4 años (¡esto es más complicado de lo que parece!).

4. Utiliza `override.aes` para que la leyenda en el siguiente gráfico sea más fácil de ver:

 
 ```r
 ggplot(diamantes, aes(quilate, precio)) +
  geom_point(aes(colour = corte, alpha = 1 / 20))
 ```
 
 <img src="28-communicate-plots_files/figure-html/unnamed-chunk-3-1.png" width="50%" />
