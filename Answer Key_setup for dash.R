candy<-read.csv("candy_production.csv")

candy$observation_date<-ymd(candy$observation_date)

#PlotA

ggplot()+
  geom_line(data=candy,aes(x=observation_date,y=IPG3113N))

#PlotB

df<-candy

df<-df%>%
  filter(observation_date<='1990-12-31')%>%
  filter(observation_date>='1990-01-01')

ggplot()+
  geom_line(data=df,aes(x=observation_date,y=IPG3113N))+
  scale_x_date(date_breaks='1 month',date_labels='%b')

#PlotC

df<-candy

df$observation_date<-str_sub(df$observation_date,3,3)

df<-df%>%
  filter(observation_date != '7')%>%
  filter(observation_date != '1')

df$observation_date<-paste(df$observation_date,"0's",sep='')

df<-df%>%
  group_by(observation_date)%>%
  summarize(avg=mean(IPG3113N))

df$observation_date<-factor(df$observation_date,levels=c("80's","90's","00's"))

ggplot()+
  geom_bar(data=df,aes(x=observation_date,y=avg),stat='identity')
