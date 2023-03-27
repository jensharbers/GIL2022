library(ggplot2)
library(ggpubr)
library(sp)
library(sf)
library(rgeos)
library(rgdal)


ballen_distanzen <- read.csv("C:/Users/Jens Harbers/ballen_distanzen.csv")
ggboxplot(ballen_distanzen,x="groups",y="dists", ylab="Distanz je Ballen und Clusterzentrum [m]", xlab="Gruppenbezeichnung")+
  theme(legend.position = "None") 

sum(base::table(ballen_distanzen$groups))
shp <- readOGR("C:\\Users\\Jens Harbers\\Documents\\skizzen\\gfn_schlaege.shp")
field <- shp[shp$SCHLAG_NR == 170,]

ballen_distanzen$groups <- as.factor(ballen_distanzen$groups)
ballen_distanzen$gr <- ballen_distanzen$groups

clusterZentren <- read.csv("C:/Users/Jens Harbers/clusterZentren.csv", sep=";")
clusterZentren$groups <- as.factor(clusterZentren$groups)

map <- ggplot() + geom_polygon(data=field, aes(x=long,y=lat),fill="white",color="black") + theme_pubr()
# map <- map + geom_point(data=Ballen_9_jueck, aes(x=coords_x_x,y=coords_y_x),color="orange")
# map
map <- map + geom_text(data=ballen_distanzen, aes(x=coords_x_x,y=coords_y_x, label = gr))  + geom_point()
map
map <- map + geom_point(data=clusterZentren, aes(x=coords_x,y=coords_y),size=3,shape=5)
map <- map + geom_point(data=clusterZentren, aes(x=coords_x,y=coords_y),size=3,shape=3)
map <- map + theme(axis.text=element_text(size=12),
                   axis.title=element_text(size=12),
                   legend.position="top",
                   axis.text.x=element_text(colour="black"),
                   axis.text.y=element_text(colour="black"))+xlab("Longitude")+ylab("Latitude")
map
