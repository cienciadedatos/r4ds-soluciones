# Factores





## 15.3 Encuesta social general{-#encuesta}

### 15.3.1 Ejercicios{-#ejercicios-1531}

1. Explora la distribución de `ingreso`. ¿Qué hace que el gráfico de barras por defecto sea tan difícil de comprender? ¿Cómo podrías mejorarlo?

<div class="solucion">
<h3>Solución</h3>

Este es el gráfico por defecto:

```r
ggplot(encuesta) + 
  aes(ingreso) + 
  geom_bar()
```

<img src="15-factors_files/figure-html/unnamed-chunk-2-1.png" width="70%" style="display: block; margin: auto;" />

Resulta difícil de leer porque las etiquetas de los valores son muy largas. Una opción para resolver esto sería girando el gráfico. Esto se puede hacer con `coord_flip()` o, en la última versión de ggplot, moviendo la variable de eje:


```r
ggplot(encuesta) + 
  aes(ingreso) + 
  geom_bar() +
  coord_flip()

# es lo mismo que 

ggplot(encuesta) + 
  aes(y = ingreso) + 
  geom_bar()
```

<img src="15-factors_files/figure-html/unnamed-chunk-3-1.png" width="70%" style="display: block; margin: auto;" /><img src="15-factors_files/figure-html/unnamed-chunk-3-2.png" width="70%" style="display: block; margin: auto;" />

En este caso particular no tendría tanto sentido ordenar las barras de forma ascendente o descente, ya que los datos ya tienen un orden. Algo que sí podríamos hacer es eliminar "No aplica" y cambiar el nombre de la etiqueta del eje x:


```r
encuesta %>% 
  filter(ingreso != "No aplica") %>% 
ggplot() + 
  aes(y = ingreso) + 
  geom_bar() +
  labs(x = "Respuestas")
```

<img src="15-factors_files/figure-html/unnamed-chunk-4-1.png" width="70%" style="display: block; margin: auto;" />



</div>


2. ¿Cuál es la `religion` más común de la encuesta? ¿Cuál es el `partido` más común?


<div class="solucion">
<h3>Solución</h3>

Una forma de encontrar el valor con mayor frecuencia sería contando con `count()` y luego ordenando de mayor a menor con `arrange(desc())` para ver cuál queda primero. Otra opción es utilizar la función `top_n()`, también del paquete **dplyr**.

La religión más común es "Protestante":


```r
encuesta %>% 
  count(religion) %>% 
  top_n(1)
#> Selecting by n
#> # A tibble: 1 x 2
#>   religion        n
#>   <fct>       <int>
#> 1 Protestante 10846
```

El valor más común en `partido` es "Independiente":


```r
encuesta %>% 
  count(partido) %>% 
  top_n(1)
#> Selecting by n
#> # A tibble: 1 x 2
#>   partido           n
#>   <fct>         <int>
#> 1 Independiente  4119
```


</div>

3. ¿A qué `religion` se aplica cada `denominacion`? ¿Cómo puedes encontrarlo con una tabla? ¿Cómo lo puedes descubrir con una visualización?

<div class="solucion">
<h3>Solución</h3>

</div>

## 15.4 Modificar el orden de los factores {-#modificar-factores}

### 15.4.1 Ejercicios{-#ejercicios-1541}

1. Hay algunos números sospechosamente grandes en `horas_tv`. ¿Es la media un buen resumen?

<div class="solucion">
<h3>Solución</h3>

</div>

2. Identifica, para cada factor en `encuesta`, si el orden de los niveles es arbitrario o responde a algún principio.

<div class="solucion">
<h3>Solución</h3>

</div>

3. ¿Por qué mover "No aplica" al inicio de los niveles lo llevó al final del gráfico?

<div class="solucion">
<h3>Solución</h3>

</div>


## 15.5 Modificar los niveles de los factores{-#modificar-niveles}

### 15.5.1 Ejercicios{-#ejercicios-1551}

1. ¿Cómo han cambiado en el tiempo las proporciones de personas que se identifican como Demócratas, Republicanas e Independientes?

<div class="solucion">
<h3>Solución</h3>

</div>

2. ¿Cómo podrías colapsar `ingreso` en un grupo más pequeño de categorías?

<div class="solucion">
<h3>Solución</h3>

</div>
