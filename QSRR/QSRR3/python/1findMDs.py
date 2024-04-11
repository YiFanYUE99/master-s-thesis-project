# -*- coding: utf-8 -*-
"""
Created on Tue Apr  9 11:30:17 2024

@author: yj991
"""

#查看当前工作目录
import os
os.getcwd()
#更改当前工作目录
os.chdir('D:\R_work\master-s-thesis-project\QSRR')
os.getcwd()#更改成功

#读取文件
import pandas as pd
filename = 'QSRR3\chem_database.xlsx'
d1=pd.read_excel(filename,header=0)
d2=pd.concat([d1.iloc[:,0],d1.iloc[:,5]], axis=1)
d2=d2.iloc[0:366,:]#367行之后的RT不完善
d2['HILIC RT'] = pd.to_numeric(d2['HILIC RT'], errors='coerce')

#根据名称找SMILES
names=d2.iloc[:,0]
#爬取SMILES的程序
from urllib.request import urlopen
from urllib.parse import quote
import numpy as np
def CIRconvert(ids):
    try:
        url = 'http://cactus.nci.nih.gov/chemical/structure/' + quote(ids) + '/smiles' 
        #quote() 函数可以用于将一个字符串转换为URL编码字符串from urllib.parse import quote
        ans = urlopen(url).read().decode('utf8') 
        #打开url，阅读它，并将它转化为utf8
        return ans
    except:
        return np.nan
    
#使用以上程序寻找我件中的SMILES式
sm=[]
for ids in names :
    an=CIRconvert(ids)
    sm.append(an)

dsm=pd.DataFrame(sm)
al=pd.concat([d2,dsm],axis=1)#同行数合并
#同列数合并axis = 0
al.columns=['NAME', 'Experimental RT', 'SMILES']#修改列名
print(dsm)
print(al)
al=al.dropna(axis=0)#还剩297个
al = al.reset_index(drop=True)#删除index以免无法合并df



#找MDs
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
for i in range(0,al.shape[0],1):
    SM.append(Chem.MolFromSmiles(al.iloc[i,2]))
    
    



mols= [m for m in SM]#mols是一个list，包括很多SMILES式
len(mols)
allDescrs = [getMolDescriptors(m) for m in mols]#提取他们的MDs，得到一个list
#将list转化为dataframe
df = pd.DataFrame(allDescrs)
#加入SMILES
al2=pd.concat([al,df],axis=1)
#删除带na的行
al2=al2.dropna(axis=0)#删除带na的MDs的行，还剩295个
al2.to_csv('QSRR3/table/MDs.csv',header=True,index=False); #38个 

















