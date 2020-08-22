library(ggplot2)
library(RColorBrewer)
library(ggmap)
library(maps)
library(rgdal)
library(scales)
library(maptools)
library(gridExtra)
library(rgeos)
states_shape = readOGR(file.choose())
class(states_shape)
names(states_shape)
print(states_shape$ID_1)
print(states_shape$NAME_1)
plot(states_shape, main = "Administrative Map of India")
dat=read.csv(file.choose())

dat_m=subset(dat,Country.Region=="China",select=Province.State:X8.13.20)
dat_m$id=seq.int(nrow(dat_m))

fortify_shape = fortify(states_shape, region = "ID_1")
class(fortify_shape)

Merged_data = merge(fortify_shape, dat_m,by="id" ,all.x=TRUE)
Map_plot = Merged_data[order(Merged_data$order), ]

dat2=read.csv(file.choose())

dat2_m=subset(dat2,Country.Region=="China",select=Province.State:X8.13.20)
dat2_m$id=seq.int(nrow(dat2_m))

fortify2_shape = fortify(states_shape, region = "ID_1")
class(fortify2_shape)

Merged2_data = merge(fortify2_shape, dat2_m,by="id" ,all.x=TRUE)
Map2_plot = Merged2_data[order(Merged2_data$order), ]

dat3=read.csv(file.choose())

dat3_m=subset(dat3,Country.Region=="China",select=Province.State:X8.13.20)
dat3_m$id=seq.int(nrow(dat3_m))

fortify3_shape = fortify(states_shape, region = "ID_1")
class(fortify3_shape)

Merged3_data = merge(fortify3_shape, dat3_m,by="id" ,all.x=TRUE)
Map3_plot = Merged3_data[order(Merged3_data$order), ]


plot1=ggplot() +
  geom_polygon(data = Map_plot,
               aes(x = long, y = lat, group = group, fill = X1.22.20),
               color = "red", size = 0.2) +
  coord_map() + scale_fill_distiller(name="Total.Cases", palette = "Set3" , breaks = pretty_breaks(n = 5))+
  theme_nothing(legend = TRUE)+
  labs(title="Total Cases in CHINA on 22/01/2020")
plot1

plot2=ggplot() +
  geom_polygon(data = Map_plot,
               aes(x = long, y = lat, group = group, fill = X8.13.20),
               color = "red", size = 0.2) +
  coord_map() + scale_fill_distiller(name="Total.Cases", palette = "Set3" , breaks = pretty_breaks(n = 5))+
  theme_nothing(legend = TRUE)+
  labs(title="Total Cases in CHINA on 13/08/2020")
plot2

plot3=ggplot() +
  geom_polygon(data = Map2_plot,
               aes(x = long, y = lat, group = group, fill = X1.22.20),
               color = "green", size = 0.2) +
  coord_map() + scale_fill_distiller(name="Recovered", palette = "Greens" , breaks = pretty_breaks(n = 9))+
  theme_nothing(legend = TRUE)+
  labs(title="Recovered Cases in CHINA on 22/01/2020")
plot3

plot4=ggplot() +
  geom_polygon(data = Map2_plot,
               aes(x = long, y = lat, group = group, fill =X8.13.20),
               color = "green", size = .2) +
  coord_map() + scale_fill_distiller(name="Recovered", palette = "Greens" , breaks = pretty_breaks(n = 9))+
  theme_nothing(legend = TRUE)+
  labs(title="Recovered Cases in CHINA on 13/08/2020")
plot4

plot5=ggplot() +
  geom_polygon(data = Map3_plot,
               aes(x = long, y = lat, group = group, fill = X1.22.20),
               color = "red", size = .2) +
  coord_map() + scale_fill_distiller(name="Deaths", palette = "Reds" , breaks = pretty_breaks(n = 9))+
  theme_nothing(legend = TRUE)+
  labs(title="Total Deaths in CHINA on 22/01/2020")
plot5

plot6=ggplot() +
  geom_polygon(data = Map3_plot,
               aes(x = long, y = lat, group = group, fill = X8.13.20),
               color = "red", size = .2) +
  coord_map() + scale_fill_distiller(name="Deaths", palette = "Reds" , breaks = pretty_breaks(n = 9))+
  theme_nothing(legend = TRUE)+
  labs(title="Total Deaths in CHINA on 13/08/2020")
plot6


library(gridExtra)
grid.arrange(plot1, plot2, plot3, plot4,plot5,plot6)
