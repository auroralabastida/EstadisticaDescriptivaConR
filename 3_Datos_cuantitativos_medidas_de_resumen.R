### CARGUEMOS LOS PAQUETES QUE USAREMOS
library(psych)
library(pastecs)
library(summarytools)


###      A. EL CONJUNTO DE DATOS IRIS

## El data frame iris (un dataset de R) lista varias medidas
## para muestras de flores de tres especies de Iris:

# Sepal.Length: Largo del sepalo
# Sepal.Width: Ancho del sepalo
# Petal.Length: Largo del petalo
# Petal.Width: Ancho del petalo
# Species: setosa, versicolor o virginica

#                   _
#          _-=-_   ::  _-=-_
# Petal   (__/ ¨"\ V /"¨ \__)
# Width |  .:II:>-\|/-<:II:.
#          ----- _/|\_        |
#     Petal     | ´'` |       | Sepal
#     Length     `._.´        | Length
#                  |
#                ------ Sepal
#                  |    Width
#


## ¿Como se ven los datos de Iris y que dimensiones tienen?
#   Explora los datos con tus opciones favoritas

#  A.1 Solo las dimensiones

dim(iris)


#  A.2 Solo las clases de variables (funcion class una vez por columna)

sapply(iris,class)


#  A.3 Dimensiones y tipos de variables

str(iris)


#  A.4 O veamos directamente la tabla

View(iris)



###      B. FUNCIONES BASICAS PARA MEDIDAS DE RESUMEN

#  B.1 Promedio o media aritmetica
#La suma de todos los valores dividida entre el total de los valores.

#  ¿Qué tan largos son los Sepalos en promedio?


mean(iris$Sepal.Length)


#  B.2 Rango
# Minimo y maximo de los valores

#  ¿Cuales son los valores minimo y maximo para el largo de los Sepalos?


min(iris$Sepal.Length)


max(iris$Sepal.Length)


range(iris$Sepal.Length)


#  B.3 Primer, segundo y tercer cuartiles
# Valores por debajo de los cuales se encuentran el 25%, 50% o 75% de los datos

#  B.3.a ¿Cuales son el primer y tercer cuartiles para Sepal.Length?


quantile(iris$Sepal.Length)

quantile(iris$Sepal.Length, 0.25)


#  B.3.b ¿Cual es el valor del segundo cuartil (la mediana)?


quantile(iris$Sepal.Length, 0.5)

median(iris$Sepal.Length)


#  B.3.c Rango intercuartil
## Mide la distancia entre el primer y tercer cuartil


IQR(iris$Sepal.Length)


## B.4 Desviacion estandar
# Cuantifica la variacion o dispersion que tienen los datos con respecto al promedio


sd(iris$Sepal.Length)


## B.5 Coeficiente de variacion
# Mide que tan grande es la desviacion estandar con respecto al promedio
# Usar con precaucion


sd(iris$Sepal.Length)/mean(iris$Sepal.Length)


# B.6 Podemos aplicar estas estadisticas a todas las columnas a la vez


sapply(iris[1:4],mean) # Solo para las columnas 1 a 4


# B.7 Podemos calcular estas estadisticas especie por especie


tapply(iris$Sepal.Length, iris$Species, mean)


tapply(iris$Sepal.Length, iris$Species, quantile)



###      C. FUNCIONES PARA OBTENER VARIAS MEDIDAS DE RESUMEN A LA VEZ


#  C.1 Cuartiles, promedio y rango con `summary`


summary(iris)


#  C.2 Medidas de tendencia central y medidas de dispersion con `stat.desc`
# del paquete `pastecs`


stat.desc(iris)


#  C.3 Medidas de tendencia central y de dispersion + representacion
# grafica con `summarytools`


view(dfSummary(iris))


#  C.4 Medidas de tendencia central y de dispersion con
# `describe` y `describeBy` de psych

  #Para todo el data frame

describe(iris)

  #Especie por especie

describeBy(iris,group=iris$Species)



######### EJERCICIOS Y TRUCOS ADICIONALES ###################################

#___Medir un cuantil a la vez para cada sub-grupo del data frame___#
# (ej. solo el primer cuartil):

tapply(iris$Sepal.Length, iris$Species, quantile, c(0.25))


#___`aggregate` y `by` para obtener estadisticas por sub-grupo___#
# Ademas de tapply podemos utilizar a aggregate y a by para obtener
# Estadisticas por sub-grupos del data frame.

aggregate( Sepal.Length ~ Species, iris, mean)

by(iris$Sepal.Length, iris$Species, mean)


#___Calculo de la moda___#

# En R no hay una funcion incluida para calular la moda (valor mas frecuente
# en el conjunto de datos) pero podemos hacerlo asi:


# Moda para Sepal.Length

# Obtenemos una tabla de cuantas veces aparece cada medida de Sepal.Length

x<-table(iris$Sepal.Length)

# Ordenamos la tabla del valor mas frecuente al valor menos frecuente

sorted_x<-sort(x,decreasing=TRUE)

# Aqui esta la primera columna de la tabla ya ordenada

sorted_x[1]

# La moda es 5 y aparecio 10 veces. La moda aparece como nombre de la primera columna.
# Para obtener el nombre de la primera columna como valor numerico

as.numeric(names(sorted_x)[1])

# Podemos hacer una funcion moda que reciba un vector y haga todos estos pasos


moda <- function(v){ #La funcion moda recibe un vector v (ej.Sepal.Length)

  x<-table(v) #Obtiene las frecuencia de aparicion de cada valor de Sepal.Length como tabla

  sorted_x<-sort(x,decreasing=TRUE) #Ordena la tabla del valor mas frecuente al menos frecuente

  moda<-as.numeric(names(sorted_x)[1]) #Obtiene el nombre del valor mas frecuente y lo hace numerico

  return(moda) #Regresa el valor calculado
  }


#Y ahora podemos usar la funcion

moda(iris$Sepal.Length)

sapply(iris[1:4],moda)
