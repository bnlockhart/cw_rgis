library(tidyverse)

#basic plot
#aes = aesthetic
#short cut piping: ctrl+shift+m -> %>% 
#aes (..., color= COLUMNAME) to color by data
# ctrl+shift+R = line
# point figure ------------------------------------------------------------



iris %>%
  ggplot(
    aes(x = Sepal.Length,
        y = Sepal.Width)
  ) +
  geom_point()

# color -------------------------------------------------------------------


#adjsting color#
iris %>% 
  ggplot(
    aes(x = Sepal.Length,
        y = Sepal.Width, 
        color = Species)
  ) +
  geom_point()
head(iris)

iris %>%
  ggplot(
    aes( x= Sepal.Length,
         y= Sepal.Width)
  ) +
  geom_point(color = "darkgreen")
  


# line figure -------------------------------------------------------------

df_x <- tibble( x = 1:50,
        y = 2 * x)
df_x


df_x %>% 
  ggplot(
    aes( x = x, 
         y = y)
  )  +
   geom_line()
  

# Histogram ---------------------------------------------------------------

iris %>%
  ggplot()
  aes( x = Sepal.Length)
 ) +
  geom_histogram()

# box plot ----------------------------------------------------------------

iris %>% 
  ggplot(
    aes(x = Species,
        y = Sepal.Length)
  ) +
  geom_boxplot()

#change color
iris %>% 
  ggplot(
    aes( x = Species,
         y = Sepal.Length,
         color = Species)
  ) +
  geom_boxplot()
  
#change inside box
iris %>% 
  ggplot(
    aes( x = Species,
         y = Sepal.Length,
         fill = Species)
  ) +
  geom_boxplot()


# exercise ----------------------------------------------------------------

#Q1 Using 'iris' data, identify the longest sepal.Length using arrange() function

iris %>% 
  arrange(desc(Sepal.Length))

#Q2 Using iris data, filter individuals with sepal.width greater than 3.0
# Use fillter()

iris %>% 
  filter(Sepal.Width > 3.0)

#Q3 Using 'iris' data, select the columns "Petal.Length" and " Petal. Wifth", 
# and then arrange the order(descending) of rows by "Petal . Length"
#Assign the result to object "df_petal"

 df_petal <- iris %>% 
  select(Petal.Length, Petal.Width) %>% 
  arrange(desc(Petal.Length))

 df_petal 

 #Q4 Calculate mean Sepal. Width by species; assign the results to "df-mean" 
 # - hint group_by() and summarize()
 
 df_mean <- iris %>% 
   group_by(Species) %>% 
   summarize(mean = mean(Sepal.Width))
 
 df_mean

 #Q5 Cerate a point figure of  petal.width (y-axis_ and sepal. width(x-axis)
 
 iris %>% 
   ggplot(
     aes(x = Sepal.Width,
         y = Petal.Width)
   ) + 
   geom_point()
   