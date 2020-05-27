# Funções
# 
# Autor: @gustavoovital
# Data: 27/05/2020

# split function ----

split_n <-   function(caracter){
    split <- str_c(unlist(caracter %>%
                            str_split("[\r\n]")), collapse = " ")
  }

# StopWords ----

StopWords <- (c(stopwords::stopwords(), letters, 'copyright', 'theo', 'mr', 'dear', 'brother'))
