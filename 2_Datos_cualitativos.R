### CARGUEMOS LOS PAQUETES QUE USAREMOS

library(ggplot2)
library(MASS)
library(dplyr)


###      A. TABLAS DE FRECUENCIAS Y DE CONTINGENCIAS

## Trabajaremos con varias columnas del data frame survey (del paquete `MASS`)

# Sex (Sexo biologico)
# W.Hnd (Cual es tu mano dominante)
# Clap (¡Aplaude! ¿Qué mano tienes arriba?)


#  A.1 Veamos los datos (con su opcion favorita)


View(survey)

head(survey)


#  A.2 Obtengamos las frecuencias de estas variables


table(survey$Sex)

table(survey$W.Hnd)

table(survey$Clap)


#  A.3 Tambien podemos observar los valores como fracciones


prop.table(table(survey$Clap))

prop.table(table(survey$W.Hnd))


#  A.4 Ahora hagamos una tabla que relacione las frecuencias de dos variables


hand_sex<-table(survey$W.Hnd,survey$Sex)

clap_hand<-table(survey$Clap,survey$W.Hnd)


#  A.5 ¿Como se obtienen los totales (marginales y global) para estas tablas?

addmargins(hand_sex)

addmargins(clap_hand)


#  A.6 ¿Cómo se convierten a proporciones estas tablas?

#  A.6.a Aqui vemos las proporciones respecto al total de observaciones

prop.table(clap_hand)*100


#  A.6.a Y podemos observar las proporciones respecto al total de las columnas

prop.table(clap_hand,2)*100


#  A.7 Tambien podemos crear tablas de tres o mas dimensiones


table(survey$Clap, survey$W.Hnd, survey$Sex)



###      B. GRAFICAS PARA DATOS CUALITATIVOS

#  B.1 Podemos representar la tabla de contingencias como grafica de mosaico


mosaicplot(t(clap_hand), # Tabla de contingencias a graficar
           main= "Mano dominante y aplauso",
           xlab="Mano dominante",
           ylab="Mano arriba en aplauso",
           col=c(2,3,4,5), #Colores para categorias
           cex.axis=1.2, # Aumentar tamaño de etiquetas
           )


#  B.2 Y podemos crear graficas de barras a partir de los datos originales


dat <- filter(survey, !is.na(W.Hnd),!is.na(Sex),!is.na(Clap))

ggplot(dat, aes(x=W.Hnd,fill=Sex)) + geom_bar(position="dodge")

ggplot(dat, aes(x=Clap, fill=W.Hnd)) + geom_bar(position="dodge")



###      C. GRAFICAS PARA DATOS ORDINALES


## Ahora trabajaremos con las siguientes columnnas del dataset survey (del paquete MASS)

# Sex (Sexo biologico)
# Smoke (¿Qué tanto fumas?)


#  C.1 Smoke es una variable cualitativa ordinal, pero sus niveles están en desorden
#Esto afecta el orden en que se tabulan y grafican los datos


levels(survey$Smoke)

table(survey$Smoke)


#  C.2 Ordenaremos los niveles de Smoke


Smoke_l<-c("Never","Occas","Regul","Heavy")

survey$Smoke<-factor(survey$Smoke, ordered = TRUE, levels= Smoke_l)


#  C.3 Generemos tablas de frecuencias y de frecuencias acumuladas

tot<-table(survey$Smoke)

acu<-cumsum(tot)


#  C.4 Generamos un factor para unirlo a las tablas de frecuencias

Smoke <- factor(Smoke_l, levels = Smoke_l)


#  C.5 Y generamos un `data frame` con las frecuencias y el factor

tot_acu<-data.frame(tot=as.numeric(tot), acu=as.numeric(acu), Smoke)


#  C.6 Grafica de las frecuencias total y acumulada para Smoke

ggplot(tot_acu, aes(x=Smoke)) +
  geom_col(aes(y=tot)) +
  geom_point(aes(y=acu)) +
  geom_line(aes(y=acu), group=1)



######### EJERCICIOS Y TRUCOS ADICIONALES ###################################


#___Como crear una tabla de frecuencias con xtabs___#
#  Las tablas generadas por `xtabs` se usan como entrada de
#  Muchos calculos estadisticos y de algebra lineal

xtabs(~survey$Clap + survey$W.Hnd)


#___Tablas de 3 dimensiones con ftable___#
# `ftable` genera vistas mas compactas
# de las tablas de 3 o mas dimensiones

ftable(survey$Clap, survey$W.Hnd, survey$Sex)


#___Tablas de mosaico con el paquete `vcd`___#

#Una segunda forma de obtener graficas de mosaico es usando el paquete `vcd`
#Este paquete utiliza las tablas de contigencias generadas por `xtab`
#(puede que requieras instalar a `vcd`)

library(vcd)
clap_hand_x<-xtabs(~survey$Clap + survey$W.Hnd)
mosaic(clap_hand_x, shade=TRUE, legend=TRUE)

#Ademas con `vcd` podemos hacer graficas sobre la asociacion de variables

assoc(clap_hand_x, shade=TRUE, legend=TRUE)
