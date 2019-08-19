# Vectores

## Tipos importantes de vectores atómicos

###Ejercicios

1. Describe la diferencia entre `is.finite(x)` y `!is.infinite(x)`.
1. Lee el código fuente de `dplyr:: near()` (Consejo: para ver el código fuente, escribe lo siguiente `()`) ¿Funcionó?
1. Un vector de tipo lógico puede tomar 3 valores posibles. ¿Cuántos valores posibles puede tomar un vector de tipo entero? ¿Cuántos valores posibles puede tomar un vector de tipo real? Usa google para realizar buscar información respecto a lo planteado anteriormente.
1. Idea al menos 4 funciones que te permitan convertir un vector del tipo real a entero. ¿En qué difieren las funciones? Sé preciso.
1. ¿Cuáles funciones del paquete readr te permiten convertir un vector del tipo string en un vector del tipo lógico, entero y doble?

## Usando vectores atómicos

### Ejercicios

1. La expresión `mean(is.na(x))`, ¿qué dice acerca del vector 'x'? ¿y qué sucede con la expresión `sum(!is.finite(x))`?

1. Detenidamente lee la documentación de `is.vector()`. ¿Para qué se prueba la función realmente? ¿Por qué la función `is.atomic()` no concuerda con la definición de vectores atómicos vista anteriormente?

1. Compara y contraste `setNames()` con `purrr::set_names()`.

1. Crea funciones que tomen un vector como entrada y devuelva:
	1. El último valor. ¿Deberás usar `[` o `[[`?.
	1. Los elementos en posiciones pares.
	1. Cada elemento excepto el último valor.
	1. Sólo las posiciones pares (y sin valores perdidos (missing values)).
	1. ¿Por qué `x[-which(x > 0)]` no es lo mismo que `x[x <= 0]`?
	1. ¿Qué sucede cuando realizas un subset (subdivisión) con un entero positivo que es mayor que la longitud del vector? ¿Qué sucede cuando realizas un subset (subdivisión) con un nombre que no existe?

## Vectores Recursivos (listas)


### Ejercicios
1.Dibuja las listas siguientes como sets anidados:

```{r
 1.	`list(a, b, list(c, d), list(e, f))`
 1.	`list(list(list(list(list(list(a))))))`
```
1.¿Qué pasaría si subdividieras un tibble como si fuera una lista? ¿Cuáles son las principales diferencias entre una lista y un tibble?

## Vectores Aumentados

### Ejecicios:
1.	¿Qué valor retorna la siguiente expresión hms::hms(3600)? ¿Cómo se muestra? ¿Cuál es la tipo primario sobre el cual se basa el vector aumentado? ¿Qué atributos utiliza el mismo?
2.	Intenta y crea un tibble que tenga columnas con diferentes longitudes ¿Qué es lo que ocurre?
3.	Teniendo en cuenta
