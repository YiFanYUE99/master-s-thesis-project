metaflux<- function(input,CKrepeat, EXPrepeat, EXPgroup=length(EXPrepeat),deltaRT=0.01,ddC=0.0002,Cnum=6,deltaC=1.0033){
  mylist1<-NULL
  mylist2<-NULL
  a<-0
  EXParea<-vector(length = EXPgroup)
  for(i in 1:dim(input)[1]){
    RTdown=input[i,2]-deltaRT
    RTup=input[i,2]+deltaRT
    Massup=input[i,1]-Cnum*(deltaC-ddC)
    Massdown=input[i,1]-Cnum*(deltaC+ddC)
    #CK在前；experiment组在后
    #计算每行EXP面积
    #EXPrepeat可以为c("3,"3")或3,但每个实验组重复个数需要相同
    for(l in 1:EXPgroup){
      EXParea[l]<-rowMeans(input[i,(3+CKrepeat+(l-1)*EXPrepeat[l]):(2+CKrepeat+l*EXPrepeat[l])])
    }
    #计算每行的CK面积
    CKarea<-rowMeans(input[i,3:(2+CKrepeat)])
    for(j in 1:EXPgroup){
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
  }
  tables<-data.table::rbindlist(mylist1)
  no<-t(as.data.frame(mylist2))
  mytable<-cbind(as.data.frame(no),tables)
  return(mytable)
}
input<-read.csv(file = "data/20230728cell_flux_10neg.csv",header=T,check.names = F)
neg10<-metaflux(input, CKrepeat = 3, EXPrepeat = 3, Cnum = 6)
write.csv(pos10,file = "pos10.csv")
# CKrepeat<-3
# EXPrepeat<-c(3,3)
# EXPgroup<-length(EXPrepeat)
# deltaRT=0.01
# deltaC=1.0033
# ddC=0.0002
# Cnum=6
# EXParea<-vector(length = EXPgroup)
# mylist1<-NULL
# mylist2<-NULL
# for(i in 1:dim(input)[1]){
#   a<-0
#   RTdown=input[i,2]-deltaRT
#   RTup=input[i,2]+deltaRT
#   Massup=input[i,1]-Cnum*(deltaC-ddC)
#   Massdown=input[i,1]-Cnum*(deltaC+ddC)
#   #CK在前；experiment组在后
#   #计算每行EXP面积
#   #EXPrepeat可以为c("3,"3")或3,但每个实验组重复个数需要相同
#   for(l in 1:EXPgroup){
#     EXParea[l]<-rowMeans(input[i,(3+CKrepeat+(l-1)*EXPrepeat[l]):(2+CKrepeat+l*EXPrepeat[l])])
#   }
#   #计算每行的CK面积
#   CKarea<-rowMeans(input[i,3:(2+CKrepeat)])
#   for(j in 1:EXPgroup){
#     if(EXParea[j]>5000 & CKarea<5000 & (EXParea[j]/CKarea)>10){
#       for (k in 1:dim(input)[1]) {
#         if((RTdown<=input[k,2])&(input[k,2]<=RTup) & (Massdown<=input[k,1])&(input[k,1]<=Massup)){
#           EXParea1=rowMeans(input[k,(3+CKrepeat+(j-1)*EXPrepeat[j]):(2+CKrepeat+j*EXPrepeat[j])])
#           CKarea1<-rowMeans(input[k,3:(2+CKrepeat)])
#           if(EXParea1>5000 & CKarea1>5000){
#             a<-a+1
#             mylist1<-append(mylist1,list(input[i,]))
#             mylist1<-append(mylist1,list(input[k,]))
#             mylist2<-append(mylist2,list(a))
#             mylist2<-append(mylist2,list(j))
#           }
#         }
#       }
#     }
#   }
# }
# tables<-data.table::rbindlist(mylist1)
# no<-t(as.data.frame(mylist2))
# mytable<-cbind(as.data.frame(no),tables)
#
# #创建list
# mylist<-NULL
# #在list中添加
# mylist<-append(mylist,list(input[1,]))
# mylist<-append(mylist,list(input[2,]))
# #将list转化为dataframe
# a<-data.table::rbindlist(mylist)
# #查看a的数据类型
# typeof(a)
# #写出
# write.csv(a,file = "output.csv")
# #设置字符串
# b<-""
# #字符串黏贴
# b<-paste0(b,"2","3")
