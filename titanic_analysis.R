#reading csv file.
data1<-read.csv("titanic.csv")

#loading dplyr
library(dplyr)

#removing missing data.
data1$Age[is.na(data1$Age)]<-mean(data1$Age,na.rm=TRUE)

#new category AgeGroup.
data1 <- data1 %>%
  mutate(AgeGroup = case_when(
    Age < 18 ~ "Underaged",
    Age >= 18 & Age <= 50 ~ "Adult",
    Age > 50 ~ "Old"
  ))

#new category Survival.
data1 <- data1 %>%
  mutate(Survival = case_when(
    Survived == 0 ~ "Died",
    Survived == 1 ~ "Survived"
  ))

#taking a smaller sample for better analysis.
data1<-sample_n(data1,250)

#data after filteration:
data1

#loading ggplot2.
library(ggplot2)

#graphs:
#barplot:
ggplot(data1,aes(x=Survived,y=Fare))+
  geom_bar(stat="identity",fill="blue")+
  theme_minimal()+
  labs(title="Survived vs Fare",x="Survived",y="Fare")

#lineplot:
ggplot(data1,aes(x=Age,y=Fare))+
  geom_line(colour="blue",linewidth=1)+
  geom_point(colour="black",size=2)+
  theme_minimal()+
  labs(title="Age vs Fare",x="Age",y="Fare")

#histogram:
ggplot(data1,aes(x=Fare))+
  geom_histogram(binwidth=5,fill="skyblue",colour="black")+
  theme_minimal()+
  labs(title="Fare vs Frequency",x="Fare",y="Frequency")

#scatterplot:
ggplot(data1,aes(x=Age,y=Fare))+
  geom_point(colour="blue",size=2)+
  theme_minimal()+
  labs(title="Age vs Fare",x="Age",y="Fare")

#boxplot:
ggplot(data1,aes(x=Fare,y=Sex))+
  geom_boxplot(fill="yellow",colour="green")+
  theme_minimal()+
  labs(title="Fare vs Sex",x="Fare",y="Sex")

#boxplot2:
ggplot(data1,aes(x=Fare,y=Survival))+
  geom_boxplot(fill="blue",colour="skyblue")+
  theme_minimal()+
  labs(title="Fare vs Survival",x="Fare",y="Survival")

#boxplot3:
ggplot(data1,aes(x=Age,y=Sex))+
  geom_boxplot(fill="green",colour="red")+
  theme_minimal()+
  labs(title="Age vs Sex",x="Age",y="Sex")

#piechart:
ggplot(data1,aes(x="",y=Fare,fill=Sex))+
  geom_bar(stat="identity",width=1)+
  coord_polar(theta="y",direction=1)+
  theme_light()+
  labs(title="Sex and Fare")

#piechart2:
ggplot(data1,aes(x="",y=Fare,fill=AgeGroup))+
  geom_bar(stat="identity",width=1)+
  coord_polar(theta="y",direction=1)+
  theme_light()+
  labs(title="AgeGroup and Fare")

#piechart3:
ggplot(data1,aes(x="",y=Fare,fill=Survival))+
  geom_bar(stat="identity",width=1)+
  coord_polar(theta="y",direction=1)+
  theme_light()+
  labs(title="Survival and Fare")

#piechart4:
ggplot(data1,aes(x="",y=Survived,fill=AgeGroup))+
  geom_bar(stat="identity",width=1)+
  coord_polar(theta="y",direction=1)+
  theme_light()+
  labs(title="Survival and AgeGroup")

#anova test
anova_result<-aov(Age ~ Survived,data=data1)
summary(anova_result)
anova_result2<-aov(Fare ~ Survived,data=data1)
summary(anova_result2)