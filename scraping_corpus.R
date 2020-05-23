# Script de Web Scraping e criação de corpus para as cartas do Vincent ao Theo
# 
# Autor: @gustavoovital
# Data: 23/05/2020

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

# split function ----

split_n <-
  function(caracter){
    split <- str_c(unlist(caracter %>%
                            str_split("[\r\n]")), collapse = " ")
  }

# Criando um Corpus ---


corpus <- tibble(Pdf = na.omit(pdfs),
                 Data = (tables[[3]][["X2"]])[2:length(tables[[3]][["X2"]])],
                 From = (tables[[3]][["X4"]])[2:length(tables[[3]][["X4"]])],
                 To = (tables[[3]][["X5"]])[2:length(tables[[3]][["X5"]])]) %>% 
  filter(From == 'VvG', To == 'TvG')

corpus$text <- NA

for(carta in 1:nrow(corpus)){
  corpus$text[carta] <- pdf_text(paste('http://www.vggallery.com/letters/', corpus$Pdf[carta], sep = '')) %>% 
    split_n()
}

# Organizando o Corpus ----

corpus$doc_id <- 1:nrow(corpus)

corpus %>% 
  select(doc_id, text, Data) -> corpus
  
saveRDS(corpus, 'Data/corpus.rds')
rm(list = ls())
