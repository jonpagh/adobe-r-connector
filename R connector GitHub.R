install.packages("RSiteCatalyst")
install.packages("httpuv")

#IF curl error then http://www.listendata.com/2015/08/install-r-package-directly-from-github.html
library(httr)


setwd("C:/Alteryx/R-3.1.3/Working directory")
library(RSiteCatalyst)
library(xlsx)
#library(httpuv)
 
#KEY_NEW <- "94328000dd-mobilelife-r-connector"
#SECRET_NEW <- "bbaffcc8adea85202d6e" 
KEY_OLD <- "jpag:MobileLife"
SECRET_OLD <- "" 


## New OAuth method
#key    <- Sys.getenv("KEY_OLD")
#secret <- Sys.getenv("SECRET_OLD")

SCAuth(KEY_OLD, SECRET_OLD)

#SCAuth(KEY_NEW, SECRET_NEW, 
#       company = "MobileLife", 
#       token.file = "auth-adobe",
#       debug.mode = TRUE,
#       auth.method = "OAUTH2"
#       )

suites <- GetReportSuites()

sweetAF <- "mobilelifesundaylive" 

evars <- GetEvars(sweetAF)
props <- GetProps(sweetAF)
metrics <- GetMetrics(sweetAF)


?xlsx

date <- Sys.Date()
path <- ("")
path_date <- paste(path," ",date,".xlsx")

write.xlsx(evars, path_date, sheetName = "evars")
write.xlsx(props, path_date, sheetName = "props", append=TRUE)
write.xlsx(metrics, path_date, sheetName = "metrics", append=TRUE)


######### GLOBAL VARIABLES
date.from <- "2016-04-01"
date.to <- "2016-04-28"
reportsuite.id <- sweetAF

#######################################################################

#Report types

#Overtime: Returns an overtime report. This is similar to the key metrics report in that the only granularity allowed is time. 
#Ranked: Returns a ranked report. This is an ordered list of elements and associated metrics with no time granularity.
#Trend: Returns a trended report. This is an ordered list of elements and associated metrics with time granularity
#Pathing: Returns a pathing report. This is an ordered list of paths matching the specified pattern.
#Fallout: Returns a fallout report. This is a pathed list of elements, with fallout values for each.

#######################################################################

###### OVER TIME REPORTS#

#### SIMPLE VISITORS
## OVERTIME REPORT VARIBLES
metrics <- c("visits","uniquevisitors","pageviews")

## wrap in system.time to report how long it takes
system.time(overtime.data <- QueueOvertime(reportsuite.id, 
                                           date.from, 
                                           date.to, metrics)
                                           )
## COMPLEX OVER TIME REPORT
metrics <- c("visits","uniquevisitors","pageviews")
date.granularity <- "hour"
segment.id <- "Visit_Natural_Search"
anomaly.detection <- FALSE
data.current <- TRUE
expedite <- FALSE ## only can set to TRUE if you have permission

system.time(overtime.data <- QueueOvertime(reportsuite.id, 
                                           date.from, date.to, 
                                           metrics,
                                           date.granularity = date.granularity,
                                           segment.id = segment.id,
                                           anomaly.detection = anomaly.detection,
                                           data.current = data.current,
                                           expedite = expedite))


######################################################################

####### RANKED REPORTS

### SIMPLE REPORTS
metrics <- c("visits","uniquevisitors","pageviews","event10")
elements <- c("page","geoCountry","geoCity")

system.time(ranked.data <- QueueRanked(reportsuite.id, 
                                       date.from, 
                                       date.to, 
                                       metrics, 
                                       elements)
                                       )

### COMPLEX REPORT
metrics <- c("visits","uniquevisitors","pageviews","event10","event9")
elements <- c("page","geoCountry","geoCity")
top <- 10
start <- 10
selected <- c("https://sunday.dk/velkommen","https://dev.sunday.dk/profile")
segment.id <- ""
data.current <- TRUE
expedite <- FALSE ## only can set to TRUE if you have permission

system.time(ranked.data <- QueueRanked(reportsuite.id, 
                                       date.from, date.to,
                                       metrics,
                                       elements,
                                       top = top,
                                       start = start,
                                       selected = selected,
                                       segment.id = segment.id,
                                       data.current = data.current,
                                       expedite = expedite))


######################################################################

####### TREND REPORTS

### SIMPLE REPORTS
metrics <- c("visits","uniquevisitors","pageviews","event10")
elements <- c("page","geoCountry","geoCity")

system.time(trended.data <- QueueTrended(reportsuite.id, 
                                         date.from, 
                                         date.to, 
                                         metrics, 
                                         elements)
                                         )

########################################################################################



metrics <- c("visits","uniquevisitors","pageviews")#,"event10","event9")
elements <- c("evar2","evar3","prop48")#,evar19","evar21","evar14")
date.from <- "2016-01-01"
date.to <- "2016-04-28"
top <- 100
start <- 100
#segment.id <- ""
data.current <- FALSE
expedite <- FALSE ## only can set to TRUE if you have permission

system.time(ranked.data2 <- QueueRanked(reportsuite.id, 
                                       date.from, date.to,
                                       metrics,
                                       elements,
                                       top = top,
                                       start = start,
                                       #selected = selected,
                                       #segment.id = segment.id,
                                       data.current = data.current,
                                       expedite = expedite))

