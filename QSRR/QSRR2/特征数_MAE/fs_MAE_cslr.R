getwd()
setwd("D:/R_work/master-s-thesis-project/QSRR/QSRR2/特征数_MAE")
input="cslrfs_no.csv"
df<-read.csv(input,header = 1,check.names = F)
df$sel__k=as.factor(df$sel__k)
df$group=rep("LR",dim(df)[2])
str(df$sel__k)

library(dplyr)
cs<-c("#AA50FF","#E6C8FF")
maecs<-c("#E6C8FF","#E0FFFF")

library(ggplot2)
ggplot(df,aes(x=sel__k,y=MAE,group=group))+
  geom_line(aes(color="group"),linetype="twodash")+
  geom_point(aes(color="group"))+
  scale_color_manual(values=c("#AA50FF"))+
  scale_x_discrete(limits = factor(c(1:20)))+
  ylim(1:2)+
  labs(title = "First 20 Features' MAE for Correlation Statistics", x = "Feature Numbers", y = "MAE")+
  theme(text = element_text(family = "mono", size=14),
        plot.title = element_text(size = 14,hjust = 0.5),#title 大小,居中
        axis.title.x = element_text(size = 14),#x轴标题
        axis.title.y = element_text(size = 14),
        axis.text.x = element_text(face = "bold", angle = 45, hjust = 1,size = 10),#横坐标
        axis.text.y = element_text(face = "italic", angle = 45, hjust = 1,size = 10),
        legend.text = element_text(size = 10,hjust = 0.5),#legend字体大小,居中
        legend.title = element_text(size = 12), #设置legend标签字体大小
        panel.background = element_rect(fill = maecs[2]),
        panel.grid.major = element_line(color = "#FFFFFF", linetype = "dashed", size = 0.5), 
        panel.grid.minor = element_line(color = "#FFFFFF", linetype = "dashed", size = 0.5),
        panel.border = element_rect(color = maecs[1], fill = NA))#去掉边框
ggsave('cs_MAE.png', width = 10, height = 7, dpi = 300,limitsize = FALSE)
