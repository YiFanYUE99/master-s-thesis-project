#绘画混淆矩阵
library(ggplot2)
library(gridExtra)
library(cowplot)
setwd("D:/R_work/master-s-thesis-project/")
#颜色
RF<-c("#4682B4","#ADD8E6")
SVM<-c("#3CB371","#90EE90")
LR<-c("#8A2BE2","#D8BFD8")
NB<-c("#FF69B4","#FFB6C1")
KNN<-c("#FFFF86","#FFFFE0")
GB<-c("#FFA500","#FFE4B5")
#ef/ec/hh
EF<-c("#000080","#00008B40")
EC<-c("#006400","#228B2240")
HH<-c("#800080","#4B008240")
titlesize<-9
#RF
data <- read.csv("QSAR/混淆矩阵/EC_fRF_confmat_7.csv", header = T, row.names = 1, check.names = F, sep = ",")
ECRF<-ggplot(data,aes(x= Predicted,y = Real))+
  geom_tile(aes(fill=Result),width=1,height =1,color = EC[2])+
  coord_equal() + # 绘制正方形，长宽相等
  scale_fill_gradientn(colors = rev(RF))+#legend上下限
  geom_text(
    aes(label = Name),
    color= EC[1],
    vjust=-0.8)+
  geom_text(
    aes(label = Result),
    color= EC[1],
    vjust=0.8)+
  scale_color_gradientn(colors = EC)+
  guides(color="none",fill="none")+
  xlim(c("P","N"))+
  ylim(c("N","P"))+
  ggtitle("Random Forest")+
  annotate("text",x=Inf, y=-Inf, label="(A)",hjust=1,vjust=-0.5)+
  theme(text = element_text(family = "mono", size=14),
        plot.title = element_text(size = titlesize,hjust = 0.5),#title 大小,居中
        axis.title.x = element_blank(),#x轴标题
        axis.title.y = element_text(size = 14),
        axis.text.x = element_text(face = "bold", angle = 0, hjust = 1,size = 14),#横坐标
        axis.text.y = element_text(face = "bold", angle = 0, hjust = 1,size = 14),
        legend.text = element_text(size = 10,hjust = 0.5),#legend字体大小,居中
        legend.title = element_text(size = 12), #设置legend标签字体大小
        panel.background = element_rect(fill = EC[2]),
        panel.border = element_rect(color = EC[2], fill = NA),#保留边框
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank())
ECRF

#SVM
data <- read.csv("QSAR/混淆矩阵/EC_fSVM_confmat_8.csv", header = T, row.names = 1, check.names = F, sep = ",")
ECSVM<-ggplot(data,aes(x= Predicted,y = Real))+
  geom_tile(aes(fill=Result),width=1,height =1,color = EC[2])+
  coord_equal() + # 绘制正方形，长宽相等
  scale_fill_gradientn(colors = rev(SVM))+#legend上下限
  geom_text(
    aes(label = Name),
    color= EC[1],
    vjust=-0.8)+
  geom_text(
    aes(label = Result),
    color= EC[1],
    vjust=0.8)+
  scale_color_gradientn(colors = EC)+
  guides(color="none",fill="none")+
  xlim(c("P","N"))+
  ylim(c("N","P"))+
  ggtitle("Support Vector Machine")+
  annotate("text",x=Inf, y=-Inf, label="(B)",hjust=1,vjust=-0.5)+
  theme(text = element_text(family = "mono", size=14),
        plot.title = element_text(size = titlesize,hjust = 0.5),#title 大小,居中
        axis.title.x = element_blank(),#x轴标题
        axis.title.y = element_blank(),
        axis.text.x = element_text(face = "bold", angle = 0, hjust = 1,size = 14),#横坐标
        axis.text.y = element_text(face = "bold", angle = 0, hjust = 1,size = 14),
        legend.text = element_text(size = 10,hjust = 0.5),#legend字体大小,居中
        legend.title = element_text(size = 12), #设置legend标签字体大小
        panel.background = element_rect(fill = EC[2]),
        panel.border = element_rect(color = EC[2], fill = NA),#保留边框
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank())
ECSVM

#LR
data <- read.csv("QSAR/混淆矩阵/EC_fLR_confmat_9.csv", header = T, row.names = 1, check.names = F, sep = ",")
ECLR<-ggplot(data,aes(x= Predicted,y = Real))+
  geom_tile(aes(fill=Result),width=1,height =1,color = EC[2])+
  coord_equal() + # 绘制正方形，长宽相等
  scale_fill_gradientn(colors = rev(LR))+#legend上下限
  geom_text(
    aes(label = Name),
    color= EC[1],
    vjust=-0.8)+
  geom_text(
    aes(label = Result),
    color= EC[1],
    vjust=0.8)+
  scale_color_gradientn(colors = EC)+
  guides(color="none",fill="none")+
  xlim(c("P","N"))+
  ylim(c("N","P"))+
  ggtitle("Logistic Regression")+
  annotate("text",x=Inf, y=-Inf, label="(C)",hjust=1,vjust=-0.5)+
  theme(text = element_text(family = "mono", size=14),
        plot.title = element_text(size = titlesize,hjust = 0.5),#title 大小,居中
        axis.title.x = element_blank(),#x轴标题
        axis.title.y = element_text(size = 14),
        axis.text.x = element_text(face = "bold", angle = 0, hjust = 1,size = 14),#横坐标
        axis.text.y = element_text(face = "bold", angle = 0, hjust = 1,size = 14),
        legend.text = element_text(size = 10,hjust = 0.5),#legend字体大小,居中
        legend.title = element_text(size = 12), #设置legend标签字体大小
        panel.background = element_rect(fill = EC[2]),
        panel.border = element_rect(color = EC[2], fill = NA),#保留边框
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank())
ECLR

#NB
data <- read.csv("QSAR/混淆矩阵/EC_fNB_confmat_10.csv", header = T, row.names = 1, check.names = F, sep = ",")
ECNB<-ggplot(data,aes(x= Predicted,y = Real))+
  geom_tile(aes(fill=Result),width=1,height =1,color = EC[2])+
  coord_equal() + # 绘制正方形，长宽相等
  scale_fill_gradientn(colors = rev(NB))+#legend上下限
  geom_text(
    aes(label = Name),
    color= EC[1],
    vjust=-0.8)+
  geom_text(
    aes(label = Result),
    color= EC[1],
    vjust=0.8)+
  scale_color_gradientn(colors = EC)+
  guides(color="none",fill="none")+
  xlim(c("P","N"))+
  ylim(c("N","P"))+
  ggtitle("Naive Bayes")+
  annotate("text",x=Inf, y=-Inf, label="(D)",hjust=1,vjust=-0.5)+
  theme(text = element_text(family = "mono", size=14),
        plot.title = element_text(size = titlesize,hjust = 0.5),#title 大小,居中
        axis.title.x = element_blank(),#x轴标题
        axis.title.y = element_blank(),
        axis.text.x = element_text(face = "bold", angle = 0, hjust = 1,size = 14),#横坐标
        axis.text.y = element_text(face = "bold", angle = 0, hjust = 1,size = 14),
        legend.text = element_text(size = 10,hjust = 0.5),#legend字体大小,居中
        legend.title = element_text(size = 12), #设置legend标签字体大小
        panel.background = element_rect(fill = EC[2]),
        panel.border = element_rect(color = EC[2], fill = NA),#保留边框
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank())
ECNB

#KNN
data <- read.csv("QSAR/混淆矩阵/EC_fKNN_confmat_11.csv", header = T, row.names = 1, check.names = F, sep = ",")
ECKNN<-ggplot(data,aes(x= Predicted,y = Real))+
  geom_tile(aes(fill=Result),width=1,height =1,color = EC[2])+
  coord_equal() + # 绘制正方形，长宽相等
  scale_fill_gradientn(colors = rev(KNN))+#legend上下限
  geom_text(
    aes(label = Name),
    color= EC[1],
    vjust=-0.8)+
  geom_text(
    aes(label = Result),
    color= EC[1],
    vjust=0.8)+
  scale_color_gradientn(colors = EC)+
  guides(color="none",fill="none")+
  xlim(c("P","N"))+
  ylim(c("N","P"))+
  ggtitle("K-Nearest Neighbors")+
  annotate("text",x=Inf, y=-Inf, label="(E)",hjust=1,vjust=-0.5)+
  theme(text = element_text(family = "mono", size=14),
        plot.title = element_text(size = titlesize,hjust = 0.5),#title 大小,居中
        axis.title.x = element_text(size = 14),#x轴标题
        axis.title.y = element_text(size = 14),
        axis.text.x = element_text(face = "bold", angle = 0, hjust = 1,size = 14),#横坐标
        axis.text.y = element_text(face = "bold", angle = 0, hjust = 1,size = 14),
        legend.text = element_text(size = 10,hjust = 0.5),#legend字体大小,居中
        legend.title = element_text(size = 12), #设置legend标签字体大小
        panel.background = element_rect(fill = EC[2]),
        panel.border = element_rect(color = EC[2], fill = NA),#保留边框
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank())
ECKNN

#GB 
data <- read.csv("QSAR/混淆矩阵/EC_fGB_confmat_12.csv", header = T, row.names = 1, check.names = F, sep = ",")
ECGB<-ggplot(data,aes(x= Predicted,y = Real))+
  geom_tile(aes(fill=Result),width=1,height =1,color = EC[2])+
  coord_equal() + # 绘制正方形，长宽相等
  scale_fill_gradientn(colors = rev(GB))+#legend上下限
  geom_text(
    aes(label = Name),
    color= EC[1],
    vjust=-0.8)+
  geom_text(
    aes(label = Result),
    color= EC[1],
    vjust=0.8)+
  scale_color_gradientn(colors = EC)+
  guides(color="none",fill="none")+
  xlim(c("P","N"))+
  ylim(c("N","P"))+
  ggtitle("Gradient Boosting Decision Trees")+
  annotate("text",x=Inf, y=-Inf, label="(F)",hjust=1,vjust=-0.5)+
  theme(text = element_text(family = "mono", size=14),
        plot.title = element_text(size = titlesize,hjust = 0.5),#title 大小,居中
        axis.title.x = element_text(size = 14),#x轴标题
        axis.title.y = element_blank(),
        axis.text.x = element_text(face = "bold", angle = 0, hjust = 1,size = 14),#横坐标
        axis.text.y = element_text(face = "bold", angle = 0, hjust = 1,size = 14),
        legend.text = element_text(size = 10,hjust = 0.5),#legend字体大小,居中
        legend.title = element_text(size = 12), #设置legend标签字体大小
        panel.background = element_rect(fill = EC[2]),
        panel.border = element_rect(color = EC[2], fill = NA),#保留边框
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank())
ECGB

#ROC
rocrf<-read.csv("QSAR/ROC曲线/EC_fRF_ROC_7.csv",header = TRUE,check.names = FALSE)
rocsvm<-read.csv("QSAR/ROC曲线/EC_fSVM_ROC_8.csv",header = TRUE,check.names = FALSE)
roclr<-read.csv("QSAR/ROC曲线/EC_fLR_ROC_9.csv",header = TRUE,check.names = FALSE)
rocnb<-read.csv("QSAR/ROC曲线/EC_fNB_ROC_10.csv",header = TRUE,check.names = FALSE)
rocknn<-read.csv("QSAR/ROC曲线/EC_fKNN_ROC_11.csv",header = TRUE,check.names = FALSE)
rocgb<-read.csv("QSAR/ROC曲线/EC_fGB_ROC_12.csv",header = TRUE,check.names = FALSE)
roc<-rbind(rocrf,rocsvm,roclr,rocnb,rocknn,rocgb)
roc$type <- factor(rep(c("RF AUC=0.934", 
                         "SVM AUC=0.720",
                         "LR AUC=0.633",
                         "NB AUC=0.631",
                         "KNN AUC=0.731",
                         "GB AUC=0.863"), 
                       times=c(dim(rocrf)[1], 
                               dim(rocsvm)[1],
                               dim(roclr)[1],
                               dim(rocnb)[1],
                               dim(rocknn)[1],
                               dim(rocgb)[1])))
color<-c("RF AUC=0.934" =RF[1], 
         "SVM AUC=0.720" =SVM[1],
         "LR AUC=0.633" =LR[1],
         "NB AUC=0.631" =NB[1],
         "KNN AUC=0.731" =KNN[1],
         "GB AUC=0.863" =GB[1])
legend_title="ML method"
ROC<-ggplot(roc) +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed", color = "grey") +  # 添加斜线
  geom_line(aes(x = `False Positive Rate`, y = `True Positive Rate`,
                color = type), 
            linetype="solid",
            linewidth = 1) +
  scale_color_manual(values = color) +
  labs(title = "ROC", x = "1- Spec.", y = "Sens.") +
  guides(color = guide_legend(title = legend_title)) +
  annotate("text",x=Inf, y=-Inf, label="(G)",hjust=1,vjust=-0.5)+
  theme(
    text = element_text(family = "mono", size=16),
    plot.title = element_text(size = 16,hjust = 0.5),#title 大小
    axis.title.x = element_text(face = "italic", size = 14),#x轴标题
    axis.title.y = element_text(face = "italic", size = 14),
    axis.text.x = element_text(angle = 45, hjust = 1,size = 10),#横坐标
    axis.text.y = element_text(angle = 45, hjust = 1,size = 10),
    legend.text = element_text(size = 14),#legend字体大小
    legend.title = element_text(size = 14), #设置legend标签字体大小
    legend.position = c(0.8,0.2),
    legend.background = element_rect(fill="transparent"),
    panel.background = element_rect(fill = EC[2]),
    panel.border = element_rect(color = EC[2], fill = NA),#保留边框
    plot.margin = margin(1, 1, 1, 1, "cm"),#图像离上下左右边框的距离
  )
ROC
com1<-grid.arrange(ECRF, ECSVM, ECLR,ECNB,ECKNN,ECGB,
                  nrow=3,
                  top= "Confusion Matrix")
com2<-grid.arrange(com1,
                 ROC,ncol=2,
                 top= "Ecotoxicity")
com2
ggsave("QSAR/pic2/EC_confmat_ROC_2.png",plot = com2, width=30, height=20,dpi = 300,units = "cm",bg="white")








