# -*- coding: utf-8 -*-
"""
Created on Thu Apr 11 16:22:35 2024

@author: yj991
"""

import os
os.getcwd()
os.chdir('D:\R_work\master-s-thesis-project\QSAR')


#读取含有SMILES的质谱文件
input3='table2/data3_MDs_modified.csv'
import pandas as pd
d1=pd.read_csv(input3,header=0,index_col=0)

unique_counts = d1.nunique()

# 获取唯一值数量为1的列（常数列）
constant_columns = unique_counts[unique_counts == 1].index

# 删除常数列
d1.drop(columns=constant_columns, inplace=True)

d1.to_csv('table2/data4_MDs_special.csv',header=True,index=True)
