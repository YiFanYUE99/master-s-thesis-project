library(tidyverse)
library(igraph)
library(ggraph)
getwd()
setwd("D:/R_work/master-s-thesis-project")
path <-
  paste0(
    'https://raw.githubusercontent.com/rfordatascience/tidytuesday/',
    'master/data/2019/2019-11-12/'
  )

data <- read_csv(paste0(path, 'loc_cran_packages.csv'))

# most popular programming languages from TIOBE Index (Nov. 2019) found in data
# (only languages with position <= 16 are considered)
popular_languages <- c(
  'Java', 'C', 'Python', 'C++', 'C#', 'Visual Basic', 'JavaScript', 'PHP', 'SQL', 'Ruby', 'Objective C++', 'Assembly', 'R'
)

# number of packages to display
number_of_pkgs <- 300

# find largest packages written in popular languages
top_packages <- data %>%
  filter(language %in% popular_languages) %>%#筛选在popular_languages中的language
  group_by(pkg_name) %>%#对data按照pkg_name分组
  summarize(total_code = sum(code)) %>%#按照pkg_name分组后，每组统计code之和
  arrange(desc(total_code)) %>%#按照total_code降序排列
  head(number_of_pkgs) %>%#显示前300个，number_of_pkgs是300
  select(pkg_name, total_code)#选择pkg_name和total_code两列

# all popular languages per package
top_languages_per_pkg <- data %>%
  filter(
    pkg_name %in% top_packages$pkg_name,#筛选data中pkg_name在top_packages$pkg_name中的部分
    language %in% popular_languages#且筛选data中language在popular——languages中的部分
  ) %>%
  arrange(pkg_name, desc(code)) %>%#按code对pkg_name降序
  group_by(pkg_name) %>%#根据pkg_name分组
  mutate(
    main = row_number() == 1, # 判断该语言是否是该pkg_name中的第一多使用的
    total_code = sum(code)#添加一列total_code=该pkg_name总和
  ) %>%
  ungroup() %>%#解开分组
  select(language, pkg_name, code, total_code, main)#挑选这五列输出

# only following languages found in given packages
(top_languages <- top_languages_per_pkg %>%
    pull(language) %>%#选择某列 等同于$
    unique %>%#删除重复的
    sort)#从小到大排序

top_language_colors <- c(
  '#efb306',
  '#eb990c',
  '#e8351e',
  '#cd023d',
  '#852f88',
  '#4e54ac',
  '#0f8096',
  '#7db954',
  '#17a769',
  '#000000'
)#设置top_language的颜色

names(top_language_colors) <- c(
  'Assembly',
  'C',
  'C++',
  'JavaScript',
  'Java',
  'R',
  'Python',
  'Ruby',
  'SQL',
  'All'
)#为top_language_colors设置相应标签

edges1 <- top_languages_per_pkg %>%
  transmute(from = language, to = pkg_name, total_code = code, main)#创建新框，只有选定的这些列

edges2 <- top_languages_per_pkg %>%
  count(language, wt = code, name = 'total_code') %>%#计算language中code出现的次数,wt是权重
  transmute(
    from = '',#from处是空白
    to = language,
    total_code,
    main = TRUE
  )

edges <- bind_rows(edges1, edges2)#将edge1、edge2按行加起来

vertices1 <- top_languages_per_pkg %>%
  filter(main) %>%#过滤出main=true的部分
  transmute(
    node = pkg_name, language, total_code, level = 1#设置node是pkg_name,且pkg_name的level为1
  )

vertices2 <- edges2 %>%
  transmute(
    node = to, language = to, total_code, level = 2
  )

vertices3 <- tibble(
  node = '', language = NA, total_code = 0, level = 3
)#设置一个空的节点 level=3

vertices <- bind_rows(vertices1, vertices2, vertices3) %>%
  mutate(
    radius = total_code**(1.8), # 添加radius列,为total_code的1.8次方
    language = factor(language, names(top_language_colors))#以names(top_language_colors)将language转化为因子
  ) %>%
  arrange(level, language, node)#按照level升序、再language升序、node升序

graph <- graph_from_data_frame(edges, vertices = vertices)

# create custom layout by updating existing circle layout
layout <- create_layout(graph, layout = 'circle')#圆形排布

outer_circle <- layout %>%
  filter(level == 1) %>%#筛选level=1的对象，外圈是程序包
  mutate(language = factor(language, names(top_language_colors))) %>%
  arrange(language, desc(name)) %>%
  mutate(
    x = cos((row_number() - 1) / number_of_pkgs * 2 * pi),#计算每个点的坐标；外圈一共300个点
    y = sin((row_number() - 1) / number_of_pkgs * 2 * pi),#row_number()是行数x是cos，y是sin
  )

# positioning circle centers manually by specifying polar coords
angles <- c(3, 43, 119, 160, 178, 255, 350, 190, 340, 0)#10个数字对应10种编程语言#角度
radii <- c(0.8, 0.5, 0.6, 0.4, 0.65, 0.45, 0.6, 0.7, 0.38, 0)#10个数字对应10种编程语言；半径
centers <- tibble(
  x = radii * cos(angles / 180 * pi),
  y = radii * sin(angles / 180 * pi)
)
inner_circle <- bind_cols(centers, select(filter(layout, level != 1), -x, -y))#内圈是编程语言，去掉layout中level=1的部分，以及去掉x,y的部分
#bind_cols按列合并

layout[] <- bind_rows(outer_circle, inner_circle) %>%#按行合并内外圈
  arrange(.ggraph.index)#根据.ggraph.index升序

ggraph(layout) +
  geom_edge_diagonal(
    aes(edge_color = edges$from, #根据edges$from确定边的颜色
        edge_alpha = as.factor(main)),#透明度根据main
    edge_width = 0.3, show.legend = FALSE
  ) +
  geom_node_point(
    aes(size = radius,#根据radius确定节点的大小
        color = language),#根据语言确定颜色
    alpha = 0.6, show.legend = FALSE
  ) +
  geom_node_text(
    aes(
      x = 1.0175 * x,#文字的横坐标
      y = 1.0175 * y,#文字的纵坐标
      label = name,#文字的内容
      angle = -((-node_angle(x, y) + 90) %% 180) + 90,#%%表示整除后返回余数,node_angle根据横纵坐标计算角度
      filter = !(name %in% top_languages) #为外圈添加标签
    ),
    size = 2, hjust = 'outward', family = 'Oswald'
  ) +
  geom_node_text(
    aes(
      x = x,
      y = y,
      label = name,
      filter = name %in% top_languages#为编程语言添加文字标签
    ),
    size = 6, hjust = 0.5, family = 'Oswald'
  ) +
  geom_node_text(
    aes(
      x = x,
      y = y - 0.045,
      label = ifelse(
        total_code > 1000,
        format(total_code, big.mark = ','),#big.mark用于指定千分位符号
        total_code
      ),
      filter = name %in% top_languages
    ),
    size = 3, hjust = 0.5, family = 'Oswald'
  ) +
  scale_edge_color_manual(values = top_language_colors) +#根据top_language_colors确定颜色
  scale_color_manual(values = top_language_colors) +#根据top_language_colors确定颜色
  scale_size_area(max_size = 150) +#缩放半径
  scale_edge_alpha_manual(values = c(0.15, 1)) +#设置边的透明度
  coord_fixed() +#图形伸缩变换
  labs(
    title = 'LOC of Popular Programming Languages in 300 CRAN Packages',
    subtitle = 'considered are largest CRAN packages written in one (or more) of top 16 programming languages from TIOBE Index (Nov. 2019)',
    caption = '#tidytuesday 46|2019 spren9er'
  ) +#添加标题、副标题、说明文字
  theme_void() +#空白主题
  theme(
    text = element_text(family = 'Oswald'),
    legend.position = c(0.645, 0.51),
    plot.title = element_text(
      face = 'bold', hjust = 0.5, size = 20, margin = margin(t = 45, b = 3)
    ),#title设定
    plot.subtitle = element_text(
      face = 'plain', hjust = 0.5, size = 13, margin = margin(t = 5, b = 3)),#subtitle设定
    plot.caption = element_text(
      face = 'plain', color = '#dedede', size = 8, hjust = 1,
      margin = margin(b = 20)
    )#caption说明文字设定
  )

ggsave(
  'images/tidytuesday_201946_cran_packages.png',
  width = 12, height = 12.5, dpi = 300
)