library(ggplot2)
library(gridExtra)
library(cowplot)
setwd("D:/R_work/master-s-thesis-project")

RF<-c("#4682B4","#ADD8E6")
SVM<-c("#3CB371","#90EE90")
LR<-c("#8A2BE2","#D8BFD8")
NB<-c("#FF69B4","#FFB6C1")
KNN<-c("#FFFF86","#FFFFE0")
GB<-c("#FFA500","#FFE4B5")
#ef/ec/hh
EF<-c("#000080","#00008B40")
EC<-c("#006400","#228B2240")
HH<-c("#800080","#4B008240")

pointsize<-4
textsize<-3
linesize<-4
titlesize<-13
xtisize<-14
ytisize<-14
xtesize<-14
ytesize<-10
fimp<-read.csv("QSAR/特征重要性/HH_fSVM_fimp_14.csv",header = TRUE,check.names = FALSE)
fimp<-fimp[1:50,]
colnames(fimp)=c("Name","score")
HHSVM<-ggplot(fimp, aes(x = Name, y = score)) +
  geom_segment(aes(x= Name, y= score, color=score,
                   xend=Name, yend=12,linewidth=score/linesize),
               linetype=1)+#使用reorder()排序变量
  geom_point(aes(fill=score, size=score/pointsize), pch = 21, color=HH[1]) +
  geom_text(aes(label =sprintf("%.3f",score)), 
            color = "black",
            size = textsize,
            family = "mono",
            fontface="bold")+ 
  scale_fill_continuous(high=SVM[1],low=SVM[2])+
  scale_color_continuous(high=SVM[1],low=SVM[2])+
  guides(fill ="none",color="none",size="none",linewidth="none")+
  labs(title = "Human Health & SVM AUC=0.777", x = "Molecular Descriptors", y = "Score")+
  xlim(rev(fimp$Name))+#固定横坐标
  coord_flip()+
  annotate("text",x=Inf, y=-Inf, label="(A)",hjust=1,vjust=-0.5)+
  theme(
    text = element_text(family = "mono", size=16),
    plot.title = element_text(size = titlesize,hjust = 0.5),#title 大小
    axis.title.x = element_text(size = xtisize),#x轴标题
    axis.title.y = element_text(size = ytisize),
    axis.text.x = element_text(face = "bold", angle = 0, hjust = 1,size = xtesize),#横坐标
    axis.text.y = element_text(face = "bold", angle = 25, hjust = 1,size = ytesize),
    legend.text = element_text(size = 8),#legend字体大小
    legend.title = element_text(size = 8), #设置legend标签字体大小
    panel.background = element_rect(fill = HH[2]),  # 去除背景
    panel.border = element_rect(color = HH[1], fill = NA)#保留边框
  )
HHSVM


ggsave(plot = HHSVM,"QSAR/pic2/feature_imp_HH.png",width = 20,height = 32,dpi = 300,units = "cm")
