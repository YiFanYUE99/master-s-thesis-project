getwd()
setwd("D:/R_work/master-s-thesis-project/QSRR/QSRR2/fs_score")
input='cslascore.csv'
df<-read.csv(input,header = 1,check.names = F)
df1<-head(df[order(-df$Score), ],20)#按照score降序排列
str(df1$Score)

cs<-c("#AA50FF","#E6C8FF")
fs<-c("#FFE0E6","#FFB3C2")
str(df$Score)
library(ggplot2)
ggplot(df1,aes(x=Feature,y=Score))+#保持按照得分降序排列
  geom_segment(aes(x=Feature, y=1, color=Score,
                   xend=Feature, yend=Score),
               size=5,
               linetype=1)+#使用reorder()排序变量
  geom_point(aes(fill=Score), size=12, pch = 21, color=fs[2]) +
  geom_text(aes(label =sprintf("%.2f",Score)), color = "black",size = 3,family = "mono")+ 
  scale_fill_continuous(high=cs[1],low=cs[2])+
  scale_color_continuous(high=cs[1],low=cs[2])+
  xlim(limts=df1$Feature)+
  labs(title = "Best 20 Features' Score for Correlation Statistics", x = "Feature", y = "Score")+
  theme(text = element_text(family = "mono", size=14),
        plot.title = element_text(size = 14,hjust = 0.5),#title 大小,居中
        axis.title.x = element_text(size = 14),#x轴标题
        axis.title.y = element_text(size = 14),
        axis.text.x = element_text(face = "bold", angle = 45, hjust = 1,size = 10),#横坐标
        axis.text.y = element_text(face = "italic", angle = 45, hjust = 1,size = 10),
        legend.text = element_text(size = 10,hjust = 0.5),#legend字体大小,居中
        legend.title = element_text(size = 12), #设置legend标签字体大小
        panel.background = element_rect(fill = fs[1]),
        panel.grid.major = element_line(color = "#FFFFFF", linetype = "dashed", size = 0.5), 
        panel.grid.minor = element_line(color = "#FFFFFF", linetype = "dashed", size = 0.5),
        panel.border = element_rect(color = fs[2], fill = NA))#去掉边框
ggsave('csscore_t20.png', width = 10, height = 7, dpi = 300,limitsize = FALSE)
