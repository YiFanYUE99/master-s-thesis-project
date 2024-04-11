library(ggplot2)
getwd()
fimp<-read.csv("QSAR/table/data5EF_RF_fimp.csv",header = TRUE,check.names = FALSE)
colnames(fimp)=c("Name","Importance")


EF<-c("#FFC18C","#FFE4C4")
RF<-c("#8686FF","#E0E0FF")

dev.new()
ggplot(fimp, aes(x = Name, y = Importance)) +
  geom_segment(aes(x= Name, y=Importance, color=Importance,
                   xend=Name, yend=0.011),
               size=5,
               linetype=1)+#使用reorder()排序变量
  geom_point(aes(fill=Importance), size=12, pch = 21, color=EF[1]) +
  geom_text(aes(label =round(Importance,2)), color = "black",size = 3,family = "mono")+ 
  scale_fill_continuous(high=RF[1],low=RF[2])+
  scale_color_continuous(high=RF[1],low=RF[2])+
  labs(title = "Environmental Fate & Random Forest", x = "Molecular Descriptors", y = "Feature importance")+
  xlim(rev(fimp$Name))+
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

ggsave("QSAR/pic/EF_RF_fimp.png",width=10, height=7,dpi=300)
