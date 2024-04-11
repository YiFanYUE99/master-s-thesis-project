library(ggplot2)
getwd()
fimp<-read.csv("QSAR/table/data9EF_SVM_fimp.csv",header = TRUE,check.names = FALSE)
colnames(fimp)=c("Name","abs(coef)")

windowsFonts()#查看自带字体



dev.new()
ggplot(fimp, aes(x = Name, y = `abs(coef)`)) +
  geom_bar(stat = "identity", fill = "#CCE7F2",#柱子内颜色
           color = "#F2D2D2") +
  geom_text(aes(label=round(`abs(coef)`,4)), #保留4位小数
            vjust=1.6,#在柱子中显示
            size=4,color="#FFB3C2")+
  labs(title = "Environmental Fate & SVM", x = "Molecular Descriptors", y = "Abs(coef)")+
  scale_x_discrete(limits = fimp$Name)+#固定横坐标
  theme(
    text = element_text(family = "mono", size=16),
    plot.title = element_text(size = 16),#title 大小
    axis.title.x = element_text(size = 14),#x轴标题
    axis.title.y = element_text(size = 14),
    axis.text.x = element_text(face = "italic", angle = 45, hjust = 1,size = 10),#横坐标
    axis.text.y = element_text(face = "italic", angle = 45, hjust = 1,size = 10),
    legend.text = element_text(size = 8),#legend字体大小
    legend.title = element_text(size = 8), #设置legend标签字体大小
    panel.background = element_blank(),  # 去除背景
    panel.border = element_rect(color = "grey", fill = NA)#保留边框
  )
  

ggsave("QSAR/pic/EF_SVM_fimp.png",width=10, height=7,dpi=300)
