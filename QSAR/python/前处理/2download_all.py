# -*- coding: utf-8 -*-
"""
Created on Thu Mar 14 22:34:11 2024

@author: yj991
"""

import os
import requests
from bs4 import BeautifulSoup
import re
os.getcwd()
os.chdir('D:\R_work\master-s-thesis-project\QSAR')

def getdata(n):
    try:
        url = 'https://sitem.herts.ac.uk/aeru/ppdb/en/Reports/' + n + '.htm' 
        response=requests.get(url)
        html=response.content.decode()
        #打开url，阅读它，并将它转化为utf8
        soup=BeautifulSoup(html,'html.parser')
        a=soup.find(attrs={'class':'report_health_issues'})
        text=a.text
        b=soup.find(attrs={'title'})
        btext=b.text
        name=re.findall('.+', btext)
        envi=re.findall('Environmental fate(\w+)', text)#带了括号就只返回括号内内容
        ecotoxicity=re.findall('Ecotoxicity(\w+)',text)
        human=re.findall('Human health(\w+)',text)
        smiles=re.findall('<td class="row_header">Canonical SMILES</td>\n</tr>\n</tbody>\n</table>\n</th>\n<td class="data1">(.+)</td>',html)
        merged = name + envi + ecotoxicity + human+ smiles
        return merged
    except:
        return 'NA'
    
#使用以上程序寻找环境效应
#使用以上程序寻找农药名称 环境效应 毒理 人类健康效应 smiles式
sm=[]
for n in range(1,4000) :
    an=getdata(str(n))
    if (an!= 'NA'):    
        sm.append(an)


len(sm[1])

new=[]
for i in range(0,len(sm)):
    if (len(sm[i])==5):
        new.append(sm[i])


import pandas as pd
smd=pd.DataFrame(new,columns=['Name','Environmental fate','Ecotoxicity','Human health','SMILES'])
print(smd)
smd=smd.replace('</td>','',regex=True)
smd.to_csv('table/data1.csv',header=True,index=False);  



    