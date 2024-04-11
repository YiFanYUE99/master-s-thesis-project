getwd()
library(ggplot2)
library(gridExtra)
setwd("D:/R_work/master-s-thesis-project/QSRR/QSRR3/result/特征数MAE")
#输入数据
#1
csmlr<-read.csv("csmlr_1.csv",header = 1,check.names = F)
csmlr$group=rep("CS+MLR",dim(csmlr)[1])
#2
mimlr<-read.csv("mimlr_2.csv",header = 1,check.names = F)
mimlr$group=rep("MI+MLR",dim(mimlr)[1])
#3
cssvr<-read.csv("cssvr_3.csv",header=1,check.names = F)
cssvr$group=rep("CS+SVR",dim(cssvr)[1])
#4
misvr<-read.csv("misvr_4.csv",header=1,check.names = F)
misvr$group=rep("MI+SVR",dim(misvr)[1])
#5
cspls<-read.csv("cspls_5.csv",header=1,check.names = F)
cspls$group=rep("CS+PLS",dim(cspls)[1])
#6
mipls<-read.csv("mipls_6.csv",header=1,check.names = F)
mipls$group=rep("MI+PLS",dim(mipls)[1])
#7
csrf<-read.csv("csrf_7.csv",header=1,check.names = F)
csrf$group=rep("CS+RF",dim(csrf)[1])
#8
mirf<-read.csv("mirf_8.csv",header=1,check.names = F)
mirf$group=rep("MI+RF",dim(mirf)[1])
#9
csla<-read.csv("csla_9.csv",header=1,check.names = F)
csla$group=rep("CS+LASSO",dim(csla)[1])
#10
mila<-read.csv("mila_10.csv",header=1,check.names = F)
mila$group=rep("MI+LASSO",dim(mila)[1])
#11
csri<-read.csv("csri_11.csv",header=1,check.names = F)
csri$group=rep("CS+Ridge",dim(csri)[1])
#12
miri<-read.csv("miri_12.csv",header=1,check.names = F)
miri$group=rep("MI+Ridge",dim(miri)[1])
#13
csgb<-read.csv("csgb_13.csv",header=1,check.names = F)
csgb$group=rep("CS+GBR",dim(csgb)[1])
#14
migb<-read.csv("migb_14.csv",header=1,check.names = F)
migb$group=rep("MI+GBR",dim(migb)[1])

#设置配色、大小
color<-c("CS+MLR"="#FF0000","MI+MLR"= "#FF9999", 
         "CS+SVR"="#FFA500","MI+SVR"= "#FFD700",
         "CS+PLS"="#FFFF00","MI+PLS"= "#FFFF99",
         "CS+RF" ="#008000","MI+RF" = "#66FF66",
         "CS+LASSO"="#00FFFF","MI+LASSO"= "#99FFFF",
         "CS+Ridge"="#0000FF","MI+Ridge"="#99CCFF",
         "CS+GBR"  ="#800080","MI+GBR"="#CC99FF")
gc<-c("#808080","#F0F0F0",'#555555')
xtsize<-7.5
xsize<-14
ytsize<-10
ysize<-14
titlesize<-17
allsize<-14
lesize<-10
lisize<-12
linesize<-1.2
pointsize<-3.2
#MLR
mlr<-rbind(csmlr,mimlr)
mlr$sel__k<-as.numeric(mlr$sel__k)
mlr<-na.omit(mlr)
mlrplot<-ggplot(mlr,aes(x=sel__k,y=MAE,group=group))+
  geom_line(aes(color=group),linetype="solid",linewidth=linesize)+
  geom_point(aes(color=group),size=pointsize)+
  geom_text(aes(label=ifelse(MAE==min(mimlr$MAE)|MAE==min(csmlr$MAE),round(MAE,3),"")),vjust=-0.5,
            size=4,color=gc[3])+
  scale_color_manual(values= color)+
  ylim(0.9,3.3)+
  scale_x_continuous(breaks = seq(0,55,1),
                     limits = c(0,55))+
  labs(title = "Multiple Linear Regression", x = "Feature Numbers", y = "MAE")+
  theme(text = element_text(family = "mono", size=allsize),
        plot.title = element_text(size = titlesize, hjust = 0.5),#title 大小,居中
        axis.title.x = element_blank(),#x轴标题
        axis.title.y = element_text(size = ysize),
        axis.text.x = element_text(face = "bold", angle = 45, hjust = 1,size = xtsize),#横坐标
        axis.text.y = element_text(face = "italic", angle = 45, hjust = 1,size = ytsize),
        legend.text = element_text(size = lesize,hjust = 0.5),#legend字体大小,居中
        legend.title = element_text(size = lisize), #设置legend标签字体大小
        panel.background = element_rect(fill = gc[2]),
        panel.grid.major = element_line(color = "#FFFFFF", linetype = "dashed", size = 0.5), 
        panel.grid.minor = element_line(color = "#FFFFFF", linetype = "dashed", size = 0.5),
        panel.border = element_rect(color = gc[1], fill = NA))#去掉边框
mlrplot
#SVR
svr<-rbind(cssvr,misvr)
svr$sel__k<-as.numeric(svr$sel__k)
svr<-na.omit(svr)
svrplot<-ggplot(svr,aes(x=sel__k,y=MAE,group=group))+
  geom_line(aes(color=group),linetype="solid",linewidth=linesize)+
  geom_point(aes(color=group),size=pointsize)+
  geom_text(aes(label=ifelse(MAE==min(misvr$MAE)|MAE==min(cssvr$MAE),round(MAE,3),"")),vjust=-0.5,
            size=4,color=gc[3])+
  scale_color_manual(values= color)+
  ylim(1.25,1.9)+
  scale_x_continuous(breaks = seq(0,55,1),
                     limits = c(0,55))+
  labs(title = "Support Vector Regression", x = "Feature Numbers", y = "MAE")+
  theme(text = element_text(family = "mono", size=allsize),
        plot.title = element_text(size = titlesize,hjust = 0.5),#title 大小,居中
        axis.title.x = element_blank(),#x轴标题
        axis.title.y = element_text(size = ysize),
        axis.text.x = element_text(face = "bold", angle = 45, hjust = 1,size = xtsize),#横坐标
        axis.text.y = element_text(face = "italic", angle = 45, hjust = 1,size = ytsize),
        legend.text = element_text(size = lesize,hjust = 0.5),#legend字体大小,居中
        legend.title = element_text(size = lisize), #设置legend标签字体大小
        panel.background = element_rect(fill = gc[2]),
        panel.grid.major = element_line(color = "#FFFFFF", linetype = "dashed", size = 0.5), 
        panel.grid.minor = element_line(color = "#FFFFFF", linetype = "dashed", size = 0.5),
        panel.border = element_rect(color = gc[1], fill = NA))#去掉边框
svrplot
#PLS
pls<-rbind(cspls,mipls)
cspls<-na.omit(cspls)
mipls<-na.omit(mipls)
pls$sel__k<-as.numeric(pls$sel__k)
pls<-na.omit(pls)
plsplot<-ggplot(pls,aes(x=sel__k,y=MAE,group=group))+
  geom_line(aes(color=group),linetype="solid",linewidth=linesize)+
  geom_point(aes(color=group),size=pointsize)+
  geom_text(aes(label=ifelse(MAE==min(cspls$MAE)|MAE==min(mipls$MAE),round(MAE,3),"")),
            vjust=-0.5,
            size=4,color=gc[3])+
  scale_color_manual(values= color)+
  ylim(1.4,2)+
  scale_x_continuous(breaks = seq(55,110,1),
                     limits = c(55,110))+
  labs(title = "Partial Least Squares Regression", x = "Feature Numbers", y = "MAE")+
  theme(text = element_text(family = "mono", size=allsize),
        plot.title = element_text(size = titlesize,hjust = 0.5),#title 大小,居中
        axis.title.x = element_blank(),#x轴标题
        axis.title.y = element_text(size = ysize),
        axis.text.x = element_text(face = "bold", angle = 45, hjust = 1,size = xtsize),#横坐标
        axis.text.y = element_text(face = "italic", angle = 45, hjust = 1,size = ytsize),
        legend.text = element_text(size = lesize,hjust = 0.5),#legend字体大小,居中
        legend.title = element_text(size = lisize), #设置legend标签字体大小
        panel.background = element_rect(fill = gc[2]),
        panel.grid.major = element_line(color = "#FFFFFF", linetype = "dashed", size = 0.5), 
        panel.grid.minor = element_line(color = "#FFFFFF", linetype = "dashed", size = 0.5),
        panel.border = element_rect(color = gc[1], fill = NA))#去掉边框
plsplot
#RF
rf<-rbind(csrf,mirf)
rf$sel__k<-as.numeric(rf$sel__k)
rf<-na.omit(rf)
rfplot<-ggplot(rf,aes(x=sel__k,y=MAE,group=group))+
  geom_line(aes(color=group),linetype="solid",linewidth=linesize)+
  geom_point(aes(color=group),size=pointsize)+
  geom_text(aes(label=ifelse(MAE==min(csrf$MAE)|MAE==min(mirf$MAE),round(MAE,3),"")),
            vjust=-0.5,
            size=4,color=gc[3])+
  scale_color_manual(values= color)+
  ylim(1,1.1)+
  scale_x_continuous(breaks = seq(29,84,1),
                     limits = c(29,84))+
  labs(title = "Random Forest", x = "Feature Numbers", y = "MAE")+
  theme(text = element_text(family = "mono", size=allsize),
        plot.title = element_text(size = titlesize,hjust = 0.5),#title 大小,居中
        axis.title.x = element_blank(),#x轴标题
        axis.title.y = element_text(size = ysize),
        axis.text.x = element_text(face = "bold", angle = 45, hjust = 1,size = xtsize),#横坐标
        axis.text.y = element_text(face = "italic", angle = 45, hjust = 1,size = ytsize),
        legend.text = element_text(size = lesize,hjust = 0.5),#legend字体大小,居中
        legend.title = element_text(size = lisize), #设置legend标签字体大小
        panel.background = element_rect(fill = gc[2]),
        panel.grid.major = element_line(color = "#FFFFFF", linetype = "dashed", size = 0.5), 
        panel.grid.minor = element_line(color = "#FFFFFF", linetype = "dashed", size = 0.5),
        panel.border = element_rect(color = gc[1], fill = NA))#去掉边框
rfplot
#LASSO
la<-rbind(csla,mila)
la$sel__k<-as.numeric(la$sel__k)
laplot<-ggplot(la,aes(x=sel__k,y=MAE,group=group))+
  geom_line(aes(color=group),linetype="solid",linewidth=linesize)+
  geom_point(aes(color=group),size=pointsize)+
  geom_text(aes(label=ifelse(MAE==min(csla$MAE)|MAE==min(mila$MAE),round(MAE,3),"")),
            vjust=-0.5,
            size=4,color=gc[3])+
  scale_color_manual(values= color)+
  ylim(1.45,6)+
  scale_x_continuous(breaks = seq(82,137,1),
                     limits = c(82,137))+
  labs(title = "LASSO Regression", x = "Feature Numbers", y = "MAE")+
  theme(text = element_text(family = "mono", size=allsize),
        plot.title = element_text(size = titlesize,hjust = 0.5),#title 大小,居中
        axis.title.x = element_blank(),#x轴标题
        axis.title.y = element_text(size = ysize),
        axis.text.x = element_text(face = "bold", angle = 45, hjust = 1,size = xtsize),#横坐标
        axis.text.y = element_text(face = "italic", angle = 45, hjust = 1,size = ytsize),
        legend.text = element_text(size = lesize,hjust = 0.5),#legend字体大小,居中
        legend.title = element_text(size = lisize), #设置legend标签字体大小
        panel.background = element_rect(fill = gc[2]),
        panel.grid.major = element_line(color = "#FFFFFF", linetype = "dashed", size = 0.5), 
        panel.grid.minor = element_line(color = "#FFFFFF", linetype = "dashed", size = 0.5),
        panel.border = element_rect(color = gc[1], fill = NA))#去掉边框
laplot
#Ridge
ri<-rbind(csri,miri)
ri$sel__k<-as.numeric(ri$sel__k)
riplot<-ggplot(ri,aes(x=sel__k,y=MAE,group=group))+
  geom_line(aes(color=group),linetype="solid",linewidth=linesize)+
  geom_point(aes(color=group),size=pointsize)+
  geom_text(aes(label=ifelse(MAE==min(csri$MAE)|MAE==min(miri$MAE),round(MAE,3),"")),
            vjust=-0.5,
            size=4,color=gc[3])+
  scale_color_manual(values= color)+
  ylim(1.3,2.8)+
  scale_x_continuous(breaks = seq(1,80,1),
                     limits = c(1,80))+
  labs(title = "Ridge Regression", x = "Feature Numbers", y = "MAE")+
  theme(text = element_text(family = "mono", size=allsize),
        plot.title = element_text(size = titlesize,hjust = 0.5),#title 大小,居中
        axis.title.x = element_blank(),#x轴标题
        axis.title.y = element_text(size = ysize),
        axis.text.x = element_text(face = "bold", angle = 45, hjust = 1,size = xtsize),#横坐标
        axis.text.y = element_text(face = "italic", angle = 45, hjust = 1,size = ytsize),
        legend.text = element_text(size = lesize,hjust = 0.5),#legend字体大小,居中
        legend.title = element_text(size = lisize), #设置legend标签字体大小
        panel.background = element_rect(fill = gc[2]),
        panel.grid.major = element_line(color = "#FFFFFF", linetype = "dashed", size = 0.5), 
        panel.grid.minor = element_line(color = "#FFFFFF", linetype = "dashed", size = 0.5),
        panel.border = element_rect(color = gc[1], fill = NA))#去掉边框
riplot
#GBR
gbr<-rbind(csgb,migb)
gbr$sel__k<-as.numeric(gbr$sel__k)
gbrplot<-ggplot(gbr,aes(x=sel__k,y=MAE,group=group))+
  geom_line(aes(color=group),linetype="solid",linewidth=linesize)+
  geom_point(aes(color=group),size=pointsize)+
  geom_text(aes(label=ifelse(MAE==min(csgb$MAE)|MAE==min(migb$MAE),round(MAE,3),"")),
            vjust=-0.5,
            size=4,color=gc[3])+
  scale_color_manual(values= color)+
  ylim(0.95,1)+
  scale_x_continuous(breaks = seq(125,180,1),
                     limits = c(125,180))+
  labs(title = "Gradient Boosting Regression", x = "Feature Numbers", y = "MAE")+
  theme(text = element_text(family = "mono", size=allsize),
        plot.title = element_text(size = titlesize,hjust = 0.5),#title 大小,居中
        axis.title.x =element_text(size = xsize),#x轴标题
        axis.title.y = element_text(size = ysize),
        axis.text.x = element_text(face = "bold", angle = 45, hjust = 1,size = xtsize),#横坐标
        axis.text.y = element_text(face = "italic", angle = 45, hjust = 1,size = ytsize),
        legend.text = element_text(size = lesize,hjust = 0.5),#legend字体大小,居中
        legend.title = element_text(size = lisize), #设置legend标签字体大小
        panel.background = element_rect(fill = gc[2]),
        panel.grid.major = element_line(color = "#FFFFFF", linetype = "dashed", size = 0.5), 
        panel.grid.minor = element_line(color = "#FFFFFF", linetype = "dashed", size = 0.5),
        panel.border = element_rect(color = gc[1], fill = NA))#去掉边框
gbrplot

dev.new()
p<-grid.arrange(mlrplot,svrplot,plsplot,rfplot,laplot,riplot,gbrplot,ncol=1)
ggsave('MAE.png',plot = p, width = 10, height = 15, dpi = 300,limitsize = FALSE)



