# -*- coding: utf-8 -*-
"""
Created on Fri Mar 15 02:02:19 2024

@author: yj991
"""

import os
os.getcwd()
os.chdir('D:\R_work\master-s-thesis-project\QSAR')
import numpy as np

#读取含有SMILES的文件
input3='table/data2_MDs.csv'
import pandas as pd
d1=pd.read_csv(input3,header=0)
#将中度警告（moderate）设置为影响不确定（不将该数据列入考虑范围）
#将低警告（low）设置为影响较小0
#将高警告（high）设置为影响较大1

d1.replace('Moderate', np.nan, inplace=True)
d1.replace('High',1,inplace = True)
d1.replace('Low',0,inplace = True)

#Environmental Fate 表
EF=pd.concat([d1.iloc[:,0:2], d1.iloc[:,4:(d1.shape[1])]],axis=1)
#删除带na的行
EF=EF.dropna(axis=0)#删除带na的列就是axis=1#还剩下485个
EF.to_csv('table/data3_EF.csv',header=True,index=False);  

#ecotoxicity表
ET=pd.concat([d1.iloc[:,[0,2]],d1.iloc[:,4:(d1.shape[1])]],axis=1)
#删除带na的行
ET=ET.dropna(axis=0)#删除带na的列就是axis=1#还剩下396个
ET.to_csv('table/data4_ET.csv',header=True,index=False);  

#human health
HH=pd.concat([d1.iloc[:,[0,3]],d1.iloc[:,4:(d1.shape[1])]],axis=1)
HH=HH.dropna(axis=0)
HH.to_csv('table/data5_HH.csv',header=True,index=False);  
