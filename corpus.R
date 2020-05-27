# Analise textual das cartas de van gogh para o seu irmao Theo. Que sempre sejam lembrados.
# "A Vida tem Cor de Água Suja"
# 
# Autor: Gustavo Vital
# Data: 27/05/2020


# To Run ----

rm(list = ls())

source('Functions/functions.R')
library(tidyverse)

corpus <- read_rds('Data/corpus.rds')

# Definindo período de vida e locais ----

corpus %>% 
  mutate(Origin = ifelse(Origin == 'T-H', 'Hague',
                         ifelse(Origin == 'Nu', 'Nuenen',
                                ifelse(Origin == 'Ar', 'Arles',
                                       ifelse(Origin == 'S-R', 'Saint-Rémy', 
                                              ifelse(Origin == 'A-s-O', 'Auvers-sur-Oise', Origin)))))) -> corpus

# Fases da Vida de Vincent de acordo com o período:
# 
#   Juventude: Até 167, carta 166 match('166', corpus$Numbers)
#   Netherlands: 168 Até 476  match('462', corpus$Numbers)
#   Arles : 477 Até 609 match('590', corpus$Numbers)
#   Saint-Remy: 610 Até 646  match('634', corpus$Numbers)
#   Auver-sur-Oises: 647 até 657 match('652', corpus$Numbers)

corpus$Life <- c(rep('Earliest', 167),
                 rep('Netherlands', (477-167)),
                 rep('Arles', (609-477)),
                 rep('Saint-Remy', (647-610)),
                 rep('Auver-sur-Oises', (658-647)))


saveRDS(corpus, 'Data/corpus_all.rds')

corpus %>% filter(Life == 'Earliest') %>%  saveRDS('Data/corpus_Earliest.rds')
corpus %>% filter(Life == 'Netherlands') %>%  saveRDS('Data/corpus_Netherlands.rds')
corpus %>% filter(Life == 'Arles') %>%  saveRDS('Data/corpus_Arles.rds')
corpus %>% filter(Life == 'Saint-Remy') %>%  saveRDS('Data/corpus_SaintRemy.rds')
corpus %>% filter(Life == 'Auver-sur-Oises') %>%  saveRDS('Data/corpus_AuverSurOises.rds')

rm(list = ls())
