###CARGUEMOS LOS PAQUETES QUE USAREMOS

library(MASS)

###      A. DATAFRAMES

##Los data frames son ideales para trabajar con datos de
##un conjunto de individuos, muestras u observaciones

#Tomemos como ejemplo el data frame "survey" que está incluido en el paquete `MASS`


#  A.0 i no tienes el paquete `MASS` por favor carga la tabla survey.csv usando:

#survey <- read.csv("datos/survey.csv",header=TRUE,row.names = 1,stringsAsFactors = TRUE)



#  A.1 Como se que esto es un data frame

class(survey)


###      B. CONTENIDO DE MIS DATOS

## ¿Cuantos datos tenemos?

#  B.0 Numero de filas de survey

nrow(survey)

#  B.1 Numero de columnas de survey

ncol(survey)

#  B.3 O ambas al mismo tiempo

dim(survey)

## ¿De que tipo son los datos?

#  B.4 Veamos los nombres de las columnas

colnames(survey)

#  B.5 Veamos los primeros registros de la tabla

head(survey)

#  B.6 O una vista amigable de la tabla usando

View(survey)

#  B.7 Tenemos datos cualitativos y cuantitativos ¿De que clase son?.


class(survey$Pulse)

class(survey$Wr.Hnd)

class(survey$Smoke)


#  B.8 O mejor para todas

sapply(survey,class)


#  B.9 Veamos una visualizacion de la estructura de datos
#¿Como se ven las columnas de los datos cualitativos?

str(survey)


###      C. Trabajando con factores
#
#        )  (
#        ( ) )
#          ( (
#      _______)_
#   .-'---------|
#  ( C| Yo <3 R |                       (based on: mrf)
#   '-.         |
#     '_________'
#      '-------'

#  C.1 Hagamos vectores sobre:

## Que tan cargado les gusta el cafe a un grupo de programadoras:
## Ligero: l, cargado: c, moderado: m
## De que region viene el cafe que toman
## L: Latinoamerica, A: Africa Central, S: Sureste de Asia

cafe<-c("l","m","c", "c", "c","m")
region<-c("L","L","L","A","A","S")


#  C.2 De que clase son los vectores y como estan guardados en memoria

class(cafe)

mode(cafe)

#  C.3 Ahora vamos a convertir los vectores a factor

#  C.3.a  Este a un factor sin orden especifico

region<-factor(region)

class(region)


#  C.3.b  Y este a categorias ordenadas ligero < moderado < cargado

cafe<-factor(cafe, ordered=TRUE,levels=c("l","m","c"))

class(cafe)



######### EJERCICIOS Y TRUCOS ADICIONALES ###################################

#___¿Que es un dataframe?___#
#Para R un dataframe es una clase especial de lista. Es por eso que
#el resultado de `class` nos muestra un resultado y el de `mode` nos muestra otro.

class(survey)

mode(survey)


#___Filas y columnas de un dataframe___#
# Los nombres de las columnas y de las filas de un data frame se obtienen con

colnames(survey) #Colummas

names(survey) #Columnas

rownames(survey) #Filas


#___¿Como ver los niveles de un factor?___#
#¿Cuantos niveles tiene un factor? Osea ¿cuantas categorias tiene la variable?

levels(cafe)


#___¿Como cargo datos en R convirtiendo las columnas de texto a factores?___#
#Si quiero que al leer datos de un archivo de texto los datos cualitativos
#se carguen como factores usar la opcion
#`stringsAsFactors = TRUE` en `read.csv` o `read.table`:

datos <- read.csv("datos/survey.csv", header=TRUE, stringsAsFactors = TRUE)

