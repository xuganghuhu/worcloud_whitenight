getwd()
setwd('C:/Users/Administrator/Documents/GitHub/play_20180925_wordcloud_whitenight')
wordbase<-read.csv("white_night.txt")
head(wordbase)

## �Լ���ϴ ȥ�����ֱ�����
word_clean<-NULL
word_clean$msg <- gsub(pattern = " ", replacement ="", wordbase[,1]) 
#ȥ�ո�
word_clean$msg <- gsub("\t", "", word_clean$msg) 
#��ʱ��Ҫʹ��\\\t  
word_clean$msg <- gsub(",", "��", word_clean$msg)
#Ӣ�Ķ���
word_clean$msg <- gsub("~|'", "", word_clean$msg)
#�滻�˲��˺ţ�~����Ӣ�ĵ����ţ�'��������֮���á�|�����Ÿ�������ʾ��Ĺ�ϵ
word_clean$msg <- gsub("\\\"", "", word_clean$msg)
#�滻���е�Ӣ��˫���ţ�"������Ϊ˫������R�������⺬�壬����Ҫʹ������б�ܣ�\\\��ת��

head(word_clean)

## �ִ�
seg_word<-segmentCN(as.character(word_clean))
seg_word

## ͳ��
words=unlist(lapply(X=smartcn, FUN=segmentCN))
word=lapply(X=seg_word, FUN=strsplit, " ") 
v=table(unlist(word))
v<-rev(sort(v))
d<-data.frame(word=names(v),cnt=v)
d=subset(d, nchar(as.character(d$word))>1)
head(d)


## ȥͣ�ô�
write.table(v,file="word_result2.txt")
ssc=read.table("word_result2.txt",header=TRUE)
class(ssc)
ssc[1:10,]
ssc=as.matrix(d)
stopwords=read.table("wordclean_list.txt")
class(stopwords)
stopwords=as.vector(stopwords[,1])
wordResult=removeWords(ssc,stopwords)
#ȥ�ո�
kkk=which(wordResult[,2]=="")
wordResult=wordResult[-kkk,][,2:3]


## ������
names(wordResult)
write.table(wordResult,'white_night_cloud.txt')
mydata<-read.table('white_night_cloud.txt')
#mydata<-filter(mydata,mydata$cnt>=10)
wordcloud2(mydata,figPath='boyandgirl.jpg')  #figPath='jingyu.jpg')

