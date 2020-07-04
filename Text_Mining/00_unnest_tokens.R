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


############################################################결과값(print)#################################################################

# [Workspace loaded from ~/.RData]

# > text<-c("Because I could not stop for Death -",
#          +         "He Kindly stopped for me -",
#          +         "The Carriage held but just Ourselves -",
#          +         "and Immorality")

# > text
# [1] "Because I could not stop for Death -"   "He Kindly stopped for me -"             "The Carriage held but just Ourselves -"
# [4] "and Immorality"  


# > library(dplyr)

# 다음의 패키지를 부착합니다: ‘dplyr’

# The following objects are masked from ‘package:stats’:
  
#  filter, lag

# The following objects are masked from ‘package:base’:
  
#  intersect, setdiff, setequal, union

# > text_df<-data_frame(line = 1:4 , text=text)

# Warning message:
#  `data_frame()` is deprecated as of tibble 1.1.0.
# Please use `tibble()` instead.
# This warning is displayed once every 8 hours.
# Call `lifecycle::last_warnings()` to see where this warning was generated. 

# > text_df

# A tibble: 4 x 2
# line text                                  
# <int> <chr>                                 
#  1     1 Because I could not stop for Death -  
#  2     2 He Kindly stopped for me -            
#  3     3 The Carriage held but just Ourselves -
#  4     4 and Immorality  

##########################################################################################################################################

# 데이터 프레임이 'tibble'이라는 이름으로 출력.

# tibble은 R의 데이터프레임_dataframe 을 나타내는 현대적인 클래스.

# dplyr 및 tibble 패키지에서 사용할 수 있는 편리한 출력 메서드가 있음.
# 문자열을 인수(factor)로 변환하지 않고, 행 이름을 사용하지 않음.

# 텍스트를 담고있는 이 데이터프레임이 정돈 텍스트 분석(tidy text analysis) 기법과는 아직 호환되지는 않음.
# 각 행이 여러 개의 결합된 단어로 구성되므로 가장 자주 출현하는 단어나 카운트 선별 불가능.

# 그러므로 우리는 먼저 이 데이터프레임을 1행당 1문서, 1문서 당 1토큰 형식으로 바꾸어야 함.


###########################################################################################################################################

