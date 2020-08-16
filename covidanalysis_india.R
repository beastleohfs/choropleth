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



fortify_shape = fortify(states_shape, region = "ID_1")
class(fortify_shape)

Merged_data = merge(fortify_shape, dat,by="id", all.x=TRUE)
Map_plot = Merged_data[order(Merged_data$order), ]

plot1=ggplot() +
  geom_polygon(data = Map_plot,
               aes(x = long, y = lat, group = group, fill = Total.Cases),
               color = "red", size = 0.2) +
  coord_map() + scale_fill_distiller(name="Total.Cases", palette = "Reds" , breaks = pretty_breaks(n = 9))+
  theme_nothing(legend = TRUE)+
  labs(title="  Total Cases in India")
plot1

plot2=ggplot() +
  geom_polygon(data = Map_plot,
               aes(x = long, y = lat, group = group, fill = Active.Cases),
               color = "blue", size = 0.2) +
  coord_map() + scale_fill_distiller(name="Total.Cases", palette = "Blues" , breaks = pretty_breaks(n = 9))+
  theme_nothing(legend = TRUE)+
  labs(title="   Active Cases in India")
plot2

plot3=ggplot() +
  geom_polygon(data = Map_plot,
               aes(x = long, y = lat, group = group, fill = Deaths.),
               color = "red", size = 0.2) +
  coord_map() + scale_fill_distiller(name="Total.Cases", palette = "YlOrRd" , breaks = pretty_breaks(n = 9))+
  theme_nothing(legend = TRUE)+
  labs(title="   Total Deaths in India")
plot3

plot4=ggplot() +
  geom_polygon(data = Map_plot,
               aes(x = long, y = lat, group = group, fill = Cured...Migrated),
               color = "black", size = .2) +
  coord_map() + scale_fill_distiller(name="Total.Cases", palette = "Greens" , breaks = pretty_breaks(n = 9))+
  theme_nothing(legend = TRUE)+
  labs(title="    Cured+Migrated")
plot4


library(gridExtra)
grid.arrange(plot1, plot2, plot3, plot4)
        