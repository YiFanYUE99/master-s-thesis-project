getwd()
library(ggplot2)
library(gridExtra)
setwd("D:/R_work/master-s-thesis-project/QSRR/QSRR3/result/预测结果")

#8
mirf<-read.csv("mirf_8.csv",header=1,check.names = F)
mirf$group=rep("MI+RF",dim(mirf)[1])
#处理数据
EX<-mirf[,1:2]
EX$type<-"Experiment"
colnames(EX)[2]<-'RT'
EX$group<-c(rep("1",59),rep("2",59),rep("3",59),rep("4",59),rep("5",59))
PRE<-mirf[,c(1,3)]
PRE$type<-"Prediction"
colnames(PRE)[2]<-'RT'
PRE$group<-c(rep("1",59),rep("2",59),rep("3",59),rep("4",59),rep("5",59))
#分行
EX1<-EX[EX$group==1,]
PRE1<-PRE[PRE$group==1,]
data1<-rbind(EX1,PRE1)

EX2<-EX[EX$group==2,]
PRE2<-PRE[PRE$group==2,]
data2<-rbind(EX2,PRE2)

EX3<-EX[EX$group==3,]
PRE3<-PRE[PRE$group==3,]
data3<-rbind(EX3,PRE3)

EX4<-EX[EX$group==4,]
PRE4<-PRE[PRE$group==4,]
data4<-rbind(EX4,PRE4)

EX5<-EX[EX$group==5,]
PRE5<-PRE[PRE$group==5,]
data5<-rbind(EX5,PRE5)
#设置颜色
rtcslr<-c("#E0FFE0","#B3FFB3")
preex<-c("#009E73","#008000")
preext<-c("#009E73","#008000")
xtsize<-14
xsize<-14
ytsize<-10
ysize<-14
titlesize<-20
allsize<-14
lesize<-18
lisize<-18
geomsize<-4

#作图
#dev.new()
mirf1<-ggplot(data1, aes(x=NAME, y=RT, fill=type))+
  geom_bar(stat = "identity", 
           width=0.9, #柱子实际宽度
           position = position_dodge(width=0.75))+ #每个柱子占的宽度)+
  
  ggtitle("MI+RF Predicted&Experimental RT")+
  geom_text(aes(label = round(RT,2), color = type), 
            size=geomsize,
            family="serif",
            vjust = -1,
            hjust=0.45,
            angle=0,
            position = position_dodge(width = 0.75)) +  # 设置标签位置
  xlim(limits=EX1$NAME)+
  scale_fill_manual(values=preex)+
  scale_color_manual(values=preext)+
  guides(color= FALSE,#隐藏数字的标签
         fill= FALSE)+
  theme(text = element_text(family = "mono", size=allsize),
        plot.title = element_text(size = titlesize,hjust = 0.5,face = "bold"),#title 大小,居中
        axis.title.x = element_blank(),#x轴标题
        axis.title.y = element_blank(),
        axis.text.x = element_text(face = "bold", angle = 65, hjust = 1,size = xtsize),#横坐标
        axis.text.y = element_text(face = "italic", angle = 45, hjust = 1,size = ytsize),
        legend.text = element_text(size = lesize,hjust = 0.5),#legend字体大小,居中
        legend.title = element_text(size = lisize), #设置legend标签字体大小
        plot.margin = unit(c(1, 1, 1, 2), "cm"),#上右下左
        panel.background = element_rect(fill = rtcslr[1]),
        panel.grid.major = element_line(color = "#FFFFFF", linetype = "dashed", size = 0.5), 
        panel.grid.minor = element_line(color = "#FFFFFF", linetype = "dashed", size = 0.5),
        panel.border = element_rect(color = rtcslr[2], fill = NA))#设置边框
mirf1

mirf2<-ggplot(data2, aes(x=NAME, y=RT, fill=type))+
  geom_bar(stat = "identity", 
           width=0.9, #柱子实际宽度
           position = position_dodge(width=0.75))+ #每个柱子占的宽度)+
  
  ggtitle("MI+RF Predicted&Experimental RT")+
  geom_text(aes(label = round(RT,2), color = type), 
            size=geomsize,
            family="serif",
            vjust = -1,
            hjust=0.45,
            angle=0,
            position = position_dodge(width = 0.75)) +  # 设置标签位置
  xlim(limits=EX2$NAME)+
  scale_fill_manual(values=preex)+
  scale_color_manual(values=preext)+
  guides(color= FALSE,#隐藏数字的标签
         fill= FALSE)+
  theme(text = element_text(family = "mono", size=allsize),
        plot.title = element_blank(),#title 大小,居中
        axis.title.x = element_blank(),#x轴标题
        axis.title.y = element_blank(),
        axis.text.x = element_text(face = "bold", angle = 65, hjust = 1,size = xtsize),#横坐标
        axis.text.y = element_text(face = "italic", angle = 45, hjust = 1,size = ytsize),
        legend.text = element_text(size = lesize,hjust = 0.5),#legend字体大小,居中
        legend.title = element_text(size = lisize), #设置legend标签字体大小
        plot.margin = unit(c(1, 1, 1, 2), "cm"),#上右下左
        panel.background = element_rect(fill = rtcslr[1]),
        panel.grid.major = element_line(color = "#FFFFFF", linetype = "dashed", size = 0.5), 
        panel.grid.minor = element_line(color = "#FFFFFF", linetype = "dashed", size = 0.5),
        panel.border = element_rect(color = rtcslr[2], fill = NA))#设置边框
mirf2

mirf3<-ggplot(data3, aes(x=NAME, y=RT, fill=type))+
  geom_bar(stat = "identity", 
           width=0.9, #柱子实际宽度
           position = position_dodge(width=0.75))+ #每个柱子占的宽度)+
  
  ggtitle("MI+RF Predicted&Experimental RT")+
  geom_text(aes(label = round(RT,2), color = type), 
            size=geomsize,
            family="serif",
            vjust = -1,
            hjust=0.45,
            angle=0,
            position = position_dodge(width = 0.75)) +  # 设置标签位置
  xlim(limits=EX3$NAME)+
  scale_fill_manual(values=preex)+
  scale_color_manual(values=preext)+
  guides(color= FALSE)+#隐藏数字的标签
  theme(text = element_text(family = "mono", size=allsize),
        plot.title =  element_blank(),#title 大小,居中
        axis.title.x = element_blank(),#x轴标题
        axis.title.y = element_text(size = ysize),
        axis.text.x = element_text(face = "bold", angle = 65, hjust = 1,size = xtsize),#横坐标
        axis.text.y = element_text(face = "italic", angle = 45, hjust = 1,size = ytsize),
        legend.text = element_text(size = lesize,hjust = 0.5),#legend字体大小,居中
        legend.title = element_text(size = lisize), #设置legend标签字体大小
        plot.margin = unit(c(1, 1, 1, 2), "cm"),#上右下左
        panel.background = element_rect(fill = rtcslr[1]),
        panel.grid.major = element_line(color = "#FFFFFF", linetype = "dashed", size = 0.5), 
        panel.grid.minor = element_line(color = "#FFFFFF", linetype = "dashed", size = 0.5),
        panel.border = element_rect(color = rtcslr[2], fill = NA))#设置边框
mirf3

mirf4<-ggplot(data4, aes(x=NAME, y=RT, fill=type))+
  geom_bar(stat = "identity", 
           width=0.9, #柱子实际宽度
           position = position_dodge(width=0.75))+ #每个柱子占的宽度)+
  
  ggtitle("MI+RF Predicted&Experimental RT")+
  geom_text(aes(label = round(RT,2), color = type), 
            size=geomsize,
            family="serif",
            vjust = -1,
            hjust=0.45,
            angle=0,
            position = position_dodge(width = 0.75)) +  # 设置标签位置
  xlim(limits=EX4$NAME)+
  scale_fill_manual(values=preex)+
  scale_color_manual(values=preext)+
  guides(color= FALSE,#隐藏数字的标签
         fill= FALSE)+
  theme(text = element_text(family = "mono", size=allsize),
        plot.title =  element_blank(),#title 大小,居中
        axis.title.x = element_blank(),#x轴标题
        axis.title.y = element_blank(),
        axis.text.x = element_text(face = "bold", angle = 65, hjust = 1,size = xtsize),#横坐标
        axis.text.y = element_text(face = "italic", angle = 45, hjust = 1,size = ytsize),
        legend.text = element_text(size = lesize,hjust = 0.5),#legend字体大小,居中
        legend.title = element_text(size = lisize), #设置legend标签字体大小
        plot.margin = unit(c(1, 1, 1, 2), "cm"),#上右下左
        panel.background = element_rect(fill = rtcslr[1]),
        panel.grid.major = element_line(color = "#FFFFFF", linetype = "dashed", size = 0.5), 
        panel.grid.minor = element_line(color = "#FFFFFF", linetype = "dashed", size = 0.5),
        panel.border = element_rect(color = rtcslr[2], fill = NA))#设置边框
mirf4

mirf5<-ggplot(data5, aes(x=NAME, y=RT, fill=type))+
  geom_bar(stat = "identity", 
           width=0.9, #柱子实际宽度
           position = position_dodge(width=0.75))+ #每个柱子占的宽度)+
  
  ggtitle("MI+RF Predicted&Experimental RT")+
  geom_text(aes(label = round(RT,2), color = type), 
            size=geomsize,
            family="serif",
            vjust = -1,
            hjust=0.45,
            angle=0,
            position = position_dodge(width = 0.75)) +  # 设置标签位置
  xlim(limits=EX5$NAME)+
  scale_fill_manual(values=preex)+
  scale_color_manual(values=preext)+
  guides(color= FALSE,#隐藏数字的标签
         fill= FALSE)+
  theme(text = element_text(family = "mono", size=allsize),
        plot.title =  element_blank(),#title 大小,居中
        axis.title.x = element_blank(),#x轴标题
        axis.title.y = element_blank(),
        axis.text.x = element_text(face = "bold", angle = 65, hjust = 1,size = xtsize),#横坐标
        axis.text.y = element_text(face = "italic", angle = 45, hjust = 1,size = ytsize),
        legend.text = element_text(size = lesize,hjust = 0.5),#legend字体大小,居中
        legend.title = element_text(size = lisize), #设置legend标签字体大小
        plot.margin = unit(c(1, 1, 1, 2), "cm"),#上右下左
        panel.background = element_rect(fill = rtcslr[1]),
        panel.grid.major = element_line(color = "#FFFFFF", linetype = "dashed", size = 0.5), 
        panel.grid.minor = element_line(color = "#FFFFFF", linetype = "dashed", size = 0.5),
        panel.border = element_rect(color = rtcslr[2], fill = NA))#设置边框
mirf5
p<-grid.arrange(mirf1,mirf2,mirf3,mirf4,mirf5,ncol=1)
ggsave('Predict_mirf.png',plot = p, width = 30, height = 40, dpi = 300,limitsize = FALSE)






