# -*- coding: utf-8 -*-
"""
Created on Wed Mar 20 23:32:43 2024

@author: yj991
"""


#查看当前工作目录
import os
os.getcwd()
#更改当前工作目录
os.chdir('D:\R_work\master-s-thesis-project\QSRR\QSRR2')
os.getcwd()#更改成功

#读取数据集
#读取SMILES特征文件
input6="MDs.csv"
import pandas as pd
d1=pd.read_csv(input6,header=0)


## split into train and test sets
from sklearn.model_selection import train_test_split
import numpy as np
X=d1.iloc[:,3:d1.shape[1]]
y=d1.iloc[:,1]
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=1)
 
# 1Model Built Using Correlation Features（20个）
from sklearn.feature_selection import SelectKBest, f_regression
def select_featurescs20(X_train, y_train, X_test):
	# configure to select a subset of features
	fs = SelectKBest(score_func=f_regression, k=4)
	# learn relationship from training data
	fs.fit(X_train, y_train)
	# transform train input data
	X_train_fs = fs.transform(X_train)
	# transform test input data
	X_test_fs = fs.transform(X_test)
	return X_train_fs, X_test_fs, fs

#使用相关性选择20个特征
X_train_fs, X_test_fs, fs = select_featurescs20(X_train, y_train, X_test)
#可视化20个特征的得分
sc=[]
for i in range(len(fs.scores_)):
	sc.append(fs.scores_[i])
#将得分list转化为得分frame
import pandas as pd
scd=pd.DataFrame(sc)
#合并特征名称和得分
fe=pd.DataFrame(X.columns)
scd1=pd.concat([fe,scd],axis=1)
scd1.columns=("Feature","Score")#取列名
#降序排列后取前20个
scd20=scd1.sort_values(by='Score', ascending=False).iloc[0:4,:]
#储存得分
scd20.to_csv('MDcslr4.csv',header=True,index=False);
#可视化在3Correlation20.R

#建立回归模型fit the model
from sklearn.linear_model import LinearRegression
model = LinearRegression()
model.fit(X_train_fs, y_train)
#评估模型
yhat = model.predict(X_test_fs)#使用测试集获得的预测结果
#评估预测结果MAE：平均绝对偏差
from sklearn.metrics import mean_absolute_error
mae = mean_absolute_error(y_test, yhat)#测试集的实际结果和预测结果的MAE
print('MAE: %.3f' % mae)#保留三位小数 2.447

#2 Model Built Using Mutual Information Features(15个)
from sklearn.feature_selection import mutual_info_regression
def select_featuresmi10(X_train, y_train, X_test):
	# configure to select a subset of features
	fs = SelectKBest(score_func=mutual_info_regression, k=10)
	# learn relationship from training data
	fs.fit(X_train, y_train)
	# transform train input data
	X_train_fs = fs.transform(X_train)
	# transform test input data
	X_test_fs = fs.transform(X_test)
	return X_train_fs, X_test_fs, fs


X_train_fs, X_test_fs, fs = select_featuresmi10(X_train, y_train, X_test)
#使用相关性选择10个特征
#可视化10个特征的得分
sc=[]
for i in range(len(fs.scores_)):
	sc.append(fs.scores_[i])
#将得分list转化为得分frame
import pandas as pd
scd=pd.DataFrame(sc)
#合并特征名称和得分
fe=pd.DataFrame(X.columns)
scd1=pd.concat([fe,scd],axis=1)
scd1.columns=("Feature","Score")#取列名
#降序排列后取前20个
scd20=scd1.sort_values(by='Score', ascending=False).iloc[0:10,:]
#储存得分
scd20.to_csv('MDmilr10.csv',header=True,index=False);
#使用R可视化4Mutal20.R

#使用mutl information 进行feature selection
# fit the model
model = LinearRegression()
model.fit(X_train_fs, y_train)
# evaluate the model
yhat = model.predict(X_test_fs)
# evaluate predictions
mae = mean_absolute_error(y_test, yhat)
print('MAE: %.3f' % mae)#0.815
