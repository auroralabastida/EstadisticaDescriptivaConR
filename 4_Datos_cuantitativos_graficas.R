### CARGUEMOS LOS PAQUETES QUE USAREMOS

library(ggplot2)
library(reshape2)


###      A. OBSERVANDO LA DISTRIBUCION DE DATOS CON HISTOGRAMAS

#  A.1 Usaremos nuevamente al conjunto de datos iris y
# una modificacion de los datos obtenida con `melt` del paquete `reshape2`

#  ¿Cómo transforma `melt` los datos?
#                                                    -12 filas-
#
#  S.L   S.W   P.L  P.W   Species             Species variable value
#   #1    #4   #7   #10   setosa               setosa     S.L    #1
#   #2    #5   #8   #11   versicolor    melt   versicolor S.L    #2
#   #3    #6   #9   #12   virginica   ----->   virginica  S.L    #3
#                                              setosa     S.W    #4
#     -4 columnas y 3 filas-                   versicolor S.W    #5
#        - 12  valores -                       virginica  S.W    #6
#                                              ...
#                                              versicolor P.W    #12


iris_m<-melt(iris)

head(iris_m)


#  A.2 Histograma: muestra la frecuencia con la que aparecen
# distintos valores para una variable (distribucion de los datos).

# Nota: al usar y=..density.. en ggplot2 se ajusta la altura de
# las barras para que sus áreas sumen 1 (como en las gráficas de
# debsidad de probabilidad)


#  A.2.a Histogramas para Petal.Length por especie


ggplot(data=iris,
       aes(Petal.Length,fill=Species,y=..density..)) +
  geom_histogram(position="identity") +
  geom_density(alpha=0.4) +
  facet_grid(Species~.)


# A.2.b Histogramas para las 4 medidas por especie utilizando como entrada
# a `iris_m` y a `facet_wrap`


ggplot(data=iris_m,
       aes(value,fill=Species)) +
  geom_density(alpha=0.4) +
  facet_wrap(~variable)



###      B. OBSERVANDO LA DISTRIBUCION DE DATOS CON DIAGRAMAS
###    DE CAJA Y DE VIOLIN


## Diagrama de caja (Box-plot): muestra las siguientes medidas:
#
# Distribucion  Boxplot
#
#         I       |  ¨¨¨¨¨ max (sin outliers)
#       III     --|--  <--- tercer cuartil
#     IIIII    |     |
#   IIIIIII    |-----|  <--- segundo cuartil
#     IIIII    |     |
#       III     --|--  <---- primer cuartil
#         I       |  ____ min (sin outliers)
#

#  B.1 Boxplot para Petal.Length por especies


ggplot(iris,
       aes(y=Petal.Length,x=Species,colour=Species)) +
  geom_boxplot(outlier.color = "black") +
  stat_summary(fun="mean", color="grey")


#  B.2 Diagrama de violin: muestra la forma de la distribucion

#  B.1.a Diagrama de violin para Petal.Length por especies


ggplot(iris,
       aes(y=Petal.Length,x=Species,colour=Species)) +
  geom_violin()


#  B.1.b Diagramas para las 4 medidas por especie

ggplot(iris_m,
       aes(y=value,x=Species,colour=Species)) +
  geom_violin() +
  facet_wrap(~variable)



###      C. RELACION ENTRE DOS VARIABLES: GRAFICAS DE DISPERSION X Y


ggplot(iris,
       aes(x = Petal.Length, y = Petal.Width)) +
  geom_point(aes(colour = Species)) +
  facet_grid(Species~.) +
  geom_smooth(method="lm",se=FALSE)



######### EJERCICIOS Y TRUCOS ADICIONALES ###################################

#___Graficas de dispersion para todos los pares de variables___#

# La forma mas sencilla de obtener graficas de dispersion para
# todos los pares de variables: `pairs` del paquete `graphics`,
# que viene instalado en R.

pairs(iris[,1:4], col=iris$Species)


#___Multiples graficas a la vez con `GGally`___#

# `GGally` es una forma sencilla y atractiva para ver:
# Distribuciones, box-plots, graficas de dispersion y correlaciones

library(GGally) # Tal vez debas instalar a `GGally`

ggpairs(iris)

#      .... O aun mejor

ggpairs(iris, aes(colour = Species, alpha = 0.4))



