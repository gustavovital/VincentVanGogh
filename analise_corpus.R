# Analise dos períodos de Vida do Vincent pelas cartas
# 
# Autor: @gustavoovital
# Data: 27/05/2020

# To Run ----

source('Functions/functions.R')

library(tidyverse)
library(tidytext)

# 1 - Análise Por Períodos ----

earliest <- read_rds('Data/corpus_all.rds')

earliest %>% 
  unnest_tokens(bigram, text, token = "ngrams", n = 2) %>% 
  count(bigram, sort = TRUE) %>% 
  separate(bigram, c('term1', 'term2'), sep = ' ') %>% 
  
  filter(!term1 %in% StopWords) %>%
  filter(!term2 %in% StopWords) %>%
  arrange(desc(n)) %>% 
  mutate(term = paste(term1, term2))
