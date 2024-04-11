getwd()
library(ggplot2)
library(gridExtra)
setwd("D:/R_work/master-s-thesis-project/QSRR/QSRR3/result/特征得分")
#2
mimlr<-read.csv("mimlr_2.csv",header = 1,check.names = F)
mimlr$group=rep("MI+MLR",dim(mimlr)[1])
#3
cssvr<-read.csv("cssvr_3.csv",header=1,check.names = F)
cssvr$group=rep("CS+SVR",dim(cssvr)[1])
#4
misvr<-read.csv("misvr_4.csv",header=1,check.names = F)
misvr$group=rep("MI+SVR",dim(misvr)[1])
#7
csrf<-read.csv("csrf_7.csv",header=1,check.names = F)
csrf$group=rep("CS+RF",dim(csrf)[1])
#8
mirf<-read.csv("mirf_8.csv",header=1,check.names = F)
mirf$group=rep("MI+RF",dim(mirf)[1])

#查看系统自带字体
windowsFonts()
#设置颜色和字体大小
xtsize<-16
xsize<-14
ytsize<-10
ysize<-14
titlesize<-14
allsize<-14
lesize<-10
lisize<-12
linesize<-1.2
pointsize<-3.2

#mi+mlr
cs<-c("#FF0000","#FF9999")
fs<-c("#CCFFCC","#00FF00")
#dev.new()
mimlrplot<-ggplot(mimlr,aes(x=Feature,y=Score))+#保持按照得分降序排列
  geom_segment(aes(x=Feature, y=0.35, color=Score,
                   xend=Feature, yend=Score),
               size=5,
               linetype=1)+#使用reorder()排序变量
  geom_point(aes(fill=Score), size=12, pch = 21, color=fs[2]) +
  geom_text(aes(label =sprintf("%.2f",Score)), color = "black",size = 3,family = "serif")+ 
  scale_fill_continuous(high=cs[1],low=cs[2])+
  scale_color_continuous(high=cs[1],low=cs[2])+
  xlim(limts=mimlr$Feature)+
  labs(title = "MI+MLR Best Features", x = "Feature", y = "Score")+
  theme(text = element_text(family = "mono", size=allsize),
        plot.title = element_text(size = titlesize,hjust = 0.5),#title 大小,居中
        axis.title.x = element_blank(),#x轴标题
        axis.title.y = element_text(size = ysize),
        axis.text.x = element_text(face = "bold", angle = 45, hjust = 1,size = xtsize),#横坐标
        axis.text.y = element_text(face = "italic", angle = 45, hjust = 1,size = ytsize),
        legend.text = element_text(size = lesize,hjust = 0.5),#legend字体大小,居中
        legend.title = element_text(size = lisize), #设置legend标签字体大小
        legend.position = "none",#隐藏标签
        panel.background = element_rect(fill = fs[1]),
        panel.grid.major = element_line(color = "#FFFFFF", linetype = "dashed", size = 0.5), 
        panel.grid.minor = element_line(color = "#FFFFFF", linetype = "dashed", size = 0.5),
        panel.border = element_rect(color = fs[2], fill = NA))#去掉边框
mimlrplot
#cs+svr
cs<-c("#FFA500","#FFD700")
fs<-c("#CCFFFF","#0000FF")
#dev.new()
cssvrplot<-ggplot(cssvr,aes(x=Feature,y=Score))+#保持按照得分降序排列
  geom_segment(aes(x=Feature, y=133, color=Score,
                   xend=Feature, yend=Score),
               size=5,
               linetype=1)+#使用reorder()排序变量
  geom_point(aes(fill=Score), size=12, pch = 21, color=fs[2]) +
  geom_text(aes(label =sprintf("%.2f",Score)), color = "black",size = 3,family = "serif")+ 
  scale_fill_continuous(high=cs[1],low=cs[2])+
  scale_color_continuous(high=cs[1],low=cs[2])+
  xlim(limts=cssvr$Feature)+
  labs(title = "CS+SVR Best Features", x = "Feature", y = "Score")+
  theme(text = element_text(family = "mono", size=allsize),
        plot.title = element_text(size = titlesize,hjust = 0.5),#title 大小,居中
        axis.title.x = element_blank(),#x轴标题
        axis.title.y = element_text(size = ysize),
        axis.text.x = element_text(face = "bold", angle = 45, hjust = 1,size = xtsize),#横坐标
        axis.text.y = element_text(face = "italic", angle = 45, hjust = 1,size = ytsize),
        legend.text = element_text(size = lesize,hjust = 0.5),#legend字体大小,居中
        legend.title = element_text(size = lisize), #设置legend标签字体大小
        legend.position = "none",#隐藏标签
        panel.background = element_rect(fill = fs[1]),
        panel.grid.major = element_line(color = "#FFFFFF", linetype = "dashed", size = 0.5), 
        panel.grid.minor = element_line(color = "#FFFFFF", linetype = "dashed", size = 0.5),
        panel.border = element_rect(color = fs[2], fill = NA))#去掉边框
cssvrplot
#misvr
cs<-c("#FFA500","#FFD700")
fs<-c("#CCFFCC","#00FF00")
#dev.new()
misvrplot<-ggplot(misvr,aes(x=Feature,y=Score))+#保持按照得分降序排列
  geom_segment(aes(x=Feature, y=0, color=Score,
                   xend=Feature, yend=Score),
               size=5,
               linetype=1)+#使用reorder()排序变量
  geom_point(aes(fill=Score), size=12, pch = 21, color=fs[2]) +
  geom_text(aes(label =sprintf("%.2f",Score)), color = "black",size = 3,family = "serif")+ 
  scale_fill_continuous(high=cs[1],low=cs[2])+
  scale_color_continuous(high=cs[1],low=cs[2])+
  xlim(limts=misvr$Feature)+
  labs(title = "MI+SVR Best Features", x = "Feature", y = "Score")+
  theme(text = element_text(family = "mono", size=allsize),
        plot.title = element_text(size = titlesize,hjust = 0.5),#title 大小,居中
        axis.title.x = element_blank(),#x轴标题
        axis.title.y = element_text(size = ysize),
        axis.text.x = element_text(face = "bold", angle = 45, hjust = 1,size = xtsize),#横坐标
        axis.text.y = element_text(face = "italic", angle = 45, hjust = 1,size = ytsize),
        legend.text = element_text(size = lesize,hjust = 0.5),#legend字体大小,居中
        legend.title = element_text(size = lisize), #设置legend标签字体大小
        legend.position = "none",#隐藏标签
        panel.background = element_rect(fill = fs[1]),
        panel.grid.major = element_line(color = "#FFFFFF", linetype = "dashed", size = 0.5), 
        panel.grid.minor = element_line(color = "#FFFFFF", linetype = "dashed", size = 0.5),
        panel.border = element_rect(color = fs[2], fill = NA))#去掉边框
misvrplot
p<-grid.arrange(mimlrplot,cssvrplot,misvrplot,nrow=1)
#ggsave('mlr_svr_Feascore.png',plot = p, width = 10, height = 5, dpi = 300,limitsize = FALSE)





#随机森林
#csrf
cs<-c("#008000","#66FF66")
fs<-c("#CCFFFF","#0000FF")
#dev.new()
csrfplot<-ggplot(csrf,aes(x=Feature,y=Score))+#保持按照得分降序排列
  geom_segment(aes(x=Feature, y=11, color=Score,
                   xend=Feature, yend=Score),
               size=5,
               linetype=1)+#使用reorder()排序变量
  geom_point(aes(fill=Score), size=12, pch = 21, color=fs[2]) +
  geom_text(aes(label =sprintf("%.2f",Score)), color = "black",size = 3,family = "serif")+ 
  scale_fill_continuous(high=cs[1],low=cs[2])+
  scale_color_continuous(high=cs[1],low=cs[2])+
  xlim(limts=csrf$Feature)+
  labs(title = "Correlation Statistics+Random Forest Best Features", x = "Feature", y = "Score")+
  theme(text = element_text(family = "mono", size=allsize),
        plot.title = element_text(size = titlesize,hjust = 0.5),#title 大小,居中
        axis.title.x = element_blank(),#x轴标题
        axis.title.y = element_text(size = ysize),
        axis.text.x = element_text(face = "bold", angle = 45, hjust = 1,size = xtsize),#横坐标
        axis.text.y = element_text(face = "italic", angle = 45, hjust = 1,size = ytsize),
        legend.text = element_text(size = lesize,hjust = 0.5),#legend字体大小,居中
        legend.title = element_text(size = lisize), #设置legend标签字体大小
        legend.position = "none",#隐藏标签
        panel.background = element_rect(fill = fs[1]),
        panel.grid.major = element_line(color = "#FFFFFF", linetype = "dashed", size = 0.5), 
        panel.grid.minor = element_line(color = "#FFFFFF", linetype = "dashed", size = 0.5),
        panel.border = element_rect(color = fs[2], fill = NA))#去掉边框
csrfplot
#mirf
cs<-c("#008000","#66FF66")
fs<-c("#CCFFCC","#00FF00")
#dev.new()
mirfplot<-ggplot(mirf,aes(x=Feature,y=Score))+#保持按照得分降序排列
  geom_segment(aes(x=Feature, y=0.15, color=Score,
                   xend=Feature, yend=Score),
               size=5,
               linetype=1)+#使用reorder()排序变量
  geom_point(aes(fill=Score), size=12, pch = 21, color=fs[2]) +
  geom_text(aes(label =sprintf("%.2f",Score)), color = "black",size = 3,family = "serif")+ 
  scale_fill_continuous(high=cs[1],low=cs[2])+
  scale_color_continuous(high=cs[1],low=cs[2])+
  xlim(limts=mirf$Feature)+
  labs(title = "Mutual Information+Random Forest Best Features", x = "Feature", y = "Score")+
  theme(text = element_text(family = "mono", size=allsize),
        plot.title = element_text(size = titlesize,hjust = 0.5),#title 大小,居中
        axis.title.x = element_blank(),#x轴标题
        axis.title.y = element_text(size = ysize),
        axis.text.x = element_text(face = "bold", angle = 45, hjust = 1,size = xtsize),#横坐标
        axis.text.y = element_text(face = "italic", angle = 45, hjust = 1,size = ytsize),
        legend.text = element_text(size = lesize,hjust = 0.5),#legend字体大小,居中
        legend.title = element_text(size = lisize), #设置legend标签字体大小
        legend.position = "none",#隐藏标签
        panel.background = element_rect(fill = fs[1]),
        panel.grid.major = element_line(color = "#FFFFFF", linetype = "dashed", size = 0.5), 
        panel.grid.minor = element_line(color = "#FFFFFF", linetype = "dashed", size = 0.5),
        panel.border = element_rect(color = fs[2], fill = NA))#去掉边框
mirfplot
prf<-grid.arrange(csrfplot,mirfplot,nrow=2)
#ggsave('rf_Feascore.png',plot = prf, width = 18, height = 14, dpi = 300,limitsize = FALSE)

















