#Demonstrate the step by step procedure for creating a word cloud of your own
#text data

install.packages("NLP")
install.packages("tm")
install.packages("RColorBrewer")
install.packages("wordcloud")
install.packages("wordcloud2")

library("NLP")
library("tm")
library("RColorBrewer")
library("wordcloud")
library("wordcloud2")

#Reading file and each line in it
filepath <- "wordcloudinput.txt"
text_file <- readLines(filepath)
head(text_file)

text_file1 <- paste(text_file, collapse = " ")
head(text_file1)

#converting all characters to lowercase
clean_text <- tolower(text_file1)
head(clean_text)

clean_text1 <- gsub(pattern="\\W", replace=" ", clean_text)
head(clean_text1)
clean_text2 <- gsub(pattern="\\d", replace=" ", clean_text1)
head(clean_text2)

#Remove stop words
stopwords()
clean_text3 <- removeWords(clean_text2, words=c(stopwords(),"a"))
head(clean_text3)

#Remove single letters
clean_text4 <- gsub(pattern="\\b[A-z]\\b{1}", replace=" ", clean_text3)
head(clean_text4)

#Strip whitespaces
clean_text5 <- stripWhitespace(clean_text4)
head(clean_text5)

#Breaking sentences into each word separately
clean_text6 <- strsplit(clean_text5, " ")
head(clean_text6)

#Word frequency table
tab <- table(clean_text6)
head(tab)

#Word frequency dataframe
tab1 <- cbind(names(tab), as.integer(tab))
head(tab1)

wc <- unlist(clean_text6)

#Different word clouds
wordcloud(wc)

wordcloud(wc, min.freq=5, random.order=FALSE, scale=c(3, 0.5))

wordcloud(wc, min.freq=3, max.words=1000, random.order=FALSE, rot.per=0.2, colors=brewer.pal(5, "Dark2"), scale=c(4, 0.2))

wordcloud2(tab)

wordcloud2(tab, color="random-light", backgroundColor="white")
