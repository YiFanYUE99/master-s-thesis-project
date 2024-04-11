#绘画混淆矩阵
library(ggplot2)
data <- read.csv("QSAR/table/data35HH_SVM_confmat.csv", header = T, row.names = 1, check.names = F, sep = ",")
#先设置热图颜色
HH<-c("#FFFF86","#FFFFE0")
SVM<-c("#86FFFF","#E0FFFF")
ggplot(data,aes(x= Predicted,y = Real))+
  geom_tile(aes(fill=Result),width=1,height =1,color = HH[2])+
  coord_equal() + # 绘制正方形，长宽相等
  scale_fill_gradientn(colors = rev(SVM))+#legend上下限
  geom_text(
    aes(label = Name), color = HH[2],
    vjust=-1.6)+
  geom_text(
    aes(label = Result), color =HH[1],
    vjust=1.6)+
  xlim(c("P","N"))+
  ylim(c("N","P"))+
  ggtitle("Confusion matrix of Human health & SVM")+
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
ggsave("QSAR/pic/HH_svm_confmat.png",width=10, height=7,dpi=300)
