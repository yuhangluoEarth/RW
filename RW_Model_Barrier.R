library(ggplot2)
library(dplyr)
library(foreign)
library(tictoc)
set.seed(251)
Break.road <- data.frame(X11399 = c(rep(201,900),rep(202,900),
                                    rep(203,900),rep(204,900),
                                    rep(205,900),rep(206,900),
                                    rep(207,900),rep(208,900),
                                    rep(209,900),rep(210,900)),
                         Y22555 = rep(c(-99:800),10))
KunPeng <- select(Break.road,X11399,Y22555)%>%mutate(XY = paste0(X11399,",",Y22555))
KunPeng2 <- select(KunPeng,XY)
##########
x.i <- 0
y.i <- 0
x <- list()
y <- list()
step <- list()
location <- data.frame(step = 0,x = x.i,y = y.i)
tic("sleeping")
for (i in c(1:20000)) {
  print(i)
  step_wid <- sample(c(1:5),1)
  sita <- sample(c(1:360),1)
  x.d <- step_wid*cos(sita)
  y.d <- step_wid*sin(sita)
  x.i <- x.i + x.d
  y.i <- y.i + y.d
  x.i2 <- round(x.i,0)
  y.i2 <-  round(y.i,0)
  if((paste0(x.i2,",",y.i2)%in%KunPeng2$XY)){
    print('out')
    x.i <- x[[i-1]]
    y.i <- y[[i-1]]
    while ((paste0(x.i2,",",y.i2)%in%KunPeng2$XY)) {
      ######
      step_wid <- sample(c(1:5),1)
      sita <- sample(c(1:360),1)
      x.d <- step_wid*cos(sita)
      y.d <- step_wid*sin(sita)
      x.i <- x.i + x.d
      y.i <- y.i + y.d
      x.i2 <- round(x.i,0)
      y.i2 <-  round(y.i,0)
      if(!(paste0(x.i2,",",y.i2)%in%KunPeng2$XY)){    
        print('out')
        x.i <- x[[i-1]]
        y.i <- y[[i-1]]}
      }
  }
  x[[i]] <- x.i
  y[[i]] <- y.i
  step[[i]] <- i
}
toc()
location.i <- data.frame(step = t(data.frame(step)),x = t(data.frame(x)),y = t(data.frame(y)))
location <- bind_rows(location,location.i)
location.begin <- filter(location,step == 0)
location.end <- filter(location,step == i)
(location.end$x^2+location.end$y^2)^0.5*5
atan(location.end$y/location.end$x)/(2*3.1415296)*360
#########
p <- ggplot(data = location,aes(x*5,y*5))+
  geom_raster(data = KunPeng,aes(X11399*5,Y22555*5),fill = "black")+
  geom_point(aes(color = step),size = 0.5)+
  geom_point(data = location.begin,aes(x*5,y*5),shape = 24,size = 4,color = "black",fill = "#da0017")+
  geom_point(data = location.end,aes(x*5,y*5),shape = 24,size = 4,color = "black",fill = "#29599f")+
  theme_bw()+theme(axis.text = element_text(color = "black"))+
  scale_color_gradientn(colors = c('#065913','#15816a','#faddbd','#d99449'))+
  xlab('Dispersal along the x-axis (m)')+ylab('Dispersal along the y-axis (m)')+
  ylim(c(-10*5,620*5))+xlim(c(-170*5,420*5))
p
#setwd('')
#ggsave(filename = "Random_Walk_Break.pdf",p,width = 5,height = 3)
