
library(qdap)
library(zoo)

corpus <- readRDS('Data/corpus.rds')

dat <- gantt(corpus$text, corpus$doc_id)
head(dat, 12)

plot(dat, base = TRUE)

sentiment <- polarity(corpus$text)

positive <- c()

for(i in 1:657){
  positive[i] <- length(sentiment[["all"]][["pos.words"]][[i]])/(length(sentiment[["all"]][["pos.words"]][[i]]) + 
                                                                   length(sentiment[["all"]][["neg.words"]][[i]]))
}

plot(rollmean(positive, 1), type = 'l', lwd = 5)
plot(rollmean(positive, 40), type = 'l', lwd = 3, col = 'dodgerblue4')
lines(rollmean(positive, 24), type = 'l', lwd = 2, col = 'dodgerblue2')
