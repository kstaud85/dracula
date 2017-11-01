sentiments
get_sentiments('nrc')
get_sentiments('bing')#positive or negative 2 words
get_sentiments('afinn')#positive or negative score

#Find all the fear words in dracula, and make a wordcloud
nrc<-get_sentiments('nrc')

nrc_fear<-nrc%>%
  filter(sentiment=='fear')

dracula<-gutenberg_download(345)

#create word column of text
dracula_words<-dracula%>%
  unnest_tokens(word,text)

dracula_fear_words<-inner_join(nrc_fear,dracula_words)
#head(dracula_fear_words)

#create a word cloud
word_freq<-dracula_fear_words%>%
  group_by(word)%>%
  summarise(count=n())

wordcloud(word_freq$word,word_freq$count,min.freq=14,color=brewer.pal(2, 'Dark2'))
#unique(nrc$sentiment)

