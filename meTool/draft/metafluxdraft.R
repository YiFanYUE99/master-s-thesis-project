input<-read.csv(file = "data/SXT-neg.csv",header=T,check.names = F)
CKrepeat<-3
EXPrepeat<-c(3,3)
EXPgroup<-length(EXPrepeat)
deltaRT=0.01
deltaC=1.0033
ddC=0.0002
Cnum=6
EXParea<-vector(length = EXPgroup)
mylist1<-NULL
mylist2<-NULL
j=2
a<-0
for(i in 1:dim(input)[1]){
  RTdown=input[i,2]-deltaRT
  RTup=input[i,2]+deltaRT
  Massup=input[i,1]-Cnum*(deltaC-ddC)
  Massdown=input[i,1]-Cnum*(deltaC+ddC)
  #CK在前；experiment组在后
  #计算每行EXP面积
  #EXPrepeat可以为c("3,"3")或3,但每个实验组重复个数需要相同
  for(l in EXPgroup){
    EXParea[l]<-rowMeans(input[i,(3+CKrepeat+(l-1)*EXPrepeat[l]):(2+CKrepeat+l*EXPrepeat[l])])
  }
  #计算每行的CK面积
  CKarea<-rowMeans(input[i,3:(2+CKrepeat)])
  if(EXParea[j]>5000 & CKarea<5000 & (EXParea[j]/CKarea)>10){
    for (k in 1:dim(input)[1]) {
      if((RTdown<=input[k,2])&(input[k,2]<=RTup) & (Massdown<=input[k,1])&(input[k,1]<=Massup)){
        EXParea1=rowMeans(input[k,(3+CKrepeat+(j-1)*EXPrepeat[j]):(2+CKrepeat+j*EXPrepeat[j])])
        CKarea1<-rowMeans(input[k,3:(2+CKrepeat)])
        if(EXParea1>5000 & CKarea1>5000){
          a<-a+1
          mylist1<-append(mylist1,list(input[i,]))
          mylist1<-append(mylist1,list(input[k,]))
          mylist2<-append(mylist2,list(a))
          mylist2<-append(mylist2,list(j))
        }
      }
    }
  }
}
tables<-data.table::rbindlist(mylist1)
no<-t(as.data.frame(mylist2))
mytable<-cbind(as.data.frame(no),tables)
