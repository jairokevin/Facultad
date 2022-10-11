# Lab de Programación Funcional #

---
Integrantes :
* Garibay, Naira
* Lopez, Jairo
* Weihmuller, Marco
---

# Introducción
Este laboratorio es un proyecto donde combinamos dibujos básicos para crear 
diseños más complejos. A partir del uso de un lenguaje que se lo suele conocer 
como DSL (Domain Specific Language: lenguaje de dominio específico)que esta 
pensado para proveer abstracciones adecuadas para resolver problemas acotados 
a cierto ámbito. Siguiendo la idea del siguiente:
[artículo](https://cs.famaf.unc.edu.ar/~mpagano/henderson-funcgeo2.pdf "en inglés")
Esto es implementado con programación funcional utilizando el lenguaje de 
programación Haskell y una librería `gloss` que nos provee la facilidad de 
visualizar las figuras.

# Implementación

Para su implementacion la catedra ah proporcionado un esqueleto donde en :

# `Dibujo.hs` :
  -----------

Definimos el lenguaje que utilizaremos creando un nuevo tipo de dato dibujo con
los siguientes constructores: básica (Basica a),rotar 90 grados (Rotar (Dibujo a)), 
espejarlo (Espejar (Dibujo a)), rotarlo 45 grados (Rot45 (Dibujo a), 
apilar dos dibujos (Apilar Int Int (Dibujo a) (Dibujo a)), 
juntar dos dibujos (Juntar Int Int (Dibujo a) (Dibujo a)), 
encimar un dibujo con otro (Encimar (Dibujo a) (Dibujo a)).

También implementamos las funciones pedidas por la cátedra:

* `Comp` Para componer n veces una misma función

Llamadas para modificar la figura:
* `r180` Rota 180 grados un figura 
* `r270` Rota 270 grados un figura

Llamadas para crear nuevas figuras apartir de una figura: 
* `(.-.)` Pone una figura sobre la otra, ambas ocupan el mismo espacio
* `(///)` Pone una figura al lado de la otra, ambas ocupan el mismo espacio
* `(^^^)` Superpone una figura con otra
* `cuarteto` Dada una figura la repite en cuatro cuadrantes
* `encimar4` Una figura repetida con las cuatro rotaciones, superpuestas
* `ciclar` Repite una figura con en cada cuadrante donde cada uno de los 
cuadrantes representa una rotación salvo uno que tiene la figura sin rotar

Esquemas para la manipulación de figuras:
* `pureDib`Ver un a como una figura
* `mapDib` Map para nuestro lenguaje
* `cambia` Cambia un dibujo de entada y devuelve otro
* `sem` Estructura general para la semántica

Definimos un predicado de la forma Pred a = a -> Bool y lo aplicamos a las siguientes funciones:
* `limpia` Cambia todas las básicas que satisfacen el predicado
* `anyDib` Alguna básica satisface el predicado
-> Para implementarla se creo una función auxiliar `or'` donde compara si el 
predicado se cumple para cada una de las figuras apiladas o juntadas
* `allDib` Todas las básicas satisfacen el predicado
->Usa la función auxiliar `and'` donde compara si el predicado se cumple para 
cada todas de las figuras apiladas o juntadas
* `desc` Describe una figura
-> Utiliza `stringJuntarApilar` para describir figuras que fueron juntadas o apiladas
* `every` Junta todas las figuras básicas de un dibujo en una lista
-> Hace llamadas a 
+ `everyBasica` la cual devuelve una lista de Básicas 
+ `everyJuntarApilar` toma dos básicas juntadas o apiladas y devuelve una lista de ellas
+ `everyEncimar` toma dos básicas encimadas y devuelve la lista de ellas 
* `contar` Cuenta la cantidad de veces que se repite una básica 
-> Utiliza las siguientes funciones 
+ `contarBasica` cuenta las Básicas
+ `contarJuntarApilar` cuenta las Básicas que han sido juntadas o apiladas
+ `contarEncimar` cuenta las Básicas que fueron encimadas
+ `contarElementos` cuenta la cantidad de Basicas que hay en la figura junto a la función`sumar`
+ `sumar` suma la cantidad de Basicas que hay en la figura

Manejo de Errores:
Se considera un error cuando una figura es rotada 360 grados o es espejada 2 
veces consecutivas para determinar si esto ocurrió se define :
* `esRot360` si la figura fue rotada 360 grados
* `esFlip2`si fue espejada dos veces seguidas
* `check` dependiendo del predicado que haya recibido devuelve un mensaje de error 
si fue rotada 360 grados o es espejada 2 veces consecutivas sino devuelve la figura
* `todoBien` Realiza checks para saber si hubo algún error. Esta devuelve el o 
los errores que hubo y si no hubo error retorna la figura

Corrección de errores detectados:
* `noRot360` quita las rotaciones de 360 grados
* `noFlip2` quita las 2 veces consecutivas que se espejo

# `Interp.hs` :
  -----------
Acá se realiza la interpretación geométrica de las figuras y se definieron 
las siguientes funciones a partir del pseudocódigo del enunciado (para poder interpretarlas) 
`rotar`, `rot45`, `espejar`, `encimar`, `juntar` y`apilar`

Ademas definimos una figura `blanca` la cual es una figura vacía

# `Escher.hs` :
-----------

Definimos una figura Escher siguiendo la idea del articulo mencionado en la 
introducción,lo que nos llevo a realizar dos dibujos `dibujo_t` y `dibujo_u`
 análogos a t y u definidos en el articulo además de `lado`, `esquina` y `noneto` 
 análogos de side, corner y nonet.
Con estas funciones implementamos `escher` de n niveles recursivos donde va a 
repetir n veces la cantidad de lados y esquinas dentro de una matriz(3x3) 
generada por noneto y la utilización de constructores. 

# Conclusión 

El laboratorio fue un gran desafío al tener que programar de manera funcional 
debido a la costumbre de programar de manera imperativa y con objetos. Hemos 
podido aprender bastante tanto en clases, gracias a la ayuda de los profesores, 
como también a la ayuda de internet y de slack (por la ayuda colectiva).

# Extra
Se implementó un punto estrella (“Permiten que las figuras básicas especifiquen
 colores y se muestran coloreadas”) y está en el branch punto_estrella.
