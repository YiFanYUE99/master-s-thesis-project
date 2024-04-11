# -*- coding: utf-8 -*-
"""
Created on Sat Mar 16 02:37:38 2024

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
y=d1.iloc[:,1]
#映射分类
mapping={'High':1, 'Not High':0}
#映射
y=y.map(mapping)
y=np.array(y)
X=np.array(d1.iloc[:,5:])

#建立SVM模型
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.svm import SVC
from sklearn.metrics import accuracy_score


#拆分训练集测试集8：2
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=99)

## 数据标准化（SVM模型一定需要标准化特征）
sc = StandardScaler()
X_train_std = sc.fit_transform(X_train)
X_test_std = sc.transform(X_test)
X_std=sc.transform(X)
#X寻找最优C
from sklearn.model_selection import GridSearchCV
svm = SVC(kernel='linear')
param_grid = {'C': [ 1, 10,100]}
grid_search = GridSearchCV(svm, param_grid, cv=5,
                           n_jobs=-1, #使用所有CPU
                           scoring= "roc_auc")#AUC作为评分标准
grid_search.fit(X_std, y)

print("Best C:", grid_search.best_params_)#打出最优C:1e-05






# 建立SVM模型
svm = SVC(kernel='linear',
          probability=True, #这里一定要设置可能性，不然无法绘制ROC曲线
          C= 1,
          random_state=7)
svm.fit(X_train_std, y_train)

# 预测
y_pred = svm.predict(X_test_std)

# 计算准确率
accuracy = accuracy_score(y_test, y_pred)
print("准确率:", accuracy)#0.5497

#准备ROC曲线所需数据
from sklearn.metrics import roc_curve

y_pred_prob = svm.predict_proba(X_test_std)

# 计算 ROC 曲线所需的指标
fpr, tpr, thresholds = roc_curve(y_test, y_pred_prob[:, 1])
#计算AUC
from sklearn.metrics import roc_auc_score
auc_score = roc_auc_score(y_test, y_pred_prob[:, 1])
print("AUC Score:", auc_score)#0.5682



fprd=pd.DataFrame(fpr,columns=['False Positive Rate'])
tprd=pd.DataFrame(tpr,columns=['True Positive Rate'])
EF_RF_ROC=pd.concat([fprd,tprd],axis=1)
EF_RF_ROC.to_csv('table/data8EF_SVM_ROC.csv',header=True,index=False);  
#用以上数据在R中画ROC图

#提取系数
svm_coefabs = abs(svm.coef_)

feature_name=d1.columns[5:]
svmcoefa=pd.DataFrame(svm_coefabs.T,index=feature_name,columns=["abs(coef)"])

svmcoefa=svmcoefa.sort_values(by="abs(coef)", ascending=False)
MDs15=svmcoefa.iloc[0:15,:]
MDs15.to_csv('table/data9EF_SVM_fimp.csv',header=True,index=True)

selected_MDs=d1[MDs15.index]
selected_MDs=pd.concat([d1["Environmental fate"],selected_MDs],axis=1)
selected_MDs.index=d1["Unnamed: 0"]
selected_MDs.to_csv('table/data10EF_SVM_fabun.csv',header=True, index = True)


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
confmat.to_csv('table/data11EF_SVM_confmat.csv',header=True, index = True)
















