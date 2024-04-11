#colors
binarycol<-c('#0072B2', '#D55E00')
tertiarycol<-c("#0072B2","#D55E00","#009E73")
quaternarycol<-c("#0072B2","#D55E00","#009E73","#CC79A7")
sequentialcol<-c("#DDEBF7","#08306B")
divergingcol<-c("#C6DBEF","#FFFFFF","#FCBBA1")
colorblindcol<-c("#56B49E","#D55E00","#CC79A7","#F0E442")
pastelcol<-c("#B3CDE3","#CCEBC5","#FBB4AE","#DECBE4")

# 棕色系
brown_colors <- c("#FFE4C4","#FFD3A8","#FFC18C","#FFB070","#FF9E54","#FF8D38","#8B4513")
#紫色系
purples<-c("#6E00E6","#8200FF","#9628FF", "#AA50FF", "#BE78FF", "#D2A0FF", "#E6C8FF")
violets<-c("#8B00E6","#A400FF","#B32CFF","#C259FF","#D186FF","#E0B3FF","#F0E0FF")
#粉色系
pinks<-c("#FFE0E6","#FFB3C2","#FF869D","#FF5980","#FF2C63","#FF0046","#E6003D")
#红色系
reds<-c("#FFE0E0","#FFB3B3","#FF8686","#FF5959","#FF2C2C","#FF0000","#E60000")
#橙色系
oranges<-c("#FFE0B3","#FFCC80","#FFB84D","#FFA31A","#FF8F00","#FF7A00","#E66500")
#黄色系
yellows<-c("#FFFFE0", "#FFFFB3", "#FFFF86", "#FFFF59", "#FFFF2C","#FFFF00","#E6E600")
#绿色系
greens<-c("#E0FFE0","#B3FFB3","#86FF86","#59FF59","#2CFF2C","#00FF00","#00E600")
#青色系
cyans<-c("#E0FFFF","#B3FFFF","#86FFFF","#59FFFF","#2CFFFF","#00FFFF","#00E6E6")
#蓝色系
blues<-c("#E0E0FF","#B3B3FF","#8686FF","#5959FF","#2C2CFF","#0000FF","#0000E6")

#makaron colors
dreamcol<-c("#F2D2D2","#D8CCE6","#CFF5D2","#FFF5CC")
sunsetcol<-c("#FFDAB9","#F2D2D2","#FFF3E0","#DFF2D8")
oceancol<-c("#CCE7F2","#CFF5D2","#D8CCE6","#FFF3E0")
springcol<-c("#DFF2D8","#FFF5CC","#F2D2D2","#CCE7F2")


#QSAR
#模型
LR<-c("#86FF86","#E0FFE0")
RF<-c("#8686FF","#E0E0FF")
SVM<-c("#86FFFF","#E0FFFF")
#ef/ec/hh
EF<-c("#FFC18C","#FFE4C4")
EC<-c("#FF869D","#FFE0E6")
HH<-c("#FFFF86","#FFFFE0")





#QSRR
#主题背景
fs<-c("#FFE0E6","#FFB3C2")
maecs<-c("#E6C8FF","#E0FFFF")
rtcslr<-c("#E6C8FF","#E0FFE0")
#点，柱子颜色
#特征选择方式的颜色
cs<-c("#AA50FF","#E6C8FF")
mi<-c("#FFA31A","#FFE0B3")
#建模方法的颜色
lr<-c("#59FF59","#E0FFE0")
#预测-实验
preex<-c("#FF869D","#86FF86")
preext<-c("#FF5980","#00E600")



#获取相反色
get_inverse_color <- function(color) {
  # Split color into RGB channels
  rgb <- col2rgb(color)
  
  # Get inverse RGB values
  inverse_rgb <- 255 - rgb
  
  # Convert back to hexadecimal color code
  inverse_color <- rgb(t(inverse_rgb), maxColorValue = 255)
  
  return(inverse_color)
}




















