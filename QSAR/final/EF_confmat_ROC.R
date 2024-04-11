#绘画混淆矩阵
library(ggplot2)
library(gridExtra)
library(cowplot)
setwd("D:/R_work/master-s-thesis-project")
data <- read.csv("QSAR/table/data7EF_RF_confmat.csv", header = T, row.names = 1, check.names = F, sep = ",")
#先设置热图颜色
EF<-c("#FFC18C","#FFE4C4")
RF<-c("#8686FF","#E0E0FF")
EFRF<-ggplot(data,aes(x= Predicted,y = Real))+
  geom_tile(aes(fill=Result),width=1,height =1,color = EF[2])+
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
  scale_color_gradientn(colors = EF)+
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
        panel.background = element_rect(fill = EF[2]),
        panel.border = element_rect(color = EF[1], fill = NA),#保留边框
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank())


data <- read.csv("QSAR/table/data15EF_LR_confmat.csv", header = T, row.names = 1, check.names = F, sep = ",")
#先设置热图颜色
EF<-c("#FFC18C","#FFE4C4")
LR<-c("#86FF86","#E0FFE0")
EFLR<-ggplot(data,aes(x= Predicted,y = Real))+
  geom_tile(aes(fill=Result),width=1,height =1,color = EF[2])+
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
  scale_color_gradientn(colors = EF)+
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
        panel.background = element_rect(fill = EF[2]),
        panel.border = element_rect(color = EF[1], fill = NA),#保留边框
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank())

data <- read.csv("QSAR/table/data11EF_SVM_confmat.csv", header = T, row.names = 1, check.names = F, sep = ",")
#先设置热图颜色
EF<-c("#FFC18C","#FFE4C4")
SVM<-c("#86FFFF","#E0FFFF")
EF_SVM<-ggplot(data,aes(x= Predicted,y = Real))+
  geom_tile(aes(fill=Result),width=1,height =1,color = EF[2])+
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
  scale_color_gradientn(colors = EF)+
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
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(),
        panel.background = element_rect(fill = EF[2]),
        panel.border = element_rect(color = EF[1], fill = NA))#保留边框

#roc
rocrf<-read.csv("QSAR/table/data4EF_RF_ROC.csv",header = TRUE,check.names = FALSE)
rocsvm<-read.csv("QSAR/table/data8EF_SVM_ROC.csv",header = TRUE,check.names = FALSE)
roclr<-read.csv("QSAR/table/data12EF_LR_ROC.csv",header = TRUE,check.names = FALSE)
roc<-rbind(rocrf,rocsvm,roclr)
roc$type <- factor(rep(c("rf AUC=0.6182", 
                         "svm AUC=0.5682",
                         "lr AUC=0.5741"), 
                       times=c(dim(rocrf)[1], 
                               dim(rocsvm)[1],
                               dim(roclr)[1])))

legend_title="ML method"
EF<-c("#FFC18C","#FFE4C4")
ROC<-ggplot(roc) +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed", color = "grey") +  # 添加斜线
  geom_line(aes(x = `False Positive Rate`, 
                y = `True Positive Rate`,
                color = type), 
            linetype="solid",
            linewidth=1) +
  scale_color_manual(values = c("rf AUC=0.6182" = "#8686FF","svm AUC=0.5682"="#86FFFF","lr AUC=0.5741"="#86FF86")) +
  labs(title = "ROC", x = "1- Spec.", y = "Sens.") +
  guides(color = guide_legend(title = legend_title)) +
  xlim(0,1)+
  ylim(0,1)+
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
    panel.background = element_rect(fill = EF[2]),
    panel.border = element_rect(color = EF[1], fill = NA),#保留边框
    plot.margin = margin(1, 1, 1, 1, "cm"),#图像离上下左右边框的距离
  )

dev.new()
com<-grid.arrange(EFRF,EFLR,EF_SVM,ROC,nrow=2,
             top= "Environmental fate")
save_plot("QSAR/final/pic/EF_confmat_ROC.png",com,base_width=30,base_height = 22,dpi = 300,units = "cm",bg="white")


















