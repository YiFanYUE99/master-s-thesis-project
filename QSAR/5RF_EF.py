# -*- coding: utf-8 -*-
"""
Created on Fri Mar 15 18:37:00 2024

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

#建立随机森林模型
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score
#映射分类


# 创建一个示例数据集
#设置X和y
y=d1.iloc[:,1]
#映射分类
mapping={'High':1, 'Not High':0}
#映射
y=y.map(mapping)
y=np.array(y)




X=np.array(d1.iloc[:,5:])


#拆分训练集测试集8：2
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=1)

#设置随机森林模型
#n_estimators是决策树数量；同样的random_state能使得每次输出结果相同
#寻找最佳n_estimators决策树数量
from sklearn.model_selection import GridSearchCV
#Gridsearch 网格搜索
# 设置参数范围
param_grid = {
    'n_estimators': [100,1000,1100]
}
# 创建随机森林分类器
random_forest = RandomForestClassifier(random_state=1)

# 使用交叉验证进行网格搜索
grid_search = GridSearchCV(estimator=random_forest, param_grid=param_grid, cv=5, scoring='roc_auc')
grid_search.fit(X_train, y_train)

# 输出最佳参数
print("Best n_estimators:", grid_search.best_params_['n_estimators'])
#最佳决策树个数是1000
random_forest = RandomForestClassifier(n_estimators=1000, random_state=90)

#在训练集上拟合模型
random_forest.fit(X_train, y_train)

# 使用测试集对模型进行评估
y_pred = random_forest.predict(X_test)
accuracy = accuracy_score(y_test, y_pred)
print("Accuracy:", accuracy)#正确率0.607

#准备ROC曲线所需数据
from sklearn.metrics import roc_curve, auc
y_pred_prob = random_forest.predict_proba(X_test)

# 计算 ROC 曲线所需的指标
fpr, tpr, thresholds = roc_curve(y_test, y_pred_prob[:, 1])
#计算AUC
from sklearn.metrics import roc_auc_score
auc_score = roc_auc_score(y_test, y_pred_prob[:, 1])
print("AUC Score:", auc_score)#0.6182



fprd=pd.DataFrame(fpr,columns=['False Positive Rate'])
tprd=pd.DataFrame(tpr,columns=['True Positive Rate'])
EF_RF_ROC=pd.concat([fprd,tprd],axis=1)
EF_RF_ROC.to_csv('table/data4EF_RF_ROC.csv',header=True,index=False);  
#画ROC图
#在R中

#提取特征
feature_imp=random_forest.feature_importances_
Mds=d1.columns[5:]
MDs_sel=pd.DataFrame(feature_imp, index=Mds,columns=['Importance'])
#降序排列
sorted_MDs = MDs_sel.sort_values(by='Importance', ascending=False)
#选取前15个Mds
MDs15=sorted_MDs.iloc[0:15,:]
#存储importance值
MDs15.to_csv('table/data5EF_RF_fimp.csv',header=True, index = True)

selected_MDs=d1[MDs15.index]
selected_MDs=pd.concat([d1["Environmental fate"],selected_MDs],axis=1)
selected_MDs.index=d1["Unnamed: 0"]
selected_MDs.to_csv('table/data6EF_RF_fabun.csv',header=True, index = True)

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
confmat.to_csv('table/data7EF_RF_confmat.csv',header=True, index = True)
#在R中画混淆矩阵






