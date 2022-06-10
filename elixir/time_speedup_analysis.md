# Actividad 5.2 Programación paralela y concurrente 

Integrantes: 


- Emilio Sibaja A01025139
    
- Miguel Angel Bustamante A01781583


Para esta actividad vamos a resolver problemas básicos de programación utilizando el estilo de programación paralela y concurrente.

## Pruebas

Realizamos pruebas con los siguientes números:

+ 100 
+ 1000
+ 10000
+ 100000
+ 1000000
+ 5000000



## Tiempo

+ 100 -> 3.7ms (Paralelo)
+ 100 -> 0.1ms (Singular)
---
+ 1000 -> 3.99ms (Paralelo)
+ 1000 -> 0.2ms (Singular)
---
+ 10000 -> 4.5ms (Paralelo)
+ 10000 -> 3.17ms (Singular)
---
+ 100000 -> 18.2ms (Paralelo)
+ 100000 -> 90.4ms (Singular)
---
+ 1000000 -> 0.33s (Paralelo)
+ 1000000 -> 1.57s (Singular)
---
+ 5000000 -> 3.23s (Paralelo)
+ 5000000 -> 15.13s (Singular)
---
+ 10000000 -> 8.67s (Paralelo)
+ 10000000 -> 39.82s (Singular)



## SpeedUp

La mejora de rendimiento de un sistema o speed-up, se calcula comparando los tiempos de
ejecución antes y después de aplicar una mejora:


Speed-up = Tej antes de la mejora / Tej después de la mejora

- Si mejoramos, el speed-up será mayor que 1.

- Si empeoramos, el speed-up será menor que 1.

- Si no mejoramos ni empeoramos con el cambio aplicado, el speed-up será igual a 1.

El speed-up nos indica cuántas veces más rápida es nuestra arquitectura después de aplicar la
mejora.

+ 100 -> 0.027
---
+ 1000 -> 0.050
---
+ 10000 -> 0.704
---
+ 100000 -> 4.967
---
+ 1000000 -> 4.757
---
+ 5000000 -> 4.684
---
+ 10000000 -> 4.592

## Conclusión

Podemos ver que cuando utilizamos cifras muy grandes la técnica de paralelismo es ideal para realizar este tipo de algoritmos, debido a que divide las tareas haciendo mucho más eficiente el tiempo de ejecución y el speedup.