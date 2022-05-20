# **Reflexión Final**

Integrantes: 

Miguel Bustamante A01781583

Emilio Sibaja A01025139


## **Solución planteada**

La solución que se logró obtener a partir de el modulo de Regex cumple con el hecho de poder reemplazar a través de cada línea de el archivo json, intercambiarla por su equivalente en html. 

La función utilizada del modulo es *Regex*.replace(). Dicha función recive como argumentos una expresión regex, la línea que va a revisar y por último el valor a reemplazar al hacer match. 

El único problema de utilizar este método es que al tener varios tipos de datos diferentes dentro del archivo json, puede ocurrir que algunos de estos se sobrescriben. 

Utilizamos una expresión regular para cada caracter especial, número strings y booleanos. Con esto logramos identificarlos y de esta manera, cambiar los colores de cada tipo de datos. 

## **Correr el programa**

Para que el programa funcione se debe de iniciar Elixir en la terminal, llamando ahí mismo el nombre del archivo de Elixir. 

Estando en la terminal (powershell o cmd), escribir: iex sintax.exs

Una vez que ya se encuentre en la terminal de Elixir, ejecutar el modulo y función de la siguiente forma: 

iex(1)> Do_regex.get_xample("example_0.json","resultado.html")

Una vez hecho esto, el programa generará el archivo html resultante. 



Las funciones que se llaman al ejecutar el programa son las siguientes:

* do_regex_string

* do_regex_two_dots

* do_regex_br

* do_regex_square_bracket
 
* do_regex_bracket

* do_regex_parentheses

* do_regex_exp

* do_regex_int

* do_regex_boolean

* do_regex_space

## **Análisis de algoritmo** 

Nuestro algoritmo tiene una complejidad de: 


1. Enum.map() tiene una complejidad de O(N)
2. *Regex*.replace() tiene una complejidad de O(MxN)

    Donde: 
    * *M* es la expresión regular.
    * *N* es la longitud del tipo de dato. 
    
En general cualquier función del modulo de Regex tiene una complejidad de O(MxN)


Debido a que utilizamos la función *Regex*.replace() y no realizamos nínguna otra operación dentro de cada función. 

## **Conclusión** 

Debido a que es la primera ocasión en la que utilizamos el modulo de *Regex* y generamos un nuevo archivo de tipo *html* a partir de los archivos de tipo *json*, replicando esté último con distintos colores dependiendo del tipo de dato. Consideramos que logramos obtener un código que cumple con la función de delimitar por secciones que parte corresponde de acuerdo a los regex realizados. 



