### CARGUEMOS LOS PAQUETES QUE USAREMOS

library(correlation)
library(corrplot)
library(psych)


###      A. ¿QUÉ ES UNA CORRELACIÓN Y COMO LA CALCULAMOS?

#  A.1 La correlación es una medida de coincidencia entre dos variables.
# Puede apuntar a una relación predictiva o causal entre variables.

# La correlación más conocida es la lineal,
# donde la dispersion X Y de dos variables se acomoda en linea recta

plot( iris$Petal.Length, iris$Petal.Width)


#  A.2 Podemos encontrar la correlación con el método de Pearson:

# Aquí lo hacemos para dos variables

cor( iris$Petal.Length , iris$Petal.Width )

# La correlación de Pearson (r) va de 1 (relación creciente total) a
# -1 (relación decreciente total) pasando por 0 (sin relación).


#   |    /       |            |\
# y |  /       y |------    y |  \
#   |/_____      |______      |____\_
#       x           x           x
#    r = 1        r = 0        r = -1


#  A.3 El método de Pearson es útil para encontrar relaciones lineales.

# ¿Qué pasa si hay una relacion pero no es lineal?


#   |       ___/
#   |      /
# y |  ___/     ?????
#   |_|_________
#       x

# Por ejemplo veamos la concentracion sanguínea de Indometacina
# a distintos tiempos tras una inyección del fármaco.

plot(Indometh$conc, Indometh$time)

# Para estas situaciones se usa el método de Spearman, que ordena las muestras
# segun el valor de la variable 1 y segun el valor de la variable 2
# y evalua que tanto coinciden las posiciones (ranks) de las muestras
# en ambos ordenamientos. El coeficiente tambien va de -1 a 1.


cor(Indometh$conc, Indometh$time) # Pearson

cor(Indometh$conc, Indometh$time, method="spearman") # Spearman


# Nota: La correlación de Spearman funciona mejor para distribuciones que
# suben o bajan de forma clara.


#  A.4 Podemos obtener una matriz de las correlaciones para multiples variables


cor(iris[1:4])



# Hay metodos para obtener tablas de correlaciones muy completas
# ej. el metodo ´correlation´ del paquete homónimo

correlation(iris)


###      B. GRAFICAS DE CORRELACION


#  B.1 Usando a ´corrplot´ del paquete homónimo

corrplot(cor(iris[1:4]))

#  B.1 Usando a ´pairs.panels´ del paquete ´psych´

pairs.panels(iris[1:4])



######### EJERCICIOS Y TRUCOS ADICIONALES ###################################

#___Calculo de correlaciones y graficas por sub-grupo ___#

#  Correlaciones con ´cor´ y ´correlation´

by(iris[,1:4], iris$Species, cor)

by(iris[,1:4], iris$Species, correlation)


# Graficas con ´corrplot´ y ´pairs.panels´

iris_ver<-subset(iris, Species=="versicolor")

corrplot(cor(iris_ver[1:4]))

pairs.panels(iris_ver[1:4])


#___¿Como le damos soporte estadistico a la correlacion?___#

# Aqui podemos usar el test de correlacion de Pearson.
# Hay correlación el intervalo de confianza no pasa por 0:


cor.test(x=iris$Sepal.Length,y=iris$Petal.Width,method="pearson")

cor.test(x=iris$Sepal.Length,y=iris$Sepal.Width,method="spearman")


# También podemos usar `cor_test` del paquete `correlation`. El
# intervalo de confianza aparece como 95% CI:


cor_test(data=iris[1:4],x=1,y=4,method="pearson")

cor_test(data=iris[1:4],x=1,y=2,method="spearman")



#___Mucha informacion grafica con ´GGally´ ___#


library(GGally) # Tal vez necesites instalar a ´GGally´

ggpairs(iris)

#      .... O aun mejor

ggpairs(iris, aes(colour = Species, alpha = 0.4))



#___Graficas coloreadas con pairs.panels de Psych ___#


# Una grafica coloreada con `pairs.panels` de Psych.

# El paquete `psych` nos da una buena herramienta:

pairs.panels(
    iris[1:4],bg=c("red","yellow","blue")[iris$Species],
    pch=21,main="Fisher Iris data by Species") # agrupa por color

