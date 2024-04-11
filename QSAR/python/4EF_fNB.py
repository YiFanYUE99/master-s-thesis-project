# -*- coding: utf-8 -*-
"""
Created on Thu Apr 11 18:55:42 2024

@author: yj991
"""

import os
os.getcwd()
os.chdir('D:\R_work\master-s-thesis-project\QSAR')

from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split, GridSearchCV
from sklearn.preprocessing import StandardScaler
from sklearn.naive_bayes import GaussianNB
from sklearn.feature_selection import SelectKBest, f_classif
from sklearn.metrics import roc_auc_score
from sklearn.pipeline import Pipeline
from sklearn.metrics import roc_curve

#读取含有SMILES的质谱文件
input3='table2/data4_MDs_special.csv'
import pandas as pd
import numpy as np
d1=pd.read_csv(input3,header=0)

# 创建一个示例数据集
#设置X和y
y=d1.iloc[:,1]
#映射分类
mapping={'High':1, 'Not High':0}
#映射
y=y.map(mapping)

df=d1.iloc[:,5:]
#标准化
X=StandardScaler().fit_transform(df)
X=pd.DataFrame(X,columns=df.columns)
#拆分训练集测试集8：2
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=1)


# 创建Pipeline
pipeline = Pipeline([
    ('fs', SelectKBest(score_func=f_classif)),  # 特征选择器
    ('nb', GaussianNB())  # 朴素贝叶斯模型
])

# 设置待调优的参数
param_grid = {
    'fs__k': np.arange(1, X.shape[1] + 1)  # 待选择的特征数量范围
}

# 使用GridSearchCV进行交叉验证和参数调优
grid_search = GridSearchCV(pipeline, param_grid, cv=5, scoring='roc_auc',n_jobs=-1)
grid_search.fit(X_train, y_train)

# 输出最优参数
print("Best number of features:", grid_search.best_params_['fs__k'])#60
print('Best AUC: %.3f' % grid_search.best_score_)#0.557

# 获取最优模型
model = grid_search.best_estimator_
# 获取最优特征子集和得分
selected_features_idx = grid_search.best_estimator_.named_steps['fs'].get_support(indices=True)
selected_features = X.columns[selected_features_idx]
feature_scores = grid_search.best_estimator_.named_steps['fs'].scores_[selected_features_idx]

# 创建包含特征及其得分的DataFrame
fi = pd.DataFrame({"Importance": feature_scores},index=selected_features)

# 按得分降序排列
fi = fi.sort_values(by='Importance', ascending=False)
fi.to_csv('特征重要性/EF_fNB_fimp_4.csv',header=True, index = True)


# 在测试集上评估模型
y_pred_proba = model.predict_proba(X_test)[:, 1]
auc = roc_auc_score(y_test, y_pred_proba)
print("AUC:", auc)#0.551
#训练集上评估模型
y_pred_proba = model.predict_proba(X_train)[:, 1]
auc = roc_auc_score(y_train, y_pred_proba)
print("AUC:", auc)#0.652
#全集上评估模型
y_pred_proba = model.predict_proba(X)[:, 1]
auc = roc_auc_score(y, y_pred_proba)
print("AUC:", auc)#0.623

# 计算在训练集上的正确率
test_accuracy = model.score(X_test, y_test)
print("在训练集上的正确率:", test_accuracy)#0.528
train_accuracy = model.score(X_train, y_train)
print("在训练集上的正确率:", train_accuracy)#0.598
full_set_accuracy = model.score(X, y)
print("在全集上的正确率:", full_set_accuracy)#0.577

#计算fpr\tpr\threshold
y_pred_proba = model.predict_proba(X)[:, 1]
# 计算FPR, TPR, 阈值
fpr, tpr, thresholds = roc_curve(y, y_pred_proba)
fprd=pd.DataFrame(fpr,columns=['False Positive Rate'])
tprd=pd.DataFrame(tpr,columns=['True Positive Rate'])
EF_RF_ROC=pd.concat([fprd,tprd],axis=1)
EF_RF_ROC.to_csv('ROC曲线/EF_fNB_ROC_4.csv',header=True,index=False);  

#画混淆矩阵
from sklearn.metrics import confusion_matrix
# 计算混淆矩阵
y_pred=model.predict(X)
conf_matrix = confusion_matrix(y, y_pred)
Xlab=pd.DataFrame(["P","P","N","N"])
Ylab=pd.DataFrame(["P","N","P","N"])
Name=pd.DataFrame(["TP","FP","FN","TN"])
Count=pd.DataFrame([conf_matrix[0,0],conf_matrix[1,0],conf_matrix[0,1],conf_matrix[1,1]])
confmat=pd.concat([Name,Count,Xlab,Ylab],axis=1)
confmat.columns=["Name","Result","Predicted","Real"]
confmat.to_csv('混淆矩阵/EF_fNB_confmat_4.csv',header=True, index = True)











