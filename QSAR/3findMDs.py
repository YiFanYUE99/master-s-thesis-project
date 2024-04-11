# -*- coding: utf-8 -*-
"""
Created on Fri Mar 15 01:49:39 2024

@author: yj991
"""

import os
os.getcwd()
os.chdir('D:\R_work\master-s-thesis-project\QSAR')
import numpy as np

#读取含有SMILES的质谱文件
input3='table/data1.csv'
import pandas as pd
d1=pd.read_csv(input3,header=0)
#删除没有smiles表达式的行
d1.replace('-', np.nan, inplace=True)
d1.dropna(inplace=True)#还剩1145个


#find molecular descriptor寻找MDs
from rdkit import Chem
import rdkit
rdkit.__version__


#计算所有descriptor的程序
from rdkit.Chem import Descriptors
def getMolDescriptors(mol, missingVal=None):
    ''' calculate the full list of descriptors for a molecule
    
        missingVal is used if the descriptor cannot be calculated
    '''
    res = {}
    for nm,fn in Descriptors._descList:
        # some of the descriptor fucntions can throw errors if they fail, catch those here:
        try:
            val = fn(mol)
        except:
            # print the error message:
            import traceback
            traceback.print_exc()
            # and set the descriptor value to whatever missingVal is
            val = missingVal
        res[nm] = val
    return res



#使用SMILES式构建单个分子 Individual molecules can be constructed using a variety of approaches
SM=[]
for i in range(0,d1.shape[0],1):
    SM.append(Chem.MolFromSmiles(d1.iloc[i,4]))
    
    



mols= [m for m in SM]#mols是一个list，包括很多SMILES式
len(mols)
allDescrs = [getMolDescriptors(m) for m in mols]#提取他们的MDs，得到一个list
#将list转化为dataframe
df = pd.DataFrame(allDescrs)
#加入SMILES
d1=pd.concat([d1,df],axis=1)
#删除带na的行
d1=d1.dropna(axis=0)#删除带na的列就是axis=1#还剩下953个
#储存MDs
d1.to_csv('table/data2_MDs.csv',header=True,index=False);  

