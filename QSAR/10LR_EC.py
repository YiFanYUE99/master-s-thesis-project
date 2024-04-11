# -*- coding: utf-8 -*-
"""
Created on Tue Mar 19 21:17:47 2024

@author: yj991
"""


import os
os.getcwd()
os.chdir('D:\R_work\master-s-thesis-project\QSAR')
import numpy as np

#读取含有SMILES的质谱文件
input3='table/data3_MDs_modified.csv'
import pandas as pd
d1=pd.read_csv(input3,header=0)

# 创建一个示例数据集
#设置X和y
y=d1.iloc[:,2]
#映射分类
mapping={'High':1, 'Not High':0}
#映射
y=y.map(mapping)
y=np.array(y)
X=np.array(d1.iloc[:,5:])


# 导入所需的库
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score


#拆分训练集测试集8：2
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=99)

## 数据标准化（SVM模型一定需要标准化特征）
from sklearn.preprocessing import StandardScaler
sc = StandardScaler()
X_train_std = sc.fit_transform(X_train)
X_test_std = sc.transform(X_test)
X_std=sc.transform(X)


#调整超参数
from sklearn.model_selection import GridSearchCV

# 定义参数网格
param_grid = {'C': [0.001, 0.01, 0.1, 1, 10, 100],
              'penalty': ['l1','l2']} # 正则化参数C的取值范围


# 初始化GridSearchCV对象
grid_search = GridSearchCV(LogisticRegression(max_iter=1000, solver='saga'), param_grid, cv=5)

# 在训练集上进行网格搜索
grid_search.fit(X_std, y)

# 输出最佳参数和最佳得分
print("最佳参数：", grid_search.best_params_)#最佳参数是C=0.001 L1
print("最佳得分：", grid_search.best_score_)



# 初始化逻辑回归模型
logistic_regression = LogisticRegression(C= 1,penalty='l1',solver='saga')
# 在训练集上训练逻辑回归模型
logistic_regression.fit(X_train_std, y_train)
# 在测试集上进行预测
y_pred = logistic_regression.predict(X_test)
#测试集上的准确率
accuracy = accuracy_score(y_test, y_pred)
print("模型的准确率：", accuracy)#0.6335

#准备ROC曲线所需数据
from sklearn.metrics import roc_curve

y_pred_prob = logistic_regression.predict_proba(X_test_std)

# 计算 ROC 曲线所需的指标
fpr, tpr, thresholds = roc_curve(y_test, y_pred_prob[:, 1])
#计算AUC
from sklearn.metrics import roc_auc_score
auc_score = roc_auc_score(y_test, y_pred_prob[:, 1])
print("AUC Score:", auc_score)#0.5741

fprd=pd.DataFrame(fpr,columns=['False Positive Rate'])
tprd=pd.DataFrame(tpr,columns=['True Positive Rate'])
EF_RF_ROC=pd.concat([fprd,tprd],axis=1)
EF_RF_ROC.to_csv('table/data24EC_LR_ROC.csv',header=True,index=False);  

#提取系数
lr_coefabs = abs(logistic_regression.coef_)

feature_name=d1.columns[5:]
lrcoefa=pd.DataFrame(lr_coefabs.T,index=feature_name,columns=["abs(coef)"])

lrcoefa=lrcoefa.sort_values(by="abs(coef)", ascending=False)
MDs15=lrcoefa.iloc[0:15,:]
MDs15.to_csv('table/data25EC_LR_fimp.csv',header=True,index=True)

selected_MDs=d1[MDs15.index]
selected_MDs=pd.concat([d1["Environmental fate"],selected_MDs],axis=1)
selected_MDs.index=d1["Unnamed: 0"]
selected_MDs.to_csv('table/data26EC_LR_fabun.csv',header=True, index = True)


#画混淆矩阵
from sklearn.metrics import confusion_matrix
# 计算混淆矩阵
conf_matrix = confusion_matrix(y_test, y_pred)
Xlab=pd.DataFrame(["P","P","N","N"])
Ylab=pd.DataFrame(["P","N","P","N"])
Name=pd.DataFrame(["TP","FP","FN","TN"])
Count=pd.DataFrame([conf_matrix[0,0],conf_matrix[1,0],conf_matrix[0,1],conf_matrix[1,1]])
confmat=pd.concat([Name,Count,Xlab,Ylab],axis=1)
confmat.columns=["Name","Result","Predicted","Real"]
confmat.to_csv('table/data27EC_LR_confmat.csv',header=True, index = True)








