# -*- coding: utf-8 -*-
"""
Created on Wed Mar 20 20:47:20 2024

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
filename = 'QSRR2\metabolites.csv'
d1=pd.read_csv(filename,header=0)
d1['Metabolites'] = d1['Metabolites'].str.lower()

d1 = d1.drop_duplicates(subset='Metabolites', keep="last")
d1.to_csv('QSRR2/met_unique.csv',header=True,index=False,encoding='gbk')

filename2='QSRR2\Fiehn_HILIC.csv'
d2=pd.read_csv(filename2,header=0)
d2 = d2.drop_duplicates(subset='NAME', keep="last")

#找出这部分代谢物的保留时间
same=[]

for i in range(0, d1.shape[0]):
    for j in range(0, d2.shape[0]):
        if d1.iloc[i,0].lower()==d2.iloc[j,0].lower():
            same.append(d2.iloc[j,:])

newmet=pd.DataFrame(same)
newmet.to_csv('QSRR2/met_RT.csv',header=True,index=False);   




#根据名称找SMILES
newmet=pd.read_csv('QSRR2/met_RT.csv',header=0)
names=newmet.iloc[:,0]
#爬取SMILES的程序
from urllib.request import urlopen
from urllib.parse import quote

def CIRconvert(ids):
    try:
        url = 'http://cactus.nci.nih.gov/chemical/structure/' + quote(ids) + '/smiles' 
        #quote() 函数可以用于将一个字符串转换为URL编码字符串from urllib.parse import quote
        ans = urlopen(url).read().decode('utf8') 
        #打开url，阅读它，并将它转化为utf8
        return ans
    except:
        return 'NA'
    
#使用以上程序寻找我件中的SMILES式
sm=[]
for ids in names :
    an=CIRconvert(ids)
    sm.append(an)

dsm=pd.DataFrame(sm)
al=pd.concat([newmet,dsm],axis=1)#同行数合并
#同列数合并axis = 0
al.columns=['NAME', 'Experimental RT', 'SMILES']#修改列名
print(dsm)
print(al)
al.to_csv('QSRR2/met_RT_smiles.csv',header=True,index=False); 


#找MDs
#读取含有SMILES的质谱文件
input3='QSRR2/met_RT_smiles.csv'
d1=pd.read_csv(input3,header=0)
#删除带na的行
d2=d1.dropna(axis=0)#删除带na的列就是axis=1

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
for i in range(0,d2.shape[0],1):
    SM.append(Chem.MolFromSmiles(d2.iloc[i,2]))
    
    



mols= [m for m in SM]#mols是一个list，包括很多SMILES式
len(mols)
allDescrs = [getMolDescriptors(m) for m in mols]#提取他们的MDs，得到一个list
#将list转化为dataframe
df = pd.DataFrame(allDescrs)
#加入SMILES
df2=pd.concat([d2,df],axis=1)
#删除带na的行
df2=df2.dropna(axis=0)#删除带na的列就是axis=1
df2.to_csv('QSRR2/MDs.csv',header=True,index=False); #38个 





