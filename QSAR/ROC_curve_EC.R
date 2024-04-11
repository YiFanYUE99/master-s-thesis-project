library(ggplot2)




rocrf<-read.csv("QSAR/table/data16EC_RF_ROC.csv",header = TRUE,check.names = FALSE)
rocsvm<-read.csv("QSAR/table/data20EC_SVM_ROC.csv",header = TRUE,check.names = FALSE)
roclr<-read.csv("QSAR/table/data24EC_LR_ROC.csv",header = TRUE,check.names = FALSE)
roc<-rbind(rocrf,rocsvm,roclr)
roc$type <- factor(rep(c("rf AUC=0.5919", 
                         "svm AUC=0.5864",
                         "lr AUC=0.5741"), 
                       times=c(dim(rocrf)[1], 
                               dim(rocsvm)[1],
                               dim(roclr)[1])))

EC<-c("#FF869D","#FFE0E6")
legend_title="ML method"
ggplot(roc) +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed", color = "grey") +  # 添加斜线
  geom_line(aes(x = `False Positive Rate`, y = `True Positive Rate`,
                color = type), linetype="solid") +
  scale_color_manual(values = c("rf AUC=0.5919" = "#8686FF","svm AUC=0.5864"="#86FFFF","lr AUC=0.5741"="#86FF86")) +
  labs(title = "Ecotoxicity ROC", x = "False Positive Rate (1- Spec.)", y = "True Positive Rate (Sens.)") +
  guides(color = guide_legend(title = legend_title)) +
  theme(
    text = element_text(family = "mono", size=16),
    plot.title = element_text(size = 16),#title 大小
    axis.title.x = element_text(face = "italic", size = 14),#x轴标题
    axis.title.y = element_text(face = "italic", size = 14),
    axis.text.x = element_text(angle = 45, hjust = 1,size = 10),#横坐标
    axis.text.y = element_text(angle = 45, hjust = 1,size = 10),
    legend.text = element_text(size = 8),#legend字体大小
    legend.title = element_text(size = 8), #设置legend标签字体大小
    legend.position = "right",
    panel.background = element_rect(fill = EC[2]),
    panel.border = element_rect(color = EC[1], fill = NA),#保留边框
    plot.margin = margin(1, 1, 1, 1, "cm"),#图像离上下左右边框的距离
  )
ggsave("QSAR/pic/EC_ROC.png",width=10, height=7,dpi=300)
