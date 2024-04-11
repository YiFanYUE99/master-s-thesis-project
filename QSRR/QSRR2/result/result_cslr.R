#展示预测的结果
getwd()
setwd("D:/R_work/master-s-thesis-project/QSRR/QSRR2/result")
input="Predict_cslr.csv"
df<-read.csv(input,header = 1,check.names = F)
df<-data[order(df$mae), ]#升序排列
#处理数据
EX<-df[,1:2]
EX$type<-"Experiment"
colnames(EX)[2]<-'RT'
PRE<-df[,c(1,3)]
PRE$type<-"Prediction"
colnames(PRE)[2]<-'RT'
data<-rbind(EX,PRE)

rtcslr<-c("#E6C8FF","#E0FFE0")
preex<-c("#FF869D","#86FF86")
preext<-c("#FF5980","#008000")

#作图
ggplot(data, aes(x=NAME, y=RT, fill=type))+
  geom_bar(stat = "identity", 
           width=0.9, #柱子实际宽度
           position = position_dodge(width=0.75))+ #每个柱子占的宽度)+
  
  ggtitle("Correlation Statistics & Linear Regression PRE-EX RT")+
  geom_text(aes(label = round(RT,2), color = type), 
            size=2.5,
            family="mono",
            vjust = -1,
            hjust=0.45,
            angle=0,
            position = position_dodge(width = 0.75)) +  # 设置标签位置
  xlim(limits=df$NAME)+
  scale_fill_manual(values=preex)+
  scale_color_manual(values=preext)+
  theme(text = element_text(family = "mono", size=14),
        plot.title = element_text(size = 14,hjust = 0.5),#title 大小,居中
        axis.title.x = element_text(size = 14),#x轴标题
        axis.title.y = element_text(size = 14),
        axis.text.x = element_text(face = "bold", angle = 65, hjust = 1,size = 10),#横坐标
        axis.text.y = element_text(face = "italic", angle = 45, hjust = 1,size = 10),
        legend.text = element_text(size = 10,hjust = 0.5),#legend字体大小,居中
        legend.title = element_text(size = 12), #设置legend标签字体大小
        panel.background = element_rect(fill = rtcslr[1]),
        panel.grid.major = element_line(color = "#FFFFFF", linetype = "dashed", size = 0.5), 
        panel.grid.minor = element_line(color = "#FFFFFF", linetype = "dashed", size = 0.5),
        panel.border = element_rect(color = rtcslr[2], fill = NA))#设置边框
ggsave('Predict_cslr.png', width = 15, height = 7, dpi = 300,limitsize = FALSE)
















