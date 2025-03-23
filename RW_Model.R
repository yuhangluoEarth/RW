library(ggplot2)
library(dplyr)
set.seed(251)
x <- 0
y <- 0
location <- data.frame(step = 0,x = 0,y = 0)
for (step in c(1:20000)) {
  step_wid <- sample(c(1:5),1)
  sita <- sample(c(1:360),1)
  x.i <- step_wid*cos(sita)
  y.i <- step_wid*sin(sita)
  x <- x + x.i
  y <- y + y.i
  location.i <- data.frame(step = step,x = x,y = y)
  
  location <- bind_rows(location,location.i)
}
location <- transform(location,x = x*5, y = y*5)
location.begin <- filter(location,step == 0)
i <- step
location.end <- filter(location,step == i)
(location.end$x^2+location.end$y^2)^0.5
atan(location.end$y/location.end$x)/(2*3.1415296)*360
#########
p <- ggplot(data = location,aes(x,y))+
  geom_point(aes(color = step),size = 0.5)+
  geom_point(data = location.begin,aes(x,y),shape = 24,size = 4,color = "black",fill = "#da0017")+
  geom_point(data = location.end,aes(x,y),shape = 24,size = 4,color = "black",fill = "#29599f")+
  theme_bw()+theme(axis.text = element_text(color = "black"))+
  scale_color_gradientn(colors = c('#065913','#15816a','#faddbd','#d99449'))+
  xlab('Dispersal along the x-axis (m)')+ylab('Dispersal along the y-axis (m)')+
  ylim(c(-10*5,620*5))+xlim(c(-170*5,420*5))
p
setwd('W:\\SZ_Species\\Fig\\Figure\\Figure2')
ggsave(filename = "Random_Walk_2w.pdf",p,width = 5,height = 3)

