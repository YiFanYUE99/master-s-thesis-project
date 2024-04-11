library(ggplot2)
library(gridExtra)
library(cowplot)
setwd("D:/R_work/master-s-thesis-project/")

data <- read.csv("QSAR/table/data31HH_RF_confmat.csv", header = T, row.names = 1, check.names = F, sep = ",")
#先设置热图颜色
HH<-c("#FFFF86","#FFFFE0")
RF<-c("#8686FF","#E0E0FF")
HHRF<-ggplot(data,aes(x= Predicted,y = Real))+
  geom_tile(aes(fill=Result),width=1,height =1,color = HH[2])+
  coord_equal() + # 绘制正方形，长宽相等
  scale_fill_gradientn(colors = rev(RF))+#legend上下限
  geom_text(
    aes(label = Name),
    color= "black",
    vjust=-0.8)+
  geom_text(
    aes(label = Result),
    color= "black",
    vjust=0.8)+
  scale_color_gradientn(colors = HH)+
  guides(color="none",fill="none")+
  xlim(c("P","N"))+
  ylim(c("N","P"))+
  ggtitle("Confusion matrix of Random Forest")+
  annotate("text",x=Inf, y=-Inf, label="(A)",hjust=1,vjust=-0.5)+
  theme(text = element_text(family = "mono", size=14),
        plot.title = element_text(size = 14,hjust = 0.5),#title 大小,居中
        axis.title.x = element_text(size = 14),#x轴标题
        axis.title.y = element_text(size = 14),
        axis.text.x = element_text(face = "italic", angle = 45, hjust = 1,size = 10),#横坐标
        axis.text.y = element_text(face = "italic", angle = 45, hjust = 1,size = 10),
        legend.text = element_text(size = 10,hjust = 0.5),#legend字体大小,居中
        legend.title = element_text(size = 12), #设置legend标签字体大小
        panel.background = element_rect(fill = HH[2]),
        panel.border = element_rect(color = HH[1], fill = NA),#保留边框
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank())


data <- read.csv("QSAR/table/data39HH_LR_confmat.csv", header = T, row.names = 1, check.names = F, sep = ",")
#先设置热图颜色
HH<-c("#FFFF86","#FFFFE0")
LR<-c("#86FF86","#E0FFE0")
HHLR<-ggplot(data,aes(x= Predicted,y = Real))+
  geom_tile(aes(fill=Result),width=1,height =1,color = HH[2])+
  coord_equal() + # 绘制正方形，长宽相等
  scale_fill_gradientn(colors = rev(LR))+#legend上下限
  geom_text(
    aes(label = Name),
    color= "black",
    vjust=-0.8)+
  geom_text(
    aes(label = Result),
    color= "black",
    vjust=0.8)+
  scale_color_gradientn(colors = HH)+
  guides(color="none",fill="none")+
  xlim(c("P","N"))+
  ylim(c("N","P"))+
  ggtitle("Confusion matrix of Logistic Regression")+
  annotate("text",x=Inf, y=-Inf, label="(B)",hjust=1,vjust=-0.5)+
  theme(text = element_text(family = "mono", size=14),
        plot.title = element_text(size = 14,hjust = 0.5),#title 大小,居中
        axis.title.x = element_text(size = 14),#x轴标题
        axis.title.y = element_text(size = 14),
        axis.text.x = element_text(face = "italic", angle = 45, hjust = 1,size = 10),#横坐标
        axis.text.y = element_text(face = "italic", angle = 45, hjust = 1,size = 10),
        legend.text = element_text(size = 10,hjust = 0.5),#legend字体大小,居中
        legend.title = element_text(size = 12), #设置legend标签字体大小
        panel.background = element_rect(fill = HH[2]),
        panel.border = element_rect(color = HH[1], fill = NA),#保留边框
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank())


data <- read.csv("QSAR/table/data35HH_SVM_confmat.csv", header = T, row.names = 1, check.names = F, sep = ",")
#先设置热图颜色
HH<-c("#FFFF86","#FFFFE0")
SVM<-c("#86FFFF","#E0FFFF")
HHSVM<-ggplot(data,aes(x= Predicted,y = Real))+
  geom_tile(aes(fill=Result),width=1,height =1,color = HH[2])+
  coord_equal() + # 绘制正方形，长宽相等
  scale_fill_gradientn(colors = rev(SVM))+#legend上下限
  geom_text(
    aes(label = Name),
    color= "black",
    vjust=-0.8)+
  geom_text(
    aes(label = Result),
    color= "black",
    vjust=0.8)+
  scale_color_gradientn(colors = HH)+
  guides(color="none",fill="none")+
  xlim(c("P","N"))+
  ylim(c("N","P"))+
  ggtitle("Confusion matrix of SVM")+
  annotate("text",x=Inf, y=-Inf, label="(C)",hjust=1,vjust=-0.5)+
  theme(text = element_text(family = "mono", size=14),
        plot.title = element_text(size = 14,hjust = 0.5),#title 大小,居中
        axis.title.x = element_text(size = 14),#x轴标题
        axis.title.y = element_text(size = 14),
        axis.text.x = element_text(face = "italic", angle = 45, hjust = 1,size = 10),#横坐标
        axis.text.y = element_text(face = "italic", angle = 45, hjust = 1,size = 10),
        legend.text = element_text(size = 10,hjust = 0.5),#legend字体大小,居中
        legend.title = element_text(size = 12), #设置legend标签字体大小
        panel.background = element_rect(fill = HH[2]),
        panel.border = element_rect(color = HH[1], fill = NA),#保留边框
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank())

#ROC
rocrf<-read.csv("QSAR/table/data28HH_RF_ROC.csv",header = TRUE,check.names = FALSE)
rocsvm<-read.csv("QSAR/table/data32HH_SVM_ROC.csv",header = TRUE,check.names = FALSE)
roclr<-read.csv("QSAR/table/data36HH_LR_ROC.csv",header = TRUE,check.names = FALSE)
roc<-rbind(rocrf,rocsvm,roclr)
roc$type <- factor(rep(c("rf AUC=0.5759", 
                         "svm AUC=0.5462",
                         "lr AUC=0.5420"), 
                       times=c(dim(rocrf)[1], 
                               dim(rocsvm)[1],
                               dim(roclr)[1])))

HH<-c("#FFFF86","#FFFFE0")
legend_title="ML method"
ROC<-ggplot(roc) +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed", color = "grey") +  # 添加斜线
  geom_line(aes(x = `False Positive Rate`, y = `True Positive Rate`,
                color = type), 
            linetype="solid",
            linewidth=1) +
  scale_color_manual(values = c("rf AUC=0.5759" = "#8686FF","svm AUC=0.5462"="#86FFFF","lr AUC=0.5420"="#86FF86")) +
  labs(title = "ROC", x = "1- Spec.", y = "Sens.") +
  guides(color = guide_legend(title = legend_title)) +
  annotate("text",x=Inf, y=-Inf, label="(D)",hjust=1,vjust=-0.5)+
  theme(
    text = element_text(family = "mono", size=16),
    plot.title = element_text(size = 16,hjust = 0.5),#title 大小
    axis.title.x = element_text(face = "italic", size = 14),#x轴标题
    axis.title.y = element_text(face = "italic", size = 14),
    axis.text.x = element_text(angle = 45, hjust = 1,size = 10),#横坐标
    axis.text.y = element_text(angle = 45, hjust = 1,size = 10),
    legend.text = element_text(size = 8),#legend字体大小
    legend.title = element_text(size = 8), #设置legend标签字体大小
    legend.position = c(0.8,0.2),
    legend.background = element_rect(fill="transparent"),
    panel.background = element_rect(fill = HH[2]),
    panel.border = element_rect(color = HH[1], fill = NA),#保留边框
    plot.margin = margin(1, 1, 1, 1, "cm"),#图像离上下左右边框的距离
  )
com<-grid.arrange(HHRF,HHLR,HHSVM,ROC,nrow=2,
                  top= "Human health")
save_plot("QSAR/final/pic/HH_confmat_ROC.png",com,base_width=30,base_height = 22,dpi = 300,units = "cm",bg="white")











