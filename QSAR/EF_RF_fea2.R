library(ggplot2)
getwd()
data <- read.csv("QSAR/table/data5EF_RF_fabun.csv", header = T, row.names = 1, check.names = F, sep = ",")
str(data)
data$`Environmental fate`=as.factor(data$`Environmental fate`)


color<-c("#E60000", "#00E6E6")
ggplot(data, aes(x = VSA_EState5, y = data$BCUT2D_LOGPHI, color = `Environmental fate`)) + 
  geom_point()+
  # stat_ellipse(aes(fill = `Environmental fate`), type = "t", level = 0.95,
  #              na.rm = FALSE, geom = "polygon", alpha = 0.25, color = NA,
  #              show.legend = F, inherit.aes = T)+
  scale_fill_manual(values = color)+
  scale_colour_manual(values = color) + 
  #xlim(-10,10)+
  ggtitle("PCA PLOT")+
  theme(text = element_text(family = "mono", size=14),
      plot.title = element_text(size = 22,hjust = 0.5),#title 大小,居中
      axis.title.x = element_text(size = 14),#x轴标题
      axis.title.y = element_text(size = 14),
      axis.text.x = element_text(face = "italic", angle = 45, hjust = 1,size = 10),#横坐标
      axis.text.y = element_text(face = "italic", angle = 45, hjust = 1,size = 10),
      legend.text = element_text(size = 10,hjust = 0.5),#legend字体大小,居中
      legend.title = element_text(size = 12), #设置legend标签字体大小
      panel.background = element_blank(), 
      panel.grid.major = element_blank(), 
      panel.grid.minor = element_blank(),
      panel.border = element_blank())#保留边框
str(df2)