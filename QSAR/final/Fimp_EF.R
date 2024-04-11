library(ggplot2)
library(gridExtra)
library(cowplot)
setwd("D:/R_work/master-s-thesis-project")

fimp<-read.csv("QSAR/table/data5EF_RF_fimp.csv",header = TRUE,check.names = FALSE)
colnames(fimp)=c("Name","Importance")
EF<-c("#FFC18C","#FFE4C4")
RF<-c("#8686FF","#E0E0FF")
EFRF<-ggplot(fimp, aes(x = Name, y = Importance)) +
  geom_segment(aes(x= Name, y= Importance, color=Importance,
                   xend=Name, yend=0.011),
               linewidth=5,
               linetype=1)+#使用reorder()排序变量
  geom_point(aes(fill=Importance), size=12, pch = 21, color=EF[1]) +
  geom_text(aes(label =sprintf("%.3f",Importance)), 
            color = "black",
            size = 3,
            family = "mono",
            fontface="bold")+ 
  scale_fill_continuous(high=RF[1],low=RF[2])+
  scale_color_continuous(high=RF[1],low=RF[2])+
  guides(fill ="none",color="none")+
  labs(title = "Environmental Fate & Random Forest", x = "Molecular Descriptors", y = "Feature importance")+
  xlim(rev(fimp$Name))+#固定横坐标
  coord_flip()+
  annotate("text",x=Inf, y=-Inf, label="(A)",hjust=1,vjust=-0.5)+
  theme(
    text = element_text(family = "mono", size=16),
    plot.title = element_text(size = 16),#title 大小
    axis.title.x = element_text(size = 14),#x轴标题
    axis.title.y = element_text(size = 14),
    axis.text.x = element_text(face = "italic", angle = 45, hjust = 1,size = 10),#横坐标
    axis.text.y = element_text(face = "bold", angle = 25, hjust = 1,size = 10),
    legend.text = element_text(size = 8),#legend字体大小
    legend.title = element_text(size = 8), #设置legend标签字体大小
    panel.background = element_rect(fill = EF[2]),  # 去除背景
    panel.border = element_rect(color = EF[1], fill = NA)#保留边框
  )

fimp<-read.csv("QSAR/table/data13EF_LR_fimp.csv",header = TRUE,check.names = FALSE)
colnames(fimp)=c("Name","abs(coef)")
EF<-c("#FFC18C","#FFE4C4")
LR<-c("#86FF86","#E0FFE0")
EFLR<-ggplot(fimp, aes(x = Name, y = `abs(coef)`)) +
  geom_segment(aes(x= Name, y=`abs(coef)`, color=`abs(coef)`,
                   xend=Name, yend=0.15),
               size=5,
               linetype=1)+#使用reorder()排序变量
  geom_point(aes(fill=`abs(coef)`), size=12, pch = 21, color=EF[1]) +
  geom_text(aes(label =sprintf("%.3f",`abs(coef)`)), 
            color = "black",
            size = 3,
            family = "mono",
            fontface="bold")+ 
  scale_fill_continuous(high=LR[1],low=LR[2])+
  scale_color_continuous(high=LR[1],low=LR[2])+
  guides(fill ="none",color="none")+
  labs(title = "Environmental Fate & LR", x = "", y = "Abs(coef)")+
  xlim(rev(fimp$Name))+#固定横坐标
  coord_flip()+
  theme(
    text = element_text(family = "mono", size=16),
    plot.title = element_text(size = 16),#title 大小
    axis.title.x = element_text(size = 14),#x轴标题
    axis.title.y = element_text(size = 14),
    axis.text.x = element_text(face = "italic", angle = 45, hjust = 1,size = 10),#横坐标
    axis.text.y = element_text(face = "bold", angle = 45, hjust = 1,size = 10),
    legend.text = element_text(size = 8),#legend字体大小
    legend.title = element_text(size = 8), #设置legend标签字体大小
    panel.background = element_rect(fill = EF[2]),  # 去除背景
    panel.border = element_rect(color = EF[1], fill = NA)#保留边框
  )

fimp<-read.csv("QSAR/table/data9EF_SVM_fimp.csv",header = TRUE,check.names = FALSE)
colnames(fimp)=c("Name","abs(coef)")
EF<-c("#FFC18C","#FFE4C4")
SVM<-c("#86FFFF","#E0FFFF")
EFSVM<-ggplot(fimp, aes(x = Name, y = `abs(coef)`)) +
  geom_segment(aes(x= Name, y=`abs(coef)`, color=`abs(coef)`,
                   xend=Name, yend=0.6),
               size=5,
               linetype=1)+#使用reorder()排序变量
  geom_point(aes(fill=`abs(coef)`), size=12, pch = 21, color=EF[1]) +
  geom_text(aes(label =sprintf("%.3f",`abs(coef)`)), 
            color = "black",
            size = 3,
            family = "mono",
            fontface="bold")+ 
  scale_fill_continuous(high=SVM[1],low=SVM[2])+
  scale_color_continuous(high=SVM[1],low=SVM[2])+
  guides(fill ="none",color="none")+
  labs(title = "Environmental Fate & SVM", x = "", y = "Abs(coef)")+
  xlim(rev(fimp$Name))+#固定横坐标
  coord_flip()+
  theme(
    text = element_text(family = "mono", size=16),
    plot.title = element_text(size = 16),#title 大小
    axis.title.x = element_text(size = 14),#x轴标题
    axis.title.y = element_text(size = 14),
    axis.text.x = element_text(face = "italic", angle = 45, hjust = 1,size = 10),#横坐标
    axis.text.y = element_text(face = "bold", angle = 45, hjust = 1,size = 10),
    legend.text = element_text(size = 8),#legend字体大小
    legend.title = element_text(size = 8), #设置legend标签字体大小
    panel.background = element_rect(fill = EF[2]),  # 去除背景
    panel.border = element_rect(color = EF[1], fill = NA)#保留边框
  )

com<-grid.arrange(EFRF,EFLR,EFSVM,nrow=1)
save_plot("QSAR/final/pic/EF_fimp.png",com,base_width=50,base_height = 15,dpi = 300,units = "cm",bg="white")






