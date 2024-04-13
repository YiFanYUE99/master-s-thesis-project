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
#HH/ec/hh
EF<-c("#000080","#00008B40")
EC<-c("#006400","#228B2240")
HH<-c("#8B0000","#8B000040")
titlesize<-9
#RF
data <- read.csv("QSAR/混淆矩阵/HH_fRF_confmat_13.csv", header = T, row.names = 1, check.names = F, sep = ",")
HHRF<-ggplot(data,aes(x= Predicted,y = Real))+
  geom_tile(aes(fill=Result),width=1,height =1,color = HH[2])+
  coord_equal() + # 绘制正方形，长宽相等
  scale_fill_gradientn(colors = rev(RF))+#legend上下限
  geom_text(
    aes(label = Name),
    color= HH[1],
    vjust=-0.8)+
  geom_text(
    aes(label = Result),
    color= HH[1],
    vjust=0.8)+
  scale_color_gradientn(colors = HH)+
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
        panel.background = element_rect(fill = HH[2]),
        panel.border = element_rect(color = HH[2], fill = NA),#保留边框
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank())
HHRF

#SVM
data <- read.csv("QSAR/混淆矩阵/HH_fSVM_confmat_14.csv", header = T, row.names = 1, check.names = F, sep = ",")
HHSVM<-ggplot(data,aes(x= Predicted,y = Real))+
  geom_tile(aes(fill=Result),width=1,height =1,color = HH[2])+
  coord_equal() + # 绘制正方形，长宽相等
  scale_fill_gradientn(colors = rev(SVM))+#legend上下限
  geom_text(
    aes(label = Name),
    color= HH[1],
    vjust=-0.8)+
  geom_text(
    aes(label = Result),
    color= HH[1],
    vjust=0.8)+
  scale_color_gradientn(colors = HH)+
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
        panel.background = element_rect(fill = HH[2]),
        panel.border = element_rect(color = HH[2], fill = NA),#保留边框
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank())
HHSVM

#LR
data <- read.csv("QSAR/混淆矩阵/HH_fLR_confmat_15.csv", header = T, row.names = 1, check.names = F, sep = ",")
HHLR<-ggplot(data,aes(x= Predicted,y = Real))+
  geom_tile(aes(fill=Result),width=1,height =1,color = HH[2])+
  coord_equal() + # 绘制正方形，长宽相等
  scale_fill_gradientn(colors = rev(LR))+#legend上下限
  geom_text(
    aes(label = Name),
    color= HH[1],
    vjust=-0.8)+
  geom_text(
    aes(label = Result),
    color= HH[1],
    vjust=0.8)+
  scale_color_gradientn(colors = HH)+
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
        panel.background = element_rect(fill = HH[2]),
        panel.border = element_rect(color = HH[2], fill = NA),#保留边框
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank())
HHLR

#NB
data <- read.csv("QSAR/混淆矩阵/HH_fNB_confmat_16.csv", header = T, row.names = 1, check.names = F, sep = ",")
HHNB<-ggplot(data,aes(x= Predicted,y = Real))+
  geom_tile(aes(fill=Result),width=1,height =1,color = HH[2])+
  coord_equal() + # 绘制正方形，长宽相等
  scale_fill_gradientn(colors = rev(NB))+#legend上下限
  geom_text(
    aes(label = Name),
    color= HH[1],
    vjust=-0.8)+
  geom_text(
    aes(label = Result),
    color= HH[1],
    vjust=0.8)+
  scale_color_gradientn(colors = HH)+
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
        panel.background = element_rect(fill = HH[2]),
        panel.border = element_rect(color = HH[2], fill = NA),#保留边框
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank())
HHNB

#KNN
data <- read.csv("QSAR/混淆矩阵/HH_fKNN_confmat_17.csv", header = T, row.names = 1, check.names = F, sep = ",")
HHKNN<-ggplot(data,aes(x= Predicted,y = Real))+
  geom_tile(aes(fill=Result),width=1,height =1,color = HH[2])+
  coord_equal() + # 绘制正方形，长宽相等
  scale_fill_gradientn(colors = rev(KNN))+#legend上下限
  geom_text(
    aes(label = Name),
    color= HH[1],
    vjust=-0.8)+
  geom_text(
    aes(label = Result),
    color= HH[1],
    vjust=0.8)+
  scale_color_gradientn(colors = HH)+
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
        panel.background = element_rect(fill = HH[2]),
        panel.border = element_rect(color = HH[2], fill = NA),#保留边框
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank())
HHKNN

#GB 
data <- read.csv("QSAR/混淆矩阵/HH_fGB_confmat_18.csv", header = T, row.names = 1, check.names = F, sep = ",")
HHGB<-ggplot(data,aes(x= Predicted,y = Real))+
  geom_tile(aes(fill=Result),width=1,height =1,color = HH[2])+
  coord_equal() + # 绘制正方形，长宽相等
  scale_fill_gradientn(colors = rev(GB))+#legend上下限
  geom_text(
    aes(label = Name),
    color= HH[1],
    vjust=-0.8)+
  geom_text(
    aes(label = Result),
    color= HH[1],
    vjust=0.8)+
  scale_color_gradientn(colors = HH)+
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
        panel.background = element_rect(fill = HH[2]),
        panel.border = element_rect(color = HH[2], fill = NA),#保留边框
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank())
HHGB

#ROC
rocrf<-read.csv("QSAR/ROC曲线/HH_fRF_ROC_13.csv",header = TRUE,check.names = FALSE)
rocsvm<-read.csv("QSAR/ROC曲线/HH_fSVM_ROC_14.csv",header = TRUE,check.names = FALSE)
roclr<-read.csv("QSAR/ROC曲线/HH_fLR_ROC_15.csv",header = TRUE,check.names = FALSE)
rocnb<-read.csv("QSAR/ROC曲线/HH_fNB_ROC_16.csv",header = TRUE,check.names = FALSE)
rocknn<-read.csv("QSAR/ROC曲线/HH_fKNN_ROC_17.csv",header = TRUE,check.names = FALSE)
rocgb<-read.csv("QSAR/ROC曲线/HH_fGB_ROC_18.csv",header = TRUE,check.names = FALSE)
roc<-rbind(rocrf,rocsvm,roclr,rocnb,rocknn,rocgb)
roc$type <- factor(rep(c("RF AUC=0.550", 
                         "SVM AUC=0.777",
                         "LR AUC=0.720",
                         "NB AUC=0.641",
                         "KNN AUC=0.726",
                         "GB AUC=0.550"), 
                       times=c(dim(rocrf)[1], 
                               dim(rocsvm)[1],
                               dim(roclr)[1],
                               dim(rocnb)[1],
                               dim(rocknn)[1],
                               dim(rocgb)[1])))
color<-c("RF AUC=0.550" =RF[1], 
         "SVM AUC=0.777" =SVM[1],
         "LR AUC=0.720" =LR[1],
         "NB AUC=0.641" =NB[1],
         "KNN AUC=0.726" =KNN[1],
         "GB AUC=0.550" =GB[1])
legend_title="ML method"
ROC<-ggplot(roc) +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed", color = "grey") +  # 添加斜线
  geom_line(aes(x = `False Positive Rate`, y = `True Positive Rate`,
                color = type), 
            linetype="solid",
            linewidth = 1) +
  scale_color_manual(values = color) +
  labs(title = "ROC", x = "1- Spec.", y = "Sens.") +
  guides(color = guide_legend(title =  legend_title)) +
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
    panel.background = element_rect(fill = HH[2]),
    panel.border = element_rect(color = HH[2], fill = NA),#保留边框
    plot.margin = margin(1, 1, 1, 1, "cm"),#图像离上下左右边框的距离
  )
ROC
com1<-grid.arrange(HHRF, HHSVM, HHLR,HHNB,HHKNN,HHGB,
                   nrow=3,
                   top= "Confusion Matrix")
com2<-grid.arrange(com1,
                   ROC,ncol=2,
                   top= "Human Health")
com2
ggsave("QSAR/pic2/HH_confmat_ROC_3.png",plot = com2, width=30, height=20,dpi = 300,units = "cm",bg="white")
