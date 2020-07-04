##########################################################################################################################################

#(주의) ->  순차적으로 코드를 실행하는 것을 권함!

#에러 발생 시 github Unstructured-data-analysis/text_mining 경로에 issue를 남기면 확인

##########################################################################################################################################


### 정돈 텍스트와 다른 데이터 구조를 비교

# 정돈 텍스트 형식은 깔끔한 데이터 형식을 뜻함.
# 1행당 1토큰이 있는 테이블을 정의.


# ***** "토큰" 이란 분석을 위해 사용하고자 하는, 단어와 같은 의미 있는 텍스트 단위*****

# ***** "토큰화" 란 텍스트를 토큰으로 분할 하는 과정을 의미*****

# 이러한 방식으로 텍스트 데이터를 구성하면 정돈 데이터 원리를 따르는게 되므로 여러 도구 모음을 사용해 텍스트를 일관되게 조작 가능.
# 이러한 방식은 정돈 텍스트 마이닝 방식이 아닌 기존 텍스트 마이닝 접근법에서 흔히 텍스트를 저장하는 방식.



# 문자열(String)

# 텍스트 R의 언어의 문자열 (즉, 문자 벡터)형식으로 저장할 수 있음. 
# 종종 텍스트 데이터는 이 형식에 맞춰 메모리로 읽혀짐.

# 말뭉치(corpus)

# 이러한 객체 유형에는 일반적으로 추가 메타데이터 및 세부사항을 사용해 주석 처리한 원시 문자열(raw strings)가 들어있음.

# 문서-용어 행렬(document-term matrix)

# 각 문서가 1개 행을 이루고 각 용어가 1개 열을 채우는 구조로 된 문서들의 모음집(즉 말뭉치)라고 설명할 수 있는 희소 행렬(sparse matrix).
# 이 행렬을 구성하는 각 값은 일반적으로 단어 개수(word count)또는 tf-idf


.libPaths("C://Users//yjang//R")    # 저장 디렉토리 및 lib 경로 설정.


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

# 텍스트 프레임워크 내에서 텍스트를 개별 토큰으로 분해하고 (토큰화) 이를 정돈 데이터 구조(tidy data structure)로 변환.
# tidytext 패키지에 들어 있는 unnest_tokens()함수를 사용.

# 여기에 사용된 unnest_tokens()의 두 가지 기본 인수인 word와 text는 각기 열 이름으로 나타냄.


# 첫 째 인수로는 텍스트의 중첩이 해제될 때 까지 생성될 출력 열 이름을 지정하고(이 경우는 word)
# 둘 째 인수로는 텍스트가 들어오는 입력 열을 지정.( 이 경우에는 text)

# 앞서 나온 text_df 에는 우리의 관심대상인 데이터를 담은 text라는 열이 있었다는 점.

# unnest_tokens() 를 사용하면 새로운 데이터 프레임에서는 각 행마다 토큰(단어)이 한 개만 있도록 각 행이 분할.
# unnest_tokens() 에서는 기본적으로 단일한 단어들을 대상으로 토큰화하는데, 이 점을 앞에 표시되어 있는 출력 내용을 보고 확인 가능.


#  ************** 주의점. ************** 

# (각 단어들이 들어 있는 열을 제외한) 나머지 열들(columns)은 그대로 유지.

# 구두점이 제거됨.

# 기본적으로 unnest_tokens()는 토큰을 소문자로 변환하므로 다른 데이터셋과 쉽게 비교하거나 결합할 수 있음.

# 이 동작을 해제하려면 to_lower = FALSE 인수를 사용. 

############################################################결과값(print)#################################################################

# > install.packages("tidytext")
# Installing package into ‘C:/Users/yjang/R’
# (as ‘lib’ is unspecified)
# also installing the dependencies ‘sys’, ‘askpass’, ‘openssl’, ‘ini’, ‘httr’, ‘curl’, ‘fs’, ‘gh’, ‘git2r’, ‘whisker’, ‘yaml’, ‘stringi’, ‘SnowballC’, ‘ISOcodes’, ‘usethis’, ‘stringr’, ‘hunspell’, ‘tokenizers’, ‘janeaustenr’, ‘stopwords’


# There are binary versions available but the source versions are later:
#  binary source needs_compilation
# openssl  1.4.1  1.4.2              TRUE
# fs       1.4.1  1.4.2              TRUE


# The downloaded binary packages are in

# C:\Users\yjang\AppData\Local\Temp\RtmpgDabmB\downloaded_packages

# > library(tidytext)

# Warning message:
#  패키지 ‘tidytext’는 R 버전 4.0.2에서 작성되었습니다 

# > text_df %>% unnest_tokens(word, text)
# A tibble: 20 x 2

#line word      
#<int> <chr>     
#  1     1 because   
#2     1 i         
#3     1 could     
#4     1 not       
#5     1 stop      
#6     1 for       
#7     1 death     
#8     2 he        
#9     2 kindly    
#10     2 stopped   
#11     2 for       
#12     2 me        
#13     3 the       
#14     3 carriage  
#15     3 held      
#16     3 but       
#17     3 just      
#18     3 ourselves 
#19     4 and       
#20     4 immorality

##########################################################################################################################################

