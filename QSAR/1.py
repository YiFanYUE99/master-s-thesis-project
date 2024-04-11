# -*- coding: utf-8 -*-
"""
Created on Sun Mar 10 19:29:36 2024

@author: yj991
"""

#爬取数据

import os
os.getcwd()
os.chdir('D:\R_work\master-s-thesis-project\QSAR')

import requests

#1.发送请求
url='https://sitem.herts.ac.uk/aeru/ppdb/en/atoz.htm'
response=requests.get(url)
#2.获取相应
#更改响应文字格式
response.encoding='utf8'
print(response.content.decode())#查看response中的文字/content是二进制，需要用decode转换

#请求ppdb的子页面
url1='https://sitem.herts.ac.uk/aeru/ppdb/en/Reports/685.htm'
response=requests.get(url1)
print(response.content.decode())
html=response.content.decode()

#3.使用beautiful soup提取数据
from bs4 import BeautifulSoup
soup=BeautifulSoup(html,'html.parser')#html.parser是解析方式 依赖于lxml模块
print(soup)
#find搜索文档树
#find(self, name=,attrs=[],recursive =True,text=,**kwargs)
#name标签名，attrs属性字典，recursive是否循环查找，text根据文本内容查找
#find返回查找到的第一个元素对象

#根据text查找
b=soup.find(text='Environmental fate')
print(b)#确实能找到


#根据name查找标签
td=soup.find(name='td')
print(td)
#查找所有该标签/但是无法接收
ths=soup.find_all(name = 'th')
print(ths)
#根据属性查找标签
a=soup.find(attrs={'class':'report_health_issues'})
text=a.text#获取report_health_issues的文本
print(text)

#还要提取Canonical SMILES；数据共有1685个
#导入正则表达式模块
import re
#.匹配除\n符的字符
#\. 才能匹配 .
#匹配列表
# \d 数字
# \D 非数字
# \s 空白字符
# \S非空白字符
# \w 单词字符
# \W 非单词字符
# * 匹配前一个字符0次或无限次
# + 匹配前一个字符一次或无限次
# ? 匹配前一个字符一次或0次
# {m} 匹配前一个字符m次ab{2}c abbc

envi=re.findall('Environmental fate(\w+)', text)#带了括号就只返回括号内内容
ecotoxicity=re.findall('Ecotoxicity(\w+)',text)
human=re.findall('Human health(\w+)',text)
merged = envi + ecotoxicity + human
print(envi)
print(ecotoxicity)
print(human)
print(merged)



















