# Script de Web Scraping e criação de corpus para as cartas do Vincent ao Theo
# 
# Autor: @gustavoovital
# Data: 23/05/2020

# To Run ----

rm(list = ls())

source('Functions/functions.R')
library(rvest)
library(tidyverse)
library(pdftools)

# Web Scraping

url_vangogh <- 'http://www.vggallery.com/letters/combined.htm'

pdfs <- url_vangogh %>% 
  read_html() %>% 
  html_nodes('table') %>% 
  html_nodes('tr') %>% 
  html_node('a') %>% 
  html_attr('href')

tables <- url_vangogh %>% 
  read_html() %>% 
  rvest::html_nodes('table') %>% 
  html_table(fill = TRUE) 


# Criando um Corpus ---


corpus <- tibble(Pdf = na.omit(pdfs),
                 Numbers = (tables[[3]][["X1"]])[2:(length(tables[[3]][["X1"]]))],
                 Data = (tables[[3]][["X2"]])[2:length(tables[[3]][["X2"]])],
                 From = (tables[[3]][["X4"]])[2:length(tables[[3]][["X4"]])],
                 To = (tables[[3]][["X5"]])[2:length(tables[[3]][["X5"]])],
                 Origin = (tables[[3]][["X3"]])[2:length(tables[[3]][["X3"]])]) %>% 
  filter(From == 'VvG', To == 'TvG')

corpus$text <- NA

for(carta in 1:nrow(corpus)){
  corpus$text[carta] <- pdf_text(paste('http://www.vggallery.com/letters/', corpus$Pdf[carta], sep = '')) %>% 
    split_n()
}

# Organizando o Corpus ----

corpus$doc_id <- 1:nrow(corpus)

corpus %>% 
  select(doc_id, text, Data, Origin, Numbers
  ) -> corpus
  
saveRDS(corpus, 'Data/corpus.rds')
rm(list = ls())
