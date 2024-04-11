#绘画混淆矩阵
library(ggplot2)
data <- read.csv("QSAR/table/data7EF_RF_confmat.csv", header = T, row.names = 1, check.names = F, sep = ",")
#先设置热图颜色
EF<-c("#FFC18C","#FFE4C4")
RF<-c("#8686FF","#E0E0FF")

ggplot(data,aes(x= Predicted,y = Real))+
  geom_tile(aes(fill=Result),width=1,height =1,color = EF[2])+
  coord_equal() + # 绘制正方形，长宽相等
  scale_fill_gradientn(colors = rev(RF))+#legend上下限
  geom_text(
    aes(label = Name, color = Result),size=12,
    vjust=-0.8)+
  geom_text(
    aes(label = Result, color =Result),size=12,
    vjust=0.8)+
  scale_color_gradientn(colors = EF)+
  xlim(c("P","N"))+
  ylim(c("N","P"))+
  ggtitle("Confusion matrix of Environmental fate & Random Forest")+
  guides(color="none")+
  theme(text = element_text(family = "mono", size=14),
        plot.title = element_text(size = 14,hjust = 0.5),#title 大小,居中
        axis.title.x = element_text(size = 14),#x轴标题
        axis.title.y = element_text(size = 14),
        axis.text.x = element_text(face = "italic", angle = 45, hjust = 1,size = 10),#横坐标
        axis.text.y = element_text(face = "italic", angle = 45, hjust = 1,size = 10),
        legend.text = element_text(size = 10,hjust = 0.5),#legend字体大小,居中
        legend.title = element_text(size = 12), #设置legend标签字体大小
        panel.background = element_blank(), 
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.border = element_blank())#去掉边框
ggsave("QSAR/pic/EF_RF_confmat.png",width=10, height=7,dpi=300)
