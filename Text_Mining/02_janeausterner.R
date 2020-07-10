##########################################################################################################################################

#(주의) ->  순차적으로 코드를 실행하는 것을 권함!

#에러 발생 시 github Unstructured-data-analysis/text_mining 경로에 issue를 남기면 확인

##########################################################################################################################################

text<-c("Because I could not stop for Death -",
        "He Kindly stopped for me -",
        "The Carriage held but just Ourselves -",
        "and Immorality")
text

# 위의 코드에 나오는 text는 전형적인 문자 벡터.
# 먼저 텍스트를 데이터 프레임에 넣어야 하는데, 이것을 정돈된 텍스트 데이터 셋으로 변환.

library(dplyr)
text_df<-data_frame(line = 1:4 , text=text)
text_df


# ************** 여기서부터 01_unnest_tokens ************** 

install.packages("tidytext")
library(tidytext)

text_df %>% unnest_tokens(word, text)


### Janeausterner package 

.libPaths("C://Users//yjang//R")    # 저장 디렉토리 및 lib 경로 설정.

install.packages("janeaustenr")
install.packages("dplyr")
install.packages("stringr")


library(janeaustenr)
library(dplyr)
library(stringr)

original_books <- austen_books() %>%
  group_by(book) %>%
  mutate(linenumber = row_number(), chapter = cumsum(str_detect(text, regex("^chapter [\\divxlc]",
                                                                            ignore_case = TRUE)))) %>%
  ungroup()


tidy_books<-original_books %>%
  unnest_tokens(word, text)

tidy_books


data("stop_words")

tidy_books<-tidy_books %>%
  anti_join(stop_words)


tidy_books %>%
  count(word, sort = TRUE)

library(ggplot2)

tidy_books %>%
  count(word,sort = TRUE) %>%
  filter(n > 600) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word,n))
  geom_col()
  xlab(NULL)
  coord_flip()

############################################################결과값(print)#################################################################

# # > tidy_books<-original_books %>%
# +   unnest_tokens(word, text)
# > tidy_books
# # A tibble: 725,055 x 4
# book                linenumber chapter word       
# <fct>                    <int>   <int> <chr>      
#   1 Sense & Sensibility          1       0 sense      
# 2 Sense & Sensibility          1       0 and        
# 3 Sense & Sensibility          1       0 sensibility
# 4 Sense & Sensibility          3       0 by         
# 5 Sense & Sensibility          3       0 jane       
# 6 Sense & Sensibility          3       0 austen     
# 7 Sense & Sensibility          5       0 1811       
# 8 Sense & Sensibility         10       1 chapter    
# 9 Sense & Sensibility         10       1 1          
# 10 Sense & Sensibility         13       1 the   


# > data("stop_words")
# > tidy_books<-tidy_books %>%
#   +   anti_join(stop_words)
# Joining, by = "word"
# > tidy_books %>%
#   +   count(word, sort = TRUE)
# # A tibble: 13,914 x 2
# word       n
# <chr>  <int>
#   1 miss    1855
# 2 time    1337
# 3 fanny    862
# 4 dear     822
# 5 lady     817
# 6 sir      806
# 7 day      797
# 8 emma     787
# 9 sister   727
# 10 house    699
# # ... with 13,904 more rows


##########################################################################################################################################