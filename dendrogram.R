#install.packages("xlsx")
library(xlsx)
library(tidyverse)
library(ggraph)
library(tidygraph)
library(igraph)
setwd("D:/paper/paper/data")
node <- read.xlsx("cleannetwork.xlsx", sheetIndex = 1)
edge <- read.xlsx("cleannetwork.xlsx", sheetIndex = 2)
#查找缺失的node
dim(node)[1]
mylist1=NULL
mylist2=NULL

for (i in 1:dim(edge)[1]){
  a<-0
  b<-0
  for (j in 1:dim(node)[1]){
    
    if(edge[i,1]==node[j,1]){
      a=a+1
    }
    if(edge[i,2]==node[j,1]){
      b<-b+1
    }
  }
  if(a==0){
    mylist1<-append(mylist1,list(edge[i,1]))
  }
  if(b==0){
    mylist2<-append(mylist2,list(edge[i,2]))
  }
}
#去掉重复内容
edge<-edge[!duplicated(edge),]
node<-node[!duplicated(node),]
#创建自己的排布
graph <- graph_from_data_frame(edge, vertices = node)
# create custom layout by updating existing circle layout
layout <- create_layout(graph, layout = 'circle')#圆形排布
#外圈
outer_num=40
outer_circle <- layout %>%
  filter(type != 'pesticides') %>%#筛选level=1的对象，外圈是程序包
  mutate(subtype = factor(subtype)) %>%
  arrange(subtype, desc(type)) %>%
  mutate(
    x = cos((row_number() - 1) / outer_num * 2 * pi),#计算每个点的坐标；外圈一共300个点
    y = sin((row_number() - 1) / outer_num * 2 * pi),#row_number()是行数x是cos，y是sin
  )
#内圈pesticides
# positioning circle centers manually by specifying polar coords
inner_num<-8
angles <- c(3, 43, 119, 160, 178, 255, 340, 0)#10个数字对应10种编程语言#角度
radii <- c(0.8, 0.5, 0.6, 0.4, 0.65, 0.45, 0.38, 0)#10个数字对应10种编程语言；半径
centers <- tibble(
  x = radii * cos(angles / 180 * pi),
  y = radii * sin(angles / 180 * pi)
)
inner_circle <- bind_cols(centers, select(filter(layout, type == "pesticides"), -x, -y))#内圈是编程语言，去掉layout中level=1的部分，以及去掉x,y的部分
layout[] <- bind_rows(outer_circle, inner_circle) %>%#按行合并内外圈
  arrange(.ggraph.index)#根据.ggraph.index升序
class(edge$Regulate)

#设置颜色对应名称
edge_Regulate_color<-c('#7db954','#33CCFF','lightgreen','#17a769')
node_type_color<-c('#cd023d','#FF3399','#CC33CC','#9933CC')
names(node_type_color)<-unique(node$type)
names(edge_Regulate_color)<-unique(edge$Regulate)

ggraph(layout) +
  geom_edge_diagonal(
    aes(edge_color = edge$Regulate, show.legend = TRUE), 
    edge_width =1
  ) +
  geom_node_point(
    aes(color = type,show.legend = TRUE),
  ) +
  geom_node_text(
    aes(
      x = 1.0175 * x,#文字的横坐标
      y = 1.0175 * y,#文字的纵坐标
      color= type,
      label = name,#文字的内容
      angle = -((-node_angle(x, y) + 90) %% 180) + 90,#%%表示整除后返回余数,node_angle根据横纵坐标计算角度
      filter =!(type=='pesticides') #为外圈添加标签
    ),
    size = 2.5, hjust = 'outward', family = 'Oswald'
  ) +
  geom_node_text(
    aes(
      x = x,
      y = y,
      color =type,
      label = name,
      filter = (type=='pesticides')#为编程语言添加文字标签
    ),
    size = 4, hjust = 0.5, family = 'Oswald'
  ) +
  geom_node_text(
    aes(
      x = x,
      y = y - 0.045,
      label = subtype,
      color =type,
      filter = (type=='pesticides')
    ),
    size = 3, hjust = 0.5, family = 'Oswald'
  ) +
  scale_edge_color_manual(values = edge_Regulate_color,
                          guide = guide_legend(title = "Regulate",
                                               title.theme = element_text(
                                                 size = 10,
                                                 face="italic",
                                                 colour = "grey1"),
                                               label.theme = element_text(
                                                 size = 10,
                                                 colour = "grey1",
                                                 face="italic")))+#根据top_language_colors确定颜色
  scale_color_manual(values = node_type_color,
                     guide = guide_legend(title = "type",
                                          title.theme = element_text(
                                            size = 10,
                                            face="italic",
                                            colour = "grey1"),
                                          label.theme = element_text(
                                            size = 10,
                                            colour = "grey1",
                                            face="italic")))+#根据top_language_colors确定颜色) +#根据top_language_colors确定颜色
  scale_size_area(max_size = 1) +#缩放半径
  coord_fixed() +#图形伸缩变换
  labs(
    title = '',
    subtitle = '',
    caption = '#'
  ) +#添加标题、副标题、说明文字
  theme(
    legend.title.align = 0,#legend左对齐
    legend.text.align =0,#legend text左对齐
    legend.spacing.x = unit(0.1,"cm"),#图例各个元素距离
    legend.spacing.y = unit(0.1,"cm"),
    panel.background = element_blank(),#delete background.
    panel.grid = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_blank()
  )+
  theme(
    text = element_text(family = 'Oswald'),
    legend.position = c(0, 1),#标签位置
    plot.title = element_text(
      face = 'bold', hjust = 0.5, size = 20, margin = margin(t = 45, b = 3)
    ),#title设定
    plot.subtitle = element_text(
      face = 'plain', hjust = 0.5, size = 13, margin = margin(t = 5, b = 3)),#subtitle设定
    plot.caption = element_text(
      face = 'plain', color = '#dedede', size = 8, hjust = 1,
      margin = margin(b = 20)
    )#caption说明文字设定
  )+
  xlim(-1.5,1.5)+
  ylim(-1.5,1.5)
ggsave(
  'Exposome2.png',
  width = 16, height = 12.5, dpi = 300
)








