
setwd('/git_repositories/RBI_Speeches')

# setwd("~/Documents/college/PhD/Output/Dataset/GitHub/RBI_Speeches") ## for my computer - sahil

library(tm)
library(ggplot2)
library(scales)

meta <- read.csv('metadata.csv', stringsAsFactors = F)
f<-read.csv('frequency_monthly.csv', stringsAsFactors = F)


#######################################
# calculating time series of speeches #
#######################################

date<-meta$date_new
date<-as.Date(date,"%d-%m-%Y")
freq<-table(date) 
freq<-data.frame(freq)

p<-ggplot(freq, aes(x = date, y = Freq))
p<-p+geom_point(size=3)
p<-p + scale_x_discrete(name="Date",labels=abbreviate) +
  scale_y_continuous(name="Frequency") + theme(axis.title.x = element_text( colour="#990000", size=20),
                                               axis.text.x  = element_text(angle=90, vjust=0.5, size=8))
pdf('Speeches_TimeSeries.pdf')
p
dev.off()

minDate <- timeCalendar(y=as.integer(format(min(time(date)),'%Y')),m=1,d=1)
maxDate <- max(time(date))
datesToShow = timeSequence(from=minDate,to=maxDate,by="1 year")

plot(freq, major.format = "%Y",type="l")

plot(freq, xaxt = "n")
axis(1, date, format(date, "%d %b"), cex.axis = .7)

ddate<-strftime(freq$date,"%Y-%m-%d")
ddate<-strftime(date,"%Y-%m")

fr_mon<-table(ddate)

fr_mon<-data.frame(fr_mon)
p<-ggplot(fr_mon, aes(x = ddate, y = Freq))
p<-p+geom_bar(size=3) + scale_x_discrete(name="Date")

plot(fr_mon,type="h")

a<-f$freq
a<-as.vector(a)
myts <- ts(a, start=c(2005, 1), end=c(2014, 9), frequency=12)

pdf('Speeches_TimeSeries.pdf')
plot(myts,xlab="Date",ylab="Frequency")
lines()
dev.off()


f<-data.frame(f)

p<-ggplot(f, aes(x = date, y = freq))
p<-p+geom_bar(size=3) + scale_x_discrete(name="Date")


#######################################
# frequency of the top speakers (by #) #
#######################################

people<-table(meta$Person)
people<-data.frame(people)
people<-people[order(people$Freq),]
peo<-cbind(as.character(people$Var1[61:78]),people$Freq[61:78])
peo<-data.frame(peo)
q<-ggplot(peo, aes(x = X1, y = X2))
q<-q+geom_bar()+coord_flip() + scale_x_discrete(name="Officials") +
  scale_y_discrete(name="Frequency") 
   
pdf('People_TopSpeakers.pdf')
q
dev.off()