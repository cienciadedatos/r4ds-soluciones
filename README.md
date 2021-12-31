## Propuesta de soluciones de los ejercicios del libro [R para Ciencia de Datos](https://es.r4ds.hadley.nz)

Última versión disponible [acá](http://cienciadedatos.github.io/r4ds-soluciones).


**Para colaborar**

1. Haz un fork en tu cuenta de Github.
2. Clona el repositorio de tu cuenta en tu computador (e.g. `git clone https://github.com/cienciadedatos/r4ds-soluciones.git`)
3. Crea un branch propio (e.g. soluciones-tunombre, puedes hacer `git checkout -b soluciones-tunombre`)
4. Cuando quieras subir tus cambios haz push a tu cuenta y luego haz un *Pull Request* indicando el branch `master` del repositorio `cienciadedatos/r4ds-soluciones`. **Solo agrega los archivos en los que hiciste cambios**. Es decir, si está ocupando git desde el Terminal no hagas `git add .`, sino `git add nombrearchivo.Rmd`. Esto evitará conflictos entre versiones de los archivos.

Los admins se van a encargar de hacer el merge y que todo funcione.

**Importante**

Para que tu _fork_ se mantenga al día y no surjan conflictos cuando hagas un _pull request_ es importante que agregues este repositorio como _remoto_ del tuyo y que cada cierto tiempo lo actualices. 

Para configurar:
`git remote add upstream https://github.com/cienciadedatos/r4ds-soluciones.git`

Para que los cambios hechos acá se actualicen en tu rama `master`:

`git fetch upstream` 

`git merge upstream/master` 

**Código de conducta**

Por su puesto que tenemos un código de conducta. Para participar tienes que haberlo leído y aceptado: https://github.com/cienciadedatos/documentacion-traduccion-r4ds/blob/master/codigo-de-conducta.md
