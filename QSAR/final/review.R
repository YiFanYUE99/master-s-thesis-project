library(ggplot2)
library(gridExtra)
library(cowplot)
setwd("D:/R_work/master-s-thesis-project")
data <- read.csv("QSAR/table/data2_MDs.csv", header = T, row.names = 1, check.names = F, sep = ",")
data <- replace(data, data == "Moderate" | data == "Low", "Not High")

data$`Environmental fate`=as.factor(data$`Environmental fate`)
data$Ecotoxicity=as.factor(data$Ecotoxicity)
data$`Human health`=as.factor(data$`Human health`)


#随后绘制直方图
color1<-c("High"="#FF869D", "Not High"="#86FF86")
color2<-c("High"="#FFB3C2", "Not High"="#B3FFB3")

#environmental fate
EFM<-ggplot(data, aes(x = `Environmental fate`,
                 fill = `Environmental fate`, 
                 color=`Environmental fate`)) +
  geom_bar(stat="count") +
  geom_text(stat="count", aes(label= after_stat(count)),vjust = 1.5,color="#D2A0FF") +#显示频数
  labs(x = "", y = "") +
  xlim("High","Not High")+
  ggtitle("")+
  scale_fill_manual(values = color2)+
  scale_color_manual(values = color1)+
  guides(color="none", fill="none")+
  annotate("text",x=Inf, y=-Inf, label="(B)",hjust=1,vjust=-0.5)+
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





#Ecotocixity
ECM<-ggplot(data, aes(x = Ecotoxicity,
                 fill = Ecotoxicity, 
                 color=Ecotoxicity)) +
  geom_bar( stat="count") +
  geom_text(stat="count", aes(label= after_stat(count)),vjust = 1.5,color="#D2A0FF") +#显示频数
  labs(x = "", y = "") +
  xlim("High","Not High")+
  ggtitle("")+
  scale_fill_manual(values = color2)+
  scale_color_manual(values = color1)+
  guides(color="none", fill="none")+
  annotate("text",x=Inf, y=-Inf, label="(D)",hjust=1,vjust=-0.5)+
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





#human health
HHM<-ggplot(data, aes(x = `Human health`,
                 fill = `Human health`, 
                 color= `Human health`)) +
  geom_bar( stat="count") +
  geom_text(stat="count", aes(label= after_stat(count)),vjust = 1.5,color="#D2A0FF") +#显示频数
  labs(x = "Alert Level", y = "") +
  xlim("High","Not High")+
  ggtitle("")+
  scale_fill_manual(values = color2)+
  scale_color_manual(values = color1)+
  annotate("text",x=Inf, y=-Inf, label="(F)",hjust=1,vjust=-0.5)+
  guides(color="none", fill="none")+
  theme(text = element_text(family = "mono", size=14),
        plot.title = element_text(size = 22,hjust = 0.5),#title 大小,居中
        axis.title.x = element_text(size = 14, hjust = -0.5),#x轴标题
        axis.title.y = element_text(size = 14),
        axis.text.x = element_text(face = "italic", angle = 45, hjust = 1,size = 10),#横坐标
        axis.text.y = element_text(face = "italic", angle = 45, hjust = 1,size = 10),
        legend.text = element_text(size = 10,hjust = 0.5),#legend字体大小,居中
        legend.title = element_text(size = 12), #设置legend标签字体大小
        panel.background = element_blank(), 
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.border = element_rect(color = "grey", fill = NA))#保留边框


data <- read.csv("QSAR/table/data2_MDs.csv", header = T, row.names = 1, check.names = F, sep = ",")
str(data)
data$`Environmental fate`=as.factor(data$`Environmental fate`)
data$Ecotoxicity=as.factor(data$Ecotoxicity)
data$`Human health`=as.factor(data$`Human health`)

color1<-c("High"="#FF869D", 'Moderate'="#86FFFF", "Low"="#86FF86")
color2<-c("High"="#FFB3C2", 'Moderate'="#B3FFFF", "Low"="#B3FFB3")

#environment fate
EF<-ggplot(data, aes(x = `Environmental fate`,
                 fill = `Environmental fate`, 
                 color=`Environmental fate`)) +
  geom_bar(stat="count") +
  geom_text(stat="count", aes(label= after_stat(count)),vjust = 1.5,color="#D2A0FF") +#显示频数
  labs(x = "", y = "") +
  xlim("High","Moderate","Low")+
  ggtitle("Environmental fate")+
  scale_fill_manual(values = color2)+
  scale_color_manual(values = color1)+
  guides(color="none", fill="none")+
  annotate("text",x=Inf, y=-Inf, label="(A)",hjust=1,vjust=-0.5)+
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





#Ecotocixity
EC<-ggplot(data, aes(x = Ecotoxicity,
                 fill = Ecotoxicity, 
                 color=Ecotoxicity)) +
  geom_bar( stat="count") +
  geom_text(stat="count", aes(label= after_stat(count)),vjust = 1.5,color="#D2A0FF") +#显示频数
  labs(x = "", y = "Count") +
  xlim("High","Moderate","Low")+
  ggtitle("Ecotoxicity")+
  scale_fill_manual(values = color2)+
  scale_color_manual(values = color1)+
  guides(color="none", fill="none")+
  annotate("text",x=Inf, y=-Inf, label="(C)",hjust=1,vjust=-0.5)+
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


#human health
HH<-ggplot(data, aes(x = `Human health`,
                 fill = `Human health`, 
                 color= `Human health`)) +
  geom_bar( stat="count") +
  geom_text(stat="count", aes(label= after_stat(count)),vjust = 1.5,color="#D2A0FF") +#显示频数
  labs(x = "", y = "") +
  xlim("High","Moderate","Low")+
  ggtitle("Human health")+
  scale_fill_manual(values = color2)+
  scale_color_manual(values = color1)+
  guides(color="none", fill="none")+
  annotate("text",x=Inf, y=-Inf, label="(E)",hjust=1,vjust=-0.5)+
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


com<-grid.arrange(EF,EFM,EC,ECM,HH,HHM,nrow=3)
save_plot("QSAR/final/pic/review.png",com,base_width=20,base_height = 30,dpi = 300,units = "cm",bg="white")


