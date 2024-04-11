library(ggplot2)
getwd()
fimp<-read.csv("QSAR/table/data21EC_SVM_fimp.csv",header = TRUE,check.names = FALSE)
colnames(fimp)=c("Name","abs(coef)")

EC<-c("#FF869D","#FFE0E6")
SVM<-c("#86FFFF","#E0FFFF")

ggplot(fimp, aes(x = Name, y = `abs(coef)`)) +
  geom_segment(aes(x= Name, y=`abs(coef)`, color=`abs(coef)`,
                   xend=Name, yend=0.66),
               size=5,
               linetype=1)+#使用reorder()排序变量
  geom_point(aes(fill=`abs(coef)`), size=12, pch = 21, color=EC[1]) +
  geom_text(aes(label =sprintf("%.3f",`abs(coef)`)), 
            color = "black",
            size = 3,
            family = "mono",
            fontface="bold")+ 
  scale_fill_continuous(high=SVM[1],low=SVM[2])+
  scale_color_continuous(high=SVM[1],low=SVM[2])+
  labs(title = "Ecotoxicity & SVM", x = "Molecular Descriptors", y = "Abs(coef)")+
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
    panel.background = element_rect(fill = EC[2]),  # 去除背景
    panel.border = element_rect(color = EC[1], fill = NA)#保留边框
  )


ggsave("QSAR/pic/EC_SVM_fimp.png",width=10, height=7,dpi=300)
