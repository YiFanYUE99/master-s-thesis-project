#直方图
library(ggplot2)
data <- read.csv("QSAR/table/data2_MDs.csv", header = T, row.names = 1, check.names = F, sep = ",")
str(data)
data$`Environmental fate`=as.factor(data$`Environmental fate`)
data$Ecotoxicity=as.factor(data$Ecotoxicity)
data$`Human health`=as.factor(data$`Human health`)

color1<-c("High"="#FF869D", 'Moderate'="#86FFFF", "Low"="#86FF86")
color2<-c("High"="#FFB3C2", 'Moderate'="#B3FFFF", "Low"="#B3FFB3")

#environment fate
ggplot(data, aes(x = `Environmental fate`,
                 fill = `Environmental fate`, 
                 color=`Environmental fate`)) +
  geom_bar(stat="count") +
  geom_text(stat="count", aes(label= after_stat(count)),vjust = 1.5,color="#D2A0FF") +#显示频数
  labs(x = "Alert Level", y = "Count") +
  xlim("High","Moderate","Low")+
  ggtitle("Environmental fate")+
  scale_fill_manual(values = color2)+
  scale_color_manual(values = color1)+
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
        panel.border = element_rect(color = "grey", fill = NA))#保留边框
ggsave("QSAR/pic/Environmentalfate.png",width=10, height=7,dpi=300)




#Ecotocixity
ggplot(data, aes(x = Ecotoxicity,
                 fill = Ecotoxicity, 
                 color=Ecotoxicity)) +
  geom_bar( stat="count") +
  geom_text(stat="count", aes(label= after_stat(count)),vjust = 1.5,color="#D2A0FF") +#显示频数
  labs(x = "Alert Level", y = "Count") +
  xlim("High","Moderate","Low")+
  ggtitle("Ecotoxicity")+
  scale_fill_manual(values = color2)+
  scale_color_manual(values = color1)+
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
        panel.border = element_rect(color = "grey", fill = NA))#保留边框
ggsave("QSAR/pic/Ecotoxicity.png",width=10, height=7,dpi=300)







#human health
ggplot(data, aes(x = `Human health`,
                 fill = `Human health`, 
                 color= `Human health`)) +
  geom_bar( stat="count") +
  geom_text(stat="count", aes(label= after_stat(count)),vjust = 1.5,color="#D2A0FF") +#显示频数
  labs(x = "Alert Level", y = "Count") +
  xlim("High","Moderate","Low")+
  ggtitle("Human health")+
  scale_fill_manual(values = color2)+
  scale_color_manual(values = color1)+
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
        panel.border = element_rect(color = "grey", fill = NA))#保留边框
ggsave("QSAR/pic/Human health.png",width=10, height=7,dpi=300)












  
